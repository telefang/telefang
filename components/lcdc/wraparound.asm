INCLUDE "telefang.inc"

SECTION "LCDC tile address tools", ROM0[$32F7]
VRAMTileWraparound::
    ld a, h
    cp $9C
    jr c, .ret
    ld h, $98
    
.ret
    ret