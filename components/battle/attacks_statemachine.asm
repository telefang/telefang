INCLUDE "telefang.inc"

SECTION "Battle Screen - Attack State Machine", ROMX[$6643], BANK[$5]
Battle_AttackStateMachine::
	ld a, [W_LateDenjuu_SubSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl
	
.table
	dw $66A5, $6709, $6724, $68D6, $6C11, $6C6E, Attack_PartnerFell, $6F47
	dw $6F84, $6F97, $7122, $717F, Attack_OpponentFell, $73CF, $740C, $741F
	dw $74B9, $7521, $7589, $75CE, Attack_PrepareForAttackAnimation, $7AEA, $7DF4, Attack_AttackPostAnimation
	dw $7F13, $6E1D, Attack_PartnerFled, $72DD, Attack_OpponentFled, $7DD6, $7689, $75BD
	dw $76B9, $6801, $747E, $7EF6, $6CBA, $7DE5, $70C5, $6AA7
	dw $70D8, $6C7F, $6CDA, $7190

SECTION "Attack - Prepare For Attack Animation", ROMX[$7612], BANK[$5]
Attack_PrepareForAttackAnimation::
	ld bc, $100
	ld e, $85
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, 8
	ld e, $85
	xor a
	call Banked_RLEDecompressTMAP1
	ld bc, $C
	ld e, $80
	xor a
	call Banked_RLEDecompressTMAP0
	call Battle_ADVICE_ClearPartnerStatus
	call Battle_ADVICE_ClearOpponentStatus
	M_AuxJmp Banked_Attack_ADVICE_PreAttackSGB
	ld a, [W_Battle_LastAttackID]
	cp $38
	jr c, .attackRange0To55
	cp $5B
	jr c, .attackRange56To90
	cp $6E
	jr c, .attackRange91To109
	jr .attackRange110Onwards

.attackRange0To55
	ld [$D4FC], a
	jr .loadAttackGfx

.attackRange56To90
	sub $38
	ld [$D4FC], a
	ld a, [W_Battle_LastAttackID]
	jr .loadAttackGfx

.attackRange91To109
	sub $5A
	ld [$D4FC], a
	jr .loadAttackGfx

.attackRange110Onwards
	sub $6E
	ld [$D4FC], a
	ld a, [W_Battle_LastAttackID]
	sub $36

.loadAttackGfx
	call $053E
	ld a, 1
	ld [W_CGBPaletteStagedOBP], a
	ld a, [W_SerIO_ConnectionState]
	or a
	jr nz, .isLinkBattle
	ld a, [W_Battle_AnimationPlayback]
	or a
	jr z, .noAttackAnimation

.isLinkBattle
	ld a, $16
	ld [W_Battle_4thOrderSubState], a
	ret

.noAttackAnimation
	ld a, $17
	ld [W_Battle_4thOrderSubState], a
	ret

SECTION "Attack - Attack Post Animation", ROMX[$7E09], BANK[$5]
Attack_AttackPostAnimation::
	M_AuxJmp Banked_Attack_ADVICE_PostAttackSGB
	call Banked_LoadMaliasGraphics
	ld bc, $100
	ld e, $86
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, 8
	ld e, $81
	xor a
	call Banked_RLEDecompressTMAP1
	call Battle_DrawPartnerUI
	call Battle_DrawOpponentUI
	call Battle_DrawPartnerStatusEffect
	call Battle_DrawOpponentStatusEffect
	xor a
	ld [W_Battle_LoopIndex], a
	ld [$D45B], a
	ld a, [W_Battle_LastAttackID]
	cp $38
	jp c, .standardAttack
	ld a, [W_Battle_LastAttackID]
	cp $6E
	jr c, .attackRange0To109MathSkipA
	sub $36

.attackRange0To109MathSkipA
	cp $38
	jr c, .attackRange61To109Or115To120
	cp $3D
	jr c, .attackRange56To60Or110To114Or121Onwards
	cp $40
	jr c, .attackRange61To109Or115To120
	cp $43
	jr nc, .attackRange61To109Or115To120

.attackRange56To60Or110To114Or121Onwards
	ld a, $15
	ld [W_Battle_4thOrderSubState], a
	ret

.attackRange61To109Or115To120
	ld a, [W_Battle_LastAttackID]
	cp $6E
	jr c, .attackRange0To109MathSkipB
	sub $36

.attackRange0To109MathSkipB
	cp $3D
	jr c, .attackRange64To109Or118To120
	cp $40
	jr nc, .attackRange64To109Or118To120
	ld a, [W_Battle_LastAttackID]
	call $05F7
	ld a, [$D495]
	ld [$D434], a
	ld a, $18
	ld [W_Battle_4thOrderSubState], a
	ret

.attackRange64To109Or118To120
	ld a, [W_Battle_LastAttackID]
	cp $56
	jr z, .attack86
	cp $6E
	jr c, .attackRange0To109MathSkipC
	sub $36

.attackRange0To109MathSkipC
	cp $43
	jr c, .standardAttack
	cp $54
	jr nc, .standardAttack

.attack86
	ld c, $72
	call Battle_QueueMessage
	ld a, $20
	ld [W_Battle_4thOrderSubState], a
	ret

.standardAttack
	ld a, $A
	ld [W_Battle_LoopIndex], a
	ld a, 0
	ld [$D42D], a
	ld a, [W_Battle_CurrentParticipantTeam]
	cp 1
	jr z, .opponentTeam

.partnerTeam
	ld a, [W_Battle_PartnerDenjuuTurnOrder]
	call Battle_StagePartnerStats
	ld a, [$D58B]
	cp a, 5
	jr nz, .attackNotBlocked
	call $7ACC
	cp 1
	jr nz, .attackNotBlocked
	call $70E4
	jr .common

.opponentTeam
	ld a, [W_Battle_OpponentDenjuuTurnOrder]
	call Battle_StageOpponentStats
	ld a, [$D58B]
	cp 5
	jp nz, .attackNotBlocked
	call $7ACC
	cp 1
	jr nz, .attackNotBlocked
	call $6BD3

.common
	call $7AAC
	ld c, $22
	call Battle_QueueMessage
	ld a, $25
	ld [W_Battle_4thOrderSubState], a
	ret

.attackNotBlocked
	ld a, $23
	ld [W_Battle_4thOrderSubState], a
	ret

SECTION "Attack - Partner Fell", ROMX[$6E82], BANK[$5]
Attack_PartnerFell::
	ld a, $5A
	ld [W_Sound_NextSFXSelect], a
	ld bc, $105
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $100
	ld e, $85
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld hl, $9160
	M_AuxJmp Banked_Battle_ADVICE_SGBPaletteOnPartnerFell
	ld a, [W_Battle_PartnerDenjuuTurnOrder]
	cp a, 1
	jr z, .jpB
	cp a, 2
	jr z, .jpD
	ld a, 0
	ld [$D507], a
	call SaveClock_EnterSRAM2
	ld hl, $A002
	ld a, [$D50D]
	call Battle_IndexStatisticsArray
	ld a, [hl]
	cp a, 0
	jr z, .jpA
	dec a
	ld [hl], a

.jpA
	call SaveClock_ExitSRAM
	jr .jpF

.jpB
	ld a, 0
	ld [$D51D], a
	call SaveClock_EnterSRAM2
	ld hl, $A002
	ld a, [$D523]
	call Battle_IndexStatisticsArray
	ld a, [hl]
	cp a, 0
	jr z, .jpC
	dec a
	ld [hl], a

.jpC
	call SaveClock_ExitSRAM
	jr .jpF

.jpD
	ld a, 0
	ld [$D533], a
	call SaveClock_EnterSRAM2
	ld hl, $A002
	ld a, [$D539]
	call Battle_IndexStatisticsArray
	ld a, [hl]
	cp a, 0
	jr z, .jpE
	dec a
	ld [hl], a

.jpE
	call SaveClock_ExitSRAM

.jpF
	ld a, [W_Battle_PartnerDenjuuTurnOrder]
	call Battle_StagePartnerStats
	ld a, [W_Battle_CurrentParticipant]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	call Status_CopyLoadedDenjuuNickname
	ld c, 5
	call Battle_ADVICE_QueueMessage_WithoutArticle
	ld a, [$D5C6]
	ld b, a
	ld a, [W_Battle_NumActivePartners]
	cp b
	jr z, .jpG
	call $652B
	jr .jpH

.jpG
	call Battle_AdvanceToNextPartnerInverse

.jpH
	ld a, [W_Battle_PartnerDenjuuTurnOrder]
	ld [$D417], a
	ld a, [W_Battle_NumActivePartners]
	dec a
	ld [W_Battle_NumActivePartners], a
	ld a, [$D5C6]
	dec a
	ld [$D5C6], a
	ld a, [$D4E5]
	dec a
	ld [$D4E5], a
	jp $4000

SECTION "Attack - Opponent Fell", ROMX[$7347], BANK[$5]
Attack_OpponentFell::
	ld a, $5A
	ld [W_Sound_NextSFXSelect], a
	ld bc, $101
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressTMAP1
	ld bc, 8
	ld e, $85
	ld a, 0
	call Banked_RLEDecompressTMAP1
	ld hl, $91B0
	M_AuxJmp Banked_Battle_ADVICE_SGBPaletteOnOpponentFell
	ld a, [W_Battle_OpponentDenjuuTurnOrder]
	cp a, 1
	jr z, .jpA
	cp a, 2
	jr z, .jpB
	ld a, 0
	ld [$D549], a
	jr .jpC

.jpA
	ld a, 0
	ld [$D55F], a
	jr .jpC

.jpB
	ld a, 0
	ld [$D575], a

.jpC
	ld a, [W_Battle_OpponentDenjuuTurnOrder]
	call Battle_StageOpponentStats
	ld a, [W_Battle_CurrentParticipant]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	ld c, 5
	call Battle_ADVICE_QueueMessage_WithArticle
	ld a, [W_Battle_NumActiveOpponents]
	dec a
	cp a, 0
	jr z, .jpF
	ld a, [$D5C7]
	ld b, a
	ld a, [W_Battle_NumActiveOpponents]
	cp b
	jr z, .jpD
	call $655B
	jr .jpE

.jpD
	call Battle_AdvanceToNextOpponent

.jpE
	ld a, [W_Battle_OpponentDenjuuTurnOrder]
	ld [$D418], a

.jpF
	ld a, [W_Battle_NumActiveOpponents]
	dec a
	ld [W_Battle_NumActiveOpponents], a
	ld a, [$D5C7]
	dec a
	ld [$D5C7], a
	ld a, [$D4E5]
	dec a
	ld [$D4E5], a
	jp $4000

SECTION "Attack - Partner Fled", ROMX[$6E29], BANK[$5]
Attack_PartnerFled::
	ld bc, $105
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $100
	ld e, $85
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld hl, $9160
	ld b, 0
	call Banked_MainScript_DrawStatusEffectString
	ld a, [W_Battle_PartnerDenjuuTurnOrder]
	call Battle_StagePartnerStats
	ld a, [W_Battle_CurrentParticipant]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	call Status_CopyLoadedDenjuuNickname
	ld c, 7
	call Battle_ADVICE_QueueMessage_WithoutArticle
	ld a, $57
	ld [W_Sound_NextSFXSelect], a
	call $652B
	ld a, [W_Battle_PartnerDenjuuTurnOrder]
	ld [$D417], a
	ld a, [W_Battle_NumActivePartners]
	dec a
	ld [W_Battle_NumActivePartners], a
	ld a, [$D5C6]
	dec a
	ld [$D5C6], a
	ld a, [$D4E5]
	dec a
	ld [$D4E5], a
	ld a, 7
	ld [W_LateDenjuu_SubSubState], a
	ret

SECTION "Attack - Opponent Fled", ROMX[$72E9], BANK[$5]
Attack_OpponentFled::
	ld bc, $101
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressTMAP1
	ld bc, 8
	ld e, $85
	ld a, 0
	call Banked_RLEDecompressTMAP1
	ld hl, $91B0
	ld b, 0
	call Banked_MainScript_DrawStatusEffectString
	ld a, [W_Battle_OpponentDenjuuTurnOrder]
	call Battle_StageOpponentStats
	ld a, [W_Battle_CurrentParticipant]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	ld c, 7
	call Battle_ADVICE_QueueMessage_WithArticle
	ld a, $57
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_Battle_NumActiveOpponents]
	dec a
	cp a, 0
	jr z, .jpA
	call $655B
	ld a, [W_Battle_OpponentDenjuuTurnOrder]
	ld [$D418], a

.jpA
	ld a, [W_Battle_NumActiveOpponents]
	dec a
	ld [W_Battle_NumActiveOpponents], a
	ld a, [$D5C7]
	dec a
	ld [$D5C7], a
	ld a, [$D4E5]
	dec a
	ld [$D4E5], a
	ld a, $D
	ld [W_LateDenjuu_SubSubState], a
	ret

SECTION "Attack - Partner Woke Up / Came To Senses Message", ROMX[$6DD1], BANK[$5]
; Part of a larger substate at 5:6CDA.
Attack_PartnerWokeUpMessage::
	call SaveClock_EnterSRAM2
	ld a, [$D591]
	ld a, a
	ld hl, $A006
	call Battle_IndexStatisticsArray
	push hl
	pop de
	call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
	call Status_CopyLoadedDenjuuNickname
	call SaveClock_ExitSRAM
	ld c, $4B
	call Battle_ADVICE_QueueMessage_WithoutArticle
	ld a, $24
	ld [W_LateDenjuu_SubSubState], a
	ret

Attack_PartnerCameToSensesMessage::
	call SaveClock_EnterSRAM2
	ld a, [$D591]
	ld a, a
	ld hl, $A006
	call Battle_IndexStatisticsArray
	push hl
	pop de
	call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
	call Status_CopyLoadedDenjuuNickname
	call SaveClock_ExitSRAM
	ld c, $48
	call Battle_ADVICE_QueueMessage_WithoutArticle
	ld a, $24
	ld [W_LateDenjuu_SubSubState], a
	ret

SECTION "Attack - Opponent Woke Up / Came To Senses Message", ROMX[$72B5], BANK[$5]
; Part of a larger substate at 5:7190.
Attack_OpponentWokeUpMessage::
	ld a, [$D591]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	ld c, $4B
	call Battle_ADVICE_QueueMessage_WithArticle
	ld a, $24
	ld [W_LateDenjuu_SubSubState], a
	ret

Attack_OpponentCameToSensesMessage::
	ld a, [$D591]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	ld c, $48
	call Battle_ADVICE_QueueMessage_WithArticle
	ld a, $24
	ld [W_LateDenjuu_SubSubState], a
	ret

SECTION "Attack - HP Recovery Message", ROMX[$7FDD], BANK[$5]
; Part of a larger substate at 5:7F13.
Attack_HPRecoveryMessage::
	ld a, [W_Battle_CurrentParticipant]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	ld a, [W_Battle_CurrentParticipantTeam]
	cp a, 1
	jr z, .isOpponent
	call Status_CopyLoadedDenjuuNickname
	ld c, $2D
	call Battle_ADVICE_QueueMessage_WithoutArticle
	jr .nextSubstate

.isOpponent
	ld c, $2D
	call Battle_ADVICE_QueueMessage_WithArticle

.nextSubstate
	ld a, $25
	ld [W_LateDenjuu_SubSubState], a
	ret


