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
	dw $74B9, $7521, $7589, $75CE, $7612, $7AEA, $7DF4, $7E09
	dw $7F13, $6E1D, Attack_PartnerFled, $72DD, Attack_OpponentFled, $7DD6, $7689, $75BD
	dw $76B9, $6801, $747E, $7EF6, $6CBA, $7DE5, $70C5, $6AA7
	dw $70D8, $6C7F, $6CDA, $7190

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
	ld hl, $9180
	ld a, 4
	call MainScript_DrawEmptySpaces
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
	call Battle_QueueMessage
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
	ld hl, $91C0
	ld a, 4
	call MainScript_DrawEmptySpaces
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
	call Battle_QueueMessage
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
	ld hl, $9180
	ld a, 4
	call MainScript_DrawEmptySpaces
	ld a, [W_Battle_PartnerDenjuuTurnOrder]
	call Battle_StagePartnerStats
	ld a, [W_Battle_CurrentParticipant]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	call Status_CopyLoadedDenjuuNickname
	ld c, 7
	call Battle_QueueMessage
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
	ld hl, $91C0
	ld a, $4
	call MainScript_DrawEmptySpaces
	ld a, [W_Battle_OpponentDenjuuTurnOrder]
	call Battle_StageOpponentStats
	ld a, [W_Battle_CurrentParticipant]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	ld c, 7
	call Battle_QueueMessage
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
	call Battle_QueueMessage
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
	call Battle_QueueMessage
	ld a, $24
	ld [W_LateDenjuu_SubSubState], a
	ret

SECTION "Attack - Opponent Woke Up / Came To Senses Message", ROMX[$72B5], BANK[$5]
; Part of a larger substate at 5:7190.
Attack_OpponentWokeUpMessage::
	ld a, [$D591]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	ld c, $4B
	call Battle_QueueMessage
	ld a, $24
	ld [W_LateDenjuu_SubSubState], a
	ret

Attack_OpponentCameToSensesMessage::
	ld a, [$D591]
	call Battle_LoadDenjuuSpeciesAsMessageArg1
	ld c, $48
	call Battle_QueueMessage
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
	jr z, .jpA
	call Status_CopyLoadedDenjuuNickname

.jpA
	ld c, $2D
	call Battle_QueueMessage
	ld a, $25
	ld [W_LateDenjuu_SubSubState], a
	ret


