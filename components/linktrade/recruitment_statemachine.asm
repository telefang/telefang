INCLUDE "telefang.inc"

SECTION "Link Trade Recruitment State Machine", ROMX[$6DBA], BANK[$1F]
LinkTrade_RecruitmentStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkTrade_StateDrawRecruitmentScreen
	dw LinkTrade_StateRecruitmentFadeInAndMemoryMarker
	dw LinkTrade_StateRecruitmentPrintGotNumberMessage
	dw LinkTrade_StateRecruitmentDrawNumber
	dw LinkTrade_StateRecruitmentHideNumberOnInput
	dw LinkTrade_StateRecruitmentNicknameQuestion
	dw LinkTrade_StateRecruitmentFadeOut
	dw LinkTrade_StateRecruitmentExitToTitlescreen
	dw LinkTrade_StateRecruitmentNicknameQuestionInputHandler
	dw LinkTrade_StateRecruitmentOpenNicknameScreen

LinkTrade_StateDrawRecruitmentScreen::
	call SaveClock_EnterSRAM2
	ld a, [$D4A7]
	ld hl, S_SaveClock_StatisticsArray
	call Battle_IndexStatisticsArray
	ld a, [hli]
	ld [$D480], a
	ld a, [hli]
	ld [$D481], a
	inc hl
	ld a, $14
	ld [$D482], a
	ld a, [hl]
	ld [$D483], a
	call SaveClock_ExitSRAM
	ld b, 0
	ld a, [$D480]
	ld c, a
	ld hl, $F00
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	ld a, 0
	ld [W_PauseMenu_CurrentContact], a
	call Banked_SaveClock_StoreWorkingStateToSaveData
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
	ld c, 3
	call Battle_QueueMessage
	ld a, $28
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, [$D481]
	ld hl, $984A
	ld c, 1
	call Encounter_DrawTileDigits
	call $60EC
	M_AuxJmp Banked_Victory_ADVICE_LoadSGBFilesRecruitment
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateRecruitmentFadeInAndMemoryMarker::
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
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateRecruitmentPrintGotNumberMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateRecruitmentDrawNumber::
	ld bc, $20E
	ld e, $AB
	ld a, 0
	call Banked_RLEDecompressTMAP0
	call SaveClock_EnterSRAM2
	ld hl, $A00A
	ld a, [$D4A7]
	call Battle_IndexStatisticsArray
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld hl, $99C3
	call LinkVictory_ADVICE_DrawPhoneNumber
	call SaveClock_ExitSRAM
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateRecruitmentHideNumberOnInput::
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A + M_JPInput_B
	ret z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld c, $64
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateRecruitmentNicknameQuestion::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, [W_Victory_UserSelection]
	cp 0
	jr nz, .skipNickname
	ld c, $8F
	call Battle_QueueMessage
	xor a
	ld [W_Victory_UserSelection], a
	call SerIO_PlaceChoiceCursor
	ld a, 0
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	ld a, 8
	ld [W_Battle_4thOrderSubState], a
	ret

.skipNickname
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateRecruitmentFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateRecruitmentExitToTitlescreen::
	xor a
	call LinkVictory_ADVICE_OnExit
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret

LinkTrade_StateRecruitmentNicknameQuestionInputHandler::
	call LCDC_IterateAnimationComplex
	call Banked_MainScriptMachine
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .leftNotPressed
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ld a, 0
	ld [W_Victory_UserSelection], a
	call SerIO_PlaceChoiceCursor
	ret

.leftNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .rightNotPressed
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ld a, 1
	ld [W_Victory_UserSelection], a
	call SerIO_PlaceChoiceCursor
	ret

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr z, .bNotPressed
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 0
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
	ld a, 0
	ld [W_MetaSpriteConfig1], a
	ld [$C0C0], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .noSelected
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_Battle_4thOrderSubState]
	inc a
	ld [W_Battle_4thOrderSubState], a
	ret

.noSelected
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	ld a, 6
	ld [W_Battle_4thOrderSubState], a
	ret

LinkTrade_StateRecruitmentOpenNicknameScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld [W_Battle_SubSubState], a
	ld a, $1F
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret
