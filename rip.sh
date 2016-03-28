#!/bin/bash
dd skip=$(($1)) count=$(($2)) if=baserom_patch.gbc of=$3 bs=1 >& /dev/null
if [[ "$3" == *.1bpp ]] || [[ "$3" == *.2bpp ]]; then
	python pokemon-reverse-engineering-tools/pokemontools/gfx.py png $3
fi
printf "\n"
printf "SECTION \"%s\", ROMX[$%04x], BANK[$%02x]\n" "$3" $(($1%0x4000+0x4000)) $(($1/0x4000))
printf "\tINCBIN \"%s\"\n" "$3"
