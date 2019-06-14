INCLUDE "telefang.inc"

SECTION "Cutscene Recruitment State Machine", ROMX[$6696], BANK[$E]
Cutscene_RecruitmentStateMachine::
	ld a, [W_LateDenjuu_SubSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw Cutscene_SubStateRecruitmentPrepareFadeOutFromOverworld
	dw Cutscene_SubStateRecruitmentFadeOutFromOverworld
	dw Cutscene_SubStateDrawRecruitmentScreen
	dw Cutscene_SubStateRecruitmentFadeIn
	dw Cutscene_SubStateRecruitmentWaitForInput
	dw Cutscene_SubStateRecruitmentFadeOutAndExitToOverworld

Cutscene_SubStateRecruitmentPrepareFadeOutFromOverworld::
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

Cutscene_SubStateRecruitmentFadeOutFromOverworld::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, 0
	ld [W_ShadowREG_HBlankSecondMode], a
	ld a, 7
	ld [W_ShadowREG_WX], a
	ld a, $90
	ld [W_ShadowREG_WY], a
	ld hl, W_MainScript_TilePtr
	ld a, 0
	ld [hli], a
	ld a, $98
	ld [hl], a
	ld a, 0
	ld [W_ShadowREG_SCX], a
	ld a, 0
	ld [W_ShadowREG_SCY], a
	call ClearGBCTileMap0
	call ClearGBCTileMap1
	call LCDC_ClearMetasprites
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, $D0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $F0
	ld [W_Status_NumericalTileIndex], a
	call Status_ExpandNumericalTiles
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret 

Cutscene_SubStateDrawRecruitmentScreen::
	ld bc, 16
	call Banked_LoadMaliasGraphics
	ld bc, 9
	call Banked_LoadMaliasGraphics
	ld bc, E
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
	ld de, LCDC_CGB_OBPaletteTable
	ld bc, $9580
	call MainScript_DrawCenteredName75
	ld a, [$D481]
	ld hl, $984A
	ld c, 1
	call Encounter_DrawTileDigits
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
	call Banked_Status_DrawPhoneNumber
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ld a, $28
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ret

Cutscene_SubStateRecruitmentFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

Cutscene_SubStateRecruitmentWaitForInput::
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A + M_JPInput_B
	ret z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

Cutscene_SubStateRecruitmentFadeOutAndExitToOverworld::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	xor a
	ld [W_LateDenjuu_SubSubState], a
	ld [W_byte_C9CF], a
	ld a, $A
	ld [W_SystemSubState], a
	ret
