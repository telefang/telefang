INCLUDE "telefang.inc"

SECTION "Battle Participant Memory", WRAMX[$D500], BANK[$1]
Battle_PartnerParticipants:: ds M_Battle_ParticipantSize * M_Battle_TeamSize
Battle_OpponentParticipants:: ds M_Battle_ParticipantSize * M_Battle_TeamSize
Battle_CurrentParticipant:: ds M_Battle_ParticipantSize

SECTION "Battle Participant Management", ROMX[$412B], BANK[$5]
Battle_StagePartnerStats::
    ld hl, Battle_PartnerParticipants
    jp Battle_CopyIntoCurrentParticipant
    
Battle_StageOpponentStats::
    ld hl, Battle_OpponentParticipants
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
    ld de, Battle_CurrentParticipant
    ld bc, M_Battle_ParticipantSize
    jp memcpy