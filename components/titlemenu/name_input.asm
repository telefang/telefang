INCLUDE "telefang.inc"

SECTION "Title Menu Player Name WRAM", WRAM0[$C3A9]
W_TitleMenu_NameBuffer:: ds M_SaveClock_DenjuuNicknameEntrySize + 1

SECTION "Title Menu Player Name Input", ROMX[$68FF], BANK[$4]
TitleMenu_PositionNameCursor::
    call TitleMenu_PositionNameCursor_GetPosition
    add 6
    ld b, a
    ld c, $68
    jp TitleMenu_PositionNicknameCursor.common

TitleMenu_PositionNameCursor_GetPosition::
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld hl, .cursorPositionList
    add l
    ld l, a
    ld a, [hl]
    ret
    
.cursorPositionList
    db $0A
    db $10
    db $16
    db $1C
    db $22
    db $28
    db $2E
    db $34
    db $3A
    db $40
	
	; Note: Free space.
	nop
	nop
	nop
    
;Nearly identical function to the above...
;Anyway, it's called by state 03 20, which I -think- has something to do with
;nicknaming denjuu obtained through link communications.
TitleMenu_PositionNicknameCursor::
    call TitleMenu_PositionNameCursor_GetPosition
    ld b, a
    ld c, $70

.common
    ld de, $C0C0 ;TODO: Cursor structure
    call PauseMenu_PositionCursor
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret
	
	; Note: Free space.
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

SECTION "Title Menu Player Name Input 2", ROMX[$6488], BANK[$4]
TitleMenu_ClearCharaName::
    push af
    push hl
    M_AuxJmp Banked_PatchUtils_InitializeRelocatedCharaName
    pop hl
    pop af
    ret

SECTION "Title Menu Player Name Input 3", ROMX[$64A9], BANK[$4]
TitleMenu_NameInputImpl::
    call PhoneIME_InputProcessing
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .noBButtonPress
    
.backspaceProcessing
    call TitleMenu_NameInputImpl_backspaceProcessingCommon
    
    call PhoneIME_SyncPlayerName
    call PauseMenu_DrawCenteredNameBufferNoVWF
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    and a
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
    jp z, .checktimer
    
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
    jp PhoneIME_PlayerNameGlyphWithIMEAutoSwitch
    
;Cycle to the next IME mode.
.cycleNextIME ;12519
    xor a
    ld [W_PhoneIME_PressCount], a
    
    ld a, [W_PhoneIME_CurrentIME]
    inc a
    cp M_PhoneIME_IMEExtendedEND
    jr nz, .storeNextIME
    
    xor a
.storeNextIME
    ld [W_PhoneIME_CurrentIME], a
    
    add a, 1
    cp M_PhoneIME_IMEExtendedEND
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
    and a
    jr nz, .playerNameConfirmed
    
    push af
    push hl
    M_AuxJmp Banked_PatchUtils_StoreDefaultCharaName
    pop hl
    pop af
    
    ld a, 7
    ld [W_PauseMenu_SelectedMenuItem], a
    
    call PhoneIME_SyncPlayerName
    jp PauseMenu_DrawCenteredNameBufferNoVWF
    
.playerNameConfirmed
    jp System_ScheduleNextSubState
    
.diacriticIntent
    ld a, [W_PhoneIME_CurrentIME]
    cp M_PhoneIME_IMEExtendedNumerals
    jp z, PhoneIME_PlayerNameGlyph
    jp PhoneIME_PlayerNameDiacritic
    
.leftKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    and a
    ret z
    dec a
    jr .cursorChange
    
.checktimer
    call PhoneIME_ADVICE_CheckTimer
    ret nz

.rightKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_MainScript_PlayerNameSize - 1
    ret z
    inc a
    
.cursorChange
    ld [W_PauseMenu_SelectedMenuItem], a
    call PhoneIME_ADVICE_ResetTimer
    call PhoneIME_CheckIMEAutoSwitch
    jr z, .cycleNextIME

.return
    ret

TitleMenu_NicknameInputImpl::
    call PhoneIME_InputProcessing
    
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .noBButtonPress
    
.backspaceProcessing
    call TitleMenu_NameInputImpl_backspaceProcessingCommon
    
    call PhoneIME_SyncDenjuuNickname
    call PauseMenu_DrawCenteredNameBufferNoVWFWithOffset
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    and a
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
    jp z, .checktimer
    
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
    jp PhoneIME_DenjuuNicknameGlyphWithIMEAutoSwitch
    
;Cycle to the next IME mode.
.cycleNextIME
    xor a
    ld [W_PhoneIME_PressCount], a
    
    ld a, [W_PhoneIME_CurrentIME]
    inc a
    cp M_PhoneIME_IMEExtendedEND
    jr nz, .storeNextIME
    
    xor a
.storeNextIME
    ld [W_PhoneIME_CurrentIME], a
    
    add a, 1
    cp M_PhoneIME_IMEExtendedEND
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
    and a
    jr nz, .playerNameConfirmed

    inc de
    ld a, $E6
    ld [de], a
    call PhoneIME_SyncDenjuuNickname
    
.playerNameConfirmed
    jp System_ScheduleNextSubState
    
.diacriticIntent
    ld a, [W_PhoneIME_CurrentIME]
    cp M_PhoneIME_IMEExtendedNumerals
    jp z, PhoneIME_DenjuuNicknameGlyph
    jp PhoneIME_DenjuuNicknameDiacritic
    
.leftKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    and a
    ret z
    
    dec a
    
    jr .cursorChange
    
.checktimer
    call PhoneIME_ADVICE_CheckTimer
    ret nz

.rightKeypadPress
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_SaveClock_DenjuuNicknameEntrySize - 1
    ret z
    
    inc a

.cursorChange
    ld [W_PauseMenu_SelectedMenuItem], a
    
    call PhoneIME_ADVICE_ResetTimer
    call PhoneIME_CheckIMEAutoSwitch
    jr z, .cycleNextIME
    
.return
    ret

TitleMenu_NameInputImpl_backspaceProcessingCommon::
    ld a, $FF
    ld [W_PhoneIME_LastPressedButton], a
    
    call PhoneIME_ADVICE_ResetTimer
    
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld [hl], $20
    ret

SECTION "Phone IME Auto Switch", ROMX[$7DAB], BANK[$4]

PhoneIME_PlayerNameGlyphWithIMEAutoSwitch::
    call PhoneIME_CheckIMEAutoSwitchOnGlyphInput
    call nz, TitleMenu_NameInputImpl.cycleNextIME
    jp PhoneIME_PlayerNameGlyph

PhoneIME_DenjuuNicknameGlyphWithIMEAutoSwitch::
    call PhoneIME_CheckIMEAutoSwitchOnGlyphInput
    call nz, TitleMenu_NicknameInputImpl.cycleNextIME
    jp PhoneIME_DenjuuNicknameGlyph

