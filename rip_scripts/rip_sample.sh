#!/bin/bash
export PYTHONPATH=$PYTHONPATH:pokemon-reverse-engineering-tools/pokemontools

dd skip=$(($1)) count=$(($2)) if=baserom_pw.gbc of=$3 bs=1 >& /dev/null
python rip_scripts/pcm.py wav $3

printf "\n"
printf "SECTION \"%s\", ROMX[$%04x], BANK[$%02x]\n" "$3" $(($1%0x4000+0x4000)) $(($1/0x4000))
printf "Sound_%s:\n" "$(echo $3 | sed -e 's/\//_/g' | sed -e 's/\./_/g')"
printf "\tINCBIN \"%s\"\n" "$3"
printf "Sound_%s_END\n" "$(echo $3 | sed -e 's/\//_/g' | sed -e 's/\./_/g')"