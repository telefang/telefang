INCLUDE "telefang.inc"

SECTION "LCDC Disable LCD", ROM0[$07DF]
;Disable the LCD (so we can have unfettered VRAM access)
;
;Since lot check guidelines prohibit us from disabling LCD mid-frame, we have to
;wait for the next Vblank period before doing so. Not doing so constititues a
;killer poke. (Apparantly. I haven't tried this myself.)
LCDC_DisableLCD::
    ld a, [REG_IE]
    ld [$FF93], a
    res 0, a        ;KNOWN BUG: Does not actually disable Vblank IRQ
    
.waitForVblank
    ld a, [REG_LY]
    cp $91
    jr nz, .waitForVblank
    
    ld a, [W_ShadowREG_LCDC]
    and $7F
    ld [REG_LCDC], a
    
    ld a, [$FF93]
    ld [REG_IE], a
    ret
    
;Enable the LCD.
;
;Since it's already disabled, we don't have to worry about waiting for VBlank to
;avoid hardware damage.
LCDC_EnableLCD::
    ld a, [REG_LCDC]
    or $80
    ld [REG_LCDC], a
    ret