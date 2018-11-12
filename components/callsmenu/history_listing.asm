INCLUDE "telefang.inc"

SECTION "Calls Menu History Listing Utils", ROMX[$6F59], BANK[$4]
CallsMenu_EntryListingInputHandler::
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .test_b_pressed
    
.a_pressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    call CallsMenu_QueuePhoneNumberSFXForHistoryEntry
    
    xor a
    ld [W_CallsMenu_SoundEffectIter], a
    
    ld a, 8
    ld [W_System_CountdownTimer], a
    
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    call PauseMenu_ClearArrowMetasprites
    jp System_ScheduleNextSubSubState
    
.test_b_pressed
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .test_can_scroll_listing
    
.b_pressed
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    ld a, M_CallsMenu_StateReturnToPauseMenu
    ld [W_SystemSubSubState], a
    ret
    
.test_can_scroll_listing
    ld a, [W_MelodyEdit_DataCount]
    cp 1
    ret z
    
    ld a, [W_JPInput_TypematicBtns]
    and $10
    jr z, .test_left_pressed
    
.right_pressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    dec a
    ld b, a
    ld a, [W_MelodyEdit_DataCurrent]
    cp b
    jr nz, .no_right_menu_wrap
    
.right_menu_wrap
    ld a, $FF
    
.no_right_menu_wrap
    inc a
    ld [W_MelodyEdit_DataCurrent], a
    jp CallsMenu_DrawCallHistoryEntry
    
.test_left_pressed
    ld a, [W_JPInput_TypematicBtns]
    and $20
    jr z, .nothing_pressed
    
.left_pressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    dec a
    ld b, a
    ld a, [W_MelodyEdit_DataCurrent]
    cp 0
    jr nz, .no_left_menu_wrap
    
.left_menu_wrap
    ld a, [W_MelodyEdit_DataCount]
    
.no_left_menu_wrap
    dec a
    ld [W_MelodyEdit_DataCurrent], a
    jp CallsMenu_DrawCallHistoryEntry

.nothing_pressed
    ret
    
CallsMenu_DrawCallHistoryEntry::
    ld b, a
    ld a, [W_MelodyEdit_DataCount]
    dec a
    sub b
    ld e, a
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    ld hl, W_CallsMenu_CallHistory
    add hl, de
    ldi a, [hl]
    dec a
    ld c, a
    ldi a, [hl]
    ld d, a
    ldi a, [hl]
    ld e, a
    
    push de
    
    call PauseMenu_CallsMenuDrawDenjuuNickname
    
    pop de
    push de
    
    ld a, d
    call Status_DecimalizeStatValue
    
    ld hl, $9962
    call PauseMenu_DrawTwoDigits
    
    pop de
    
    ld a, e
    call Status_DecimalizeStatValue
    
    ld hl, $9965
    call PauseMenu_DrawTwoDigits
    
    ld a, [W_MelodyEdit_DataCurrent]
    inc a
    call Status_DecimalizeStatValue
    
    ld hl, $99E2
    call PauseMenu_DrawTwoDigits
    
    ld a, [W_MelodyEdit_DataCount]
    call Status_DecimalizeStatValue
    
    ld hl, $99E5
    jp PauseMenu_DrawTwoDigits
