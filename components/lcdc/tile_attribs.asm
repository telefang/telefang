INCLUDE "telefang.inc"

SECTION "LCDC Set Tile Attribs", ROM0[$15CA]
LCDC_SetTileAttribsSquare::
    ld [W_GenericRegPreserve], a
    
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret nz
    
    ld a, 1
    ldh [REG_VBK], a
    
    ld a, b
    ld [Malias_CmpSrcBank], a
    
.colloop
    push hl
    
    ld a, [Malias_CmpSrcBank]
    ld b, a
    
.rowloop:
    ld a, [W_GenericRegPreserve]
    call vmempoke
    
    dec b
    jr nz, .rowloop
    
    pop hl
    
    ld de, $20
    add hl, de
    dec c
    jr nz, .colloop
    
    xor a
    ldh [REG_VBK], a
    
    ret