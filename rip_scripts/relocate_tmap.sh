#!/bin/bash

#usage: ./relocate_tmap.sh gfx/unknown/tilemap_1/1 components/attractmode/scene1/cave_bg_tmap

OLD_FILENAME=$1
NEW_FILENAME=$2

OLD_FILENAME_STRIPPED=${OLD_FILENAME%.*}
OLD_FILENAME_STRIPPED=${OLD_FILENAME_STRIPPED#*/}
NEW_FILENAME_STRIPPED=${NEW_FILENAME%.*}
NEW_FILENAME_STRIPPED=${NEW_FILENAME_STRIPPED#*/}

OLD_SYMBOL=Tilemap_$(echo $OLD_FILENAME_STRIPPED | sed -e 's/\//_/g')
NEW_SYMBOL=Tilemap_$(echo $NEW_FILENAME_STRIPPED | sed -e 's/\//_/g')

#Since we're not properly parsing rgbds grammar asm, we have to be a bit hackier
#with our matching expressions to avoid relocating unrelated tilemaps which
#contain a prefix of the symbol. Three sed expressions are required to catch all
#three cases: The dw on the tilemap listing, the symbol declaration itself, and
#the END symbol at the END. This is still not a general purpose relocation but
#it covers everything that we put into the tilemap ASM.
SYMBOL_SED_EXPR="""s/""$OLD_SYMBOL""\$/""$NEW_SYMBOL""/g"""
SYMBOL_SED_EXPR2="""s/""$OLD_SYMBOL"":/""$NEW_SYMBOL"":/g"""
SYMBOL_SED_EXPR3="""s/""$OLD_SYMBOL""_END/""$NEW_SYMBOL""_END/g"""

OLD_TMAP_FILENAME=${1%.*}.tmap
NEW_TMAP_FILENAME=${2%.*}.tmap

FILENAME_SED_EXPR="s{""$OLD_TMAP_FILENAME""{""$NEW_TMAP_FILENAME""{g"

git mv $OLD_FILENAME $NEW_FILENAME
cat versions/power/tilemaps.asm | sed -e $FILENAME_SED_EXPR -e $SYMBOL_SED_EXPR -e $SYMBOL_SED_EXPR2 -e $SYMBOL_SED_EXPR3 > versions/power/tilemaps.asm.tmp
mv versions/power/tilemaps.asm.tmp versions/power/tilemaps.asm
cat versions/speed/tilemaps.asm | sed -e $FILENAME_SED_EXPR -e $SYMBOL_SED_EXPR -e $SYMBOL_SED_EXPR2 -e $SYMBOL_SED_EXPR3 > versions/speed/tilemaps.asm.tmp
mv versions/speed/tilemaps.asm.tmp versions/speed/tilemaps.asm
