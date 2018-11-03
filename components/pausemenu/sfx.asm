SECTION "PauseMenu Phone IME SFX", ROMX[$66A1], BANK[$4]
PauseMenu_PlayPhoneButtonSFX::
    ld a, [W_PhoneIME_Button]
    ld e, a
    ld d, 0
    ld hl, .sfx_table
    add hl, de
    ld a, [hl]
    ld [W_Sound_NextSFXSelect], a
    ret
    
.sfx_table
    db $63, $63, $63, $63, $16, $17, $18, $19
    db $1A, $1B, $1C, $1D, $1E, $1F, $20, $21
