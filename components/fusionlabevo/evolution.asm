INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution State", ROMX[$58BF], BANK[$2A]
FusionLabEvo_StateEvolveDenjuu::
	call $2CC4
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + $E]
	cp $E6
	jr nc, .isEvolved
	ld a, 1
	ld [W_ShadowREG_HBlankSecondMode], a
	ld a, 1
	ld [W_HBlank_SCYIndexAndMode], a
	call FusionLabEvo_DetermineEvolutionAnimationPortrait
	ld b, 0
	ld a, c
	or a
	jr z, .displayUnevolvedForm
	ld b, $80

.displayUnevolvedForm
	ld hl, $C463
	ld [hl], b
	ld a, [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + $E]
	cp $E6
	jr nz, .exit

	ld a, $15
	ld [W_Sound_NextSFXSelect], a
	call FusionLabEvo_DrawPostEvolutionScreen
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .isFusion

.isLab
	ld a, $2D
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	jr .exit

.isFusion
	ld a, $2C
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a

.exit
	ret

.isEvolved
	ld a, [$C984]
	and 3
	jr nz, .skipParticleGenerationThisFrame
	ld a, $C
	ld hl, $7303
	call CallBankedFunction_int

.skipParticleGenerationThisFrame
	call FusionLabEvo_AnimateSprites
	ld a, [W_MainScript_State]
	cp 9
	jr nz, .waitForMainScriptMachine
	ld a, 0
	ld [W_FusionLabEvo_DidEvolutionFail], a
	call FusionLabEvo_StateNoItems_justExitPlz
	ld a, 0
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld [$CD00], a
	call FusionLabEvo_ClearSpriteConfig1

.waitForMainScriptMachine
	ret

SECTION "Fusion/Lab No Evolution State", ROMX[$59F5], BANK[$2A]
FusionLabEvo_StateNoEvolveDenjuu::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	call $5A57
	call $2CC4
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr nz, .noSelected
	ld a, [W_MainScript_State]
	cp 9
	jr nz, .yUNORetNZ
	ld bc, $C3E
	call Overworld_CheckFlagValue
	jr nz, .yesSelected

.noSelected
	ld a, 0
	ld [W_FusionLabEvo_DidEvolutionFail], a
	call FusionLabEvo_StateNoItems_justExitPlz
	ld a, 0
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld [$CD00], a
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	ret

.yesSelected
	call FusionLabEvo_StateNoItems_justExitPlz
	ld a, $19
	ld [W_SystemSubState], a
	ld a, 0
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld [$CD00], a
	ld a, [$C908]
	ld [$CDEC], a
	ld a, [$C2DD]
	ld [$CDEE], a
	ld a, [$C2FD]
	ld [$CDE1], a
	call FusionLabEvo_RememberLastItemOfFocus
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ret

.yUNORetNZ
	ret
