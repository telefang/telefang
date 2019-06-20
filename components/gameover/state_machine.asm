INCLUDE "telefang.inc"

SECTION "Game Over State Machine", ROMX[$458E], BANK[$2]
GameOver_StateMachine::
	ld a, [W_SystemSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw GameOver_StateDrawTiles
	dw GameOver_StateMapTiles
	dw GameOver_StateAssignMusic
	dw GameOver_StateFadeIn
	dw GameOver_StateAwaitInput
	dw GameOver_StatePrepareFadeOut
	dw GameOver_StateFadeOut
	dw GameOver_StateReturnToTitlescreen

GameOver_StateDrawTiles::
	call ClearGBCTileMap0
	call ClearGBCTileMap1
	call LCDC_ClearMetasprites
	ld bc, $42
	call Banked_LoadMaliasGraphics
	ld bc, $43
	call Banked_LoadMaliasGraphics
	ld bc, 7
	call Banked_CGBLoadBackgroundPalette
	jp System_ScheduleNextSubState

GameOver_StateMapTiles::
	M_AuxJmp Banked_GameOver_ADVICE_LoadSGBFiles
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $72
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	jp System_ScheduleNextSubState

GameOver_StateAssignMusic::
	ld a, $1B
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState

GameOver_StateFadeIn::
	ld a, 2
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp System_ScheduleNextSubState

GameOver_StateAwaitInput::
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Start
	ret z
	jp System_ScheduleNextSubState

GameOver_StatePrepareFadeOut::
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	jp System_ScheduleNextSubState

GameOver_StateFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld bc, 0
	call Banked_CGBLoadBackgroundPalette
	ld a, 1
	ld [W_CGBPaletteStagedBGP], a
	jp System_ScheduleNextSubState

GameOver_StateReturnToTitlescreen::
	ld a, 0
	ld [W_SystemState], a
	xor a
	ld [W_SystemSubState], a
	ret
