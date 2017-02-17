INCLUDE "telefang.inc"

SECTION "LCDC Palette Fade WRAM", WRAM0[$C3D8]
W_LCDC_PaletteAnimWaitCounter:: ds 1
W_LCDC_PaletteAnimSlowdown:: ds 1
W_LCDC_PaletteAnimFrame:: ds 1
    ds 4
W_LCDC_PaletteAnimRunning:: ds 1

SECTION "LCDC Palette Fade WRAM2", WRAM0[$CB27]
W_LCDC_FadeType:: ds 1

SECTION "LCDC Palette Fade Operations", ROM0[$122D]
; Sets up a new palette animation.
; A = The slowdown factor for the animation.
;     Essentially, multiplied by the standard fade framecount of 4 to produce a
;     final fade length. The higher the slowdown, the more wait frames in
;     between palette changes.
; 
; On return, A is 1 if the animation ended or 0 if the animation is running or
; not started yet.
LCDC_SetupPalswapAnimation::
    ld [W_LCDC_PaletteAnimSlowdown], a
    xor a
    ld [W_LCDC_PaletteAnimWaitCounter], a
    ld [W_LCDC_PaletteAnimFrame], a
    ld a, 1
    ld [W_LCDC_PaletteAnimRunning], a
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret nz
    push de
    call LCDC_UnpackStagedPalettes
    pop de
    ret

; Does the actual per-frame fade animation.
LCDC_PaletteFade::
    ld [W_LCDC_FadeType], a
    ld a, [W_LCDC_PaletteAnimWaitCounter]
    or a
    jr z, .doFade
    dec a
    ld [W_LCDC_PaletteAnimWaitCounter], a
    jp .noFade

.doFade
    ld a, [W_LCDC_PaletteAnimFrame]
    cp M_LCDC_FadeLength
    jr z, .endAnimation
    ld a, [W_LCDC_PaletteAnimSlowdown]
    ld [W_LCDC_PaletteAnimWaitCounter], a
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jp z, Banked_LCDC_PaletteFadeCGB
    
    ;DMB/MGB-only codepath.
    ld a, [W_LCDC_FadeType]
    ld d, 0
    ld e, a
    sla e
    rl d
    sla e
    rl d
    ld hl, LCDC_DMGPaletteFades
    add hl, de
    
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    ld a, [W_LCDC_PaletteAnimFrame]
    ld d, 0
    ld e, a
    add hl, de
    
    ld a, [hl]
    ld [W_ShadowREG_BGP], a
    
    ld d, 0
    ld e, 5
    add hl, de
    ld a, [hl]
    ld [W_ShadowREG_OBP0], a
    
    ld d, 0
    ld e, 5
    add hl, de
    ld a, [hl]
    ld [W_ShadowREG_OBP1], a
    
    ld a, [W_LCDC_PaletteAnimFrame]
    inc a
    ld [W_LCDC_PaletteAnimFrame], a

.noFade
    xor a
    ret

.endAnimation
    xor a
    ld [W_LCDC_PaletteAnimRunning], a
    ld a, 1
    ret

;Perhaps this could be better implemented as a compilable resource...
;Anyway, one interesting part about this table is that it's structured in rows
;of 5, but the fade logic consumes three rows per animation (one for BGP, OBPx).
;Despite this, the table itself is perfectly fine with aliasing the OBP rows of
;other fade animations. So, for example, the first fade's reference to .pal1
;will pull .pal2 for OBP0 and .pal3 for OBP1, but the second fade pulls .pal3 as
;a BGP animation. Furthermore, one of the fades points to the end of the table,
;meaning that random code will be taken as OBPx palettes!
LCDC_DMGPaletteFades:
    dw .pal1, .pal3, .pal4, .pal6, .pal7, .pal9, .palA, .palC
    
.pal1 dw $00, $54, $A4, $E4, $FF
.pal2 dw $00, $50, $A0, $E0, $FF
.pal3 dw $00, $51, $92, $D2, $FF
.pal4 dw $E4, $A4, $54, $00, $FF
.pal5 dw $E0, $A0, $50, $00, $FF
.pal6 dw $D2, $92, $51, $00, $FF
.pal7 dw $FF, $EA, $E5, $E4, $FF
.pal8 dw $FF, $EA, $E5, $E0, $FF
.pal9 dw $FF, $EA, $D6, $D2, $FF
.palA dw $E4, $E5, $EA, $FF, $FF
.palB dw $E0, $E5, $EA, $FF, $FF
.palC dw $D2, $D6, $EA, $FF, $FF