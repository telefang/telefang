INCLUDE "telefang.inc"

SECTION "Title Menu Player Name WRAM", WRAM0[$C3A9]
W_TitleMenu_NameBuffer:: ds M_MainScript_PlayerNameSize + 1

SECTION "Title Menu Player Name Input", ROMX[$68FF], BANK[$4]
TitleMenu_PositionNameCursor::
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    ld hl, .cursorPositionList
    add hl, de
    ld a, [hl]
    
    ld b, a
    ld c, $68
    ld de, $C0C0 ;TODO: This is the cursor structure
    call PauseMenu_PositionCursor
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret
    
.cursorPositionList
    db $08
    db $10
    db $18
    db $20
    db $28
    db $30
    db $38
    db $40
    
;Nearly identical function to the above...
;It doesn't use a lookup table, but instead calculates the X coordinate in the
;same way, all for an 8 pixel offset...
;Anyway, it's called by state 03 20, which I -think- has something to do with
;nicknaming denjuu obtained through link communications.
TitleMenu_PositionNicknameCursor::
    ld a, [W_PauseMenu_SelectedMenuItem]
    sla a
    sla a
    sla a
    add a, $10
    ld b, a
    ld c, $70
    ld de, $C0C0 ;TODO: Cursor structure
    call PauseMenu_PositionCursor
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret

SECTION "Title Menu Player Name Input 2", ROMX[$6488], BANK[$4]
TitleMenu_ClearCharaName::
    push af
    push hl
    ld a, 4
    call PatchUtils_AuxCodeJmp
    pop hl
    pop af
    ret

SECTION "Title Menu Player Name Input 3", ROMX[$64A9], BANK[$4]
TitleMenu_NameInputImpl::
    call PauseMenu_PhoneIMEWraparoundProcessing
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .noBButtonPress
    
.backspaceProcessing
    ld a, $FF
    ld [$CB66], a
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
    ld hl, $9780
    ld b, M_MainScript_PlayerNameSize
    call PauseMenu_ClearInputTiles
    
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld [hl], 0
    
    call $6794
    call PauseMenu_DrawCenteredNameBufferNoVWF
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    ret z
    
    dec a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, 4
    ld [byte_FFA1], a
    ret
    
.noBButtonPress
    ld a, [H_JPInput_Changed]
    and 8
    jr nz, .confirmIntent
    
.noStartButtonPress
    ld a, [H_JPInput_Changed]
    and 1
    jp z, .return
    
    call $66A1
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp M_PhoneMenu_ButtonNote
    jp z, .cycleNextIME
    cp M_PhoneMenu_ButtonLeft
    jp z, .leftKeypadPress
    cp M_PhoneMenu_ButtonRight
    jp z, .rightKeypadPress
    cp M_PhoneMenu_ButtonConfirm
    jp z, .confirmIntent
    cp M_PhoneMenu_ButtonStar
    jp z, .specialCharacterIntent
    cp M_PhoneMenu_ButtonPound
    jp z, .specialCharacterIntent
    jp $66C0
    
;Cycle to the next IME mode.
.cycleNextIME ;12519
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
    ld a, [W_PauseMenu_NextPhoneIME]
    inc a
    cp M_PhoneMenu_IMEEND
    jr nz, .storeNextIME
    
    xor a
.storeNextIME
    ld [W_PauseMenu_NextPhoneIME], a
    
    add a, 1
    cp M_PhoneMenu_IMEEND
    jr nz, .storePhoneIME
    
    xor a
.storePhoneIME
    ld [W_PauseMenu_PhoneIME], a
    
    call PauseMenu_LoadPhoneIMEGraphics
    jp PauseMenu_LoadPhoneIMETilemap
    
;If the name is empty, write the default name.
;Otherwise, confirm the player name.
.confirmIntent ;12539
    ld a, 3
    ld [byte_FFA1], a
    call $6794
    cp 0
    jr nz, .playerNameConfirmed
    
    push af
    push hl
    ld a, 0
    call PatchUtils_AuxCodeJmp
    pop hl
    pop af
    
    nop
    nop
    nop
    nop
    nop
    nop
    
    ld a, 7
    ld [W_PauseMenu_SelectedMenuItem], a
    
    call $6794
    jp PauseMenu_DrawCenteredNameBufferNoVWF
    
.playerNameConfirmed
    jp System_ScheduleNextSubState
    
.specialCharacterIntent
    jp $6673
    
.leftKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    ret z
    dec a
    jr .cursorChange
    
.rightKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_MainScript_PlayerNameSize - 1
    ret z
    inc a
    
.cursorChange
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, $FF
    ld [$CB66], a
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a

.return
    ret

TitleMenu_NicknameInputImpl::
    call PauseMenu_PhoneIMEWraparoundProcessing
    
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .noBButtonPress
    
.backspaceProcessing
    ld a, $FF
    ld [$CB66], a
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
    ld hl, $9780
    ld b, M_SaveClock_DenjuuNicknameSize
    call PauseMenu_ClearInputTiles
    
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld [hl], 0
    
    call $67B7
    call PauseMenu_DrawCenteredNameBufferNoVWF
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    ret z
    
    dec a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, 4
    ld [byte_FFA1], a
    ret
    
.noBButtonPress
    ld a, [H_JPInput_Changed]
    and 8
    jr nz, .confirmIntent
    
    ld a, [H_JPInput_Changed]
    and 1
    jp z, .return
    
    call $66A1
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp M_PhoneMenu_ButtonNote
    jp z, .cycleNextIME
    cp M_PhoneMenu_ButtonLeft
    jp z, .leftKeypadPress
    cp M_PhoneMenu_ButtonRight
    jp z, .rightKeypadPress
    cp M_PhoneMenu_ButtonConfirm
    jp z, .confirmIntent
    cp M_PhoneMenu_ButtonStar
    jp z, .specialCharacterIntent
    cp M_PhoneMenu_ButtonPound
    jp z, .specialCharacterIntent
    jp $672A
    
;Cycle to the next IME mode.
.cycleNextIME
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
    ld a, [W_PauseMenu_NextPhoneIME]
    inc a
    cp M_PhoneMenu_IMEEND
    jr nz, .storeNextIME
    
    xor a
.storeNextIME
    ld [W_PauseMenu_NextPhoneIME], a
    
    add a, 1
    cp M_PhoneMenu_IMEEND
    jr nz, .storePhoneIME
    
    xor a
.storePhoneIME
    ld [W_PauseMenu_PhoneIME], a
    
    call PauseMenu_LoadPhoneIMEGraphics
    jp PauseMenu_LoadPhoneIMETilemap
    
.confirmIntent
    ld a, 3
    ld [byte_FFA1], a
    call $67B7
    cp 0
    jr nz, .playerNameConfirmed
    
    ld a, [$D4A7]
    call $7D8C
    call $6794
    
    ld d, $C
    jp PauseMenu_DrawCenteredNameBufferNoVWF
    
.playerNameConfirmed
    jp System_ScheduleNextSubState
    
.specialCharacterIntent
    jp $668A
    
.leftKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    ret z
    
    dec a
    ld [W_PauseMenu_SelectedMenuItem], a
    
    ld a, $FF
    ld [$CB66], a
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    ret
    
.rightKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_SaveClock_DenjuuNicknameSize - 1
    ret z
    
    inc a
    ld [W_PauseMenu_SelectedMenuItem], a
    
    ld a, $FF
    ld [$CB66], a
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
.return
    ret
