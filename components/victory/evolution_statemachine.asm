INCLUDE "telefang.inc"

SECTION "Victory Evolution State Machine", ROMX[$548F], BANK[$1D]
Victory_EvolutionStateMachine::
	ld a, [W_LateDenjuu_SubSubState]
	ld hl, .table
	call System_IndexWordList
	jp [hl]

.table
	dw Victory_SubStateDrawEvolutionScreen
	dw Victory_SubStateEvolutionFadeIn
	dw Victory_SubStateEvolutionMessageLightshowAndSave
	dw Victory_SubStateEvolutionPrepareForFade
	dw Victory_SubStateEvolutionFadeOut
	dw Victory_SubStateEvolutionExit
	dw Victory_SubStateEvolutionDrawDenjuu
	dw Victory_SubStateEvolutionMapDenjuu
	dw Victory_SubStateDrawEvolvedDenjuuInfo
	dw Victory_SubStateEvolutionSuccessScreen
	dw Victory_SubStateEvolutionAnimationInit
	dw Victory_SubStateEvolutionAnimationLoop

Victory_SubStateDrawEvolutionScreen::
	ld bc, $16
	call Banked_LoadMaliasGraphics
	ld bc, 9
	call Banked_LoadMaliasGraphics
	ld bc, $19
	call Banked_LoadMaliasGraphics
	ld bc, $E
	call Banked_CGBLoadBackgroundPalette
	ld a, $28
	call PauseMenu_CGBStageFlavorPalette
	ld a, 4
	ld bc, 5
	call CGBLoadBackgroundPaletteBanked
	ld a, $38
	ld hl, $8400
	ld de, $5560
	ld bc, $100
	call Banked_LCDC_LoadTiles
	ld a, 2
	ld bc, $1FE
	call CGBLoadObjectPaletteBanked
	ld bc, 0
	ld e, $70
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $70
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld hl, $9580
	ld a, 8
	call MainScript_DrawEmptySpaces
	ld a, 0
	ld [W_Victory_LeveledUpParticipant], a
	ld a, $2B
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld bc, $605
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld a, $C
	ld hl, $9100
	call MainScript_DrawEmptySpaces
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, 6
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionDrawDenjuu::
	ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 0) + 7]
	cp $B
	jr nz, .participantANotEvolving
	ld a, 0
	ld [W_Victory_LeveledUpParticipant], a
	jr .loadEvolvingParticipant

.participantANotEvolving
	ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + 7]
	cp $B
	jr nz, .participantBNotEvolving
	ld a, 1
	ld [W_Victory_LeveledUpParticipant], a
	jr .loadEvolvingParticipant

.participantBNotEvolving
	ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + 7]
	cp $B
	jr nz, .participantCNotEvolving
	ld a, 2
	ld [W_Victory_LeveledUpParticipant], a
	jr .loadEvolvingParticipant

.participantCNotEvolving
	ld a, 3
	ld [W_LateDenjuu_SubSubState], a
	ret

.loadEvolvingParticipant
	ld a, [W_Victory_LeveledUpParticipant]
	ld hl, W_Battle_PartnerParticipants
	call Victory_CopyParticipantIntoActiveSlot
	ld a, [W_Battle_CurrentParticipant]
	call Victory_LoadSpeciesNameAsArg1
	ld a, [W_Battle_CurrentParticipant]
	ld de, $9100
	call Status_LoadEvolutionIndicatorBySpecies
	ld bc, $605
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld a, [W_Battle_CurrentParticipant]
	push af
	ld c, 0
	ld de, $8800
	call Banked_Battle_LoadDenjuuPortrait
	pop af
	call Battle_LoadDenjuuPalettePartner
	ld a, [W_Battle_CurrentParticipant]
	ld [W_Status_SelectedDenjuuSpecies], a
	ld c, $C
	call Banked_Battle_LoadSpeciesData
	ld a, [W_Battle_RetrSpeciesByte]
	dec a
	push af
	ld c, 0
	ld de, $9200
	call Banked_Battle_LoadDenjuuPortrait
	pop af
	call Battle_LoadDenjuuPaletteOpponent
	ld a, 1
	ld [W_CGBPaletteStagedBGP], a
	ld a, [W_Battle_CurrentParticipant]
	ld de, Victory_ExternalStateMachine
	ld bc, $9580
	call MainScript_DrawCenteredName75
	ld a, 0
	ld [$D44C], a
	ld a, [$D585]
	ld hl, $984A
	ld c, 1
	call Encounter_DrawTileDigits
	ld b, 0
	ld a, [W_Battle_RetrSpeciesByte]
	dec a
	ld c, a
	ld hl, $F00
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	ld a, 7
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionMapDenjuu::
	ld bc, 4
	ld e, $A0
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, 5
	ld e, $92
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld a, $A
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionAnimationInit::
	ld a, 1
	ld [W_ShadowREG_HBlankSecondMode], a
	ld a, 1
	ld [W_HBlank_SCYIndexAndMode], a
	ld hl, W_Battle_WindowOverlap
	ld a, $21
	ld [hli], a
	ld a, 0
	ld [hli], a
	ld a, $5F
	ld [hli], a
	ld a, 0
	ld [$D4CF], a
	ld [hl], a
	ld a, $B
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionAnimationLoop::
	call .checkAnimationStage
	cp 0
	jr z, .switchToEvolvedForm
	ld a, 0
	ld [$D4CF], a
	jr .proceed

.switchToEvolvedForm
	ld a, $80
	ld [$D4CF], a

.proceed
	ld a, [$D4CF]
	ld [$C463], a
	ld a, [$D44C]
	cp $E6
	ret c
	ld a, 8
	ld [W_LateDenjuu_SubSubState], a
	ret

.checkAnimationStage
	ld c, 0
	ld a, [$D44C]
	inc a
	ld [$D44C], a

.speedBracketA
	cp $55
	jr nc, .speedBracketB
	and $E
	jr z, .evolvedFormFrame
	ret

.speedBracketB
	cp $96
	jr nc, .speedBracketC
	and 6
	jr z, .evolvedFormFrame
	ret

.speedBracketC
	cp $E6
	jr nc, .evolvedFormFrame
	and 2
	jr z, .evolvedFormFrame
	ret
 
.evolvedFormFrame
	inc c
	ret

Victory_EvolutionMoveLightParticles::
	ld a, [W_SystemSubState]
	push af
	ld a, 4
	ld [W_SystemSubState], a
	ld a, $C
	ld hl, $479C
	call CallBankedFunction_int
	pop af
	ld [W_SystemSubState], a
	ret

Victory_SubStateDrawEvolvedDenjuuInfo::
	ld a, [W_Battle_RetrSpeciesByte]
	dec a
	ld de, Victory_ExternalStateMachine
	ld bc, $9580
	call MainScript_DrawCenteredName75
	ld a, [W_Battle_RetrSpeciesByte]
	dec a
	ld de, $9100
	call Status_LoadEvolutionIndicatorBySpecies
	ld a, 9
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionSuccessScreen::
	ld bc, 4
	ld e, $A2
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $605
	ld e, $A1
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $605
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld a, [W_Battle_RetrSpeciesByte]
	dec a
	ld de, Victory_ExternalStateMachine
	call Victory_LoadSpeciesNameAsArg1
	ld a, $15
	ld [W_Sound_NextSFXSelect], a
	ld c, $1A
	call Battle_QueueMessage
	ld a, 2
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionMessageLightshowAndSave::
	call Banked_MainScriptMachine
	ld a, [W_FrameCounter]
	and 3
	jr nz, .noParticleSpawn
	ld a, $C
	ld hl, $7303
	call CallBankedFunction_int

.noParticleSpawn
	call Victory_EvolutionMoveLightParticles
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	call Victory_EvolutionRemoveLightParticles
	ld a, [W_Victory_LeveledUpParticipant]
	cp 0
	jr z, .participantAEvolved
	cp 1
	jr z, .participantBEvolved
	jr .participantCEvolved

.participantAEvolved
	ld a, 3
	ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 0) + 7], a
	call SaveClock_EnterSRAM2
	ld hl, S_SaveClock_StatisticsArray
	ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 0) + $D]
	call Battle_IndexStatisticsArray
	ld a, [W_Battle_RetrSpeciesByte]
	dec a
	ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantSpecies], a
	ld [hl], a
	ld [W_Overworld_PartnerSpecies], a
	jr .nextSubstate

.participantBEvolved
	ld a, 3
	ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + 7], a
	call SaveClock_EnterSRAM2
	ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + $D]
	ld hl, S_SaveClock_StatisticsArray
	call Battle_IndexStatisticsArray
	ld a, [W_Battle_RetrSpeciesByte]
	dec a
	ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantSpecies], a
	ld [hl], a
	jr .nextSubstate

.participantCEvolved
	ld a, 3
	ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + 7], a
	call SaveClock_EnterSRAM2
	ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + $D]
	ld hl, S_SaveClock_StatisticsArray
	call Battle_IndexStatisticsArray
	ld a, [W_Battle_RetrSpeciesByte]
	dec a
	ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantSpecies], a
	ld [hl], a

.nextSubstate
	ld a, 6
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionPrepareForFade::
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

Victory_SubStateEvolutionExit::
	ld a, 0
	ld [W_ShadowREG_HBlankSecondMode], a
	ld a, 0
	ld [W_HBlank_SCYIndexAndMode], a
	ld hl, W_Battle_WindowOverlap
	ld a, 0
	ldi [hl], a
	ld a, 0
	ldi [hl], a
	ld a, 0
	ldi [hl], a
	ld a, 0
	ld [$D4CF], a
	ld [hl], a
	xor a
	ld [W_LateDenjuu_SubSubState], a
	jp Battle_IncrementSubSubState

Victory_EvolutionRemoveLightParticles::
	ld b, $C
	ld hl, W_MetaSpriteConfig1
	ld de, $20
	xor a

.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret
