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

SECTION "Pause menu IME Diacritic patch stuff", ROMX[$6629], BANK[$4]
PhoneIME_ADVICE_NameDiacriticCommon::
    ld hl, W_TitleMenu_NameBuffer
    ld bc, W_PauseMenu_SelectedMenuItem
    ld a, [bc]
    ld e, a
    add l
    ld l, a
    ld a, e
    or a
    jr z, .skipLeftCheck

.loop
    ld a, [hl]
    cp $20
    jr nz, .exitLoop
    dec hl
    dec e
    jr nz, .loop

.exitLoop
    ld a, e
    ld [bc], a

.skipLeftCheck
    ld a, [hl]
    push af
    push hl
    call PhoneIME_ApplyDiacritic
    pop hl
    ld [hl], a
    pop de
    cp d
    ret z
    ld a, $48
    ld [W_PhoneIME_NextCharTimer], a
    ld a, $10
    ld [W_PhoneIME_LastPressedButton], a
    ret
    nop
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

PhoneIME_ADVICE_ResetTimer_extJP::
    ld [W_PhoneIME_NextCharTimer], a
    ret

PhoneIME_ADVICE_CheckTimer::
    ld a, [W_PhoneIME_NextCharTimer]
    sub 1
    ret c

    ld [W_PhoneIME_NextCharTimer], a
    or a
    ret

SECTION "Phone IME Backspace Fix", ROMX[$67C2], BANK[$4]
TitleMenu_ADVICE_NameInputImpl_fixDoubleBackspace::
    call PhoneIME_ADVICE_ResetTimer
    ld de, W_PauseMenu_SelectedMenuItem
    ld a, [de]
    or a
    ret z
    call TitleMenu_ADVICE_NameInputImpl_isSpace
    ret nz
    ld a, [W_PhoneIME_LastPressedButton]
    cp $FF
    ret nz
    ld a, [de]
    dec a
    ld [de], a
    ret
    nop

SECTION "Phone IME Backspace Fix 2", ROMX[$667C], BANK[$4]
TitleMenu_ADVICE_NameInputImpl_isSpace::
    ld hl, W_TitleMenu_NameBuffer
    add l
    ld l, a
    ld a, [hl]
    cp $20
    ret

    ; Note: Free Space
    nop
    nop
    nop
    nop
    nop

SECTION "Phone IME Backspace Fix 3", ROMX[$6693], BANK[$4]
TitleMenu_ADVICE_NameInputImpl_determineBackspaceFocus::
    ld a, [W_PauseMenu_SelectedMenuItem]
    or a
    ld a, $FF
    jr z, .notFirstpos
    ld a, $11

.notFirstpos
    ld [W_PhoneIME_LastPressedButton], a
    ret
