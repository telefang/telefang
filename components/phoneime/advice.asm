INCLUDE "telefang.inc"

SECTION "Phone IME Patch WRAM", WRAM0[$CB60]
W_PhoneIME_NextCharTimer:: ds 1

SECTION "Phone IME Abc Mode", ROMX[$7D8C], BANK[$4]
PhoneIME_GetIMEGraphicsID::
    cp M_PhoneIME_IMEExtendedNumerals
    jr nz, .asIs
    dec a
    dec a

.asIs
    ret

PhoneIME_CheckIMEAutoSwitch::
    dec a
    ld [W_PhoneIME_LastPressedButton], a
    ld a, [W_PhoneIME_CurrentIME]
    or a
    ret

PhoneIME_CheckIMEAutoSwitchOnGlyphInput::
    ld a, [W_PhoneIME_LastPressedButton]
    cp $FF
    ret z
    ld b, a
    ld a, [W_PhoneIME_Button]
    cp b
    ret z
    jp PhoneIME_CheckIMEAutoSwitch_Alt

SECTION "Phone IME Translate ID", ROMX[$7DBD], BANK[$4]
PhoneIME_GetIMEID::
    ld a, [W_PhoneIME_CurrentIME]
    cp M_PhoneIME_IMEExtendedLatinUpper
    jr c, .asIs
    jr nz, .numerals
    dec a

.numerals
    dec a

.asIs
    ret
	nop

SECTION "Phone IME Abc Mode 2", ROMX[$666B], BANK[$4]
PhoneIME_CheckIMEAutoSwitch_Alt::
    ld a, [W_PhoneIME_CurrentIME]
    dec a
    and $80
    ret
    nop

SECTION "Phone IME Character Input Timer", ROMX[$45A4], BANK[$4]
PhoneIME_ADVICE_StartTimer::
    ld a, $48
    ld [W_PhoneIME_NextCharTimer], a
    ld a, [W_PhoneIME_LastPressedButton]
    ret

PhoneIME_ADVICE_ResetTimer::
    xor a
    ld [W_PhoneIME_PressCount], a
    ld [W_PhoneIME_NextCharTimer], a
    ret

PhoneIME_ADVICE_CheckTimer::
    ld a, [W_PhoneIME_NextCharTimer]
    sub 1
    ret c

    ld [W_PhoneIME_NextCharTimer], a
    or a
    ret
