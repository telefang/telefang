#!/bin/bash

mkdir gfx/denjuu

BASEFLATADDR=1753088 # 0x1AC000
GRAPHICSIZE=896      # (8*8 * 8*7) / 4
GRAPHICCOUNT=179

# To account for extra empty space at the end of banks.
extraOffset=0

for ((i = 0; i < GRAPHICCOUNT; i++))
do

./rip.sh $((BASEFLATADDR + GRAPHICSIZE * i + extraOffset)) $GRAPHICSIZE gfx/denjuu/$i.w64.2bpp
mv gfx/denjuu/${i}.w64.2bpp gfx/denjuu/${i}.2bpp
mv gfx/denjuu/${i}.w64.png gfx/denjuu/${i}.png

# 18 sprites per bank.
if ((i % 18 == 17)); then
	((extraOffset += 256))
fi

done
