INCLUDE "telefang.inc"

SECTION "Title Menu State Machine", ROMX[$4000], BANK[$4]
TitleMenu_GameStateMachine::
    ld a, [W_SystemSubState]
    ld hl, TitleMenu_StateTable
    call System_IndexWordList
    jp [hl]
    
;TODO: disassemble
TitleMenu_StateTable
    dw $4054, $406E, $4089, $40BD, $40EA, $40FA, $4108, $4113 ;07
    dw $413B, $41EC, $41F7, $4205, $4216, $4221, $4232, $4265 ;0F
    dw $428A, $42AA, $42B3, TitleMenu_StateClearNameInput, TitleMenu_StateNameInput, TitleMenu_StateStorePlayerName, $4339, $4346 ;17
    dw $437F, $43A5, $43B4, $43E2, $4400, $440E, $4424, $406E ;1F
    dw TitleMenu_StateInitNickname, $4546, $4558, $456A, $457D ;24

SECTION "Title Menu State Machine - Name Input", ROMX[$42CD], BANK[$4]
; State 03 13
TitleMenu_StateClearNameInput::
    ld hl, $9780 ;Tile no. 78
    ld b, M_MainScript_PlayerNameSize
    call PauseMenu_ClearInputTiles
    xor a
    ld [$CA65], a
    call PauseMenu_SelectTextStyle
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, M_PhoneMenu_IMEHiragana
    ld [W_PauseMenu_NextPhoneIME], a
    ld a, $FF
    ld [$CB66], a
    call TitleMenu_PositionNameCursor
    ld a, 2
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0C0
    call Banked_PauseMenu_InitializeCursor
    ld a, M_PhoneMenu_IMEKatakana
    ld [W_PauseMenu_PhoneIME], a
    call PauseMenu_LoadPhoneIMEGraphics
    call TitleMenu_ClearCharaName
    call $649A
    ld bc, $104
    ld e, $35
    call PauseMenu_LoadMap0
    call PauseMenu_LoadPhoneIMETilemap
    jp System_ScheduleNextSubState

; State 03 14
TitleMenu_StateNameInput::
    ld de, $C0C0
    call Banked_PauseMenu_IterateCursorAnimation
    call TitleMenu_PositionNameCursor
    jp TitleMenu_NameInputImpl
    
; State 03 15
TitleMenu_StateStorePlayerName::
    ld b, M_MainScript_PlayerNameSize + 1
    ld hl, W_MainScript_CenteredNameBuffer
    ld de, W_MainScript_PlayerName
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop
    
    jp System_ScheduleNextSubState
    
; TODO: Disassemble states 03 16 thru 03 20. (that's A states)

SECTION "Title Menu State Machine - Denjuu Nickname Input", ROMX[$4452], BANK[$4]
; State 03 20
TitleMenu_StateInitNickname::
    ld bc, $17
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .loadGraphic
    
.dmgGraphic
    ld bc, $58
    
.loadGraphic
    call Banked_LoadMaliasGraphics
    ld hl, $9700
    ld b, $10
    call PauseMenu_ClearScreenTiles
    
    ld bc, 0
    ld e, $10
    call PauseMenu_LoadMap0
    
    ld bc, 0
    ld e, $11
    call PauseMenu_LoadMap1
    
    ld bc, $104
    ld e, $3A
    call PauseMenu_LoadMap0
    
    xor a
    ld [$CA65], a
    
    call PauseMenu_SelectTextStyle
    
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    
    call TitleMenu_ClearCharaName
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, $FF
    ld [$CB66], a
    call TitleMenu_PositionNameCursor
    
    ld a, 2
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0C0
    call Banked_PauseMenu_InitializeCursor
    
    ld a, M_PhoneMenu_IMEKatakana
    ld [W_PauseMenu_PhoneIME], a
    call PauseMenu_LoadPhoneIMEGraphics
    
    ld a, M_PhoneMenu_IMEHiragana
    ld [W_PauseMenu_NextPhoneIME], a
    
    call PauseMenu_CGBLoadPalettes
    xor a
    ld [W_CGBPaletteStagedBGP], a
    ld a, $E3
    ld [W_ShadowREG_LCDC], a
    ld a, $58
    ld [W_ShadowREG_WX], a
    xor a
    ld [W_ShadowREG_WY], a
    xor a
    ld [W_ShadowREG_SCX], a
    ld [W_ShadowREG_SCY], a
    ld [W_PauseMenu_SelectedMenuItem], a
    
    ld a, 4
    ld [W_MelodyEdit_State], a
    
    call TitleMenu_PositionNicknameCursor
    call $5D40
    
    ld hl, $9700
    ld b, $10
    call PauseMenu_ClearInputTiles
    
    ld a, $70
    ld [W_MainScript_TileBaseIdx], a
    ld a, [$D480]
    ld [W_StringTable_ROMTblIndex], a
    
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    
    ld d, $C
    call PauseMenu_CenterPreppedName
    
    ld a, [$D480]
    call $7D46
    
    ld a, $C
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, $C120
    call Banked_PauseMenu_InitializeCursor
    
    ld a, $28
    ld [$C123], a
    ld a, $40
    ld [$C123 + 1], a
    
    ld a, 1
    ld [$C120], a
    ld a, 0
    ld [$C121], a
    
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    
    call TitleMenu_ClearCharaName
    
    ld a, [$D4A7]
    call $7D8C
    call $67B7
    
    ld d, $C
    call $649A
    call PauseMenu_LoadPhoneIMETilemap
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp System_ScheduleNextSubState