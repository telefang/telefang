# coding=utf-8


# mainscript_text.py
# Injects (and/or extracts) main script data from the master metatable.

import argparse, os, io, json, csv, urllib.request
from FangTools.tfscript.commands import make_tbl
from FangTools.tfscript.extract import METATABLE_LOC, extract_metatable_from_rom, extract
from FangTools.tfscript.banknames import parse_bank_names
from FangTools.tfmessage.charmap import parse_charmap
from FangTools.gb import flat
from FangTools.rgbds import format_sectionaddr_rom
from FangTools.fs import install_path

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
                wikidir = os.path.join(args.input, bank["basedir"])
                wikipath = os.path.join(args.input, bank["filename"])
                
                install_path(wikidir)
                with open(wikipath, "w", encoding="utf-8") as bank_wikitext:
                    bank_wikitext.write(data["query"]["pages"][pageid]["revisions"][0]["*"])

def update_data(args):
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    
    for h, bank in enumerate(banknames):
        #Wikitext to CSV conversion pass
        #At the end of this conversion, the wikitext will be deleted and a CSV
        #will have been created. Existing CSV file will be deleted, if any.
        try:
            with io.open(os.path.join(args.input, bank["legacy_filename"]), 'r', encoding="utf-8") as bank_wikifile:
                rows, hdrs = parse_wikitext(bank_wikifile)
                
                with open(os.path.join(args.output, bank["filename"]), "w", encoding="utf-8") as bank_csvfile:
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
    ap.add_argument('--output', type=str, default="build")
    ap.add_argument('--input', type=str, default="")
    ap.add_argument('--metatable_loc', type=int, default=METATABLE_LOC)
    ap.add_argument('--metrics', type=str, default="components/mainscript/metrics.tffont.csv")
    ap.add_argument('--window_width', type=int, default=15 * 8) #15 tiles
    ap.add_argument('--overflow_bank', type=int, default=0x1E)
    ap.add_argument('rom', type=str)
    ap.add_argument('filenames', type=str, nargs="*")
    ap.add_argument('output_filename', type=str)
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
