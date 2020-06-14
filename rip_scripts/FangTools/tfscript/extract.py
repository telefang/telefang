"""Extraction utilities for the Telefang script."""

import os, csv
from FangTools.tfscript.banknames import parse_bank_names
from FangTools.tfmessage.pack import specials
from FangTools.tfmessage.unpack import reverse_specials
from FangTools.tfmessage.charmap import parse_charmap
from FangTools.fs import install_path
from FangTools.gb import METATABLE_FARPTR, PTR, CHARA, flat, struct
from FangTools.rgbds import format_literal, format_control_code

METATABLE_LOC = 0x2C94F

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

def extract(args):
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    banknames = extract_metatable_from_rom(args.rom, charmap, banknames, args)

    with open(args.rom, 'rb') as rom:
        for bank in banknames:
            wikitext = ["{|", "|-", "!Pointer", "!" + args.language]
            csvdata = [["Pointer", args.language]]

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
                csvrow = ["0x{0:x}".format(flat(bank["basebank"], bank["baseaddr"] + i * 2))]
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
                        csvrow.append("<ALIAS ROW 0x{0:x}>".format(j))
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
                        csvrow.append("<ALIAS ROW 0x{0:x} INTO 0x{1:x}>".format(last_nonaliasing_row, read_ptr - last_start))
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

                                csvrow.append("".join(string))
                                wikitext.append("|" + "".join(string))
                                string = []
                                
                                csvdata.append(csvrow)
                                csvrow = ["(No pointer)"]
                                wikitext.append("|-")
                                wikitext.append("|(No pointer)")

                                read_length += 1
                    
                    csvrow.append("".join(string))
                    wikitext.append("|" + "".join(string))
                    string = []

                    #Store the actual end pointer for later use.
                    last_start = read_ptr
                    last_end = read_ptr + read_length
                    last_nonaliasing_row = i
            
                csvdata.append(csvrow)
            
            wikitext.append("|-")
            wikitext.append("|}")

            wikitext = "\n".join(wikitext)

            wikidir = os.path.join(args.input, bank["basedir"])
            wikipath = os.path.join(args.input, bank["legacy_filename"])
            csvpath = os.path.join(args.input, bank["filename"])

            install_path(wikidir)
            #with open(wikipath, "w+", encoding="utf-8") as bank_wikitext:
                #bank_wikitext.write(wikitext)
            
            with open(csvpath, "w+", encoding="utf-8") as bank_csvtext:
                csvwriter = csv.writer(bank_csvtext)
                
                for csvrow in csvdata:
                    csvwriter.writerow(csvrow)