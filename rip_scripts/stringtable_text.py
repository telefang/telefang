# coding=utf-8
from __future__ import division

import mainscript_text
import argparse, io, os.path

def parse_tablenames(filename):
    """Parse the list of table names
    
    #name baseaddr stride count"""
    tables = []

    with io.open(filename, "r", encoding="utf-8") as tablenames:
        for line in tablenames:
            if line[0] == "#" or line == "":
                continue

            parameters = line.split(" ")
            
            if len(parameters) < 4:
                continue

            table = {}
            table["basedir"] = os.path.join(*parameters[0].split("/")[0:-1])
            table["filename"] = os.path.join(*(parameters[0] + ".wikitext").split("/"))
            table["objname"] = os.path.join(*(parameters[0] + ".stringtbl").split("/"))
            #table["wikiname"] = parameters[1]
            table["symbol"] = "MainScript_" + parameters[0].replace("/", "_")
            
            #Parameter 2 is the flat address for the ROM
            flatattr = int(parameters[1], 16)

            if (flatattr < 0x4000):
                table["baseaddr"] = flatattr
                table["basebank"] = 0
            else:
                table["baseaddr"] = flatattr % 0x4000 + 0x4000
                table["basebank"] = flatattr // 0x4000
                
            #The other parameters are the length of each entry and the total
            #entry count. Base 10 this time.
            table["stride"] = int(parameters[2], 10)
            table["count"] = int(parameters[3], 10)

            tables.append(table)

    return tables

def extract(args):
    charmap = mainscript_text.parse_charmap(args.charmap)
    tablenames = parse_tablenames(args.tablenames)

    with open(args.rom, 'rb') as rom:
        for table in tablenames:
            wikitext = [u"{|", u"|-", u"!#", u"!" + args.language]

            rom.seek(mainscript_text.flat(table["basebank"], table["baseaddr"]))

            addr = table["baseaddr"]
            end = 0x8000
            
            #Actually extract our strings
            string = []
            
            for i in range(table["count"]):
                wikitext.append(u"|-")
                wikitext.append(u"|{0}".format(i))

                rom.seek(mainscript_text.flat(table["basebank"], table["baseaddr"] + i * table["stride"]))
                
                for j in range(table["stride"]):
                    next_chara = mainscript_text.CHARA.unpack(rom.read(1))[0]
                    
                    if next_chara < 0xE0 and next_chara in charmap[1]: #Control codes are the E0 block
                        string.append(charmap[1][next_chara])
                    elif next_chara in mainscript_text.reverse_specials:
                        #This must be the work of an 「ＥＮＥＭＹ　ＳＴＡＮＤ」
                        this_special = specials[mainscript_text.reverse_specials[next_chara]]
                        string.append(u"«")
                        string.append(mainscript_text.reverse_specials[next_chara])

                        if this_special.bts:
                            read_length += this_special.bts
                            fmt = "<"+("", "B", "H")[this_special.bts]
                            word = struct.unpack(fmt, rom.read(this_special.bts))[0]
                            string.append(mainscript_text.format_int(word))

                        string.append(u"»")

                        if this_special.end:
                            first_read = False
                            break
                    elif next_chara == 0xE0:
                        #End of string
                        break
                    else:
                        #Literal specials
                        string.append(u"«")
                        string.append(mainscript_text.format_int(next_chara))
                        string.append(u"»")

                wikitext.append(u"|" + u"".join(string))
                string = []

            wikitext.append(u"|-")
            wikitext.append(u"|}")

            wikitext = u"\n".join(wikitext)

            wikidir = os.path.join(args.output, table["basedir"])
            wikipath = os.path.join(args.output, table["filename"])

            mainscript_text.install_path(wikidir)
            with io.open(wikipath, "w+", encoding="utf-8") as table_wikitext:
                table_wikitext.write(wikitext)

def make_tbl(args):
    pass

def asm(args):
    """Generate the ASM for string tables.

    This operation needs to be performed once, plus 

    Generated ASM will be printed to console. This portion of the script is
    intended to be piped into a file."""

    charmap = mainscript_text.parse_charmap(args.charmap)
    tablenames = parse_tablenames(args.tablenames)
    
    for table in tablenames:
        print u'SECTION "' + table["symbol"] + u' Section", ' + mainscript_text.format_sectionaddr_rom(mainscript_text.flat(table["basebank"], table["baseaddr"]))
        print table["symbol"] + u':'
        print u'\tINCBIN "' + os.path.join(args.output, table["objname"]).replace("\\", "/") + u'"'
        print table["symbol"] + u'_END'
        print u''

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('--charmap', type=str, default="charmap.asm")
    ap.add_argument('--tablenames', type=str, default="rip_scripts/stringtable_names.txt")
    ap.add_argument('--language', type=str, default=u"Japanese")
    ap.add_argument('--output', type=str, default="script")
    ap.add_argument('--metrics_loc', type=int, default=0x2FB00)
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
