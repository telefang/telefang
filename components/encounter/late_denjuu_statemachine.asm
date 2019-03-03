INCLUDE "telefang.inc"

SECTION "Late Denjuu Transition SubSubState", WRAMX[$D401], BANK[$1]
W_LateDenjuu_SubSubState:: ds 1

SECTION "Late Denjuu Transition State Machine", ROMX[$57F7], BANK[$1C]
Encounter_LateDenjuuStateMachine::
	ld a, [W_LateDenjuu_SubSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl
.table
	dw LateDenjuu_SetupFade, LateDenjuu_FadeOutOfBattle, LateDenjuu_BuildCallScreen, LateDenjuu_FadeIntoScreen, LateDenjuu_DrawMessage, LateDenjuu_AwaitButtonPress, LateDenjuu_FadeFromScreen, $5957
	dw $59E0, $5A11
LateDenjuu_SetupFade:: ; 5815
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret
LateDenjuu_FadeOutOfBattle:: ; 5822
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret
LateDenjuu_BuildCallScreen:: ; 5831
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
	ld e,a
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
	ld hl, $9200
	ld a, [$D43C]
	call Status_DrawDenjuuNickname
	ld a, [$D46E]
	cp a, $2
	jr c, .jpA
	cp a, $4
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
	cp a, 1
	jr z, .jpE
	ld a, [W_Encounter_BattleType]
	cp a, 1
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
LateDenjuu_FadeIntoScreen:: ; 5907
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
LateDenjuu_DrawMessage:: ; 591B
	call Banked_MainScriptMachine
	ld a, [W_Battle_LoopIndex]
	dec a
	ld [W_Battle_LoopIndex], a
	ret nz
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret
LateDenjuu_AwaitButtonPress:: ; 592E
	call Banked_MainScriptMachine
	ldh a,[$FF8D]
	and a, 1
	ret  z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret
LateDenjuu_FadeFromScreen:: ; 5948
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, [W_LateDenjuu_SubSubState]
	inc a
	ld [W_LateDenjuu_SubSubState], a
	ret