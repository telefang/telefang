INCLUDE "telefang.inc"

SECTION "LCDC Palette Fade Staging 2 WRAM", WRAM0[$C440]
W_LCDC_CGBFadeFactor:: ds 1

SECTION "LCDC Palette Fade Staging 3 WRAM", WRAM0[$C451]
; And some parameters go here.
; Yes, this aliases Malias_DeCmpDst. Not sure how the hell they managed to do
; that...
W_LCDC_FadeColMathArena:: ds M_LCDC_CGBMathArenaSize
W_LCDC_ColMathPaletteTarget:: ds 2

SECTION "LCDC Palette Fade CGB", ROMX[$7682], BANK[3]
LCDC_PaletteFadeCGB::
    push de
    
    ld de, W_LCDC_FadeStagingArea
    ld a, d
    ld [W_LCDC_ColMathPaletteTarget], a
    ld a, e
    ld [W_LCDC_ColMathPaletteTarget + 1], a
    ld a, [W_LCDC_FadeType]
    ld hl, W_LCDC_CGBScratchBGPaletteArea
    call LCDC_FadeExecuteCurve
    call LCDC_CGBStageFadedBGPalette
    
    ld de, W_LCDC_FadeStagingArea
    ld a, d
    ld [W_LCDC_ColMathPaletteTarget], a
    ld a, e
    ld [W_LCDC_ColMathPaletteTarget + 1], a
    ld a, [W_LCDC_FadeType]
    ld hl, W_LCDC_CGBScratchOBPaletteArea
    call LCDC_FadeExecuteCurve
    call LCDC_CGBStageFadedOBPalette
    
    ld a, [W_LCDC_PaletteAnimFrame]
    inc a
    ld [W_LCDC_PaletteAnimFrame], a
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld [W_CGBPaletteStagedOBP], a
    
    pop de
    xor a
    ret

LCDC_CGBStageFadedBGPalette::
    ld hl, W_LCDC_FadeStagingArea
    ld de, W_LCDC_CGBStagingBGPaletteArea
    ld b, 8

.palLoop
    push bc
    ld b, 4

.colLoop
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jp nz, .colLoop
    
    pop bc
    dec b
    jp nz, .palLoop
    
    ret
    
;Not sure what this is for, but it's between the two stage funcs...
    db $80, $88, $90, $98, $A0, $A8, $B0, $B8

LCDC_CGBStageFadedOBPalette::
    ld hl, W_LCDC_FadeStagingArea
    ld de, W_LCDC_CGBStagingOBPaletteArea
    ld b, 8

.palLoop
    push bc
    ld b, 4

.colLoop
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jp nz, .colLoop
    
    pop bc
    dec b
    jp nz, .palLoop
    
    ret

SECTION "LCDC CGB Fades Curves", ROMX[$7873], BANK[3]
LCDC_FadeExecuteCurve:
    ld b, h
    ld c, l
    ld d, 0
    ld e, a
    sla e
    rl d
    sla e
    rl d
    ld hl, .table
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp hl

.table
    dw LCDC_RevealWhiteCurve
    dw LCDC_NoFadeCurve
    dw LCDC_FadeToWhiteCurve
    dw LCDC_NoFadeCurve
    dw LCDC_RevealBlackCurve
    dw LCDC_NoFadeCurve
    dw LCDC_FadeToBlackCurve
    dw LCDC_NoFadeCurve

LCDC_NoFadeCurve:
    ret

;Fade from white down to fully visible.
LCDC_RevealWhiteCurve:
    ld h, b
    ld l, c
    ld a, [W_LCDC_PaletteAnimFrame]
    add a, 1
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $20
    sub c
    ld c, a ;Essentially, WHITE + 1 - 8(frame + 1)
    
    ld b, 8
    
.palLoop
    push bc
    push hl
    call LCDC_FadeCGBPaletteWhite
    pop hl
    ld de, M_LCDC_CGBScratchAreaStride
    add hl, de
    
    pop bc
    dec b
    jp nz, .palLoop
    
    ret

;Fade from fully visible up to white.
LCDC_FadeToWhiteCurve:
    ld h, b
    ld l, c
    ld a, [W_LCDC_PaletteAnimFrame]
    add a, 1
    add a, a
    add a, a
    add a, a
    sub 1
    ld c, a
    ld a, 0
    add a, c
    ld c, a ;Essentially, 8(frame + 1) - 1
    
    ld b, 8
    
.palLoop
    push bc
    push hl
    call LCDC_FadeCGBPaletteWhite
    pop hl
    ld de, M_LCDC_CGBScratchAreaStride
    add hl, de
    
    pop bc
    dec b
    jp nz, .palLoop
    
    ret

;Fade from black to fully visible.
LCDC_RevealBlackCurve:
    ld h, b
    ld l, c
    ld a, [W_LCDC_PaletteAnimFrame]
    add a, 1
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, 0
    add a, c
    ld c, a ;Essentially, 8(frame + 1)
    
    ld b, 8
    
.palLoop
    push bc
    push hl
    call LCDC_FadeCGBPaletteBlack
    pop hl
    ld de, M_LCDC_CGBScratchAreaStride
    add hl, de
    
    pop bc
    dec b
    jp nz, .palLoop
    
    ret

;Fade from fully visible down to black.
LCDC_FadeToBlackCurve:
    ld h, b
    ld l, c
    ld a, [W_LCDC_PaletteAnimFrame]
    add a, 1
    add a, a
    add a, a
    add a, a
    sub 1
    ld c, a
    ld a, $1F
    sub c
    ld c, a ;Essentially, WHITE - 8(frame + 1) - 1
    
    ld b, 8
    
.palLoop
    push bc
    push hl
    call LCDC_FadeCGBPaletteBlack
    pop hl
    ld de, M_LCDC_CGBScratchAreaStride
    add hl, de
    
    pop bc
    dec b
    jp nz, .palLoop
    
    ret

;Fade an entire CGB palette white, controlled by a fade factor (A).
LCDC_FadeCGBPaletteWhite::
    ld a, c
    ld [W_LCDC_CGBFadeFactor], a
    ld de, W_LCDC_FadeColMathArena
    call LCDC_FadeCGBColorWhite
    ld de, W_LCDC_FadeColMathArena
    call LCDC_FadeCGBColorWhite
    ld de, W_LCDC_FadeColMathArena
    call LCDC_FadeCGBColorWhite
    ld de, W_LCDC_FadeColMathArena
    call LCDC_FadeCGBColorWhite
    ret

LCDC_FadeCGBColorWhite::
    ld b, M_LCDC_CGBMathArenaSize

.componentLoop
    ld a, [W_LCDC_CGBFadeFactor]
    cp [hl]
    jp nc, .useFadedColor
    ld a, [hl]
    
.useFadedColor
    ld [de], a
    
    inc hl
    inc de
    dec b
    jp nz, .componentLoop
    call LCDC_CGBColorPack24to15
    ret

;Fade an entire CGB palette black, controlled by a fade factor (A).
LCDC_FadeCGBPaletteBlack::
    ld a, c
    ld [W_LCDC_CGBFadeFactor], a
    ld de, W_LCDC_FadeColMathArena
    call LCDC_FadeCGBColorBlack
    ld de, W_LCDC_FadeColMathArena
    call LCDC_FadeCGBColorBlack
    ld de, W_LCDC_FadeColMathArena
    call LCDC_FadeCGBColorBlack
    ld de, W_LCDC_FadeColMathArena
    call LCDC_FadeCGBColorBlack
    ret

LCDC_FadeCGBColorBlack::
    ld b, M_LCDC_CGBMathArenaSize

.componentLoop
    ld a, [W_LCDC_CGBFadeFactor]
    cp [hl]
    jp c, .useFadedColor
    ld a, [hl]
    
.useFadedColor
    ld [de], a
    
    inc hl
    inc de
    dec b
    jp nz, .componentLoop
    call LCDC_CGBColorPack24to15
    ret

;Repack colors into a format the CGB can read.
;For color maths, we split out the individual 5 bits of R, G, and B into
;separate bytes; so we have to bitmanip them back together here.
LCDC_CGBColorPack24to15::
    dec de
    ld a, [de]
    ld b, a
    sla b
    sla b
    
    dec de
    ld a, [de]
    sla a
    swap a
    ld c, a
    and $3
    or b
    ld b, a
    ld a, c
    and $E0
    ld c, a
    
    dec de
    ld a, [de]
    or c
    
    ;Write the packed palette to the target pointer, moving it up in the process
    ld c, a
    ld a, [W_LCDC_ColMathPaletteTarget]
    ld d, a
    ld a, [W_LCDC_ColMathPaletteTarget + 1]
    ld e, a
    
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    
    ld a, d
    ld [W_LCDC_ColMathPaletteTarget], a
    ld a, e
    ld [W_LCDC_ColMathPaletteTarget + 1], a
    ret