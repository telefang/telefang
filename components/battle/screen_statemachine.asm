INCLUDE "telefang.inc"

SECTION "Battle SubSubState", WRAMX[$D400], BANK[$5]
W_Battle_SubSubState:: ds 1

SECTION "Battle Screen State Machine", ROMX[$4460], BANK[$5]
Battle_ScreenStateMachine::
    ld a, [W_SerIO_ConnectionState]
    or a
    jr z, .executeSubSubState
    
    ld a, [W_Battle_SubSubState]
    cp $37
    jr z, .executeSubSubState
    cp $38
    jr z, .executeSubSubState
    cp $39
    jr z, .executeSubSubState
    call $06B4
    
    ld a, [Malias_CmpSrcBank]
    or a
    jr z, .executeSubSubState
    
    ld a, $37
    ld [W_Battle_SubSubState], a
    
.executeSubSubState
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]

.stateTable
    dw $457D,$45A9,$45F5,$463E,$4681,$4B07,$4BC6,$4C34 ;00-07
    dw $4D1F,$4DDD,$4F81,$510A,$545C,$545F,$57FB,$59BC ;08-0F
    dw $5F2D,$5F57,$62CD,$6348,$6360,$63FE,$6416,$46E2 ;10-17
    dw $46F2,$4707,$48E9,$48FC,$4911,$464B,$6099,$6289 ;18-1F
    dw $5FD6,$6318,$61FB,$50F5,$53EF,$5F3D,Battle_SubStateStatusWarning,$48AD ;20-27
    dw $492F,$4AAD,$4F12,$5F79,$5428,$5489,$4AF8,$63EF ;28-2F
    dw $63E0,$5F66,$5FA1,$5FB4,$5661,$5292,$5683,$452D ;30-37
    dw $454A,$4566,$561E,$5051,$50E0,$5416,$4F32,$5810 ;38-3F

Battle_ScreenUIStrings::
    INCBIN "script/battle/ui_strings.stringtbl"

SECTION "Battle Screen State Machine - Status Warnings", ROMX[$4721], BANK[$5]
Battle_SubStateStatusWarning::
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    call Battle_StagePartnerStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    
    ld a, [W_Battle_CurrentParticipant + $07]
    cp 5
    jr nz, .notFive
    
.five
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    call Battle_LoadDenjuuSpeciesAsMessageArg1
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld [W_Status_SelectedDenjuuSpecies], a
    
    ld a, 3
    call Battle_SetAttackNameArg2
    
    ld a, [W_Battle_CurrentParticipant + $0B]
    ld b, a
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    cp b
    jr z, .gotoStateC
    
    ld a, [W_Battle_NumActiveOpponents]
    cp 3
    jr z, .threeOpponents
    cp 2
    jr z, .twoOpponents
    jp .gotoStateC

.twoOpponents
    ld a, [W_Battle_CurrentParticipant + $0B]
    ld b, a
    ld a, [W_Battle_OpponentDenjuuTurnOrder + 1]
    cp b
    jr nz, .gotoStateC

.threeOpponents
    ld bc, $101
    ld e, $8B
    xor a
    call Banked_RLEDecompressTMAP1
    
.opponentScanLoop
    ld a, [W_Battle_CurrentParticipant + $0B]
    ld b, a
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    cp b
    jr z, .drawNewOpponent
    call Battle_AdvanceToNextOpponent
    jr .opponentScanLoop

.drawNewOpponent
    call Battle_PrepActiveOpponentDenjuu
    call Battle_DrawOpponentUI
    
    ld a, $3D
    ld [W_Battle_SubSubState], a
    ret

.gotoStateC
    ld a, $C
    ld [W_Battle_SubSubState], a
    ret
    
.notFive
    call Status_CopyLoadedDenjuuNickname
    
    ld a, [W_SerIO_ConnectionState]
    or a
    jp z, .checkPartnerStatus
    
    ld a, [W_Battle_OpponentUsingLinkCable]
    cp 1
    jp z, .checkPartnerStatus
    
.checkLinkCableData
    call Battle_ReadByteFromRecvBuffer
    cp 0
    ret z
    
    ld a, [W_Battle_NextSerIOByteIn]
    inc a
    ld [W_Battle_NextSerIOByteIn], a
    
    ld a, [hl]
    cp $EE
    jp z, .playStatusRemovalMessage
    cp $E0
    jp z, .playStatusContinueMessage
    
.checkPartnerStatus
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    call Battle_StagePartnerStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantStatusCondition]
    cp 0
    jp z, .playBattlePhraseMessage
    cp 1
    jr z, .playStatusRemovalMessage
    cp 2
    jr z, .playStatusRemovalMessage
    cp 8
    jr z, .playStatusRemovalMessage
    cp $B
    jr z, .playStatusRemovalMessage
    
    call $6614
    cp 1
    jr z, .playStatusRemovalMessage
    
    ;TODO: WTF DOES THIS DO?
    ld a, [W_Battle_CurrentParticipant + $11]
    ld b, a
    ld a, $CD
    add a, b
    ld b, a
    call $0D4E
    cp $80
    jr nc, .playStatusContinueMessage

.playStatusRemovalMessage
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantStatusCondition]
    call Battle_IndexStatusConditionRemovalMessage
    call Battle_QueueMessage
    
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    cp 1
    jr z, .resetSecondPartner
    cp 2
    jr z, .resetThirdPartner
    
.resetFirstPartner
    xor a
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantStatusCondition], a
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantArrivalTimeElapsed], a
    jr .doneResetting
    
.resetSecondPartner
    xor a
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantStatusCondition], a
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantArrivalTimeElapsed], a
    jr .doneResetting
    
.resetThirdPartner
    xor a
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantStatusCondition], a
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantArrivalTimeElapsed], a

.doneResetting
    ld hl, $9180
    ld a, 4
    call MainScript_DrawEmptySpaces
    
    ld a, [W_Battle_OpponentUsingLinkCable]
    cp 0
    jp z, .chooseNextStateAfterStatusRemoval
    
    ld a, $EE
    ld [W_SerIO_ProcessOutByte], a
    
.chooseNextStateAfterStatusRemoval
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantStatusCondition]
    cp 5
    jr z, .gotoState30
    cp 7
    jr z, .gotoState30
    cp 8
    jr z, .gotoState30
    cp $B
    jr z, .gotoState30
    
.gotoState27
    ld a, $3C
    ld [W_Battle_LoopIndex], a
    ld a, $27
    ld [W_Battle_SubSubState], a
    ret
    
.gotoState30
    ld a, $30
    ld [W_Battle_SubSubState], a
    ret
    
.playStatusContinueMessage
    ld a, [W_Battle_OpponentUsingLinkCable]
    cp 0
    jp z, .findMessage
    
    ld a, $E0
    ld [W_SerIO_ProcessOutByte], a
    
.findMessage
    call Banked_Battle_IncrementCurrentParticipantByte
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantStatusCondition]
    call Battle_IndexStatusConditionContinuingMessage
    jr .queueMessage
    
.playBattlePhraseMessage
    ld a, [W_Battle_OpponentUsingLinkCable]
    cp 0
    jp z, .loadBattlePhrase
    
    ld a, $E8
    ld [W_SerIO_ProcessOutByte], a
    
.loadBattlePhrase
    ld hl, StringTable_battle_attack_phrases
    call Banked_StringTable_LoadBattlePhrase
    ld hl, W_Battle_PhraseStagingBuffer
    nop
	 nop
	 nop
    
    ld a, $5C
    ld [byte_FFA1], a
    
    call Status_CopyLoadedDenjuuNickname
    
    ld c, M_Battle_MessageDenjuuBattlePhraseAlias
    
.queueMessage
    call Battle_QueueMessage
    ld a, $3C
    ld [W_Battle_LoopIndex], a
    ld a, $27
    ld [W_Battle_SubSubState], a
    ret