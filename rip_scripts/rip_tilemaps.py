# coding=utf-8
from __future__ import division

import mainscript_text
import argparse, io, os.path, csv, math, struct

def parse_mapnames(filename):
    """Parse the list of tilemap names.
    
    Format is:
    
    name type bank index"""
    tables = []
    banks = []
    tbl_index = {}
    bank_index = {}
    
    bank = 0

    with io.open(filename, "r", encoding="utf-8") as tablenames:
        for line in tablenames:
            if line[0] == "#" or line == "":
                continue
            
            #The line is technically --BANK-- but let's be lazy here
            if line[0] == "-":
                bank += 1
                continue

            parameters = line.strip().split(" ")
            
            if len(parameters) < 3:
                continue
            
            if parameters[0] == "BANK":
                bank = {}
                bank["category"] = parameters[1]
                bank["bank"] = int(parameters[2], 16)
                bank["flataddr"] = int(parameters[3], 16)

                if bank["category"] == "attrib":
                    bank["symbol"] = "Attribmap_BANK_" + parameters[2].replace("/", "_")
                elif bank["category"] == "tilemap":
                    bank["symbol"] = "Tilemap_BANK_" + parameters[2].replace("/", "_")
                
                bank["id"] = len(banks)
                
                if not bank_index.has_key(bank["category"]):
                    bank_index[bank["category"]] = {}
                
                bank_index[bank["category"]][bank["bank"]] = bank["id"]
                banks.append(bank)
            else:
                table = {}
                table["name"] = parameters[0]
                table["category"] = parameters[1]
                table["bank"] = int(parameters[2], 16)
                table["index"] = int(parameters[3], 16)
                table["basedir"] = os.path.join(*(parameters[0].split("/")[0:-1]))
                table["filename"] = os.path.join(*(parameters[0] + ".csv").split("/"))
                table["objname"] = os.path.join(*(parameters[0] + ".tmap").split("/"))

                if table["category"] == "attrib":
                    table["symbol"] = "Attribmap_" + parameters[0].replace("/", "_")
                elif table["category"] == "tilemap":
                    table["symbol"] = "Tilemap_" + parameters[0].replace("/", "_")

                table["id"] = len(tables)

                if not tbl_index.has_key(table["category"]):
                    tbl_index[table["category"]] = {}

                if not tbl_index[table["category"]].has_key(table["bank"]):
                    tbl_index[table["category"]][table["bank"]] = {}

                if not tbl_index[table["category"]][table["bank"]].has_key(table["index"]):
                    tbl_index[table["category"]][table["bank"]][table["index"]] = {}

                tbl_index[table["category"]][table["bank"]][table["index"]] = table["id"]
                tables.append(table)
    
    return tables, tbl_index, banks, bank_index

def decompress_tilemap(rom, offset = None):
    """Decompress a compressed tilemap from a given ROM file.
    
    Return value is an array; first element is the decompressed data, second is
    the number of bytes read from the tilemap. The data is in the form of an
    integer array from 0 to 255, these correspond to tile IDs.
    
    If offset is given, ROM will be read from that position. Your existing ROM
    position will be preserved."""
    
    if offset is None:
        offset = rom.tell()
    
    last = rom.tell()
    rom.seek(offset)
    
    decomp_mapping = []
    decomp_row = []
    comp_length = 0
    
    next_cmd = mainscript_text.CHARA.unpack(rom.read(1))[0]
    comp_length += 1
    
    if next_cmd & 0x03 == 0:
        #Uncompressed data
        while True:
            next_cmd = mainscript_text.CHARA.unpack(rom.read(1))[0]
            comp_length += 1
            
            if next_cmd == 0xFF:
                break
            elif next_cmd == 0xFE:
                #Newline
                decomp_mapping.append(decomp_row)
                decomp_row = []
            else:
                #Literal tile value
                decomp_row.append(next_cmd)
        
        #In case there isn't a newline at the end...
        if len(decomp_row) > 0:
            decomp_mapping.append(decomp_row)
        
    elif next_cmd != 0xFF:
        #Compressed data
        while True:
            next_cmd = mainscript_text.CHARA.unpack(rom.read(1))[0]
            comp_length += 1
            
            if next_cmd == 0xFF:
                break
            
            cmd = (next_cmd & 0xC0) >> 6
            count = next_cmd & 0x3F
            
            if cmd == 3:
                #DecBytes
                dat = mainscript_text.CHARA.unpack(rom.read(1))[0]
                comp_length += 1
                
                for i in range(count + 2):
                    decomp_row.append((dat - i) % 0xFF)
            elif cmd == 2:
                #IncBytes
                dat = mainscript_text.CHARA.unpack(rom.read(1))[0]
                comp_length += 1
                
                for i in range(count + 2):
                    decomp_row.append((dat + i) % 0xFF)
            elif cmd == 1:
                #RepeatBytes
                dat = mainscript_text.CHARA.unpack(rom.read(1))[0]
                comp_length += 1
                
                for i in range(count + 2):
                    decomp_row.append((dat) % 0xFF)
            else:
                #CopyBytes
                for i in range(count + 1):
                    dat = mainscript_text.CHARA.unpack(rom.read(1))[0]
                    comp_length += 1
                    
                    decomp_row.append((dat) % 0xFF)
        
        #Split decomp_row into 32-byte rows.
        #Interestingly enough the design of the decompressor prohibits fully
        #compressed graphics from having shorter rows - there's no newline
        #command nor any way to skip bytes.
        for i in range(0, len(decomp_row), 32):
            decomp_mapping.append(decomp_row[i:i+32])
        
    rom.seek(last)
    
    return decomp_mapping, comp_length

def decompress_bank(rom, offset=None):
    """Decompress an entire table of compressed data.
    
    Return value is an array of data, individual data items match the return
    value of decompress_tilemap.
    
    If offset is given, ROM will be read from that position. Your existing ROM
    position will be preserved."""
    
    if offset is None:
        offset = rom.tell()
    
    last = rom.tell()
    rom.seek(offset)
    
    ret_dat = []
    
    #The table consists of multiple pointers followed immediately by compressed
    #tilemap data. There is no explicit length, so we discover the length of
    #the pointer table by reading and decompressing pointers until we overrun
    #already-decompressed data.
    largest_ptr = 0xFFFF
    start_ptr, this_bank = mainscript_text.banked(offset)
    
    while mainscript_text.banked(rom.tell())[0] < largest_ptr:
        this_ptr = mainscript_text.PTR.unpack(rom.read(2))[0]
        if this_ptr <= largest_ptr:
            largest_ptr = this_ptr
        
        this_data, this_clen = decompress_tilemap(rom, mainscript_text.flat(this_bank, this_ptr))
        ret_dat.append(this_data)
    
    rom.seek(last)
    return ret_dat

def extract_metatable(rom, length, offset=None):
    """Extract the bank list (metatable) from the ROM.
    
    Length is required; there is currenly no autodetect for the table length.
    This function returns a list of banks.
    
    If offset is given, ROM will be read from that position. Your existing ROM
    position will be preserved."""
    
    if offset is None:
        offset = rom.tell()
    
    last = rom.tell()
    rom.seek(offset)
    
    ret_banks = []
    for i in range(length):
        ret_banks.append(mainscript_text.CHARA.unpack(rom.read(1))[0])
    
    rom.seek(last)
    return ret_banks

def extract(args):
    with open(args.rom, 'rb') as rom:
        metatable = extract_metatable(rom, args.metatable_length, args.metatable_loc)
        metatable_attribs = extract_metatable(rom, args.metatable_length, args.metatable_loc_attribs)
        
        for i, bank in enumerate(metatable):
            this_bank = decompress_bank(rom, 0x4000 * bank)
            
            for j, data in enumerate(this_bank):
                csvpath = os.path.join(args.output, "unknown", "tilemap_{0:x}".format(i))
                mainscript_text.install_path(csvpath)
                
                with open(os.path.join(csvpath, "{0:x}.csv".format(j)), "w+") as csvout:
                    csvwriter = csv.writer(csvout)
                    
                    for row in data:
                        csvwriter.writerow(row)
        
        for i, bank in enumerate(metatable_attribs):
            this_bank = decompress_bank(rom, 0x4000 * bank)
            
            for j, data in enumerate(this_bank):
                csvpath = os.path.join(args.output, "unknown", "attribs_{0:x}".format(i))
                mainscript_text.install_path(csvpath)
                
                with open(os.path.join(csvpath, "{0:x}.csv".format(j)), "w+") as csvout:
                    csvwriter = csv.writer(csvout)
                    
                    for row in data:
                        csvwriter.writerow(row)

def linearized(data):
    """Generator which yields every column in data without breaks."""
    for row in data:
        for tile in row:
            yield tile

def compress_tilemap(data):
    """Compress tilemap data.
    
    Data is assumed to be in 32-column rows; row breaks will be ignored.
    
    Data will be compressed as efficiently as possible under the current format
    and no attempt will be made at mirroring less-efficient algorithms."""
    
    #Technically, a whole number of bytes can indicate compressed data, we are
    #assuming #FE.
    encoded_bytes = ["\xfe"]
    bytes_to_encode = []
    incompressible = []
    
    for tile in linearized(data):
        bytes_to_encode.append(tile)
    
    while len(bytes_to_encode) > 0:
        #Attempt to encode as many bytes as possible using the three run-length
        #encodings available; otherwise, move a byte into a CopyBytes packet.
        
        this_byte = bytes_to_encode[0]
        run_length = 1
        for byte in bytes_to_encode[1:]:
            if byte == this_byte:
                run_length += 1
            else:
                break
        
        inc_length = 1
        for byte in bytes_to_encode[1:]:
            if byte == (this_byte + inc_length) % 0xFF:
                inc_length += 1
            else:
                break
        
        dec_length = 1
        for byte in bytes_to_encode[1:]:
            if byte == (this_byte - dec_length) % 0xFF:
                dec_length += 1
            else:
                break
        
        #Flush incompressible data if it looks like we have something.
        #TODO: Split runs of incompressible bytes if they overflow
        if run_length >= 2 or inc_length >= 2 or dec_length >= 2:
            encoded_bytes.append(len(incompressible) - 1)
            encoded_bytes.append("".join(incompressible))
            incompressible = []
        
        #Now that we know how long each command can be, pick the best one.
        #Keep in mind that there's a minimum to each! The format will not allow
        #runs less than 2 bytes, for what should be fairly obvious reasons.
        #EDGE CASE/TODO: If there's a run of 68 bytes, it will compress to five
        #bytes, when there's a more optimal four-byte encoding to be had by
        #splitting the run such that the second command has enough bytes..
        
        if run_length >= 2 and run_length > inc_length and run_length > dec_length:
            if run_length > 66:
                run_length = 66
            
            cmd_byte = 0x40 | (run_length - 2)
            encoded_bytes.append(chr(cmd_byte))
            encoded_bytes.append(chr(this_byte))
        elif inc_length >= 2 and inc_length > dec_length:
            if inc_length > 66:
                inc_length = 66
            
            cmd_byte = 0x80 | (inc_length - 2)
            encoded_bytes.append(chr(cmd_byte))
            encoded_bytes.append(chr(this_byte))
        elif dec_length >= 2:
            if dec_length > 66:
                dec_length = 66
            
            cmd_byte = 0xC0 | (dec_length - 2)
            encoded_bytes.append(chr(cmd_byte))
            encoded_bytes.append(chr(this_byte))
        else:
            #We can't compress data yet, so add this byte onto the pile of
            #uncompressible data and try again.
            incompressible.append(chr(this_byte))
            bytes_to_encode = bytes_to_encode[1:]
    
    #Encode the last few bits of incompressible data if it exists
    #TODO: Split runs of incompressible bytes if they overflow
    if run_length >= 2 or inc_length >= 2 or dec_length >= 2:
        encoded_bytes.append(len(incompressible) - 1)
        encoded_bytes.append("".join(incompressible))
        incompressible = []
        
    encoded_bytes.append(chr(0xff))
    return "".join(encoded_bytes)

def encode_literal_tilemap(data):
    """Given tile or attribute data, produce an uncompressed datastream.
    
    This data format is necessary for any tilemap which is not 32 columns wide.
    It's the only format to support newlines."""
    
    outdat = []
    
    for i, row in enumerate(data):
        for cell in row:
            outdat.append(chr(int(cell, 10)))
        
        if i < len(data):
            outdat.append(chr(0xFE))
    
    outdat.append(chr(0xFF))
    return "".join(outdat)

def encode_tilemap(data):
    """Given tile or attribute data, produce a compressed datastream.
    
    Data streams with 32-column wide rows representable with the compressed
    data format will automatically be compressed. Data streams with shorter
    rows will be encoded using the uncompressed format as it's the only one
    that supports newlines."""
    
    #Determine if the data is compressible or no
    use_compression = True
    for i, row in enumerate(data):
        if i < len(data) and len(row) < 32:
            use_compression = False
            break
        elif i == len(data):
            break
    else:
        #Empty data gets a big fat 0xFF
        return "\xff"
    
    if use_compression:
        return compress_tilemap(data)
    else:
        return encode_literal_tilemap(data)

def asm(args):
    """Generate an ASM file for the metatables and tables present within the
    compressed tilemap system.
    
    This process needs to be run at least once, to convert the compressed
    tilemap names into imports that the assembler and linker can use. Changes
    to that file can be mirrored into the ASM by re-running this command, or
    manually doing so."""

    charmap = mainscript_text.parse_charmap(args.charmap)
    tables, table_index, banks, bank_index = parse_mapnames(args.mapnames)
    
    for category_name, category_index in table_index.items():
        if category_name == "attrib":
            print u'SECTION "' + category_name + u' Section", ' + mainscript_text.format_sectionaddr_rom(args.metatable_loc_attribs)
        elif category_name == "tilemap":
            print u'SECTION "' + category_name + u' Section", ' + mainscript_text.format_sectionaddr_rom(args.metatable_loc)
        
        for bank_id, bank_table_index in category_index.items():
            bank = banks[bank_index[category_name][bank_id]]
            print u'\tdb BANK(' + bank["symbol"] + ')'
        
        print u''
    
    print u''
    
    for category_name, category_index in table_index.items():
        for bank_id, bank_table_index in category_index.items():
            bank = banks[bank_index[category_name][bank_id]]
            print u'SECTION "' + category_name + u' Bank {0}'.format(bank_id) + u'", ' + mainscript_text.format_sectionaddr_rom(bank["flataddr"])
            
            for tmap_id, table_index in bank_table_index.items():
                table = tables[table_index]
                
                print u'\tdw ' + table["symbol"]
            
            print u''
            
            for tmap_id, table_index in bank_table_index.items():
                table = tables[table_index]
                
                print table["symbol"] + u'::'
                print u'\tincbin "' + os.path.join(args.output, table["objname"]).replace("\\", "/") + '"'
                print table["symbol"] + u'_END'
                print u''
        
        print u''

def make_maps(args):
    """Compile the stated (or all) tilemaps into .tmap files suitable for
    inclusion within the compressed tilemap banks."""
    
    charmap = mainscript_text.parse_charmap(args.charmap)
    tables, table_index, banks, bank_index = parse_mapnames(args.mapnames)
    
    #We Are Number One but a python script compiles everything
    #YouTube: Our Cancer Has Cancer.
    for i, table in enumerate(tables):
        #If filenames are specified, only export maps that are mentioned there
        if len(args.filenames) > 0 and table["objname"] not in args.filenames:
            continue
        
        with open(os.path.join(args.output, table["filename"]), "r") as csvfile:
            csvreader = csv.reader(csvfile)
            csv_data = []
            
            for row in csvreader:
                csv_data.append(row)
            
            with open(os.path.join(args.output, table["objname"]), "wb") as objfile:
                objfile.write(encode_tilemap(csv_data))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('--charmap', type=str, default="charmap.asm")
    ap.add_argument('--output', type=str, default="gfx")
    ap.add_argument('--mapnames', type=str, default="rip_scripts/compressed_tilemap_names.txt")
    ap.add_argument('--metatable_loc', type=int, default=0x0B18)
    ap.add_argument('--metatable_loc_attribs', type=int, default=0x0C34)
    ap.add_argument('--metatable_length', type=int, default=2)
    ap.add_argument('rom', type=str)
    ap.add_argument('filenames', type=str, nargs="*")
    args = ap.parse_args()

    method = {
        "extract": extract,
        "asm": asm,
        "make_maps": make_maps
    }.get(args.mode, None)

    if method == None:
        raise Exception, "Unknown conversion method!"

    method(args)

if __name__ == "__main__":
    main()
