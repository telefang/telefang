SECTION "Phone IME Patch WRAM", WRAM0[$CB60]
W_PhoneIME_NextCharTimer:: ds 1

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
