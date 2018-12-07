INCLUDE "telefang.inc"

SECTION "Pause Menu Melo-D", ROMX[$4E5B], BANK[$4]
MelodyMenu_StateMachine::
    call PauseMenu_DrawClockSprites
    ld a, [W_SystemSubSubState]
    ld hl, .state_table
    call System_IndexWordList
    jp [hl]

.state_table
    dw MelodyMenu_StatePlaceholder
    dw MelodyMenu_StateLoadGraphics
    dw MelodyMenu_StateInitScreen
    dw MelodyMenu_StateInputHandler
    dw MelodyMenu_StateMelodyEdit
    dw PauseMenu_SubStateSMSExit1
    dw PauseMenu_SubStateSMSExit2
    dw MelodyMenu_StateMelodyEditKeyAction
	
MelodyMenu_StatePlaceholder::
    jp System_ScheduleNextSubSubState

MelodyMenu_StateLoadGraphics::
    ld bc, $13
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .use_cgb_graphic
    ld bc, $5A

.use_cgb_graphic
    call Banked_LoadMaliasGraphics
    jp System_ScheduleNextSubSubState

MelodyMenu_StateInitScreen::
    ld e, $30
    call PauseMenu_LoadMenuTilemap0
    ld e, $35
    call PauseMenu_LoadMenuAttribmap0
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    xor a
    ld [W_MelodyEdit_State], a
    ld [W_MelodyEdit_DataCurrent], a
    ld [W_MelodyEdit_DataCount], a
    ld [W_MelodyEdit_CurrentPage], a
    ld [$CB6A], a
    ld [$CB6B], a
    ld [$CB6C], a
    ld [W_CallsMenu_SoundEffectIter], a
    ld a, $FF
    ld [W_PhoneIME_LastPressedButton], a
    ld [$CB6E], a
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0C0
    call Banked_PauseMenu_InitializeCursor
    call $5FE9
    jp System_ScheduleNextSubSubState

MelodyMenu_StateInputHandler::
	ld de, $C0C0
	call Banked_PauseMenu_IterateCursorAnimation
	jp $608B

MelodyMenu_StateMelodyEdit::
	jp $5AAF

MelodyMenu_StateMelodyEditKeyAction::
	call $5C1D
	ld a, 4
	ld [W_SystemSubSubState], a
	ret
