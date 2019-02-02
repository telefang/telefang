INCLUDE "telefang.inc"

SECTION "Melody Menu Scroll Position", WRAM0[$CB6C]
W_MelodyMenu_ScrollPosition:: ds 1

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
	jp MelodyMenu_InputHandler

MelodyMenu_StateMelodyEdit::
	jp MelodyMenu_MelodyEditInputHandler

MelodyMenu_StateMelodyEditKeyAction::
	call $5C1D
	ld a, 4
	ld [W_SystemSubSubState], a
	ret

SECTION "Pause Menu Melo-D Input Handler 1", ROMX[$608B], BANK[$4]
MelodyMenu_InputHandler::
; W_CallsMenu_SoundEffectIter contains the cursor position relative to the scroll position.
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Up
	jr z, .upNotPressed
	call $1BD1
	ld a, [W_CallsMenu_SoundEffectIter]
	cp 0
	jr nz, .dontScrollUp
	ld a, [W_MelodyMenu_ScrollPosition]
	cp 0
	ret z
	ld a, [W_MelodyMenu_ScrollPosition]
	dec a
	ld [W_MelodyMenu_ScrollPosition], a
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp $5FE9

.dontScrollUp
	dec a
	ld [W_CallsMenu_SoundEffectIter], a
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp $5FE9

.upNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Down
	jr z, .downNotPressed
	call $1BD1
	ld a, [W_CallsMenu_SoundEffectIter]
	cp 5
	jr nz, .dontScrollDown
	ld a, [W_MelodyMenu_ScrollPosition]
	cp $49
	ret z
	ld a, [W_MelodyMenu_ScrollPosition]
	inc a
	ld [W_MelodyMenu_ScrollPosition], a
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp $5FE9

.dontScrollDown
	inc a
	ld [W_CallsMenu_SoundEffectIter], a
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp $5FE9

.downNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr z, .bNotPressed
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	ld e, $2D
	call PauseMenu_LoadMenuMap0
	xor a
	ld [W_PhoneIME_NextIME], a
	call PhoneIME_LoadGraphicsForIME
	call $1BD1
	call $5EE9
	ld a, $32
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, 5
	ld [W_SystemSubSubState], a
	ret

.bNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	jr z, .aNotPressed

; Find out what option we just selected by adding the arrow position and scroll position together.

	ld a, [W_MelodyMenu_ScrollPosition]
	ld b, a
	ld a, [W_CallsMenu_SoundEffectIter]
	add b
	ld [W_System_GenericCounter], a
	cp $47
	jr nc, .openCustomRingtoneForEditing

	ld a, [$CFC0]
	cp 0
	jr z, .musicNotPlaying
	call $1BD1

.musicNotPlaying
	ld a, [W_System_GenericCounter]
	add $81
	 ; This db and dw is "ld [W_Sound_NextRingtoneSelect], a" converted to bytes so that rgbds doesn't try to convert it to "ldh [W_Sound_NextRingtoneSelect], a"
	db $EA
	dw W_Sound_NextRingtoneSelect
	ld a, 4
	ld [W_Sound_MusicSet], a
	ret

.openCustomRingtoneForEditing
	ld e, $30
	call PauseMenu_LoadMenuMap0
	xor a
	ld [W_PhoneIME_NextIME], a
	call PhoneIME_LoadGraphicsForIME
	xor a
	ld [W_MelodyEdit_DataCurrent], a
	ld [W_MelodyEdit_CurrentPage], a
	ld a, 4
	ld [W_MelodyEdit_State], a
	ld a, $FF
	ld [W_PhoneIME_LastPressedButton], a
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld de, $C0C0
	call LCDC_ClearSingleMetasprite
	call $5F76
	call $072F
	call PhoneIME_PlaceCursor
	call MelodyEdit_DrawDataIndicator
	call MelodyEdit_DrawPageIndicator
	call MelodyEdit_DrawTempoIndicator
	jp System_ScheduleNextSubSubState

.aNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, [W_MelodyMenu_ScrollPosition]
	add 6
	cp $47
	jr nc, .rightNotPressed
	ld [W_MelodyMenu_ScrollPosition], a
	call $1BD1
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp $5FE9

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, [W_MelodyMenu_ScrollPosition]
	sub 6
	bit 7, a
	jr nz, .leftNotPressed
	ld [W_MelodyMenu_ScrollPosition], a
	call $1BD1
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp $5FE9

.leftNotPressed
	ret

SECTION "Pause Menu Melo-D Input Handler 2", ROMX[$5AAF], BANK[$4]
MelodyMenu_MelodyEditInputHandler::
	call PhoneIME_InputProcessing
	call $5D7E
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr z, .bNotPressed
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	ld bc, $106
	ld e, $30
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $106
	ld e, $35
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	call $1BD1
	call $5EE9
	ld a, 3
	ld [W_SystemSubSubState], a
	ld a, $FF
	ld [$CB6E], a
	ld a, 4
	ld [W_PauseMenu_SelectedCursorType], a
	ld de, $C0C0
	call Banked_PauseMenu_InitializeCursor
	call $5FE9
	xor a
	ld [W_PhoneIME_NextIME], a
	jp PhoneIME_LoadGraphicsForIME

.bNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	jr z, .aNotPressed
	call PauseMenu_PlayPhoneButtonSFX
	ld a, 7
	ld [W_SystemSubSubState], a
	ret

.aNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Select
	jr z, .selectNotPressed
	ld b, 0
	ld a, [W_PhoneIME_NextIME]
	cp 0
	jr nz, .displayNumberIME
	ld b, 3

.displayNumberIME
	ld a, b
	ld [W_PhoneIME_NextIME], a
	call PhoneIME_LoadGraphicsForIME

.selectNotPressed
	ret
