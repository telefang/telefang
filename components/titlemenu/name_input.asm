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
    ld hl, W_TitleMenu_NameBuffer
    ld de, W_MainScript_CenteredNameBuffer
    ld b, M_MainScript_PlayerNameSize + 1

.clearLoop
    ld a, $E0
    ld [de], a
    inc de
    xor a
    ld [hli], a
    dec b
    jr nz, .clearLoop
    
    ret

SECTION "Title Menu Player Name Input 3", ROMX[$64A9], BANK[$4]
TitleMenu_NameInputImpl::
    call PhoneIME_InputProcessing
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .noBButtonPress
    
.backspaceProcessing
    ld a, $FF
    ld [W_PhoneIME_LastPressedButton], a
    
    xor a
    ld [W_PhoneIME_PressCount], a
    
    ld hl, $9780
    ld b, M_MainScript_PlayerNameSize
    call PauseMenu_ClearInputTiles
    
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld [hl], 0
    
    call PhoneIME_SyncPlayerName
    call PauseMenu_DrawCenteredNameBuffer
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    ret z
    
    dec a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    ret
    
.noBButtonPress
    ld a, [H_JPInput_Changed]
    and M_JPInput_Start
    jr nz, .confirmIntent
    
.noStartButtonPress
    ld a, [H_JPInput_Changed]
    and M_JPInput_A
    jp z, .return
    
    call PauseMenu_PlayPhoneButtonSFX
    ld a, [W_PhoneIME_Button]
    cp M_PhoneIME_ButtonNote
    jp z, .cycleNextIME
    cp M_PhoneIME_ButtonLeft
    jp z, .leftKeypadPress
    cp M_PhoneIME_ButtonRight
    jp z, .rightKeypadPress
    cp M_PhoneIME_ButtonConfirm
    jp z, .confirmIntent
    cp M_PhoneIME_ButtonStar
    jp z, .diacriticIntent
    cp M_PhoneIME_ButtonPound
    jp z, .diacriticIntent
    jp PhoneIME_PlayerNameGlyph
    
;Cycle to the next IME mode.
.cycleNextIME ;12519
    xor a
    ld [W_PhoneIME_PressCount], a
    
    ld a, [W_PhoneIME_CurrentIME]
    inc a
    cp M_PhoneIME_IMEEND
    jr nz, .storeNextIME
    
    xor a
.storeNextIME
    ld [W_PhoneIME_CurrentIME], a
    
    add a, 1
    cp M_PhoneIME_IMEEND
    jr nz, .storePhoneIME
    
    xor a
.storePhoneIME
    ld [W_PhoneIME_NextIME], a
    
    call PhoneIME_LoadGraphicsForIME
    jp PhoneIME_LoadTilemapForIME
    
;If the name is empty, write the default name.
;Otherwise, confirm the player name.
.confirmIntent ;12539
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    call PhoneIME_SyncPlayerName
    cp 0
    jr nz, .playerNameConfirmed
    
    ;シゲキ
    ld a, $C
    ld [W_TitleMenu_NameBuffer], a
    ld a, $70
    ld [W_TitleMenu_NameBuffer + 1], a
    ld a, 7
    ld [W_TitleMenu_NameBuffer + 2], a
    
    ld a, 3
    ld [W_PauseMenu_SelectedMenuItem], a
    
    call PhoneIME_SyncPlayerName
    jp PauseMenu_DrawCenteredNameBuffer
    
.playerNameConfirmed
    jp System_ScheduleNextSubState
    
.diacriticIntent
    jp PhoneIME_PlayerNameDiacritic
    
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
    ld [W_PhoneIME_LastPressedButton], a
    xor a
    ld [W_PhoneIME_PressCount], a

.return
    ret

TitleMenu_NicknameInputImpl::
    call PhoneIME_InputProcessing
    
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .noBButtonPress
    
.backspaceProcessing
    ld a, $FF
    ld [W_PhoneIME_LastPressedButton], a
    
    xor a
    ld [W_PhoneIME_PressCount], a
    
    ld hl, $9780
    ld b, M_SaveClock_DenjuuNicknameSize
    call PauseMenu_ClearInputTiles
    
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld [hl], 0
    
    call PhoneIME_SyncDenjuuNickname
    call PauseMenu_DrawCenteredNameBuffer
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    ret z
    
    dec a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    ret
    
.noBButtonPress
    ld a, [H_JPInput_Changed]
    and M_JPInput_Start
    jr nz, .confirmIntent
    
    ld a, [H_JPInput_Changed]
    and M_JPInput_A
    jp z, .return
    
    call PauseMenu_PlayPhoneButtonSFX
    ld a, [W_PhoneIME_Button]
    cp M_PhoneIME_ButtonNote
    jp z, .cycleNextIME
    cp M_PhoneIME_ButtonLeft
    jp z, .leftKeypadPress
    cp M_PhoneIME_ButtonRight
    jp z, .rightKeypadPress
    cp M_PhoneIME_ButtonConfirm
    jp z, .confirmIntent
    cp M_PhoneIME_ButtonStar
    jp z, .diacriticIntent
    cp M_PhoneIME_ButtonPound
    jp z, .diacriticIntent
    jp PhoneIME_DenjuuNicknameGlyph
    
;Cycle to the next IME mode.
.cycleNextIME
    xor a
    ld [W_PhoneIME_PressCount], a
    
    ld a, [W_PhoneIME_CurrentIME]
    inc a
    cp M_PhoneIME_IMEEND
    jr nz, .storeNextIME
    
    xor a
.storeNextIME
    ld [W_PhoneIME_CurrentIME], a
    
    add a, 1
    cp M_PhoneIME_IMEEND
    jr nz, .storePhoneIME
    
    xor a
.storePhoneIME
    ld [W_PhoneIME_NextIME], a
    
    call PhoneIME_LoadGraphicsForIME
    jp PhoneIME_LoadTilemapForIME
    
.confirmIntent
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    call PhoneIME_SyncDenjuuNickname
    cp 0
    jr nz, .playerNameConfirmed
    
    ld a, [$D4A7]
    call TitleMenu_LoadDenjuuNicknameIntoBuffer
    call PhoneIME_SyncPlayerName
    
    ld d, $C
    jp PauseMenu_DrawCenteredNameBuffer
    
.playerNameConfirmed
    jp System_ScheduleNextSubState
    
.diacriticIntent
    jp PhoneIME_DenjuuNicknameDiacritic
    
.leftKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    ret z
    
    dec a
    ld [W_PauseMenu_SelectedMenuItem], a
    
    ld a, $FF
    ld [W_PhoneIME_LastPressedButton], a
    
    xor a
    ld [W_PhoneIME_PressCount], a
    ret
    
.rightKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_SaveClock_DenjuuNicknameSize - 1
    ret z
    
    inc a
    ld [W_PauseMenu_SelectedMenuItem], a
    
    ld a, $FF
    ld [W_PhoneIME_LastPressedButton], a
    
    xor a
    ld [W_PhoneIME_PressCount], a
    
.return
    ret