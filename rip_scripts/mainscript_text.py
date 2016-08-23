# coding=utf-8
from __future__ import division

# mainscript_text.py
# Injects (and/or extracts) main script data from the master metatable.

import argparse
import errno
import sys
import os
import os.path
import struct
import io, codecs
import exceptions

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
    def __init__(self, byte, default=0, bts=1, end=False, names=None):
        self.byte = byte
        self.default = default
        self.bts = bts
        self.end = end
        self.names = names if names else {}

specials = {}
specials["&"] = Special(0xe5, bts=2, names={0xc92c: "name", 0xd448: "num"})
specials['S'] = Special(0xe3, default=2)
specials['*'] = Special(0xe1, end=True)
specials['D'] = Special(0xe9)

#Used here for text extraction from the ROM.
reverse_specials = {}
reverse_specials[0xE5] = "&"
reverse_specials[0xE3] = "S"
reverse_specials[0xE1] = "*"
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
            if chara == u"":
                #Special case: Quoted quotes.
                #   e.g. charmap """, $22

                #This parsing logic sucks arse.
                if len(delim_split) > 3:
                    chara = u"\""

            if chara == u"\\n":
                chara = u"\n"

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
            bank["filename"] = os.path.join(*(parameters[0] + ".wikitext").split("/"))
            bank["objname"] = os.path.join(*(parameters[0] + ".scripttbl").split("/"))
            bank["wikiname"] = parameters[1]
            bank["symbol"] = "MainScript_" + parameters[0].replace("/", "_")

            if len(parameters) > 2:
                #Parameter 3 is the flat address for the ROM
                #If not present, location of table will be determined from ROM
                flatattr = int(parameters[2], 16)

                if (flatattr < 0x4000):
                    bank["baseaddr"] = flatattr
                    bank["basebank"] = 0
                else:
                    bank["baseaddr"] = flatattr % 0x4000 + 0x4000
                    bank["basebank"] = flatattr // 0x4000

            banks.append(bank)

    return banks

METATABLE_FARPTR = struct.Struct("<HB")
PTR = struct.Struct("<H")
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

            if "baseaddr" not in bank.keys():
                bank["baseaddr"] = parsed[0]
                bank["basebank"] = parsed[1]

            banks.append(bank)

    return banks

def flat(bank, addr):
    if (addr < 0x4000):
        return addr

    if (addr > 0x7FFF):
        return None #Maybe raise?

    return (bank * 0x4000) + (addr - 0x4000)

def format_int(i):
    if i < 0x10: #Small numbers lack the 0x
        return u"{0:x}".format(i)
    else: #Large numbers are hex
        return u"0x{0:x}".format(i)

def format_hex(i):
    if i < 0x10: #Small numbers lack the 0x
        return u"{0:x}".format(i)
    else: #Large numbers are hex
        return u"0x{0:x}".format(i)

def format_sectionaddr_rom(flataddr):
    """Format a flat address for the assembler's section macro."""
    if (flataddr < 0x4000):
        return u"ROM0[${0:x}]".format(flataddr)
    else:
        return u"ROMX[${0:x}], BANK[${1:x}]".format(0x4000 + flataddr % 0x4000, flataddr // 0x4000)

def extract(args):
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    banknames = extract_metatable_from_rom(args.rom, charmap, banknames, args)

    with open(args.rom, 'rb') as rom:
        for bank in banknames:
            wikitext = [u"{|", u"|-", u"!Pointer", u"!" + args.language]

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

            for i in range(tbl_length):
                wikitext.append(u"|-")
                wikitext.append(u"|0x{0:x}".format(flat(bank["basebank"], bank["baseaddr"] + i * 2)))

                rom.seek(flat(bank["basebank"], bank["baseaddr"] + i * 2))
                read_ptr = PTR.unpack(rom.read(2))[0]

                #Attempt to autodetect "holes" in the text data.
                next_ptr = PTR.unpack(rom.read(2))[0]
                expected_length = next_ptr - read_ptr
                if i >= tbl_length - 1:
                    expected_length = 0

                rom.seek(flat(bank["basebank"], bank["baseaddr"]))
                for j in range(i):
                    if read_ptr == PTR.unpack(rom.read(2))[0]:
                        #Aliased pointer!
                        wikitext.append(u"|«ALIAS ROW 0x{0:x}»".format(j))
                        print u"Aliased pointer {0:x}".format(j)
                        break
                else:
                    read_characters = 0
                    rom.seek(flat(bank["basebank"], read_ptr))

                    while True:
                        next_chara = CHARA.unpack(rom.read(1))[0]
                        while next_chara != 0xE0: #E0 is end-of-string
                            if next_chara < 0xE0 and next_chara in charmap[1]: #Control codes are the E0 block
                                string.append(charmap[1][next_chara])
                            elif next_chara in reverse_specials:
                                #This must be the work of an 「ＥＮＥＭＹ　ＳＴＡＮＤ」
                                this_special = specials[reverse_specials[next_chara]]
                                string.append(u"«")
                                string.append(reverse_specials[next_chara])

                                if this_special.bts:
                                    fmt = "<"+("", "B", "H")[this_special.bts]
                                    word = struct.unpack(fmt, rom.read(this_special.bts))[0]
                                    string.append(format_int(word))

                                string.append(u"»")

                                if this_special.end:
                                    break
                            #elif next_chara == 0xE2:
                                #Literal newline
                            #    string.append(u"\n")
                            else:
                                #Literal specials
                                string.append(u"«")
                                string.append(format_int(next_chara))
                                string.append(u"»")

                            next_chara = CHARA.unpack(rom.read(1))[0]

                        print 0x4000 + rom.tell() - flat(bank["basebank"], 0x4000) - read_ptr

                        if 0x4000 + rom.tell() - flat(bank["basebank"], 0x4000) - read_ptr >= expected_length:
                            break
                        else:
                            #There's a hole in the ROM!
                            #Disassemble the next string.
                            print u"Found a hole in our ROM!"
                            wikitext.append(u"|" + u"".join(string))
                            string = []

                            wikitext.append(u"|-")
                            wikitext.append(u"|(No pointer)")

                    wikitext.append(u"|" + u"".join(string))
                    string = []

            wikitext.append(u"|-")
            wikitext.append(u"|}")

            wikitext = u"\n".join(wikitext)

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

    print u'SECTION "MainScript Meta Table", ' + format_sectionaddr_rom(args.metatable_loc)

    for bank in banknames:
        print u"dw " + bank["symbol"]
        print u"db BANK(" + bank["symbol"] + u')'

    print u''

    for bank in banknames:
        print u'SECTION "' + bank["symbol"] + u' Section", ' + format_sectionaddr_rom(flat(bank["basebank"], bank["baseaddr"]))
        print bank["symbol"] + u':'
        print u'\tINCBIN "' + os.path.join(args.output, bank["objname"]).replace("\\", "/") + u'"'
        print bank["symbol"] + u'_END'
        print u''

def pack_string(string, charmap, metrics, window_width):
    """Given a string, encode it as ROM table data.

    This function, if provided with metrics, will also automatically insert a
    newline after window_width pixels."""

    text_data = ""
    line_data = ""
    line_px = 0
    word_data = ""
    word_px = 0

    special = u""
    skip_sentinel = False
    end_sentinel = False

    even_line = True

    #This closure necessary to ensure proper newline handling
    def encode(char):
        try:
            return charmap[0][char]
        except KeyError:
            print u"Warning: Character 0x{0:x} does not exist in current ROM.\n".format(ord(char))
            return charmap[0][u"?"]

    #Empty strings indicate text strings that alias to the next string in
    #sequence.
    if string == "":
        return ""

    for char in string:
        if skip_sentinel:
            skip_sentinel = False
            continue

        if special:
            if char in u">»": #End of a control code.
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
                        print u"Warning: Invalid literal special {} (0x{:3x})".format(special_num, special_num)
                        continue

                    word_data += str(chr(special_num))

                    if metrics:
                        word_px += metrics[special_num]
                else:
                    ctrl_code = special[0]
                    if ctrl_code not in specials.keys():
                        print u"Warning: Invalid control code: "
                        for char in ctrl_code:
                            print u"{0:x}".format(ord(char))
                        print u"\n"
                        special = u""
                        continue

                    s = specials[ctrl_code]
                    val = special[1:]
                    word_data += str(chr(s.byte))

                    for value, name in s.names.items():
                        if name == val:
                            val = value
                            break
                    else:
                        val = int(val, 16)

                    if val == u"":
                        val = s.default

                    if s.bts:
                        fmt = "<" + ("", "B", "H")[s.bts]
                        word_data += struct.pack(fmt, val)

                    if s.end:
                        end_sentinel = True

                    if special[0] == u"&":
                        if val == 0xd448:
                            word_px += 3*8
                        else:
                            word_px += 8*8

                special = u""
            else:
                special += char
        else:
            if char == u"\\":
                skip_sentinel = True

            if char in u"<«":
                special = char
            else:
                enc_char = encode(char)
                word_data += str(chr(enc_char))

                if metrics:
                    word_px += metrics[enc_char] + 1

                if char in (u" ", u"\n"):
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

                if char == u"\n":
                    text_data += line_data
                    line_data, line_px = "", 0
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

def parse_wikitext(wikitext):
    tbl_start = wikitext.find(u"{|")
    tbl_end = wikitext.find(u"|}")
    rows = wikitext[tbl_start:tbl_end].split(u"|-")
    parsed_rows = []
    parsed_hdrs = []

    for row in rows:
        cols = row.split(u"\n|")[1:]
        hdrs = row.split(u"\n!")[1:]

        if len(hdrs) > 0:
            #Extract headers
            for col in hdrs:
                parsed_hdrs.append(col.strip())
        elif len(cols) > 0:
            #Extract translations
            stripped_cols = []
            for col in cols:
                #Conservatively strip one newline from the end of the string only.
                if col[-1] == "\n":
                    col = col[:-1]

                stripped_cols.append(col)
            parsed_rows.append(stripped_cols)

    return parsed_rows, parsed_hdrs

def make_tbl(args):
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    banknames = extract_metatable_from_rom(args.rom, charmap, banknames, args)

    if args.language == u"Japanese":
        metrics = None
    else:
        #TODO: Parse and apply metrics for Latin-1 language patches.
        raise exceptions.NotImplementedError("VWF ROMs can't be injected yet")

    for bank in banknames:
        print "Compiling " + bank["filename"]
        #If filenames are specified, only export banks that are mentioned there
        if len(args.filenames) > 0 and bank["objname"] not in args.filenames:
            continue

        #Open and parse the data
        with io.open(os.path.join(args.output, bank["filename"]), "r", encoding="utf-8") as wikifile:
            rows, headers = parse_wikitext(wikifile.read())

        #Determine what column we want
        str_col = headers.index(args.language)
        ptr_col = headers.index(u"Pointer")

        #Pack our strings
        table = []
        packed_strings = [""] * len(rows)

        baseaddr = bank["baseaddr"]
        lastbk = None

        for i, row in enumerate(rows):
            if str_col >= len(row):
                print "WARNING: ROW {} IS MISSING IT'S TEXT!!!".format(i)
                packed_strings.append("")
                continue

            if row[str_col][:11] == u"«ALIAS ROW ":
                #Aliased string!
                table.append(table[int(row[str_col][11:-1], 16)])
                packed_strings.append("")
            else:
                packed = pack_string(row[str_col], charmap, metrics, args.window_width)
                packed_strings.append(packed)

                #DEBUG: Strings we're interested in
                if bank["filename"] == "npc\\1.wikitext" and i in (113, 114, 115):
                    print i
                    print codecs.encode(row[str_col], "utf-8")
                    print codecs.encode(row[str_col], "raw_unicode_escape")
                    print codecs.encode(packed, "hex")

                if row[ptr_col] != u"(No pointer)":
                    #Yes, some text banks have strings not mentioned in the
                    #table because screw you.
                    table.append(baseaddr)

                    #Sanity check: are our pointer numbers increasing?
                    nextbk = int(rows[i][ptr_col], 16)
                    if lastbk != None and nextbk != lastbk + 2:
                        print "Warning: Pointer " + rows[i][ptr_col] + " is out of order."
                    lastbk = nextbk
                else:
                    print "Warning: Row explicitly marked with no pointer"

                baseaddr += len(packed)

        #Moveup pointers to account for the table size
        for i, value in enumerate(table):
            table[i] = PTR.pack(value + len(table) * 2)

        #Write the data out to the object files. We're done here!
        with open(os.path.join(args.output, bank["objname"]), "wb") as objfile:
            for line in table:
                objfile.write(line)

            for line in packed_strings:
                objfile.write(line)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('--charmap', type=str, default="charmap.asm")
    ap.add_argument('--banknames', type=str, default="rip_scripts/mainscript_bank_names.txt")
    ap.add_argument('--language', type=str, default=u"Japanese")
    ap.add_argument('--output', type=str, default="script")
    ap.add_argument('--metatable_loc', type=int, default=METATABLE_LOC)
    ap.add_argument('--window_width', type=int, default=0x16 * 0x8) #16 tiles
    ap.add_argument('rom', type=str)
    ap.add_argument('filenames', type=str, nargs="*")
    args = ap.parse_args()

    method = {
        "extract": extract,
        "asm": asm,
        "make_tbl": make_tbl
    }.get(args.mode, None)

    if method == None:
        raise Exception, "Unknown conversion method!"

    method(args)

if __name__ == "__main__":
    main()
