SECTION "Title Menu State Machine (Power)", ROMX[$4054], BANK[$4]
; State 03 00
TitleMenu_StateSetupPalettes::
    ld bc, 0
    call Banked_CGBLoadBackgroundPalette
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    
    xor a
    ld [W_PauseMenu_NextPhoneIME], a
    ld [W_PauseMenu_CurrentPhoneIME], a
    
    ld a, 0
    ld [W_PauseMenu_PhoneState], a
    
    jp System_ScheduleNextSubState