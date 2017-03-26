INCLUDE "telefang.inc"

SECTION "Title Menu State Machine", ROMX[$4000], BANK[$4]
TitleMenu_GameStateMachine::
    ld a, [W_SystemSubState]
    ld hl, TitleMenu_StateTable
    call System_IndexWordList
    jp [hl]
    
;TODO: disassemble
TitleMenu_StateTable
    dw $4054, $406E, $4089, $40BD, $40EA, $40FA, $4108, $4113
    dw $413B, $41EC, $41F7, $4205, $4216, $4221, $4232, $4265
    dw $428A, $42AA, $42B3, TitleMenu_StateClearNameInput, $431C, $4328, $4339, $4346
    dw $437F, $43A5, $43B4, $43E2, $4400, $440E, $4424, $406E
    dw $4452, $4546, $4558, $456A, $457D

SECTION "Title Menu State Machine - Name Input", ROMX[$42CD], BANK[$4]
; State 03 13
TitleMenu_StateClearNameInput::
    ld hl, $9780 ;Tile no. 78
    ld b, 8 ;Length of character name.
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