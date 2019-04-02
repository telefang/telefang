INCLUDE "telefang.inc"

SECTION "Battle UI Bookkeeping", WRAM0[$C460]
W_Battle_WindowOverlap:: ds 1
W_Battle_WindowYPos:: ds 1

SECTION "Battle SubSubState", WRAMX[$D400], BANK[$5]
W_Battle_SubSubState:: ds 1
W_Battle_4thOrderSubState:: ds 1

SECTION "Status Screen Home Utils 2", ROM0[$3CF8]
Battle_IncrementSubSubState::
    ld hl, W_Battle_SubSubState
    inc [hl]
    ret

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
    jp hl

.stateTable
    dw Battle_SubStateInitGraphics,Battle_SubStateInitTilemaps,$45F5,$463E,$4681,$4B07,$4BC6,$4C34 ;00-07
    dw $4D1F,$4DDD,$4F81,$510A,$545C,$545F,$57FB,$59BC ;08-0F
    dw $5F2D,$5F57,$62CD,$6348,$6360,$63FE,$6416,$46E2 ;10-17
    dw $46F2,$4707,$48E9,$48FC,$4911,$464B,Battle_SubStateParticipantArrivalProcessing,Battle_SubStateDenjuuArrivalPhrase ;18-1F
    dw $5FD6,$6318,$61FB,$50F5,$53EF,$5F3D,Battle_SubStateStatusWarningPartner,$48AD ;20-27
    dw Battle_SubStateStatusWarningOpponent,$4AAD,$4F12,$5F79,$5428,$5489,$4AF8,$63EF ;28-2F
    dw $63E0,$5F66,$5FA1,$5FB4,$5661,$5292,$5683,$452D ;30-37
    dw $454A,$4566,$561E,$5051,$50E0,$5416,$4F32,$5810 ;38-3F

Battle_ScreenUIStrings::
    INCBIN "build/script/battle/ui_strings.stringtbl"

SECTION "Battle Screen State Machine - Init", ROMX[$457D], BANK[$5]
Battle_SubStateInitGraphics::
    ld bc, 1
    call Banked_LoadMaliasGraphics
    ld bc, $17
    call Banked_CGBLoadBackgroundPalette
    ld a, $28
    call PauseMenu_CGBStageFlavorPalette
    ld bc, 4
    call Banked_CGBLoadObjectPalette
    ld bc, $10
    call Banked_LoadMaliasGraphics
    ld a, $20
    ld [W_LCDC_MetaspriteAnimationBank], a
    xor a
    ld [$D417], a
    ld [W_Summon_SelectedPageContact], a
    jp Battle_IncrementSubSubState

Battle_SubStateInitTilemaps::
    ld bc, 0
    ld e, $F
    xor a
    call Banked_RLEDecompressTMAP0
    ld bc, 0
    ld e, $F
    xor a
    call Banked_RLEDecompressAttribsTMAP0
    ld bc, 0
    ld e, $71
    xor a
    call Banked_RLEDecompressTMAP1
    ld bc, 0
    ld e, $71
    xor a
    call Banked_RLEDecompressAttribsTMAP1
    call $45D6
    call Battle_ExpandNumericalTiles
    jp Battle_IncrementSubSubState

SECTION "Battle Screen State Machine - Status Warnings For Partners", ROMX[$4721], BANK[$5]
Battle_SubStateStatusWarningPartner::
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    call Battle_StagePartnerStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLocation]
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
    call Battle_SetMessageArg2Phrase
    
    ld a, $5C
    ld [W_Sound_NextSFXSelect], a
    
    call Status_CopyLoadedDenjuuNickname
    
    ld c, M_Battle_MessageDenjuuBattlePhraseAlias
    
.queueMessage
    call Battle_QueueMessage
    ld a, $3C
    ld [W_Battle_LoopIndex], a
    ld a, $27
    ld [W_Battle_SubSubState], a
    ret

SECTION "Battle Screen State Machine - Status Warnings For Opponents", ROMX[$492F], BANK[$5]
Battle_SubStateStatusWarningOpponent::
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    call Battle_StageOpponentStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLocation]
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
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    cp b
    jr z, .gotoStateC
    
    ld a, [W_Battle_NumActivePartners]
    cp 3
    jr z, .threePartners
    cp 2
    jr z, .twoPartners
    jp .gotoStateC

.twoPartners
    ld a, [W_Battle_CurrentParticipant + $0B]
    ld b, a
    ld a, [W_Battle_PartnerDenjuuTurnOrder + 1]
    cp b
    jr nz, .gotoStateC

.threePartners
    ld bc, $105
    ld e, $8B
    xor a
    call Banked_RLEDecompressTMAP0
    
.partnersScanLoop
    ld a, [W_Battle_CurrentParticipant + $0B]
    ld b, a
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    cp b
    jr z, .drawNewPartner
    call Battle_AdvanceToNextPartnerInverse
    jr .partnersScanLoop

.drawNewPartner
    call Battle_PrepActivePartnerDenjuu
    call Battle_DrawPartnerUI
    
    ld a, $24
    ld [W_Battle_SubSubState], a
    ret

.gotoStateC
    ld a, $C
    ld [W_Battle_SubSubState], a
    ret
    
.notFive
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    call Battle_LoadDenjuuSpeciesAsMessageArg1
    
    ld a, [W_SerIO_ConnectionState]
    cp 0
    jp z, .checkOpponentStatus
    
    ld a, [W_Battle_OpponentUsingLinkCable]
    cp 1
    jp z, .checkOpponentStatus
    
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
    
.checkOpponentStatus
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    call Battle_StageOpponentStats
    
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
    
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    cp 1
    jr z, .resetSecondOpponent
    cp 2
    jr z, .resetThirdOpponent
    
.resetFirstOpponent
    xor a
    ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantStatusCondition], a
    ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantArrivalTimeElapsed], a
    jr .doneResetting
    
.resetSecondOpponent
    xor a
    ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantStatusCondition], a
    ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantArrivalTimeElapsed], a
    jr .doneResetting
    
.resetThirdOpponent
    xor a
    ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantStatusCondition], a
    ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantArrivalTimeElapsed], a

.doneResetting
    ld hl, $91C0
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
    
.gotoState29
    ld a, $3C
    ld [W_Battle_LoopIndex], a
    ld a, $29
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
    call Battle_SetMessageArg2Phrase
    
    ld a, $5D
    ld [W_Sound_NextSFXSelect], a
    
    ld c, M_Battle_MessageDenjuuBattlePhraseAlias
    
.queueMessage
    call Battle_QueueMessage
    ld a, $3C
    ld [W_Battle_LoopIndex], a
    ld a, $29
    ld [W_Battle_SubSubState], a
    ret
    
SECTION "Battle Substate Attack Menu Draw", ROMX[$4C34], BANK[$5]
Battle_SubStateDrawAttackMenuWindow::
    ld hl, W_Battle_WindowOverlap
    ld a, $3F ;This is the height of the menu.
    ld [hli], a
    ld a, [W_ShadowREG_WX]
    ld [hl], a
    
    xor a
    ld [W_ShadowREG_WY], a
    
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    call Battle_StagePartnerStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesMove1
    ld hl, $9400
    call Battle_DrawAttackNameOnMenu
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesMove2
    ld hl, $9480
    call Battle_DrawAttackNameOnMenu
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove3Level
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    cp b
    jr c, .noThirdAttack
    
.thirdAttack
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesMove3
    ld hl, $9500
    call Battle_DrawAttackNameOnMenu
    
    ld a, 2
    ld [$D41E], a
    jr .checkFourthAttack

.noThirdAttack
    ld a, 1
    ld [$D41E], a
    
    ld hl, $9500
    ld a, 8
    call MainScript_DrawEmptySpaces
    jr .noFourthAttack

.checkFourthAttack
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove4Level
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    cp b
    jr c, .noFourthAttack
    
.fourthAttack
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesMove4
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    or a
    jr z, .noFourthAttack
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesMove4
    ld hl, $9580
    call Battle_DrawAttackNameOnMenu
    
    ld a, 3
    ld [$D41E], a
    jr .drawMenuFrame

.noFourthAttack
    ld hl, $9580
    ld a, 8
    call MainScript_DrawEmptySpaces
    
.drawMenuFrame
    ld bc, $909
    ld e, $88
    xor a
    call Banked_RLEDecompressTMAP0
    
    ld bc, $909
    ld e, $80
    xor a
    call Banked_RLEDecompressAttribsTMAP0
    
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    cp 1
    jr z, .secondDenjuu
    cp 2
    jr z, .thirdDenjuu
    
.firstDenjuu
    ld a, [$D49D]
    ld [$D414], a
    jr .setupCursor

.secondDenjuu
    ld a, [$D49E]
    ld [$D414], a
    jr .setupCursor

.thirdDenjuu
    ld a, [$D49F]
    ld [$D414], a
    
.setupCursor
    call $65C3
    
    xor a
    ld [W_PauseMenu_SelectedCursorType], a
    
    call LCDC_BeginAnimationComplex
    jp Battle_IncrementSubSubState
    
Battle_DrawAttackNameOnMenu::
    push hl
    ld b, 0
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld de, StringTable_battle_attacks
    pop bc
    jp Banked_MainScript_DrawName75
    
SECTION "Battle Substates - Participant Arrival Processing", ROMX[$6099], BANK[$5]
Battle_SubStateParticipantArrivalProcessing::
    ld bc, $C
    ld e, $80
    xor a
    call Banked_RLEDecompressTMAP0
    
    ld bc, $30E
    ld e, $83
    xor a
    call Banked_RLEDecompressAttribsTMAP0
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLocation]
    cp M_Battle_LocationArriving
    jp z, .secondPartnerArriving
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLocation]
    cp M_Battle_LocationArriving
    jp z, .thirdPartnerArriving
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLocation]
    cp M_Battle_LocationArriving
    jp z, .secondOpponentArriving
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLocation]
    cp M_Battle_LocationArriving
    jp z, .thirdOpponentArriving
    
.secondPartnerArriving
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    
    ld bc, W_StringTable_StagingLoc
    call Battle_CopyTableString
    call Battle_SetMessageArg2Denjuu
    
    ld a, [W_StringTable_ROMTblIndex]
    call Battle_LoadDenjuuResourcesPartner
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantContactID]
    ld hl, $9200
    call Battle_DrawSpecifiedDenjuuNickname
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantMaxHP]
    ld [W_Battle_CurrentParticipant + M_Battle_ParticipantHP], a
    ld [W_Battle_CurrentParticipant + M_Battle_ParticipantMaxHP], a
    
    call Battle_DrawPartnerHPMeter
    ld a, 1
    call Battle_DrawPartnerDPMeter
    ld a, M_Battle_LocationPresent
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLocation], a
    jp .nextState

.thirdPartnerArriving
    ld a, 1
    call Battle_StagePartnerStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLocation]
    cp 4
    jr z, .reorderBeforeSecondPartner
    cp M_Battle_LocationCalled
    jr nz, .updatePartnerUI
    
.reorderBeforeSecondPartner
    ld a, 2
    ld [W_Battle_PartnerDenjuuTurnOrder + 1], a
    ld a, 1
    ld [W_Battle_PartnerDenjuuTurnOrder + 2], a
    
.updatePartnerUI
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    
    ld bc, W_StringTable_StagingLoc
    call Battle_CopyTableString
    call Battle_SetMessageArg2Denjuu
    
    ld a, [W_StringTable_ROMTblIndex]
    call Battle_LoadDenjuuResourcesPartner
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantContactID]
    ld hl, $9200
    call Battle_DrawSpecifiedDenjuuNickname
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantMaxHP]
    ld [W_Battle_CurrentParticipant + M_Battle_ParticipantHP], a
    ld [W_Battle_CurrentParticipant + M_Battle_ParticipantMaxHP], a
    
    call Battle_DrawPartnerHPMeter
    ld a, 2
    call Battle_DrawPartnerDPMeter
    ld a, M_Battle_LocationPresent
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLocation], a
    jp .nextState

.secondOpponentArriving
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    
    ld bc, W_StringTable_StagingLoc
    call Battle_CopyTableString
    call Battle_SetMessageArg2Denjuu
    
    ld a, [W_StringTable_ROMTblIndex]
    call Battle_LoadDenjuuResourcesOpponent
    
    ld a, [W_StringTable_ROMTblIndex]
    ld de, StringTable_denjuu_species
    ld bc, $9280
    call Banked_MainScript_DrawName75
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantMaxHP]
    ld [W_Battle_CurrentParticipant + M_Battle_ParticipantHP], a
    ld [W_Battle_CurrentParticipant + M_Battle_ParticipantMaxHP], a
    
    call Battle_DrawOpponentHPMeter
    ld a, 1
    call Battle_DrawOpponentDPMeter
    ld a, M_Battle_LocationPresent
    ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLocation], a
    jr .nextState

.thirdOpponentArriving
    ld a, 1
    call Battle_StageOpponentStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLocation]
    cp 4
    jr z, .reorderBeforeSecondOpponent
    cp M_Battle_LocationCalled
    jr nz, .updateOpponentUI
    
.reorderBeforeSecondOpponent
    ld a, 2
    ld [W_Battle_OpponentDenjuuTurnOrder + 1], a
    ld a, 1
    ld [W_Battle_OpponentDenjuuTurnOrder + 2], a
    
.updateOpponentUI
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    
    ld bc, W_StringTable_StagingLoc
    call Battle_CopyTableString
    call Battle_SetMessageArg2Denjuu
    
    ld a, [W_StringTable_ROMTblIndex]
    call Battle_LoadDenjuuResourcesOpponent
    
    ld a, [W_StringTable_ROMTblIndex]
    ld de, StringTable_denjuu_species
    ld bc, $9280
    call Banked_MainScript_DrawName75
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantMaxHP]
    ld [W_Battle_CurrentParticipant + M_Battle_ParticipantHP], a
    ld [W_Battle_CurrentParticipant + M_Battle_ParticipantMaxHP], a
    
    call Battle_DrawOpponentHPMeter
    ld a, 2
    call Battle_DrawOpponentDPMeter
    ld a, M_Battle_LocationPresent
    ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLocation], a

.nextState
    ld a, $22
    ld [W_Battle_SubSubState], a
    ret
    
SECTION "Battle State - Denjuu Arrival Phrases", ROMX[$6289], BANK[$5]
Battle_SubStateDenjuuArrivalPhrase::
    ld a, [W_Battle_LoopIndex]
    inc a
    ld [W_Battle_LoopIndex], a
    
    cp $1E
    ret c
    
;30 frames (a half second) of waiting later...
    xor a
    ld [$C120], a
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld a, $10
    ld hl, $9700
    call MainScript_DrawEmptySpaces
    
    ld hl, StringTable_battle_arrive_phrases
    call Banked_StringTable_LoadBattlePhrase
    
    ld hl, W_Battle_PhraseStagingBuffer
    call Battle_SetMessageArg2Phrase
    
    ld a, [W_Battle_DenjuuHasNickname]
    cp 1
    jr z, .noNickname
    
.nicknamed
    call Status_CopyLoadedDenjuuNickname
    jr .printMessage
    
.noNickname
    ld a, [W_StringTable_ROMTblIndex]
    call Battle_LoadDenjuuSpeciesAsMessageArg1
    
.printMessage
    ld c, M_Battle_MessageDenjuuBattlePhrase
    call Battle_QueueMessage
    
    ld a, $12
    ld [W_Battle_SubSubState], a
    ret

SECTION "Battle Status Effect Display Update Functions", ROMX[$643A], BANK[$05]
Battle_DrawPartnerStatusEffect::
    ld hl, $9180
    ld a, 4
    call MainScript_DrawEmptySpaces

    ld a, [W_Battle_PartnerDenjuuTurnOrder] ; Active Denjuu.
    call Battle_StagePartnerStats

    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantStatusCondition]
    or a
    ret z

    ld bc, $0100
    ld e, $BA ; Partner status effect tilemap.
    ld a, $00
    call Banked_RLEDecompressTMAP0

    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantStatusCondition]
    ld b, a
    ld hl, $9180
    jp Banked_MainScript_DrawStatusEffectString

Battle_DrawOpponentStatusEffect::
    ld hl, $91C0
    ld a, 4
    call MainScript_DrawEmptySpaces

    ld a, [W_Battle_OpponentDenjuuTurnOrder] ; Active Denjuu.
    call Battle_StageOpponentStats

    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantStatusCondition]
    or a
    ret z

    ld bc, $0108
    ld e, $BB ; Opponent status effect tilemap.
    xor a
    call Banked_RLEDecompressTMAP1

    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantStatusCondition]
    ld b, a
    ld hl, $91C0
    jp Banked_MainScript_DrawStatusEffectString
