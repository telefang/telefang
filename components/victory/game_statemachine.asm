INCLUDE "telefang.inc"

SECTION "Victory Game State Memory", WRAMX[$D407], BANK[$01]
W_Victory_PlayerWon:: ds 1

SECTION "Victory Game State Machine", ROMX[$40EE], BANK[$1D]
Victory_GameStateMachine::
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl
    
.stateTable
    dw Victory_StateBattleScreen,Victory_StateBranchWinner,Victory_StatePlayerWin,$4142
    dw $4145,$41E4,$41E7,$4216
    dw $4219,$4220,$4233

;State 08 00 00
Victory_StateBattleScreen::
    jp Victory_BattleScreenStateMachine
    
;State 08 00 01
Victory_StateBranchWinner::
    ld a, [W_Victory_PlayerWon]
    or a
    jr z, .playerLostBattle
    
.playerWonBattle
    jp Battle_IncrementSubSubState
    
.playerLostBattle
    ld a, M_Victory_StatePlayerLoss
    ld [W_Battle_SubSubState], a
    ret
    
;State 08 00 02
Victory_StatePlayerWin::
    xor a
    ld [W_Battle_4thOrderSubState], a
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLocation]
    cp M_Battle_LocationEvolving
    jr z, .enterEvolutionState
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLocation]
    cp M_Battle_LocationEvolving
    jr z, .enterEvolutionState
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLocation]
    cp M_Battle_LocationEvolving
    jr z, .enterEvolutionState
    
    ld a, $04
    ld [W_Battle_SubSubState], a
    ret
    
.enterEvolutionState
    jp Battle_IncrementSubSubState