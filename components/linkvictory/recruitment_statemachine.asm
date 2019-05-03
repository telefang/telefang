INCLUDE "telefang.inc"

SECTION "Link Battle Recruitment State Machine", ROMX[$5C46], BANK[$1F]
LinkVictory_RecruitmentStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	cp $F
	jr z, .subStateIsF
	cp 0
	jr nz, .jumpToState

.subStateIsF
	call $461B
	ld a, [Malias_CmpSrcBank]
	or a
	jr z, .jumpToState
	ld a, $B
	ld [W_Battle_4thOrderSubState], a

.jumpToState
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .table
	call System_IndexWordList
	jp [hl]
 
.table
	dw LinkVictory_SubStateRecruitmentQueueConnectionMessage
	dw LinkVictory_SubStateRecruitmentFadeInAndMemoryMarker
	dw LinkVictory_DefectionPrintGotNumberMessage
	dw LinkVictory_SubStateRecruitmentDrawNumber
	dw LinkVictory_SubStateRecruitmentHideNumberOnInput
	dw LinkVictory_SubStateRecruitmentSaveNumberMessageAndInputHandler
	dw LinkVictory_SubStateRecruitmentSaveNumberParseResponse
	dw LinkVictory_SubStateRecruitmentFadeOutForExit
	dw LinkVictory_SubStateRecruitmentExitToTitleMenu
	dw LinkVictory_DefectionQueueGotNumberMessage
	dw LinkVictory_SubStateRecruitmentHideNumberOnInput
	dw LinkVictory_SubStateRecruitmentQueueLostConnectionMessage
	dw LinkVictory_SubStateRecruitmentPrintLostConnectionMessage
	dw LinkVictory_SubStateRecruitmentGiveNicknameMessageAndInputHandler
	dw LinkVictory_SubStateRecruitmentOpenNicknameScreen
	dw LinkVictory_SubStateRecruitmentStoreDenjuu
	dw LinkVictory_SubStateDrawRecruitmentScreen
	dw LinkVictory_SubStateRecruitmentLostConnectionFadeOut
	dw LinkVictory_SubStateRecruitmentLostConnectionExitToTitlemenu

; The table below isn't actually used, but is likely here because
; someone probably copypasta'd it from Victory_RecruitmentPhoneMemoryTable
; and later forgot to remove it.
LinkVictory_RecruitmentPhoneMemoryTable::
    db $46, $8C, $F0
    db $46, $8C, $F0
    db $46, $8C, $F0

LinkVictory_SubStateRecruitmentQueueLostConnectionMessage::
	ld c, $74
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState
 
LinkVictory_SubStateRecruitmentPrintLostConnectionMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp $9
	ret nz
	call SerIO_ResetConnection
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $11
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_SubStateRecruitmentLostConnectionFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkVictory_SubStateRecruitmentLostConnectionExitToTitlemenu::
	call Banked_SaveClock_StoreWorkingStateToSaveData
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret

LinkVictory_SubStateRecruitmentQueueConnectionMessage::
	ld c, $72
	call Battle_QueueMessage
	ld a, $F
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_SubStateRecruitmentStoreDenjuu::
	ld hl, W_SerIO_RecvBuffer
	ld a, [W_Battle_NextSerIOByteIn]
	add a, $16
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp $EE
	jr z, .successfulCommunication
	jp Banked_MainScriptMachine

.successfulCommunication
	ld de, $DC60
	ld a, 0
	ld [W_Battle_LoopIndex], a
	ld a, [W_Battle_NextSerIOByteIn]
	ld c, a

.copyloop
	ld hl, W_SerIO_RecvBuffer
	ld b, 0
	add hl, bc
	push de
	push bc
	ld bc, 1
	call memcpy
	pop bc
	inc c
	pop de
	inc de
	ld a, [W_Battle_LoopIndex]
	inc a
	ld [W_Battle_LoopIndex], a
	cp $16
	jr nz, .copyloop

	ld hl, $DC60
	ld b, $16

.correctionLoop
	ld a, [hl]
	cp $FF
	jr z, .ffSpecialCase
	dec a

.ffSpecialCase
	ldi [hl], a
	dec b
	jr nz, .correctionLoop

	call SaveClock_EnterSRAM2
	ld hl, $A001
	ld de, $10
	ld b, 0

.emptySlotFinderLoop
	add hl, de
	inc b
	ld a, [hl]
	cp 0
	jr nz, .emptySlotFinderLoop

	ld a, b
	ld [$D4A7], a
	ld a, [$D4A7]
	ld hl, S_SaveClock_StatisticsArray
	call Battle_IndexStatisticsArray
	ld d, h
	ld e, l
	ld hl, $DC60
	ld bc, $10
	call memcpy
	ld a, [$D4A7]
	ld hl, S_SaveClock_NicknameArray
	ld de, 6
	cp 0
	jr z, .skiploop

.addloop
	add hl, de
	dec a
	jr nz, .addloop

.skiploop
	ld d, h
	ld e, l
	ld hl, $DC70
	ld bc, 6
	call memcpy
	ld a, [W_Battle_NextSerIOByteIn]
	add a, $16
	ld [W_Battle_NextSerIOByteIn], a
	ld a, [$D4A7]
	ld hl, S_SaveClock_StatisticsArray
	call Battle_IndexStatisticsArray
	ldi a, [hl]
	ld [$D480], a
	ldi a, [hl]
	ld [$D481], a
	inc hl
	ld a, $14
	ld [$D482], a
	ld a, [hl]
	ld [$D483], a
	ld b, $00
	ld a, [$D480]
	ld c, a
	ld hl, $F00
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	call SaveClock_ExitSRAM
	ld a, $EE
	ld [W_SerIO_ProcessOutByte], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_SubStateDrawRecruitmentScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld bc, $16
	call Banked_LoadMaliasGraphics
	ld bc, 9
	call Banked_LoadMaliasGraphics
	ld bc, $E
	call Banked_CGBLoadBackgroundPalette
	ld a, $28
	call PauseMenu_CGBStageFlavorPalette
	ld bc, 0
	ld e, $70
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $70
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, 4
	ld e, $AD
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $605
	ld e, $91
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $605
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld a, [$D480]
	ld de, $9100
	call Status_LoadEvolutionIndicatorBySpecies
	ld a, [$D480]
	push af
	ld c, 0
	ld de, $8800
	call Banked_Battle_LoadDenjuuPortrait
	pop af
	call Battle_LoadDenjuuPaletteOpponent
	ld hl, $9580
	ld a, 8
	call MainScript_DrawEmptySpaces
	ld a, [$D480]
	ld de, SerIO_GameStateMachine
	ld bc, $9580
	call MainScript_DrawCenteredName75
	ld a, [$D480]
	call SerIO_LoadDenjuuSpeciesAsMessageArg1
	ld a, $28
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, [$D481]
	ld hl, $984A
	ld c, 1
	call Encounter_DrawTileDigits
	ld a, 0
	call $60E5
	ld b, 0
	ld a, [$D480]
	ld c, a
	ld hl, $F00
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 1
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_SubStateRecruitmentFadeInAndMemoryMarker::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	call $0704
	ld a, [W_Victory_LeveledUpParticipant]
	cp 0
	jr z, .notInMemory
	ld bc, $201
	ld e, $A3
	ld a, 0
	call Banked_RLEDecompressTMAP0

.notInMemory
	ld a, 9
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_DefectionQueueGotNumberMessage::
	ld c, 3
	call Battle_QueueMessage
	ld a, 2
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_DefectionPrintGotNumberMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	jp SerIO_Increment4thOrderSubState

LinkVictory_SubStateRecruitmentDrawNumber::
	ld bc, $20E
	ld e, $AB
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, $18
	call Banked_LoadMaliasGraphics
	xor a
	ld [W_PauseMenu_CurrentContact], a
	call SaveClock_EnterSRAM2
	ld hl, $A00A
	ld a, [$D4A7]
	call Battle_IndexStatisticsArray
	ldi a, [hl]
	ld e, a
	ldi a, [hl]
	ld d, a
	ldi a, [hl]
	ld c, a
	ldi a, [hl]
	ld b, a
	ld a, [hl]
	ld hl, $99C3
	call Banked_Status_DrawPhoneNumber
	call SaveClock_EnterSRAM2
	ld a, [$D4A7]
	ld hl, $B800
	ld b, 0
	ld c, a
	add hl, bc
	ld [hl], $47
	call SaveClock_ExitSRAM
	jp SerIO_Increment4thOrderSubState

LinkVictory_SubStateRecruitmentHideNumberOnInput::
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A + M_JPInput_B
	ret z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld c, $63
	call Battle_QueueMessage
	xor a
	ld [W_Victory_UserSelection], a
	call SerIO_PlaceChoiceCursor
	xor a
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	jp SerIO_Increment4thOrderSubState

LinkVictory_SubStateRecruitmentSaveNumberMessageAndInputHandler::
	call LCDC_IterateAnimationComplex
	call Banked_MainScriptMachine
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .moveCursorRightOnLeft
	xor a
	ld [W_Victory_UserSelection], a
	jp SerIO_PlaceChoiceCursor

.moveCursorRightOnLeft
	ld a, 1
	ld [W_Victory_UserSelection], a
	jp SerIO_PlaceChoiceCursor

.leftNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .moveCursorLeftOnRight
	ld a, 1
	ld [W_Victory_UserSelection], a
	jp SerIO_PlaceChoiceCursor

.moveCursorLeftOnRight
	xor a
	ld [W_Victory_UserSelection], a
	jp SerIO_PlaceChoiceCursor

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr z, .bNotPressed
	jr .noSelected

.bNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .noSelected
	call Banked_SaveClock_StoreWorkingStateToSaveData
	ld c, $64
	jr .yesSelected

.noSelected
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	ld a, 1
	ld [W_Victory_UserSelection], a
	call SaveClock_EnterSRAM2
	ld hl, S_SaveClock_StatisticsArray
	ld a, [$D4A7]
	call Battle_IndexStatisticsArray
	ld a, $10

.clearloop
	ld [hl], 0
	inc hl
	dec a
	jr nz, .clearloop
	ld c, $65

.yesSelected
	call Battle_QueueMessage
	xor a
	ld [W_MetaSpriteConfig1], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	call SaveClock_ExitSRAM
	jp SerIO_Increment4thOrderSubState

LinkVictory_SubStateRecruitmentSaveNumberParseResponse::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, [W_Victory_UserSelection]
	cp 0
	jr nz, .noSelected
	ld c, $8F
	call Battle_QueueMessage
	xor a
	ld [W_Victory_UserSelection], a
	call SerIO_PlaceChoiceCursor
	xor a
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	ld a, $D
	ld [W_Battle_4thOrderSubState], a
	ret

.noSelected
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	jp SerIO_Increment4thOrderSubState

LinkVictory_SubStateRecruitmentFadeOutForExit::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkVictory_SubStateRecruitmentExitToTitleMenu::
	call Banked_SaveClock_StoreWorkingStateToSaveData
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret

LinkVictory_SubStateRecruitmentGiveNicknameMessageAndInputHandler::
	call LCDC_IterateAnimationComplex
	call Banked_MainScriptMachine
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .moveCursorRightOnLeft
	xor a
	ld [W_Victory_UserSelection], a
	jp SerIO_PlaceChoiceCursor

.moveCursorRightOnLeft
	ld a, 1
	ld [W_Victory_UserSelection], a
	jp SerIO_PlaceChoiceCursor

.leftNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .moveCursorLeftOnRight
	ld a, 1
	ld [W_Victory_UserSelection], a
	jp SerIO_PlaceChoiceCursor

.moveCursorLeftOnRight
	xor a
	ld [W_Victory_UserSelection], a
	jp SerIO_PlaceChoiceCursor

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr z, .bNotPressed
	xor a
	ld [W_MetaSpriteConfig1], a
	ld [$C0C0], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	jr .noSelected

.bNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	xor a
	ld [W_MetaSpriteConfig1], a
	ld [$C0C0], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .noSelected
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

.noSelected
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	ld a, 7
	ld [W_LateDenjuu_SubSubState], a
	ret

LinkVictory_SubStateRecruitmentOpenNicknameScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	xor a
	ld [W_LateDenjuu_SubSubState], a
	ld [W_Battle_SubSubState], a
	ld a, $1F
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret
