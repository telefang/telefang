INCLUDE "telefang.inc"

SECTION "Late Denjuu SubSubState", WRAMX[$D401], BANK[$1]
W_LateDenjuu_SubSubState:: ds 1

SECTION "Late Denjuu State Machine", ROMX[$57F7], BANK[$1C]
Encounter_LateDenjuuStateMachine::
	ld a, [W_LateDenjuu_SubSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LateDenjuu_SetupFade
	dw LateDenjuu_FadeOutOfBattle
	dw LateDenjuu_BuildCallScreen
	dw LateDenjuu_FadeIntoScreen
	dw LateDenjuu_DrawMessage
	dw LateDenjuu_AwaitButtonPress
	dw LateDenjuu_FadeFromScreen
	dw LateDenjuu_RedrawBattleScreen
	dw LateDenjuu_OverlayBattleScreen
	dw LateDenjuu_ReturnToBattleScreenStateMachine

LateDenjuu_SetupFade::
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_FadeOutOfBattle::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_BuildCallScreen::
	ld bc, $17
	call Banked_CGBLoadBackgroundPalette
	ld a, $28
	call PauseMenu_CGBStageFlavorPalette
	call $06BC
	call $5A2F
	call $057E
	ld a, [W_PauseMenu_PhoneState]
	ld e, a
	ld d, 0
	ld hl, $390
	add hl, de
	push hl
	pop bc
	xor a
	call CGBLoadBackgroundPaletteBanked
	ld bc, $C
	ld e, $80
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $B
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld e, $B0
	ld a, [W_Encounter_SceneryType]
	add e
	ld e, a
	ld bc, 0
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld e, $A0
	ld a, [W_Encounter_SceneryType]
	add e
	ld e, a
	ld bc, 0
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $500
	ld e, $AE
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $500
	ld e, $93
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld a,[$D4CE]
	push af
	ld c, 1
	ld de, $8B80
	call Banked_Battle_LoadDenjuuPortrait
	pop af
	call Battle_LoadDenjuuPalettePartner
	call LateDenjuu_ADVICE_NamePreparations
	ld a, [$D43C]
	call Status_DrawDenjuuNickname
	ld a, [$D46E]
	cp 2
	jr c, .jpA
	cp 4
	jr c, .jpB

.jpA
	ld c, $66
	call Battle_QueueMessage
	jr .jpC

.jpB
	ld c, $67
	call Battle_QueueMessage

.jpC
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [$CD00]
	cp 1
	jr z, .jpE
	ld a, [W_Encounter_BattleType]
	cp 1
	jr z, .jpD
	ld a, $14
	jr .jpG

.jpD
	ld a, $15
	jr .jpG

.jpE
	ld bc, $1F7
	call Overworld_CheckFlagValue
	jr nz, .jpF
	ld a, $16
	jr .jpG

.jpF
	ld a, $17

.jpG
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, 2
	ld [W_Overworld_PowerAntennaPattern], a
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_FadeIntoScreen::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, $3C
	ld [W_Battle_LoopIndex], a
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_DrawMessage::
	call Banked_MainScriptMachine
	ld a, [W_Battle_LoopIndex]
	dec a
	ld [W_Battle_LoopIndex], a
	ret nz
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_AwaitButtonPress::
	call Banked_MainScriptMachine
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_FadeFromScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_RedrawBattleScreen::
	ld bc, 0
	ld e, $F
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $F
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $17
	call Banked_CGBLoadBackgroundPalette
	ld a, $28
	call PauseMenu_CGBStageFlavorPalette
	ld a, [W_Battle_PartnerDenjuuTurnOrder]
	ld hl, W_Battle_PartnerParticipants
	call $5A70
	ld a, [W_Battle_CurrentParticipant]
	push af
	ld c, 1
	ld de, $8B80
	call Banked_Battle_LoadDenjuuPortrait
	pop af
	call Battle_LoadDenjuuPalettePartner
	ld a, [W_Battle_OpponentDenjuuTurnOrder]
	ld hl, W_Battle_OpponentParticipants
	call $5A70
	ld a, [W_Battle_CurrentParticipant]
	push af
	ld c, 0
	ld de, $8800
	call Banked_Battle_LoadDenjuuPortrait
	pop af
	call Battle_LoadDenjuuPaletteOpponent
	ld hl, $9200
	ld a, 8
	call MainScript_DrawEmptySpaces
	ld bc, $100
	ld e, $86
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $100
	ld e, $87
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, 8
	ld e, $81
	ld a, 0
	call Banked_RLEDecompressTMAP1
	ld bc, $108
	ld e, $84
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP1
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_OverlayBattleScreen::
	ld a, $58
	ld [W_ShadowREG_WX], a
	ld a, 0
	ld [W_ShadowREG_WY], a
	ld a, [W_ShadowREG_LCDC]
	set 5, a
	ld [W_ShadowREG_LCDC], a
	ld a, [W_ShadowREG_LCDC]
	set 6, a
	ld [W_ShadowREG_LCDC], a
	ld a, 1
	ld [W_ShadowREG_HBlankSecondMode], a
	ld hl, W_Battle_WindowOverlap
	ld a, $5F
	ldi [hl], a
	ld a, [W_ShadowREG_WX]
	ld [hl], a
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret

LateDenjuu_ReturnToBattleScreenStateMachine::
	xor a
	ld [W_Overworld_PowerAntennaPattern], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 0
	ld [W_LateDenjuu_SubSubState], a
	ld a, $31
	ld [W_Battle_SubSubState], a
	ld a, 0
	ld [W_SystemSubState], a
	ld a, 7
	ld [W_SystemState], a
	ret
	
SECTION "Late Denjuu Advice Code", ROMX[$5A87], BANK[$1C]
LateDenjuu_ADVICE_NamePreparations::
	push bc
	xor a
	ld hl, $9200
	ld b, $40
	
.clearLoop
	di
	call YetAnotherWFB
	ld [hli], a
	ld [hli], a
	ei
	dec b
	jr nz, .clearLoop
	pop bc
	ld hl, $9200
	ret
