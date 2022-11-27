INCLUDE "telefang.inc"

SECTION "Status UI Graphics Loader WRAM", WRAM0[$C91E]
W_Status_NumericalTileIndex:: ds 1

; TODO: all of these functions reference uncompressed graphics in need of being
; imported into the project.

SECTION "Status UI Graphics Loader", ROM0[$39EC]
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

SECTION "Status Numerical Tiles Loader", ROM0[$3566]
; Expands the uncompressed 1bpp number graphics into a 2bpp set of tiles
; according to your current text style.
Status_ExpandNumericalTiles::
    ld a, [W_CurrentBank]
    push af
    ld a, $38
    rst $10
    ld a, [W_Status_NumericalTileIndex]
    call LCDC_TileIdx2Ptr
    ld de, $4B38
    ld b, $80
    
.loop
    di
    ld a, [W_MainScript_TextStyle]
    cp 2
    jr z, .waitForBlankingInverted
    
.waitForBlanking
    ldh a, [REG_STAT]
    and 2
    jr nz, .waitForBlanking
    
    ld a, [de]
    ld [hli], a
    ld [hli], a
    
    ei
    inc de
    dec b
    jr nz, .loop
    
    pop af
    rst $10
    ret
    
.waitForBlankingInverted
    ldh a, [REG_STAT]
    and 2
    jr nz, .waitForBlankingInverted
    
    ld a, [de]
    cpl
    ld [hli], a
    ld [hli], a
    
    ei
    inc de
    dec b
    jr nz, .loop
    
    pop af
    rst $10
    ret