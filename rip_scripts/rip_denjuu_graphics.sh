#!/bin/bash

mkdir gfx/denjuu

SPRITESSTART=1753088 # 0x1AC000
GRAPHICSIZE=896      # (8*8 * 8*7) / 4
GRAPHICCOUNT=175
PALETTESSTART=215040 # 0x034800

# To account for extra empty space at the end of banks.
extraOffset=0

for ((i = 0; i < GRAPHICCOUNT; i++))
do

# Sprites
./rip.sh $((SPRITESSTART + GRAPHICSIZE * i + extraOffset)) $GRAPHICSIZE gfx/denjuu/$i.w64.2bpp
mv gfx/denjuu/${i}.w64.2bpp gfx/denjuu/${i}.2bpp
mv gfx/denjuu/${i}.w64.png gfx/denjuu/${i}.png

# 18 sprites per bank, with 256 bytes of nothing after.
if ((i % 18 == 17)); then
	((extraOffset += 256))
fi

# Palettes
dd bs=1 skip=$((PALETTESSTART + 8 * i)) count=8 if=baserom_pw.gbc of=gfx/denjuu/$i.gbcpal >& /dev/null

# Last but not least, colorize the PNG.
rip_scripts/colorize_png.py gfx/denjuu/$i.gbcpal gfx/denjuu/$i.png > /dev/null

done
