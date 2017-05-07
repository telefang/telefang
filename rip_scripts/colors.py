from mainscript_text import CHARA, PTR, BE_PTR, format_sectionaddr_rom
import argparse

def rip_colordata(rom, offset = None, count = 1):
    """Rip color data from ROM. Returns list of palettes, which are four RGB hexcodes."""
    
    cloc = rom.tell()
    if offset is not None:
        rom.seek(offset)
    
    output = []
    
    for i in range(0, count):
        out_col = []
        
        for j in range(0, 4):
            color_bin = PTR.unpack(rom.read(2))[0]
            
            red = color_bin & 0x001F
            green = (color_bin & 0x03E0) >> 5
            blue = (color_bin & 0x7C00) >> 10
            
            colorcode = "dcolor {0}, {1}, {2}".format(red, green, blue)
            
            out_col.append(colorcode)
        
        output.append(out_col)
    
    rom.seek(cloc)
    
    return output

def rip_palettedata(rom, offset = None, count = 1):
    """Rip palette data from ROM."""
    
    cloc = rom.tell()
    if offset is not None:
        rom.seek(offset)
        
    table = []
    output = []
    
    for i in range(0, count):
        table_paletteset = []
        
        for j in range(0, 8):
            palette_index = BE_PTR.unpack(rom.read(2))[0]
            
            table_paletteset.append(palette_index)
            
        palettecode = "dpalette ${0:X}, ${1:X}, ${2:X}, ${3:X}, ${4:X}, ${5:X}, ${6:X}, ${7:X}".format(*table_paletteset)
        
        table.append(table_paletteset)
        output.append(palettecode)
    
    rom.seek(cloc)
    
    return table, output

def extract(args):
    with open(args.rom, 'rb') as rom:
        print "INCLUDE \"telefang.inc\""
        print ""
        print "SECTION \"CGB Background Palette Data\", " + format_sectionaddr_rom(args.bg_palette_loc)
        print "LCDC_CGB_BGPaletteTable::"
        
        bgp_table, bgp_code = rip_palettedata(rom, args.bg_palette_loc, args.bg_palette_len)
        max_bgp_index = 0
        for palette in bgp_table:
            for index in palette:
                if index > max_bgp_index:
                    max_bgp_index = index
        
        for code in bgp_code:
            print "    " + code
        
        print "\nSECTION \"CGB Background Color Data\", " + format_sectionaddr_rom(args.bg_color_loc)
        print "LCDC_CGB_BGColorTable::"
        
        bgc_code = rip_colordata(rom, args.bg_color_loc, max_bgp_index / 4)
        
        i = 0
        
        for codeset in bgc_code:
            print ";Palette {0:X}".format(i)
            i += 1
            
            for code in codeset:
                print "    " + code
        
        print "\nSECTION \"CGB Object Palette Data\", " + format_sectionaddr_rom(args.obj_palette_loc)
        print "LCDC_CGB_OBPaletteTable::"
        
        obp_table, obp_code = rip_palettedata(rom, args.obj_palette_loc, args.obj_palette_len)
        max_obp_index = 0
        for palette in obp_table:
            for index in palette:
                if index > max_obp_index:
                    max_obp_index = index
        
        for code in obp_code:
            print "    " + code
        
        print "\nSECTION \"CGB Object Color Data\", " + format_sectionaddr_rom(args.obj_color_loc)
        print "LCDC_CGB_OBColorTable::"
        
        obc_code = rip_colordata(rom, args.obj_color_loc, max_obp_index / 4)
        
        i = 0
        
        for codeset in obc_code:
            print ";Palette {0:X}".format(i)
            i += 1
            
            for code in codeset:
                print "    " + code
        

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('--bg_palette_loc', type=int, default=0x1C000)
    ap.add_argument('--bg_palette_len', type=int, default=108)
    ap.add_argument('--bg_color_loc', type=int, default=0x34000)
    ap.add_argument('--obj_palette_loc', type=int, default=0x38000)
    ap.add_argument('--obj_palette_len', type=int, default=18)
    ap.add_argument('--obj_color_loc', type=int, default=0x35D80)
    ap.add_argument('rom', type=str)
    ap.add_argument('filenames', type=str, nargs="*")
    args = ap.parse_args()

    method = {
        "extract": extract
    }.get(args.mode, None)

    if method == None:
        raise Exception, "Unknown conversion method!"

    method(args)

if __name__ == "__main__":
    main()
