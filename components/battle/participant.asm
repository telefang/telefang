INCLUDE "telefang.inc"

SECTION "Battle Participant Memory 3", WRAMX[$D4E6], BANK[$1]
W_Battle_NumActivePartners:: ds 1
W_Battle_NumActiveOpponents:: ds 1
W_Battle_PartnerMeterFraction:: ds 1
W_Battle_OpponentMeterFraction:: ds 1

SECTION "Battle Participant Memory 2", WRAMX[$D474], BANK[$1]
W_Battle_PartnerDenjuuTurnOrder:: ds M_Battle_TeamSize
W_Battle_OpponentDenjuuTurnOrder:: ds M_Battle_TeamSize

SECTION "Battle Participant Memory", WRAMX[$D500], BANK[$1]
W_Battle_PartnerParticipants:: ds M_Battle_ParticipantSize * M_Battle_TeamSize
W_Battle_OpponentParticipants:: ds M_Battle_ParticipantSize * M_Battle_TeamSize
W_Battle_CurrentParticipant:: ds M_Battle_ParticipantSize

SECTION "Battle Participant Management", ROMX[$412B], BANK[$5]
Battle_StagePartnerStats::
    ld hl, W_Battle_PartnerParticipants
    jp Battle_CopyIntoCurrentParticipant
    
Battle_StageOpponentStats::
    ld hl, W_Battle_OpponentParticipants
    jp Battle_CopyIntoCurrentParticipant
    
Battle_CopyIntoCurrentParticipant::
    ld de, M_Battle_ParticipantSize
    cp 0
    jr z, .copy
    
.index
    add hl, de
    dec a
    jr nz, .index
    
.copy
    ld de, W_Battle_CurrentParticipant
    ld bc, M_Battle_ParticipantSize
    jp memcpy