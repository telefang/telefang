#!/bin/bash

mkdir gfx/items
mkdir gfx/items/0

BASEFLATADDR=704512
GRAPHICSIZE=480
GRAPHICCOUNT=34

for ((i=0; i<GRAPHICCOUNT; i++))
do

./rip.sh $((BASEFLATADDR + GRAPHICSIZE * i)) $GRAPHICSIZE gfx/items/0/$i.w48.2bpp
mv gfx/items/0/${i}.w48.2bpp gfx/items/0/${i}.2bpp
mv gfx/items/0/${i}.w48.png gfx/items/0/${i}.png

done

mkdir gfx/items/1

for ((i=0; i<GRAPHICCOUNT; i++))
do

./rip.sh $((BASEFLATADDR + 0x4000 + GRAPHICSIZE * i)) $GRAPHICSIZE gfx/items/1/$i.w48.2bpp
mv gfx/items/1/${i}.w48.2bpp gfx/items/1/${i}.2bpp
mv gfx/items/1/${i}.w48.png gfx/items/1/${i}.png

done