SECTION "LCDC DMG Palette management", ROM0[$1043]
LCDC_ClearDMGPaletteShadow::
    xor a
    ld [W_ShadowREG_BGP], a
    ld [W_ShadowREG_OBP0], a
    ld [W_ShadowREG_OBP1], a
    ret

LCDC_DMGSetupClearPalette::
    ld a, $FF
    ld [W_ShadowREG_BGP], a
    ld [W_ShadowREG_OBP0], a
    ld [W_ShadowREG_OBP1], a
    ret
    
LCDC_DMGSetupDirectPalette::
    ld a, $E4 ;Mapping: 3, 2, 1, 0
    ld [W_ShadowREG_BGP], a
    ld a, $E4 ;Mapping: 3, 2, 1, 0
    ld [W_ShadowREG_OBP0], a
    ld a, $D0 ;Mapping: 3, 2, 0, 0
    ld [W_ShadowREG_OBP1], a
    ret