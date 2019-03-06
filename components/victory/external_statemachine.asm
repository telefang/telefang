INCLUDE "telefang.inc"

SECTION "Victory External State Machine", ROMX[$4000], BANK[$1D]
Victory_ExternalStateMachine::
    ld a, [W_SystemSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl
    
.stateTable
    dw Victory_ExStateVictoryScreen, Victory_ExStateOverworldReturn

;State 08 01
Victory_ExStateVictoryScreen::
    jp Victory_GameStateMachine
    
Victory_ExStateOverworldReturn::
    xor a
    ld [REG_MBC3_SRAMENABLE], a
    
    ld a, 0
    ld [W_ShadowREG_HBlankSecondMode], a
    
    ld a, 0
    ld [W_ShadowREG_SCX], a
    ld a, 0
    ld [W_ShadowREG_WX], a
    ld a, $A5
    ld [W_ShadowREG_WX], a
    
    ld a, [W_ShadowREG_LCDC]
    res 5, a
    ld [W_ShadowREG_LCDC], a
    
    ld a, [W_ShadowREG_LCDC]
    res 6, a
    ld [W_ShadowREG_LCDC], a
    
    ld a, 0
    ld [W_ShadowREG_HBlankSecondMode], a
    
    ld a, [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantHP]
    ld [$C955], a
    
    ld a, $A
    ld [W_SystemSubState], a
    ld a, M_System_GameStateOverworld
    ld [W_SystemState], a
    
    ret