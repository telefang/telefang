INCLUDE "telefang.inc"

SECTION "Phone IME Glyph Processing", ROMX[$66C0], BANK[$4]
PhoneIME_PlayerNameGlyph::
    call PhoneIME_ADVICE_StartTimer
    cp $FF
    jr z, .setCharacter
    
    ld b, a
    ld a, [W_PhoneIME_Button]
    cp b
    jr nz, .gotoNextGlyph
    
    ld a, [W_PhoneIME_PressCount]
    inc a
    ld [W_PhoneIME_PressCount], a
    jr .setCharacter
    
.gotoNextGlyph
    xor a
    ld [W_PhoneIME_PressCount], a
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_MainScript_PlayerNameSize - 1
    jr z, .setCharacter
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    inc a
    ld [W_PauseMenu_SelectedMenuItem], a
    
.setCharacter
    ld a, [W_PhoneIME_Button]
    ld [W_PhoneIME_LastPressedButton], a
    
    call PhoneIME_GetIMEID
    ld hl, PhoneIME_Data
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a ;HL now points to the IME-specific mapping table
    
    ld a, [W_PhoneIME_Button]
    sub 4
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a ;HL now points to the specific keypad button's list
    
    ld a, [hli]
    ld b, a
    ld a, [W_PhoneIME_PressCount]
    cp b
    jr nz, .noPressCountOverflow
    
.pressCountOverflow
    xor a
    ld [W_PhoneIME_PressCount], a
    
.noPressCountOverflow
    ld e, a
    ld d, 0
    add hl, de
    
    ld a, [hl]
    push af
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    pop af
    ld [hl], a ;Set the current character
    
    call PhoneIME_SyncPlayerName
    jp PauseMenu_DrawCenteredNameBufferNoVWF

PhoneIME_DenjuuNicknameGlyph::
    call PhoneIME_ADVICE_StartTimer
    cp $FF
    jr z, .setCharacter
    
    ld b, a
    ld a, [W_PhoneIME_Button]
    cp b
    jr nz, .gotoNextGlyph
    
    ld a, [W_PhoneIME_PressCount]
    inc a
    ld [W_PhoneIME_PressCount], a
    jr .setCharacter
    
.gotoNextGlyph
    xor a
    ld [W_PhoneIME_PressCount], a
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_SaveClock_DenjuuNicknameSize - 1
    jr z, .setCharacter
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    inc a
    ld [W_PauseMenu_SelectedMenuItem], a
    
.setCharacter
    ld a, [W_PhoneIME_Button]
    ld [W_PhoneIME_LastPressedButton], a
    
    call PhoneIME_GetIMEID
    ld hl, PhoneIME_Data
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a ;HL now points to the IME-specific mapping table
    
    ld a, [W_PhoneIME_Button]
    sub 4
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a ;HL now points to the specific keypad button's list
    
    ld a, [hli]
    ld b, a
    ld a, [W_PhoneIME_PressCount]
    cp b
    jr nz, .noPressCountOverflow
    
.pressCountOverflow
    xor a
    ld [W_PhoneIME_PressCount], a
    
.noPressCountOverflow
    ld e, a
    ld d, 0
    add hl, de
    
    ld a, [hl]
    push af
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    pop af
    ld [hl], a ;Set the current character
    
    call PhoneIME_SyncDenjuuNickname
    jp PauseMenu_DrawCenteredNameBufferNoVWF
