#!/bin/sh
set -ve
PROJECT="telefang_patch"
rgbasm -E -o $PROJECT.o main.asm
rgblink -n $PROJECT.sym -m $PROJECT.map -O baserom_patch.gbc -o $PROJECT.gbc $PROJECT.o
rgbfix -v -c -i BXTJ -k 2N -l 0x33 -m 0x10 -p 0 -r 3 -t "TELEFANG PW" $PROJECT.gbc
