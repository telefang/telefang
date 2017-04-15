INCLUDE "telefang.inc"

SECTION "Phone IME Glyph Processing", ROMX[$66C0], BANK[$4]
PauseMenu_PhoneIMEPlayerNameGlyph::
    ld a, [W_PauseMenu_PhoneIMELastPressedButton]
    cp $FF
    jr z, .setCharacter
    
    ld b, a
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp b
    jr nz, .gotoNextGlyph
    
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    inc a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    jr .setCharacter
    
.gotoNextGlyph
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_MainScript_PlayerNameSize - 1
    jr z, .setCharacter
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    inc a
    ld [W_PauseMenu_SelectedMenuItem], a
    
.setCharacter
    ld a, [W_PauseMenu_PhoneIMEButton]
    ld [W_PauseMenu_PhoneIMELastPressedButton], a
    
    ld a, [W_PauseMenu_CurrentPhoneIME]
    ld hl, PauseMenu_PhoneIMEData
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a ;HL now points to the IME-specific mapping table
    
    ld a, [W_PauseMenu_PhoneIMEButton]
    sub 4
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a ;HL now points to the specific keypad button's list
    
    ld a, [hli]
    ld b, a
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp b
    jr nz, .noPressCountOverflow
    
.pressCountOverflow
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
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
    
    call PauseMenu_PhoneIMESyncPlayerName
    jp PauseMenu_DrawCenteredNameBuffer

PauseMenu_PhoneIMEDenjuuNicknameGlyph::
    ld a, [W_PauseMenu_PhoneIMELastPressedButton]
    cp $FF
    jr z, .setCharacter
    
    ld b, a
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp b
    jr nz, .gotoNextGlyph
    
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    inc a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    jr .setCharacter
    
.gotoNextGlyph
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_SaveClock_DenjuuNicknameSize - 1
    jr z, .setCharacter
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    inc a
    ld [W_PauseMenu_SelectedMenuItem], a
    
.setCharacter
    ld a, [W_PauseMenu_PhoneIMEButton]
    ld [W_PauseMenu_PhoneIMELastPressedButton], a
    
    ld a, [W_PauseMenu_CurrentPhoneIME]
    ld hl, PauseMenu_PhoneIMEData
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a ;HL now points to the IME-specific mapping table
    
    ld a, [W_PauseMenu_PhoneIMEButton]
    sub 4
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a ;HL now points to the specific keypad button's list
    
    ld a, [hli]
    ld b, a
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp b
    jr nz, .noPressCountOverflow
    
.pressCountOverflow
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
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
    
    call PauseMenu_PhoneIMESyncDenjuuNickname
    jp PauseMenu_DrawCenteredNameBuffer