SECTION "Status UI Graphics Loader", ROM0[$39EC]
; TODO: Figure out what these symbols do...
Status_LoadUIGraphics::
    push af
    ld a, $42
    rst $10
    pop af
    ld d, a
    ld e, 0
    ld hl, $5A00
    add hl, de
    ld de, $8300
    ld bc, $100
    jp LCDC_LoadGraphicIntoVRAM