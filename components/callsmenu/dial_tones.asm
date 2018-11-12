INCLUDE "telefang.inc"

SECTION "Calls Menu Dial Tone Memory", WRAM0[$CB08]
W_CallsMenu_DialToneBuffer:: ds M_CallsMenu_DialToneBufferCount

SECTION "Calls Menu Dial Tone WRAM 2", WRAM0[$CB6D]
W_CallsMenu_SoundEffectIter:: ds 1

SECTION "Calls Menu Dial Tone Queue", ROMX[$72B0], BANK[$4]
CallsMenu_QueuePhoneNumberSFXForContact::
    push af
    
    and $F0
    swap a
    ld d, a
    
    pop af
    
    and $F
    swap a
    ld e, a
    ld b, BANK(S_SaveClock_StatisticsArray)
    call TitleMenu_EnterSRAM
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuPhoneVals
    add hl, de
    ldi a, [hl]
    ld e, a
    ldi a, [hl]
    ld d, a
    ldi a, [hl]
    ld c, a
    ldi a, [hl]
    ld b, a
    ld a, [hl]
    
    push af
    
    call TitleMenu_ExitSRAM
    
    pop af
    
    call Banked_Status_CalculatePhoneNumber
    jp CallsMenu_ConvertPhoneNumberIntoDialTones

SECTION "Calls Menu Dial Tone Utilities", ROMX[$6AEF], BANK[$4]
CallsMenu_ConvertPhoneNumberIntoDialTones::
    ld hl, $CA00
    ld de, W_CallsMenu_DialToneBuffer
    ld b, M_CallsMenu_DialToneBufferCount
    
.digit_index_conversion_loop
    ldi a, [hl]
    
    cp M_ContactEnlist_PhoneSymbolDash
    jr z, .next_digit
    
.store_tone_in_memory
    sub M_ContactEnlist_PhoneSymbol0
    srl a
    ld [de], a
    
    inc de
    
.next_digit
    dec b
    jr nz, .digit_index_conversion_loop
    
    ld b, M_CallsMenu_DialToneBufferLogicalCount
    ld hl, W_CallsMenu_DialToneBuffer
    
.sfx_tone_storage_loop
    push bc
    
    ld a, [hl]
    
    push hl
    
    ld hl, .dial_sfx_table
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    
    pop hl
    
    ldi [hl], a
    
    pop bc
    
    dec b
    jr nz, .sfx_tone_storage_loop
    ret

.dial_sfx_table
    db $A, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 0, $B, 0, 9

;I don't know where this code is called from, but I imagine it's a different
;component altogether.
sub_12B2B::
    ld a, [W_System_CountdownTimer]
    dec a
    ld [W_System_CountdownTimer], a
    
    cp 0
    ret nz
    
    ld a, [W_MelodyEdit_DataCurrent]
    cp M_CallsMenu_DialToneBufferLogicalCount
    jr z, .done_playing_dial_tones
    
.play_next_dial_tone
    ld a, 8
    ld [W_System_CountdownTimer], a
    
    ld hl, W_CallsMenu_DialToneBuffer
    ld a, [W_MelodyEdit_DataCurrent]
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    add a, $16
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCurrent]
    inc a
    ld [W_MelodyEdit_DataCurrent], a
    ret
    
.done_playing_dial_tones
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    ld a, $C
    ld [W_SystemSubSubState], a
    ret

CallsMenu_DialQueuedPhoneNumber::
    ld a, [W_System_CountdownTimer]
    dec a
    ld [W_System_CountdownTimer], a
    
    cp 0
    ret nz
    
    ld a, [W_CallsMenu_SoundEffectIter]
    cp M_CallsMenu_DialToneBufferLogicalCount
    jr z, .done_playing_dial_tones
    
.play_next_dial_tone
    ld a, 8
    ld [W_System_CountdownTimer], a
    
    ld hl, W_CallsMenu_DialToneBuffer
    ld a, [W_CallsMenu_SoundEffectIter]
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    add a, $16
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_CallsMenu_SoundEffectIter]
    inc a
    ld [W_CallsMenu_SoundEffectIter], a
    ret
    
.done_playing_dial_tones
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    jp System_ScheduleNextSubSubState
