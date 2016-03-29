#!/usr/bin/python
import sys
import struct
import os

class InvalidGraphicsError(Exception): pass

def readshort():
    return struct.unpack("<H", rom.read(2))[0]

def readbeshort():
    return struct.unpack(">H", rom.read(2))[0]
    
def readbyte():
    return struct.unpack("<B", rom.read(1))[0]
    
def abspointer(bank, offset):
    return bank*0x4000+offset-0x4000

def decompress(offset):
    rom.seek(offset)
    
    #try:
    compressed = readbyte()
    data = bytearray() 
    total = readshort()
    try:
        if total > 0:
            if compressed == 0x00:
                for i in range(total):
                    data.append(readbyte())
            else:
                if compressed != 0x01:
                    raise InvalidGraphicsError(compressed)
                while len(data) < total: 
                    modes = readshort()
                    for mode in bin(modes)[2:].zfill(16)[::-1]:
                        if (len(data) >= total): break
                        if int(mode) == 1:
                            e = rom.read(1)
                            d = rom.read(1)
                            loc = -(struct.unpack("<H", e+d)[0]  & 0x07ff) 
                            num = ((struct.unpack("<B", d)[0] >> 3) & 0x1f) + 0x03 
                            loc += len(data)-1
                            for j in range(num):
                                if (len(data) >= total): break
                                if loc < 0:
                                    raise InvalidGraphicsError(loc)
                                else:
                                    data.append(data[loc+j])
                        else:
                            data.append(readbyte())
    except (InvalidGraphicsError, struct.error):
        return None, compressed
                
    return data[:total], compressed

rom = open(sys.argv[1], 'rb')

NUMGFX = 0x60

graphics = {}

rom.seek(0x18000)

for i in range(NUMGFX):
    bank, target = struct.unpack("<BH", rom.read(3))
    #if target > 0x7fff and target < 0xa000:
    graphics[i] = {'bank':bank,
                   'target':target,
                   'filename': None,
                   'title': None,
                   'label': None,
                   'corrupted': False,}
    rom.read(1)

rom.seek(0x1DE1)

for i in range(NUMGFX):
    pointer, = struct.unpack("<H", rom.read(2))
    graphics[i]['pointer'] = pointer

for i in range(NUMGFX):
    g = graphics[i]
    if g['pointer']:
        rom.seek(g['bank']*0x4000 + g['pointer'] % 0x4000)
        startpos = rom.tell()
        g['decompressed_data'], g['is_compressed'] = decompress(g['bank']*0x4000 + g['pointer'] % 0x4000)
        if not g['decompressed_data']:
            sys.stderr.write("Error: 0x{:02x} has corrupted data\n".format(i))
            g['corrupted'] = True
        else:
            g['size'] = rom.tell() - startpos
            g['decompressed_size'] = len(g['decompressed_data'])
            rom.seek(startpos)
            rom.read(1)
            g['data'] = rom.read(g['size']-1)


i = 0
for line in open("rip_scripts/compressed_graphic_names.txt"):
    if " " in line:
        i, filename = line.strip().split(" ")
        i = int(i, 16)
    else:
        filename = line.strip()
    graphics[i]['filename'] = filename
    graphics[i]['title'] = filename.replace('/', ' - ').replace('_', ' ').title().replace("Dmg", "DMG")+" Compressed GFX"
    graphics[i]['label'] = filename.replace('/', ' ').replace('_', ' ').title().replace(' ', '').replace("Dmg", "DMG")+"Gfx"
    i += 1

print
print 'SECTION "Compressed gfx pointer table", ROMX[$4000], BANK[$6]'
for i in range(NUMGFX):
    g = graphics[i]
    if g['label']:
        print "\tdbwb BANK({}),\t${:04x}, 0 ; ${:02x}".format(g['label'], g['target'], i)
    else:
        print "\tdbwb ${:02x},\t${:04x}, 0 ; ${:02x}".format(g['bank'], g['target'], i)

print
print 'SECTION "Compressed gfx pointer table 2", HOME[$1DE1]'
for i in range(NUMGFX):
    g = graphics[i]
    if g['label']:
        print "\tdw {} ; ${:02x}".format(g['label'], i)
    else:
        print "\tdw ${:04x} ; ${:02x}".format(g['pointer'], i)

print "NOT_COMPRESSED EQU 0"
print "COMPRESSED EQU 1"

for i in range(NUMGFX):
    g = graphics[i]
    if g['label']:
        print
        if i != 0 and graphics[i-1]['bank'] == g['bank'] and graphics[i-1]['pointer'] + graphics[i-1]['size'] == g['pointer'] and not graphics[i-1]['corrupted']:
            pass
        else:
            print 'SECTION "{}", ROMX[${:04x}], BANK[${:02x}]'.format(g['title'], g['pointer'], g['bank'])
        print "{}:".format(g['label'])
        if g['corrupted']:
            print '\t; corrupted'
        else:
            if g['is_compressed']:
                print '\tdb COMPRESSED'
            else:
                print '\tdbw NOT_COMPRESSED, {}End - {} - 3'.format(g['label'], g['label'])
            print '\tINCBIN "gfx/{}.{}"'.format(g['filename'], ['2bpp', 'malias'][g['is_compressed']])
            print "{}End".format(g['label'])

for i in range(NUMGFX):
    g = graphics[i]
    if g['filename'] and not g['corrupted']:
        path = 'gfx/{}'.format('/'.join(g['filename'].split('/')[:-1]))
        if not os.path.isdir(path):
            os.mkdir(path)
        if g['is_compressed']:
            open("gfx/{}.malias".format(g['filename']), "wb").write(g['data'])
        open("gfx/{}.2bpp".format(g['filename']), "wb").write(g['decompressed_data'])
        os.system("python pokemon-reverse-engineering-tools/pokemontools/gfx.py png gfx/{}.2bpp".format(g['filename']))
        
        if g['is_compressed']:
            os.system("git add gfx/{}.malias".format(g['filename']))
        else:
            os.system("git add gfx/{}.2bpp".format(g['filename']))
        os.system("git add gfx/{}.png".format(g['filename']))
            

#for i in range(NUMGFX):
#    bank, pointer = graphics[i]['bank'], graphics[i]['pointer']
#    if pointer >= 0x4000 and pointer < 0x8000:
#        
