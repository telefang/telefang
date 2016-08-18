# coding=utf-8
from __future__ import division

# mainscript_text.py
# Injects (and/or extracts) main script data from the master metatable.

import argparse
import errno
import os
import os.path
import struct
import codecs

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

    with codecs.open(filename, "r", "utf-8") as charmap:
        for line in charmap:
            if CHARMAP_DELIM not in line:
                continue

            if line[0] == "#":
                continue

            delim_split = line.split('"')
            chara = delim_split[1]
            unparsed_hex = delim_split[2].split("$")[1].strip()
            bytes = 0

            for i in range(0, len(unparsed_hex), 2):
                bytes += int(unparsed_hex[i:i+2], 16) << i // 2

            mapping[chara] = bytes
            reverse_mapping[bytes] = chara

    return mapping, reverse_mapping

def parse_bank_names(filename):
    """Parse the list of bank names"""
    banks = []

    with codecs.open(filename, "r", "utf-8") as banknames:
        for line in banknames:
            if line[0] == "#":
                continue

            parameters = line.split(" ")

            bank = {}
            bank["basedir"] = os.path.join(*parameters[0].split("/")[0:-1])
            bank["filename"] = os.path.join(*(parameters[0] + ".wikitext").split("/"))
            bank["wikiname"] = parameters[1]
            bank["symbol"] = "MainScript_" + parameters[0].replace("/", "_")

            banks.append(bank)

    return banks

METATABLE_FARPTR = struct.Struct("<HB")
PTR = struct.Struct("<H")
CHARA = struct.Struct("<B") #Pack or be packed

def extract_metatable_from_rom(rom_filename, charmap, banknames):
    """Parse the master script metatable"""
    banks = []

    with open(rom_filename, 'rb') as rom:
        rom.seek(METATABLE_LOC)

        for bankdata in banknames:
            entry = rom.read(3)
            parsed = METATABLE_FARPTR.unpack(entry)

            bank = bankdata.copy()
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
    if i < 0x10: #Small numbers are treated as decimal
        return u"{0}".format(i)
    else: #Large numbers are hex
        return u"0x{0:x}".format(i)

def extract(rom_filename, charmap, banknames, args):
    with open(rom_filename, 'rb') as rom:
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

                rom.seek(flat(bank["basebank"], read_ptr))
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
                    else:
                        #Literal specials
                        string.append(u"«")
                        string.append(format_int(next_chara))
                        string.append(u"»")

                    next_chara = CHARA.unpack(rom.read(1))[0]

                wikitext.append(u"|" + u"".join(string))
                string = []

            wikitext.append(u"|-")
            wikitext.append(u"|}")

            wikitext = u"\n".join(wikitext)

            wikidir = os.path.join(args.output, bank["basedir"])
            wikipath = os.path.join(args.output, bank["filename"])

            install_path(wikidir)
            with codecs.open(wikipath, "w+", "utf-8") as bank_wikitext:
                bank_wikitext.write(wikitext)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('--charmap', type=str, default="charmap.asm")
    ap.add_argument('--banknames', type=str, default="rip_scripts/mainscript_bank_names.txt")
    ap.add_argument('--language', type=str, default="Japanese")
    ap.add_argument('--output', type=str, default="script")
    ap.add_argument('filename', type=str)
    args = ap.parse_args()

    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    banknames = extract_metatable_from_rom(args.filename, charmap, banknames)

    method = {
        "extract": extract
    }.get(args.mode, None)

    if method == None:
        raise Exception, "Unknown conversion method!"

    method(args.filename, charmap, banknames, args)

if __name__ == "__main__":
    main()
