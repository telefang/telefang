# coding=utf-8
from __future__ import division

import mainscript_text
import argparse, io, os.path, csv, math, struct

def parse_tablenames(filename):
    """Parse the list of table names
    
    #name baseaddr (table) stride count
    #name baseaddr (block)
    #name baseaddr (index) foreign_name"""
    tables = []
    tbl_index = {}

    with io.open(filename, "r", encoding="utf-8") as tablenames:
        for line in tablenames:
            if line[0] == "#" or line == "":
                continue

            parameters = line.strip().split(" ")
            
            if len(parameters) < 4:
                continue

            table = {}
            table["name"] = parameters[0]
            table["basedir"] = os.path.join(*(parameters[0].split("/")[0:-1]))
            table["filename"] = os.path.join(*(parameters[0] + ".csv").split("/"))
            table["symbol"] = "StringTable_" + parameters[0].replace("/", "_")
            table["format"] = parameters[2]

            if table["format"] == "table":
                table["objname"] = os.path.join(*(parameters[0] + ".stringtbl").split("/"))

                #The other parameters are the length of each entry and the total
                #entry count. Base 10 this time.
                table["count"] = int(parameters[3], 10)
                table["stride"] = int(parameters[4], 10)
            elif table["format"] == "index":
                table["objname"] = os.path.join(*(parameters[0] + ".stringidx").split("/"))
                table["count"] = int(parameters[3], 10)
                table["foreign_name"] = parameters[4]
            elif table["format"] == "block":
                table["objname"] = os.path.join(*(parameters[0] + ".stringblk").split("/"))
                table["count"] = int(parameters[3], 10)
            
            #Parameter 2 is the flat address for the ROM
            flatattr = int(parameters[1], 16)

            if (flatattr < 0x4000):
                table["baseaddr"] = flatattr
                table["basebank"] = 0
            else:
                table["baseaddr"] = flatattr % 0x4000 + 0x4000
                table["basebank"] = flatattr // 0x4000

            table["id"] = len(tables)
            tbl_index[table["name"]] = table["id"]
            tables.append(table)

    #Fixup foreign names
    for i, row in enumerate(tables):
        try:
            tables[i]["foreign_id"] = tbl_index[row["foreign_name"]]
        except KeyError:
            pass

    return tables

def extract_string(rom, charmap, max_length = None):
    """Extract characters from the given file until exhausted.

    This function will extract unti it reaches a terminal character, it will
    return annotated text. You may limit the maximum string length in bytes
    read with max_length."""

    string = []
    read_chara = 0

    while True:
        if max_length is not None and read_chara >= max_length:
            break

        next_chara = mainscript_text.CHARA.unpack(rom.read(1))[0]
        read_chara += 1

        if next_chara < 0xE0 and next_chara in charmap[1]: #Control codes are the E0 block
            string.append(charmap[1][next_chara])
        elif next_chara in mainscript_text.reverse_specials:
            #This must be the work of an 「ＥＮＥＭＹ　ＳＴＡＮＤ」
            this_special = mainscript_text.specials[mainscript_text.reverse_specials[next_chara]]
            string.append(u"«")
            string.append(mainscript_text.reverse_specials[next_chara])

            if this_special.bts:
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

    return u"".join(string)

def extract(args):
    charmap = mainscript_text.parse_charmap(args.charmap)
    tablenames = parse_tablenames(args.tablenames)

    with open(args.rom, 'rb') as rom:
        for table in tablenames:
            #Indexes are extracted in a second pass
            if table["format"] == "index":
                continue
            
            entries = []
            reverse_entries = {}

            csvdir = os.path.join(args.output, table["basedir"])
            csvpath = os.path.join(args.output, table["filename"])
            mainscript_text.install_path(csvdir)

            with open(csvpath, "w+") as table_csvfile:
                csvwriter = csv.writer(table_csvfile)
                csvwriter.writerow(["#", args.language])

                if table["format"] == "table":
                    for i in range(table["count"]):
                        rom.seek(mainscript_text.flat(table["basebank"], table["baseaddr"] + i * table["stride"]))
                        reverse_entries[rom.tell()] = len(entries)
                        entries.append(rom.tell())
                        data = extract_string(rom, charmap, table["stride"]).encode("utf-8")
                        idx = u"{0}".format(i + 1).encode("utf-8")
                        csvwriter.writerow([idx, data])
                elif table["format"] == "block":
                    rom.seek(mainscript_text.flat(table["basebank"], table["baseaddr"]))
                    for i in range(table["count"]):
                        reverse_entries[rom.tell()] = len(entries)
                        entries.append(rom.tell())
                        data = extract_string(rom, charmap).encode("utf-8")
                        idx = u"{0}".format(i + 1).encode("utf-8")
                        csvwriter.writerow([idx, data])

            #Save these for later
            table["entries"] = entries
            table["reverse_entries"] = reverse_entries

        #OK, now we can extract the indexes
        for table in tablenames:
            if table["format"] != "index":
                continue

            foreign_ptrs = tablenames[table["foreign_id"]]["reverse_entries"]
            rom.seek(mainscript_text.flat(table["basebank"], table["baseaddr"]))
            
            csvdir = os.path.join(args.output, table["basedir"])
            csvpath = os.path.join(args.output, table["filename"])
            mainscript_text.install_path(csvdir)
            
            with open(csvpath, "w+") as table_csvfile:
                csvwriter = csv.writer(table_csvfile)
                
                pretty_row_length = math.ceil(math.sqrt(table["count"]))
                cur_row = []

                for i in range(table["count"]):
                    ptr = mainscript_text.PTR.unpack(rom.read(2))[0]
                    addr = mainscript_text.flat(table["basebank"], ptr)
                    
                    cur_row.append(u"{0}".format(foreign_ptrs[addr] + 1).encode("utf-8"))
                    if len(cur_row) >= pretty_row_length:
                        csvwriter.writerow(cur_row)
                        cur_row = []

                if len(cur_row) > 0:
                    csvwriter.writerow(cur_row)

def asm(args):
    """Generate the ASM for string tables.

    This operation needs to be performed once, plus 

    Generated ASM will be printed to console. This portion of the script is
    intended to be piped into a file."""

    charmap = mainscript_text.parse_charmap(args.charmap)
    tablenames = parse_tablenames(args.tablenames)
    
    for table in tablenames:
        print u'SECTION "' + table["symbol"] + u' Section", ' + mainscript_text.format_sectionaddr_rom(mainscript_text.flat(table["basebank"], table["baseaddr"]))
        print table["symbol"] + u'::'
        print u'\tINCBIN "' + os.path.join(args.output, table["objname"]).replace("\\", "/") + u'"'
        print table["symbol"] + u'_END'
        print u''

def make_tbl(args):
    charmap = mainscript_text.parse_charmap(args.charmap)
    tablenames = parse_tablenames(args.tablenames)
    
    for table in tablenames:
        #Indexes are compiled in a second pass
        if table["format"] == "index":
            continue
        
        #If filenames are specified, only export banks that are mentioned there
        if len(args.filenames) > 0 and table["objname"] not in args.filenames:
            continue
        
        print "Compiling " + table["filename"]
        
        #Open and parse the data
        with open(os.path.join(args.output, table["filename"]), "r") as csvfile:
            csvreader = csv.reader(csvfile)
            headers = None
            rows = []
            
            for row in csvreader:
                if headers is None:
                    headers = [cell.decode("utf-8") for cell in row]
                else:
                    rows.append([cell.decode("utf-8") for cell in row])

        #Determine what column we want
        str_col = headers.index(args.language)
        index_col = headers.index(u"#")

        #Pack our strings
        packed_strings = []
        
        baseaddr = table["baseaddr"]
        
        entries = []
        reverse_entries = {}
        
        for i, row in enumerate(rows):
            if str_col >= len(row):
                print "WARNING: ROW {} IS MISSING IT'S TEXT!!!".format(i)
                packed_strings.append("")
                continue
            
            packed = mainscript_text.pack_string(row[str_col], charmap, None, args.window_width, True)
            
            if "stride" in table:
                if len(packed) > table["stride"]:
                    print "WARNING: Row {} is too long for the current string table stride of {} in table {}.".format(i, table["stride"], table["filename"])
                    packed = packed[0:table["stride"]]
                else:
                    #Pad the string out with E0s.
                    packed = packed + "".join(["\xe0"] * (table["stride"] - len(packed)))
            else:
                packed = packed + "\xe0"
            
            packed_strings.append(packed)
            
            reverse_entries[mainscript_text.flat(table["basebank"], baseaddr)] = len(entries)
            entries.append(mainscript_text.flat(table["basebank"], baseaddr))
            
            baseaddr += len(packed)
        
        #Save these for later
        table["entries"] = entries
        table["reverse_entries"] = reverse_entries
        
        #Write the data out to the object files. We're done here!
        with open(os.path.join(args.output, table["objname"]), "wb") as objfile:
            for line in packed_strings:
                objfile.write(line)
    
    for table in tablenames:
        #Now's the time to compile indexes
        if table["format"] != "index":
            continue
        
        #If filenames are specified, only export banks that are mentioned there
        if len(args.filenames) > 0 and table["objname"] not in args.filenames:
            continue
        
        print "Compiling " + table["filename"]
        
        foreign_ptrs = tablenames[table["foreign_id"]]["entries"]
        packed_strings = []
        
        entries = []
        reverse_entries = {}
        
        #Open and parse the data
        with open(os.path.join(args.output, table["filename"]), "r") as csvfile:
            csvreader = csv.reader(csvfile)
            
            for row in csvreader:
                for cell in row:
                    packed_strings.append(mainscript_text.PTR.pack(foreign_ptrs[int(cell, 10) - 1] % 0x4000 + 0x4000))
        
        #Write the data out to the object files. We're done here!
        with open(os.path.join(args.output, table["objname"]), "wb") as objfile:
            for line in packed_strings:
                objfile.write(line)

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
