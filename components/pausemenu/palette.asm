INCLUDE "telefang.inc"

SECTION "Pause Menu Palettes", ROMX[$7A1E], BANK[$4]
PauseMenu_CGBLoadPalettes::
    ld bc, $15
    call Banked_CGBLoadBackgroundPalette
    
    ld bc, 3
    call Banked_CGBLoadObjectPalette
    
    call PauseMenu_CGBApplyWindowFlavor
    jp PauseMenu_CGBLoadPhonePalette

SECTION "Pause Menu Palettes 2", ROMX[$6EFE], BANK[$4]
PauseMenu_CGBApplyWindowFlavor::
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld a, [W_PauseMenu_WindowFlavor]
    ld e, a
    ld d, 0
    ld hl, $320
    add hl, de
    push hl
    pop bc
    ld a, 5
    jp CGBLoadBackgroundPaletteBanked