# coding=utf-8


# mainscript_text.py
# Injects (and/or extracts) main script data from the master metatable.

import argparse, errno, sys, os, os.path, struct, io, codecs, exceptions, urllib.request, urllib.error, urllib.parse, json, csv

def install_path(path):
    try:
        os.makedirs(path)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise

#Used by the original text injector script to represent special codes.
class Special():
    def __init__(self, byte, default=0, bts=1, end=False, names=None, redirect=False, base=16):
        self.byte = byte
        self.default = default
        self.bts = bts
        self.end = end
        self.redirect = redirect
        self.base = base
        self.names = names if names else {}

specials = {}
specials["&"] = Special(0xe5, bts=2, names={0xc92c: "name", 0xd448: "num"})
specials['S'] = Special(0xe3, default=2)
specials['*'] = Special(0xe1, end=True)
specials['O'] = Special(0xec, bts=2, redirect=True)
specials['D'] = Special(0xe9, base=10)

#Used here for text extraction from the ROM.
reverse_specials = {}
reverse_specials[0xE5] = "&"
reverse_specials[0xE3] = "S"
reverse_specials[0xE1] = "*"
reverse_specials[0xEC] = "O"
reverse_specials[0xE9] = "D"

CHARMAP_DELIM = 'charmap "'

METATABLE_LOC = 0x2C94F

def parse_charmap(filename):
    """Parse charmap.asm to determine the ROM's encoding.

    File must be UTF-8, sorry.

    This actually could support a hypothetical multibyte encoding, even though
    no build of Telefang (hacked or no) would support it."""
    mapping = {}
    reverse_mapping = {}

    with io.open(filename, "r", encoding="utf-8") as charmap:
        for line in charmap:
            if CHARMAP_DELIM not in line:
                continue

            if line[0] == "#":
                continue

            delim_split = line.split('"')
            chara = delim_split[1]
            if chara == "":
                #Special case: Quoted quotes.
                #   e.g. charmap """, $22

                #This parsing logic sucks arse.
                if len(delim_split) > 3:
                    chara = "\""

            if chara == "\\n":
                chara = "\n"

            unparsed_hex = delim_split[-1].split("$")[1].strip()
            bytes = 0

            for i in range(0, len(unparsed_hex), 2):
                bytes += int(unparsed_hex[i:i+2], 16) << i // 2

            mapping[chara] = bytes
            reverse_mapping[bytes] = chara

    return mapping, reverse_mapping

def parse_bank_names(filename):
    """Parse the list of bank names"""
    banks = []

    with io.open(filename, "r", encoding="utf-8") as banknames:
        for line in banknames:
            if line[0] == "#":
                continue

            parameters = line.split(" ")

            bank = {}
            bank["basedir"] = os.path.join(*parameters[0].split("/")[0:-1])
            bank["legacy_filename"] = os.path.join(*(parameters[0] + ".wikitext").split("/"))
            bank["filename"] = os.path.join(*(parameters[0] + ".messages.csv").split("/"))
            bank["objname"] = os.path.join(*(parameters[0] + ".scripttbl").split("/"))
            bank["wikiname"] = parameters[1]
            bank["symbol"] = "MainScript_" + parameters[0].replace("/", "_")

            if len(parameters) > 2 and parameters[2] != "null":
                #Parameter 3 is the flat address for the ROM
                #If not present, location of table will be determined from ROM
                flatattr = int(parameters[2], 16)

                if (flatattr < 0x4000):
                    bank["baseaddr"] = flatattr
                    bank["basebank"] = 0
                else:
                    bank["baseaddr"] = flatattr % 0x4000 + 0x4000
                    bank["basebank"] = flatattr // 0x4000

            if len(parameters) > 3:
                bank["window_width"] = int(parameters[3], 10)

            banks.append(bank)

    return banks

METATABLE_FARPTR = struct.Struct("<HB")
PTR = struct.Struct("<H")
BE_PTR = struct.Struct(">H")
CHARA = struct.Struct("<B") #Pack or be packed

def extract_metatable_from_rom(rom_filename, charmap, banknames, args):
    """Parse the master script metatable"""
    banks = []

    with open(rom_filename, 'rb') as rom:
        rom.seek(args.metatable_loc)

        for bankdata in banknames:
            entry = rom.read(3)
            parsed = METATABLE_FARPTR.unpack(entry)

            bank = bankdata.copy()

            if "baseaddr" not in list(bank.keys()):
                bank["baseaddr"] = parsed[0]
                bank["basebank"] = parsed[1]

            banks.append(bank)

    return banks

def extract_metrics_from_rom(rom_filename, charmap, banknames, args):
    metrics = []

    with open(rom_filename, 'rb') as rom:
        rom.seek(args.metrics_loc)

        for i in range(255):
            metrics.append(CHARA.unpack(rom.read(1))[0])

    return metrics

def flat(bank, addr):
    if (addr < 0x4000):
        return addr

    if (addr > 0x7FFF):
        return None #Maybe raise?

    return (bank * 0x4000) + (addr - 0x4000)

def banked(flataddr):
    if (flataddr < 0x4000):
        return flataddr, 0
    
    return flataddr % 0x4000 + 0x4000, flataddr // 0x4000

def format_int(i):
    if i < 0x10: #Small numbers lack the 0x
        return "{0:x}".format(i)
    else: #Large numbers are hex
        return "0x{0:x}".format(i)

def format_hex(i):
    if i < 0x10: #Small numbers lack the 0x
        return "{0:x}".format(i)
    else: #Large numbers are hex
        return "0x{0:x}".format(i)

def format_sectionaddr_rom(flataddr):
    """Format a flat address for the assembler's section macro."""
    if (flataddr < 0x4000):
        return "ROM0[${0:x}]".format(flataddr)
    else:
        return "ROMX[${0:x}], BANK[${1:x}]".format(0x4000 + flataddr % 0x4000, flataddr // 0x4000)
    
def format_control_code(cc, word = None):
    """Format a control code."""
    string = []
    
    string.append("«")
    string.append(cc)
    
    if word != None:
        string.append(format_int(word))
    
    string.append("»")
    
    return "".join(string)

def format_literal(chara, charmap = None):
    """Format a literal character."""
    if charmap is not None and chara in charmap:
        return charmap[chara]
    
    string = []
    
    string.append("«")
    string.append(format_int(chara))
    string.append("»")
    
    return "".join(string)

def extract(args):
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    banknames = extract_metatable_from_rom(args.rom, charmap, banknames, args)

    with open(args.rom, 'rb') as rom:
        for bank in banknames:
            wikitext = ["{|", "|-", "!Pointer", "!" + args.language]

            rom.seek(flat(bank["basebank"], bank["baseaddr"]))

            addr = bank["baseaddr"]
            end = 0x8000

            #Autodetect the end/length of the table by finding the lowest
            #pointer that isn't stored after an existing pointer
            while addr < end:
                next_ptr = PTR.unpack(rom.read(2))[0]

                #Reject obviously invalid pointers
                if (next_ptr < addr or next_ptr > 0x7FFF):
                    break

                end = min(end, next_ptr)
                addr += 2

            tbl_length = (addr - bank["baseaddr"]) // 2

            #Actually extract our strings
            string = []

            #Stores the actual end of the last string, used for alias detection
            last_start = 0xFFFF
            last_end = 0xFFFF
            last_nonaliasing_row = -1
            
            #Also store if a redirected/overflowed row is being extracted
            redirected = False
            old_loc = None
            
            for i in range(tbl_length):
                wikitext.append("|-")
                wikitext.append("|0x{0:x}".format(flat(bank["basebank"], bank["baseaddr"] + i * 2)))

                rom.seek(flat(bank["basebank"], bank["baseaddr"] + i * 2))
                read_ptr = PTR.unpack(rom.read(2))[0]

                #Attempt to autodetect "holes" in the text data.
                next_ptr = PTR.unpack(rom.read(2))[0]
                expected_length = next_ptr - read_ptr
                if i >= tbl_length - 1:
                    expected_length = -1 #maximum length by far

                #Two different alias detects:

                #First, we try to see if this pointer matches another pointer
                #in the table.
                rom.seek(flat(bank["basebank"], bank["baseaddr"]))
                for j in range(i):
                    if read_ptr == PTR.unpack(rom.read(2))[0]:
                        #Aliased pointer!
                        wikitext.append("|«ALIAS ROW 0x{0:x}»".format(j))
                        print("Pointer at 0x{0:x} fully aliases pointer 0x{1:x}".format(flat(bank["basebank"], bank["baseaddr"] + i * 2), flat(bank["basebank"], bank["baseaddr"] + j * 2)))
                        break
                else:
                    #Second, we try to see if this pointer is in the middle of
                    #the last string.
                    
                    #This alias detection breaks when the previous row uses the
                    #overflow code, so disable it if so.
                    if i > 0 and read_ptr < last_end - 1 and not redirected:
                        print("Pointer at 0x{0:x} partially aliases previous pointer".format(rom.tell() - 2))
                        wikitext.append("|«ALIAS ROW 0x{0:x} INTO 0x{1:x}»".format(last_nonaliasing_row, read_ptr - last_start))
                        continue

                    read_length = 1
                    first_read = True
                    rom.seek(flat(bank["basebank"], read_ptr))
                    
                    #Now we can initialize these...
                    redirected = False
                    old_loc = None
                    
                    while (rom.tell() % 0x4000 < 0x3FFF or rom.tell() == flat(bank["basebank"], bank["baseaddr"])):
                        next_chara = CHARA.unpack(rom.read(1))[0]
                        while (rom.tell() % 0x4000 < 0x3FFF or rom.tell() == flat(bank["basebank"], bank["baseaddr"])) and (read_length <= expected_length or first_read or redirected) and next_chara != 0xE0: #E0 is end-of-string
                            if next_chara < 0xE0 and next_chara in charmap[1]: #Control codes are the E0 block
                                string.append(charmap[1][next_chara])
                            elif next_chara in reverse_specials and specials[reverse_specials[next_chara]].redirect:
                                #Redirecting opcodes are transparently removed from the extracted text.
                                this_special = specials[reverse_specials[next_chara]]
                                
                                if this_special.bts:
                                    read_length += this_special.bts
                                    fmt = "<"+("", "B", "H")[this_special.bts]
                                    word = struct.unpack(fmt, rom.read(this_special.bts))[0]
                                    
                                    if word < 0x4000 or word > 0x7FFF:
                                        #Overflowing into RAM is illegal - use the jump opcode.
                                        #Overflowing into ROM0 is technically not illegal, but
                                        #unorthodox enough that we're going to disallow it.
                                        string.append(format_literal(this_special.byte))
                                        string.append(format_literal(word & 0xFF, charmap[1]))
                                        string.append(format_literal(word >> 8, charmap[1]))
                                    else:
                                        #We need to do this right now to avoid breaking hole detection
                                        old_loc = rom.tell()
                                        read_length = rom.tell() - flat(bank["basebank"], read_ptr)

                                        rom.seek(flat(args.overflow_bank, word))
                                        redirected = True
                                else:
                                    raise RuntimeError("Invalid specials dictionary. Redirecting special character is missing bts.")
                            elif next_chara in reverse_specials:
                                #This must be the work of an 「ＥＮＥＭＹ　ＳＴＡＮＤ」
                                this_special = specials[reverse_specials[next_chara]]
                                
                                if this_special.bts:
                                    read_length += this_special.bts
                                    fmt = "<"+("", "B", "H")[this_special.bts]
                                    word = struct.unpack(fmt, rom.read(this_special.bts))[0]
                                    string.append(format_control_code(reverse_specials[next_chara], word))
                                else:
                                    string.append(format_control_code(reverse_specials[next_chara]))

                                if this_special.end:
                                    first_read = False
                                    break
                            #elif next_chara == 0xE2:
                                #Literal newline
                            #    string.append(u"\n")
                            else:
                                #Literal specials
                                string.append(format_literal(next_chara))

                            next_chara = CHARA.unpack(rom.read(1))[0]
                            
                            #Explicitly stop updating read_length if the
                            #overflow opcode is used. Otherwise we'd think we
                            #read thousands or negative thousands of chars
                            if not redirected:
                                read_length = rom.tell() - flat(bank["basebank"], read_ptr)
                        
                        #After the main extraction loop
                        if read_length >= expected_length:
                            break
                        else:
                            #Detect nulls (spaces) after the end of a string
                            #and append them to avoid creating a new pointer row
                            loc = rom.tell()
                            if redirected:
                                loc = old_loc
                            
                            while CHARA.unpack(rom.read(1))[0] == charmap[0][" "] and read_length < expected_length:
                                string.append(" ")
                                loc += 1
                                read_length += 1

                            rom.seek(loc) #cleanup

                            if read_length >= expected_length:
                                break
                            else:
                                #There's a hole in the ROM!
                                #Disassemble the next string.
                                print("Inaccessible data found at 0x{0:x}".format(flat(bank["basebank"], read_ptr)))

                                wikitext.append("|" + "".join(string))
                                string = []

                                wikitext.append("|-")
                                wikitext.append("|(No pointer)")

                                read_length += 1

                    wikitext.append("|" + "".join(string))
                    string = []

                    #Store the actual end pointer for later use.
                    last_start = read_ptr
                    last_end = read_ptr + read_length
                    last_nonaliasing_row = i

            wikitext.append("|-")
            wikitext.append("|}")

            wikitext = "\n".join(wikitext)

            wikidir = os.path.join(args.output, bank["basedir"])
            wikipath = os.path.join(args.output, bank["filename"])

            install_path(wikidir)
            with io.open(wikipath, "w+", encoding="utf-8") as bank_wikitext:
                bank_wikitext.write(wikitext)

def asm(args):
    """Generate the ASM for the metatable and each section.

    This operation needs to be performed once, and once again if tables are to
    be relocated. To relocate tables, add a third parameter for that table into
    the bank names file with it's new flat address, regenerate the metatable
    ASM, then reassemble the ROM.

    Generated ASM will be printed to console. This portion of the script is
    intended to be piped into a file."""

    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    banknames = extract_metatable_from_rom(args.rom, charmap, banknames, args)

    print('SECTION "MainScript Meta Table", ' + format_sectionaddr_rom(args.metatable_loc))

    for bank in banknames:
        print("dw " + bank["symbol"])
        print("db BANK(" + bank["symbol"] + ')')

    print('')

    for bank in banknames:
        print('SECTION "' + bank["symbol"] + ' Section", ' + format_sectionaddr_rom(flat(bank["basebank"], bank["baseaddr"])))
        print(bank["symbol"] + ':')
        print('\tINCBIN "' + os.path.join(args.output, bank["objname"]).replace("\\", "/") + '"')
        print(bank["symbol"] + '_END')
        print('')

def pack_string(string, charmap, metrics, window_width, do_not_terminate = False):
    """Given a string, encode it as ROM table data.

    This function, if provided with metrics, will also automatically insert a
    newline after window_width pixels."""

    text_data = ""
    line_data = ""
    line_px = 0
    word_data = ""
    word_px = 0

    special = ""
    skip_sentinel = False
    end_sentinel = do_not_terminate

    even_line = True

    #This closure necessary to ensure proper newline handling
    def encode(char):
        try:
            return charmap[0][char]
        except KeyError:
            print("Warning: Character 0x{0:x} does not exist in current ROM.\n".format(ord(char)))
            return charmap[0]["?"]

    #Empty strings indicate text strings that alias to the next string in
    #sequence.
    if string == "":
        return ""
    
    #Remove nowiki tags
    string = string.replace("<nowiki>", "")
    string = string.replace("</nowiki>", "")

    for char in string:
        if skip_sentinel:
            skip_sentinel = False
            continue

        if special:
            if char in ">»": #End of a control code.
                special = special[1:]
                is_literal = True

                try:
                    special_num = int(special, 16)
                except ValueError:
                    is_literal = False

                if is_literal and special_num == 0xE2:
                    #Nonstandard newline
                    word_data += str(chr(special_num))

                    if metrics:
                        word_px += metrics[special_num]

                    max_px = window_width if even_line else window_width - 8
                    if len(line_data) > 0 and line_px + word_px > max_px:
                        #Next word will overflow, so inject a newline.
                        text_data += line_data[:-1] + str(chr(0xE2))
                        line_data, line_px = word_data, word_px
                        even_line = not even_line
                    else:
                        #Flush the word to the line with no injected newline.
                        line_data += word_data
                        line_px += word_px

                    word_data, word_px = "", 0

                    text_data += line_data
                    line_data, line_px = "", 0
                    even_line = not even_line
                elif is_literal and not special.startswith("D"):
                    if special_num > 255:
                        print("Warning: Invalid literal special {} (0x{:3x})".format(special_num, special_num))
                        continue

                    word_data += str(chr(special_num))

                    if metrics:
                        word_px += metrics[special_num]
                else:
                    ctrl_code = special[0]
                    if ctrl_code not in list(specials.keys()):
                        print("Warning: Invalid control code: ")
                        for char in ctrl_code:
                            print("{0:x}".format(ord(char)))
                        print("\n")
                        print("Found in line " + string.encode("utf-8") + "\n")
                        special = ""
                        continue

                    s = specials[ctrl_code]
                    val = special[1:]
                    word_data += str(chr(s.byte))

                    for value, name in list(s.names.items()):
                        if name == val:
                            val = value
                            break
                    else:
                        if val[:2] == "0x":
                            val = int(val[2:], 16)
                        else:
                            val = int(val, s.base)

                    if val == "":
                        val = s.default

                    if s.bts:
                        fmt = "<" + ("", "B", "H")[s.bts]
                        word_data += struct.pack(fmt, val)

                    if s.end:
                        end_sentinel = True

                    if special[0] == "&":
                        if val == 0xd448:
                            word_px += 3*8
                        else:
                            word_px += 8*8

                special = ""
            else:
                special += char
        else:
            if char == "\\":
                skip_sentinel = True

            if char in "<«":
                special = char
            else:
                if char in "\r":
                    #Fix CRLF-based files parsed on LF operating systems.
                    #NOTE: Breaks on Mac OS 9 and lower. Who cares?
                    continue
                
                if char not in "\n":
                    enc_char = encode(char)
                    word_data += str(chr(enc_char))
                    
                    if metrics:
                        word_px += metrics[enc_char] + 1
                
                if char in (" ", "\n"):
                    max_px = window_width if even_line else window_width - 8
                    if len(line_data) > 0 and line_px + word_px > max_px:
                        #Next word will overflow, so inject a newline.
                        text_data += line_data[:-1] + str(chr(0xE2))
                        line_data, line_px = word_data, word_px
                        even_line = not even_line
                    else:
                        #Flush the word to the line with no injected newline.
                        line_data += word_data
                        line_px += word_px
                    
                    word_data, word_px = "", 0
                    
                    if char in "\n" and len(line_data) > 0:
                        text_data += line_data + str(chr(0xE2))
                        line_data = ""
                        line_px = 0
                        even_line = not even_line

    #Slight alteration: Don't inject a newline if there's no line data that
    #needs to have it injected.
    line_window_width = (window_width if even_line else window_width - 8)
    if len(line_data) > 0 and line_px + word_px > line_window_width:
        text_data += line_data[:-1] + str(chr(0xE2))
        line_data = word_data
    else:
        line_data += word_data
    text_data += line_data

    if not end_sentinel:
        text_data += "\xe1\x00" #Null terminator

    return text_data

def parse_wikitext(wikifile):
    wikitext = wikifile.read()
    tbl_start = wikitext.find("{|")
    tbl_end = wikitext.find("|}")
    rows = wikitext[tbl_start:tbl_end].split("|-")
    parsed_rows = []
    parsed_hdrs = []

    for row in rows:
        cols = row.split("\n|")[1:]
        hdrs = row.split("\n!")[1:]

        if len(hdrs) > 0:
            #Extract headers
            for col in hdrs:
                parsed_hdrs.append(col.strip())
        elif len(cols) > 0:
            #Extract translations
            stripped_cols = []
            for col in cols:
                if len(col) == 0:
                    continue
                
                #Conservatively strip one newline from the end of the string only.
                if col[-1] == "\n":
                    col = col[:-1]

                stripped_cols.append(col)
            parsed_rows.append(stripped_cols)

    return parsed_rows, parsed_hdrs

def parse_csv(csvfile):
    csvreader = csv.reader(csvfile)
    headers = None
    rows = []

    for row in csvreader:
        if headers is None:
            headers = [cell.decode("utf-8") for cell in row]
        else:
            rows.append([cell.decode("utf-8") for cell in row])
    
    return rows, headers

def make_tbl(args):
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    banknames = extract_metatable_from_rom(args.rom, charmap, banknames, args)
    
    overflow_strings = []
    overflow_ptr = 0x4000
    overflow_bank_id = None
    
    if args.language == "Japanese":
        metrics = None
    else:
        metrics = extract_metrics_from_rom(args.rom, charmap, banknames, args)
    
    for h, bank in enumerate(banknames):
        last_aliased_row = -1
        
        if bank["filename"].startswith("overflow"):
            #Don't attempt to compile the overflow bank. That's a separate pass
            overflow_bank_id = h
            continue
        
        #If filenames are specified, don't bother because we can't do on-demand
        #compilation anyway and the makefile gets the path wrong
        
        print("Compiling " + bank["filename"])
        #Open and parse the data
        with open(os.path.join(args.output, bank["filename"]), "r") as csvfile:
            rows, headers = parse_csv(csvfile)

        #Determine what column we want
        ptr_col = headers.index("Pointer")
        try:
            str_col = headers.index(args.language)
        except ValueError:
            str_col = ptr_col

        #Pack our strings
        table = []
        packed_strings = [""] * len(rows)

        baseaddr = bank["baseaddr"]
        lastbk = None

        bank_window_width = args.window_width
        if "window_width" in list(bank.keys()):
            bank_window_width = bank["window_width"]
            
        last_table_index = 0

        for i, row in enumerate(rows):
            if "#" in row[ptr_col]:
                print("Row {} is not a message, skipped".format(i))
                continue
                
            if row[ptr_col] != "(No pointer)":
                table_idx = (int(row[ptr_col][2:], 16) - bank["baseaddr"]) % 0x4000 // 2
                last_table_index = table_idx
            else:
                table_idx = last_table_index
            
            if str_col >= len(row):
                print("WARNING: ROW {} IS MISSING IT'S TEXT!!!".format(i))
                table.append(baseaddr)
                packed_strings[table_idx] = pack_string("/0x{0:X}/".format(table_idx), charmap, metrics, bank_window_width)
                continue
            
            if row[str_col][:11] == "«ALIAS ROW " or row[str_col][:11] == "<ALIAS ROW ":
                #Aliased string!
                split_row = row[str_col][11:-1].split(" ")
                if len(split_row) > 1 and split_row[1] == "INTO":
                    #Partial string alias.
                    table.append(table[int(split_row[0], 16)] + int(split_row[2], 16))
                    packed_strings[table_idx] = ""
                else:
                    table.append(table[int(split_row[0], 16)])
                    packed_strings[table_idx] = ""
                
                #We don't want to have to try to handle both overflow and
                #aliasing at the same time, so don't.
                last_aliased_row = table_idx
            else:
                packed = pack_string(row[str_col], charmap, metrics, bank_window_width, row[ptr_col] == "(No pointer)")
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
        
        #Moveup pointers to account for the table size
        for i, value in enumerate(table):
            table[i] = PTR.pack(value + len(table) * 2)
            
        #Overflow detection + handling
        bytes_remaining = 0x4000
        for line in table:
            bytes_remaining -= len(line)
        
        for line in packed_strings:
            bytes_remaining -= len(line)
        
        if bytes_remaining <= 0:
            print("Bank " + bank["filename"] + " exceeds size of MBC bank limit by 0x{0:x} bytes".format(abs(bytes_remaining)))
            
            #Compiled bank exceeds the amount of space available in the bank.
            #Start assigning strings from the last one forward to be spilled
            #into the overflow bank. This reduces their size to 3.
            strings_to_spill = 0
            string_bytes_saved = 0
            
            for table_idx, spill_string in reversed(list(enumerate(packed_strings))):
                if table_idx == last_aliased_row:
                    #We can't spill aliased rows, nor do we want to attempt to
                    #support that usecase, since it would be too much work.
                    #Instead, stop spilling at the end.
                    print("WARNING: Terminating spills at 0x{0:x} due to aliasing.".format(table_idx))
                    print("Your bank likely will not fit upon assembly.")
                    print("Please consider removing aliasing rows.")
                    break
                
                strings_to_spill += 1
                string_bytes_saved += len(packed_strings[table_idx]) - 3
                
                if string_bytes_saved + bytes_remaining > 0:
                    #That's enough! Stop counting bytes, we've spilled enough.
                    break
            
            #Actually spill strings to the overflow bank now, in order.
            for table_idx in range(len(packed_strings) - strings_to_spill, len(packed_strings)):
                cur_string = packed_strings[table_idx]
                packed_strings[table_idx] = "\xec" + chr(overflow_ptr & 0xFF) + chr(overflow_ptr >> 8)
                
                if table_idx < len(table) - 1:
                    #fixup the next pointer in the table
                    thisptr = PTR.unpack(table[table_idx])[0]
                    table[table_idx + 1] = PTR.pack(thisptr + len(packed_strings[table_idx]))
                
                overflow_strings.append(cur_string)
                overflow_ptr += len(cur_string)
                
            print("Spilled 0x{0:x} bytes to overflow bank".format(abs(string_bytes_saved)))

        #Write the data out to the object files. We're done here!
        with open(os.path.join(args.output, bank["objname"]), "wb") as objfile:
            for line in table:
                objfile.write(line)

            for line in packed_strings:
                objfile.write(line)
    
    if overflow_bank_id is not None:
        with open(os.path.join(args.output, banknames[overflow_bank_id]["objname"]), "wb") as objfile:
            for line in overflow_strings:
                objfile.write(line)

def wikisync(args):
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    
    for h, bank in enumerate(banknames):
        api_url = "http://wiki.telefang.net/api.php?action=query&titles=Wikifang:Telefang_1_Translation_Patch/Text_dump/{}&format=json&prop=revisions&rvprop=content".format(bank["wikiname"].strip())
        full_wikiname = "Wikifang:Telefang 1 Translation Patch/Text dump/{}".format(bank["wikiname"].strip())
        
        wikifile = urllib.request.urlopen(api_url)
        data = json.load(wikifile)
        
        for pageid in data["query"]["pages"]:
            if data["query"]["pages"][pageid]["title"] == full_wikiname:
                wikidir = os.path.join(args.output, bank["basedir"])
                wikipath = os.path.join(args.output, bank["filename"])
                
                install_path(wikidir)
                with io.open(wikipath, "w", encoding="utf-8") as bank_wikitext:
                    bank_wikitext.write(data["query"]["pages"][pageid]["revisions"][0]["*"])

def update_data(args):
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    
    for h, bank in enumerate(banknames):
        #Wikitext to CSV conversion pass
        #At the end of this conversion, the wikitext will be deleted and a CSV
        #will have been created. Existing CSV file will be deleted, if any.
        try:
            with io.open(os.path.join(args.output, bank["legacy_filename"]), 'r', encoding="utf-8") as bank_wikifile:
                rows, hdrs = parse_wikitext(bank_wikifile)
                
                with open(os.path.join(args.output, bank["filename"]), "w") as bank_csvfile:
                    csvwriter = csv.writer(bank_csvfile)
                    
                    encoded_hdrs = [hdr.encode("utf-8") for hdr in hdrs]
                    csvwriter.writerow(encoded_hdrs)
                    
                    for row in rows:
                        encoded_row = [cell.encode("utf-8") for cell in row]
                        csvwriter.writerow(encoded_row)
            
            os.remove(os.path.join(args.output, bank["legacy_filename"]))
        except IOError:
            pass
        
        #Special characters conversion pass
        #Change double-brackets to single brackets.

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('--charmap', type=str, default="charmap.asm")
    ap.add_argument('--banknames', type=str, default="rip_scripts/mainscript_bank_names.txt")
    ap.add_argument('--language', type=str, default="Japanese")
    ap.add_argument('--output', type=str, default="script")
    ap.add_argument('--metatable_loc', type=int, default=METATABLE_LOC)
    ap.add_argument('--metrics_loc', type=int, default=0x2FB00)
    ap.add_argument('--window_width', type=int, default=16 * 8) #16 tiles
    ap.add_argument('--overflow_bank', type=int, default=0x1E)
    ap.add_argument('rom', type=str)
    ap.add_argument('filenames', type=str, nargs="*")
    args = ap.parse_args()

    method = {
        "extract": extract,
        "asm": asm,
        "make_tbl": make_tbl,
        "wikisync": wikisync,
        "update_data": update_data
    }.get(args.mode, None)

    if method == None:
        raise Exception("Unknown conversion method!")

    method(args)

if __name__ == "__main__":
    main()
