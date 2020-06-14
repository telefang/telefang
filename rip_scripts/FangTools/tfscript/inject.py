"""Injection utilities for the Telefang script."""

from FangTools.tfscript.banknames import parse_bank_names
from FangTools.tfmessage.charmap import parse_charmap
from FangTools.tfmessage.csv import parse_csv, omnibus_bank_split
from FangTools.tfmessage.pack import pack_text, specials, memory_widths
from FangTools.tffont.parser import parse_font_metrics
from FangTools.gb import METATABLE_FARPTR, PTR, BE_PTR, CHARA, flat, banked
from FangTools.fs import install_path
from FangTools.rgbds import format_section, format_symbol, format_directives
import os

def generate_table_section(bank, rows, charmap, metrics, bank_window_width):
    """Given a bank and string data, generate RGBDS source that assembles to it.

    `rows` is assumed to be an iterable yielding 2-tuples, where the first item
    in each tuple is the pointer index; and the second item is the string to
    pack.

    `charmap` is a map of string characters to encoded bytes, used to configure
    the text encoding for this particular iteration of Telefang.

    `metrics` is the character width of each encoded byte.

    `bank_window_width` is the pixel width of the window this particular bank
    of strings is expected to fit into.

    This function returns a tuple with the following information:

     - srcdata: RGBDS source code containing all table section data and symbols.
     - overflow: A dict of data which overflows this block. Dictionary keys
     correspond to the RGBDS symbols which are expected to be defined in the
     overflow bank, while the values are the actual string data to put there."""
    
    table = []
    packed_strings = [b""] * len(rows)

    baseaddr = bank["baseaddr"]
    lastbk = None
    last_table_index = 0
    last_aliased_row = -1

    ptr_col = 0
    str_col = 1
    wrap_col = 2
    
    for i, row in enumerate(rows):
        if "#" in row[ptr_col]:
            print("Skipping row {} as it is not a message.".format(i))
            continue

        if row[ptr_col] != "(No pointer)":
            try:
                table_idx = (int(row[ptr_col][2:], 16) - bank["baseaddr"]) % 0x4000 // 2
                last_table_index = table_idx
            except ValueError:
                continue #Skip rows that don't have parsable ptr columns
        else:
            table_idx = last_table_index
        
        if str_col >= len(row):
            print("WARNING: ROW {} IS MISSING IT'S TEXT!!!".format(i))
            table.append(baseaddr)

            packed = pack_text("/0x{0:X}/".format(table_idx), specials, charmap[0], metrics,
                               bank_window_width, 2, memory_widths, wrap=row[wrap_col])

            baseaddr += len(packed)
            packed_strings[table_idx] = packed
            continue

        if row[str_col][:11] == "«ALIAS ROW " or row[str_col][:11] == "<ALIAS ROW ":
            #Aliased string!
            split_row = row[str_col][11:-1].split(" ")
            if len(split_row) > 1 and split_row[1] == "INTO":
                #Partial string alias.
                table.append(table[int(split_row[0], 16)] + int(split_row[2], 16))
                packed_strings[table_idx] = b""
            else:
                table.append(table[int(split_row[0], 16)])
                packed_strings[table_idx] = b""

            #We don't want to have to try to handle both overflow and
            #aliasing at the same time, so don't.
            last_aliased_row = table_idx
        else:
            packed = pack_text(row[str_col], specials, charmap[0], metrics,
                               bank_window_width, 2, memory_widths, wrap=row[wrap_col],
                               do_not_terminate=row[ptr_col] == "(No pointer)")
            packed_strings[table_idx] += packed #We concat here in case of nopointer rows

            if row[ptr_col] != "(No pointer)":
                #Yes, some text banks have strings not mentioned in the
                #table because screw you.
                table.append(baseaddr)

                #Sanity check: are our pointer numbers increasing?
                nextbk = int(rows[i][ptr_col], 16)
                if lastbk != None and nextbk != lastbk + 2:
                    print("Warning: Pointer " + rows[i][ptr_col] + " is out of order.")
                lastbk = nextbk
            else:
                print("Warning: Row explicitly marked with no pointer")
            
            baseaddr += len(packed)
    
    #Remove empty strings from packed strings list.
    while len(packed_strings) > 0 and packed_strings[-1] == b"":
        packed_strings = packed_strings[:-1]
    
    #Moveup pointers to account for the table size
    for i, value in enumerate(table):
        table[i] = value + len(table) * 2
    
    #Overflow detection + handling
    bytes_remaining = 0x4000
    for intptr in table:
        bytes_remaining -= 2

    for line in packed_strings:
        bytes_remaining -= len(line)
    
    overflow = {}
    
    if bytes_remaining <= 0:
        print("Bank " + bank["filename"] + " exceeds size of MBC bank limit by 0x{0:x} bytes".format(abs(bytes_remaining)))
        
        #Compiled bank exceeds the amount of space available in the bank.
        #Start assigning strings from the last one forward to be spilled
        #into the overflow bank. This reduces their size to 4.
        strings_to_spill = 0
        string_bytes_saved = 0
        
        for table_idx, spill_string in reversed(list(enumerate(packed_strings))):
            if table_idx == last_aliased_row:
                #We can't spill aliased rows, nor do we want to attempt to
                #support that usecase, since it would be too much work.
                #Instead, stop spilling at the end.
                print("WARNING: Terminating spills at 0x{0:x} due to aliasing.".format(table_idx))
                print("The resulting object file is invalid.")
                print("Please consider removing aliasing rows.")
                break
            
            strings_to_spill += 1
            string_bytes_saved += len(packed_strings[table_idx]) - 4
            
            if string_bytes_saved + bytes_remaining > 0:
                #That's enough! Stop counting bytes, we've spilled enough.
                break
        
        #Replace each spilled string with the overflow opcode and a fixup into
        #the overflow list.
        for table_idx in range(len(packed_strings) - strings_to_spill, len(packed_strings)):
            spill_symbol_name = bank["symbol"] + ("_%d_OVERFLOW" % table_idx)
            cur_string = packed_strings[table_idx]
            packed_strings[table_idx] = (bytes([0xEC]), "db BANK(%s)" % spill_symbol_name, "dw %s" % spill_symbol_name)
            
            thisptr = table[table_idx]
            
            if table_idx < len(table) - 1:
                #fixup the next pointer in the table
                table[table_idx + 1] = thisptr + 4
            
            overflow[spill_symbol_name] = cur_string
        
        print("Spilled 0x{0:x} bytes to overflow bank".format(abs(string_bytes_saved)))
    
    #Actually generate our section source code now.
    srcdata = format_section("String table %s" % (bank["symbol"],), flat(bank["basebank"], bank["baseaddr"]))
    srcdata += format_symbol(bank["symbol"], True)

    for table_ptr in table:
        srcdata += "    dw $%x\n" % (table_ptr)
    
    for packed_string in packed_strings:
        srcdata += format_directives(packed_string)

    return (srcdata, overflow)