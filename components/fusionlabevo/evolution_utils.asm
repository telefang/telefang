INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Utils", ROMX[$57CF], BANK[$2A]
FusionLabEvo_CheckEvolutionCapability::
	ld hl, $60B1
	ld a, [W_FusionLabEvo_PartnerSpecies]
	ld b, 0
	ld c, a
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld a, [W_FusionLabEvo_SelectedItem]
	ld b, a
	dec b
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .isFusion

.isLab
	ld a, b
	add $40
	ld b, a

.isFusion
	ld c, 0
	ld a, [hli]
	cp b
	jr z, .canEvolve

.cantEvolve
	inc c
	ld a, [hli]
	cp b
	jr z, .canEvolve
	ld a, 1
	ld [W_FusionLabEvo_DidEvolutionFail], a
	ret

.canEvolve
	inc hl
	ld a, [hl]
	dec a
	ld [W_FusionLabEvo_EvolutionSpecies], a
	ld [W_Overworld_PartnerSpecies], a
	ld c, a
	ld b, 0
	ld hl, $F00
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	ld bc, $FF00
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, 2
	ld [REG_MBC3_SRAMBANK], a
	ld a, [W_PauseMenu_DeletedContact]
	ld c, a
	ld hl, $A000
	ld b, 0
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld a, [W_Overworld_PartnerSpecies]
	ld [hl], a
	ld a, 0
	ld [REG_MBC3_SRAMENABLE], a
	ld a, [W_Overworld_PartnerSpecies]
	call FusionLabEvo_LoadSpeciesNameEntryPointB
	ld a, 0
	ld [W_FusionLabEvo_DidEvolutionFail], a
	ret

SECTION "Fusion/Lab Evolution Utils 2", ROMX[$5942], BANK[$2A]
FusionLabEvo_DrawPostEvolutionScreen::
	call Status_ExpandNumericalTiles
	ld bc, $1D
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .isFusion
	ld bc, $1E

.isFusion
	call Banked_LoadMaliasGraphics
	ld a, $38
	ld hl, $98A0
	ld de, $5118
	ld bc, $E0
	call Banked_LCDC_LoadTiles
	ld bc, $1DD
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .isFusionEvo
	ld bc, $1DC

.isFusionEvo
	M_AuxJmp Banked_FusionLabEvo_ADVICE_LoadSGBFilesEvolution
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_ShadowREG_HBlankSecondMode], a
	ld [W_HBlank_SCYIndexAndMode], a
	ld d, 7
	ld bc, 8
	ld hl, $98A6
	ld a, 6
	call LCDC_InitAttributesSquare
	ld d, 8
	ld bc, 6
	ld hl, $9880
	ld a, 5
	call LCDC_InitAttributesSquare
	ld d, 8
	ld bc, 6
	ld hl, $988E
	ld a, 5
	call LCDC_InitAttributesSquare
	ld c, $B5
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .tisFusion
	ld c, $B6

.tisFusion
	call FusionLabEvo_ClearMessageBox
	ld a, 1
	ld [W_CGBPaletteStagedBGP], a
	ld de, $5448
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .fusionThisBe
	ld de, $5348

.fusionThisBe
	ld a, $38
	ld hl, $9880
	ld bc, $100
	call Banked_LCDC_LoadTiles
	ret

FusionLabEvo_DetermineEvolutionAnimationPortrait::
	ld c, 0
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + $E]
	inc a
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + $E], a
	cp $55
	jr nc, .frequencyLevelB
	and $E
	jr z, .showEvolvedForm
	ret

.frequencyLevelB
	cp $96
	jr nc, .frequencyLevelC
	and 6
	jr z, .showEvolvedForm
	ret

.frequencyLevelC
	cp $E6
	jr nc, .showEvolvedForm
	and 2
	jr z, .showEvolvedForm
	ret

.showEvolvedForm
	inc c
	ret
