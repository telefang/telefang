INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution - Evolution Variables",  WRAM0[$C2B6]
W_FusionLabEvo_EvolutionSpecies:: ds 1
W_FusionLabEvo_DidEvolutionFail:: ds 1

SECTION "Fusion/Lab Evolution - Post-Join Timer",  WRAM0[$C2F3]
W_FusionLabEvo_PostJoinTimer:: ds 1

SECTION "Fusion/Lab Evolution - Item Object Post-Clear Timer",  WRAM0[$C2F5]
W_FusionLabEvo_SparkleTimer:: ds 1

SECTION "Fusion/Lab Evolution - Scroll Variance",  WRAM0[$C2F7]
W_FusionLabEvo_ScrollVariance:: ds 1

SECTION "Fusion/Lab Evolution Fusion Animation State Machine", ROMX[$53CF], BANK[$2A]
; This is actually a poorly structured state machine.
FusionLabEvo_FusionScreenStateMachine::
.checkSubState00
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	cp 0
	jp nz, .checkSubState01

.drawScreenSubState
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, $38
	ld hl, $98A0
	ld de, $4F58
	ld bc, $E0
	call Banked_LCDC_LoadTiles
	ld bc, $A
	call Banked_CGBLoadBackgroundPalette
	call FusionLabEvo_GetWindowFlavourColour
	ld a, 0
	ld [W_CGBPaletteStagedBGP], a
	ld a, BANK(FusionLabEvo_FusionScreenStateMachine)
	ld [W_PreviousBank], a
	ld a, [W_FusionLabEvo_PartnerSpecies]
	call Battle_LoadDenjuuPaletteOpponent
	ld a, [W_FusionLabEvo_SelectedItem]
	ld c, a
	call FusionLabEvo_LoadSelectedItemObjectPalette
	ld a, 2
	ld bc, $1FE
	call CGBLoadObjectPaletteBanked
	ld bc, $E0
	ld hl, $98A0
	ld a, 7
	call LCDC_InitAttributesLine
	ld bc, 0
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 1
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	call FusionLabEvo_LoadSpeciesNameEntryPointC
	call FusionLabEvo_DrawItemData_extEntry
	call $2CC4
	ld de, $4C88
	ld hl, $9820
	ld b, 2
	ld c, $14
	ld a, 0
	call FusionLabEvo_MapTilesRectangle
	call FusionLabEvo_DrawPartnerStats
	ld a, 0
	ld hl, $8B80
	call Banked_MainScript_DrawLetter
	ld a, 0
	ld hl, $8B90
	call Banked_MainScript_DrawLetter
	ld a, 0
	ld hl, $8BA0
	call Banked_MainScript_DrawLetter
	ld c, $B3
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .isFusionEvo
	ld c, $B4

.isFusionEvo
	call FusionLabEvo_ClearMessageBox
	jp FusionLabEvo_StatePrepareForFusionScreenTransition_wait

.checkSubState01
	cp 1
	jr nz, .checkSubState02

.fadeInSubState
	call $2CC4
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_XOffset]
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimPosition], a
	call FusionLabEvo_PrepareItemScroll
	jp FusionLabEvo_StatePrepareForFusionScreenTransition_wait

.checkSubState02
	cp 2
	jp nz, .checkSubState03

.combiningAnimationSubState
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_FusionLabEvo_SparkleTimer]
	or a
	jp nz, .sparkleTime
	ld a, [W_FusionLabEvo_PostJoinTimer]
	or a
	jp nz, .scrollingFinished
	ld a, [$C984]
	and 7
	jr nz, .skipHalfTheTime
	ld a, $C
	ld hl, $711F
	call CallBankedFunction_int

.skipHalfTheTime
	call $57AA
	call $2CC4
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + $B]
	ld d, a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimStopped]
	ld e, a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimPosition]
	ld h, a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimCounter]
	ld l, a
	add hl, de
	ld a, h
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimPosition], a
	ld a, l
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimCounter], a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + $D]
	ld h, a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + $C]
	ld l, a
	add hl, de
	ld a, h
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + $D], a
	ld a, l
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + $C], a
	ld hl, $FFFF
	add hl, de
	ld hl, W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimStopped
	ld a, $C0
	ld [hli], a
	ld a, $FF
	ld [hl], a
	ldh a, [H_JPInput_HeldDown]
	and M_JPInput_B
	jr z, .dontSpeedUp
	ld hl, W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimStopped
	ld a, $80
	ld [hli], a
	ld a, $FF
	ld [hl], a

.dontSpeedUp
	ld c, 3
	ld a, [W_FusionLabEvo_ScrollVariance]
	ld b, a
	bit 7, a
	jr nz, .noVarianceYet
	ld c, 7

.noVarianceYet
	call $30A7
	and c
	add c
	add b
	ld [W_FusionLabEvo_ScrollVariance], a
	ld d, a
	call $3058
	sra a
	sra a
	sra a
	sra a
	sra a
	ld b, a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + $D]
	add b
	ld [W_FusionLabEvo_ScrollPosition], a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_AnimPosition]
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld hl, $C463
	ld a, [W_FusionLabEvo_ScrollPosition]
	ld [hl], a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + $D]
	cp $D0
	ret nz
	ld a, $D0
	ld [W_FusionLabEvo_ScrollPosition], a
	ld hl, $C463
	ld a, [W_FusionLabEvo_ScrollPosition]
	ld [hl], a
	ld a, 1
	ld [W_FusionLabEvo_PostJoinTimer], a
	ret

.scrollingFinished
	call $57AA
	ld a, [W_FusionLabEvo_PostJoinTimer]
	inc a
	ld [W_FusionLabEvo_PostJoinTimer], a
	cp $28
	ret c
	ld a, $43
	ld [W_Sound_NextSFXSelect], a
	ld a, 1
	ld [$C9D9], a
	ld a, 1
	ld [W_FusionLabEvo_SparkleTimer], a
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld b, 8

.jpA
	ld a, $C
	ld hl, $722A
	push bc
	ld d, b
	swap d
	call CallBankedFunction_int
	pop bc
	dec b
	jr nz, .jpA
	ret

.sparkleTime
	call $57AA
	ld a, [W_FusionLabEvo_SparkleTimer]
	inc a
	ld [W_FusionLabEvo_SparkleTimer], a
	cp $50
	jp nc, FusionLabEvo_StatePrepareForFusionScreenTransition_wait
	ret

.checkSubState03
	cp 3
	jr nz, .checkSubState04

.subState03
	call $57C0
	call $57CF
	ld a, [W_FusionLabEvo_SelectedItem]
	ld b, a
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer]
	dec a
	add b
	ld hl, W_PauseMenu_InventoryQuantities
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	dec [hl]
	ld a, [W_FusionLabEvo_DidEvolutionFail]
	or a
	jr z, .willEvolve
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp FusionLabEvo_StatePrepareForFusionScreenTransition_wait

.checkSubState04
	cp 4
	jp nz, .checkSubState05

.noEvolveSubState
	ld a, BANK(FusionLabEvo_FusionScreenStateMachine)
	ld [W_PreviousBank], a
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_FusionLabEvo_DidEvolutionFail]
	or a

; This will always fire.
	jr nz, .wontEvolve

.willEvolve
	ld a, BANK(FusionLabEvo_FusionScreenStateMachine)
	ld [W_PreviousBank], a
	ld a, [W_FusionLabEvo_EvolutionSpecies]
	call Battle_LoadDenjuuPalettePartner
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 0
	ld [W_FusionLabEvo_ScrollPosition], a
	call FusionLabEvo_PrepareItemScroll
	ld a, [W_FusionLabEvo_EvolutionSpecies]
	ld c, 0
	ld de, $9410
	call Banked_Battle_LoadDenjuuPortrait
	ld d, 7
	ld bc, 8
	ld hl, $98B6
	ld a, 6
	call LCDC_InitAttributesSquare
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + $F], a
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + $E], a
	ld a, 1
	ld [W_CGBPaletteStagedBGP], a
	jp System_ScheduleNextSubState

.wontEvolve
	ld a, $38
	ld hl, $8000
	ld de, $5308
	ld bc, $40
	call Banked_LCDC_LoadTiles
	ld bc, $1F
	call Banked_LoadMaliasGraphics
	ld hl, $9880
	ld a, $40
	ld bc, $100
	call $3775
	ld de, $5548
	ld hl, $98E7
	ld b, 4
	ld c, 6
	ld a, 6
	call FusionLabEvo_MapTilesRectangle
	ld d, 8
	ld bc, $20
	ld hl, $9880
	ld a, 6
	call LCDC_InitAttributesSquare
	ld bc, $A
	call Banked_CGBLoadBackgroundPalette
	ld bc, $11
	call Banked_CGBLoadObjectPalette
	call FusionLabEvo_GetWindowFlavourColour
	ld a, BANK(FusionLabEvo_FusionScreenStateMachine)
	ld [W_PreviousBank], a
	ld a, 6
	ld bc, $1DB
	call CGBLoadBackgroundPaletteBanked
	call Status_ExpandNumericalTiles
	call $5858
	call $56E4
	add $AF
	ld c, a
	call FusionLabEvo_ClearMessageBox
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_ShadowREG_HBlankSecondMode], a
	ld [W_HBlank_SCYIndexAndMode], a
	ld a, 0
	ld [W_CGBPaletteStagedBGP], a
	ld a, $6F
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, $6F
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, $30
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, $70
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, BANK(FusionLabEvo_FusionScreenStateMachine)
	ld [W_PreviousBank], a
	ld bc, 0
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	jp FusionLabEvo_StatePrepareForFusionScreenTransition_wait

.checkSubState05
	cp 5
	jr nz, .exit

.fadeIntoNoEvolveScreenSubState
	ld a, BANK(FusionLabEvo_FusionScreenStateMachine)
	ld [W_PreviousBank], a
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, 0
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld a, [W_FusionLabEvo_DidEvolutionFail]
	or a
	jp z, System_ScheduleNextSubState
	ld a, $20
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld a, $23
	ld [W_SystemSubState], a
	ld a, 5
	ld [W_Sound_NextSFXSelect], a

.exit
	ret
