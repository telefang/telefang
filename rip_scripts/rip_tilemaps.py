# coding=utf-8
from __future__ import division

import mainscript_text
import argparse, io, os.path, csv, math, struct

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

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('--charmap', type=str, default="charmap.asm")
    ap.add_argument('--output', type=str, default="gfx")
    ap.add_argument('--metatable_loc', type=int, default=0x0B18)
    ap.add_argument('--metatable_loc_attribs', type=int, default=0x0C34)
    ap.add_argument('--metatable_length', type=int, default=2)
    ap.add_argument('rom', type=str)
    ap.add_argument('filenames', type=str, nargs="*")
    args = ap.parse_args()

    method = {
        "extract": extract,
        #"asm": asm,
        #"make_tbl": make_tbl
    }.get(args.mode, None)

    if method == None:
        raise Exception, "Unknown conversion method!"

    method(args)

if __name__ == "__main__":
    main()
