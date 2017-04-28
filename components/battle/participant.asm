INCLUDE "telefang.inc"

SECTION "Battle Participant Memory 4", WRAMX[$D416], BANK[$1]
W_Battle_CurrentParticipantTeam:: ds 1

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

SECTION "Battle Participant Management 2", ROMX[$448C], BANK[$1C]
Battle_IncrementCurrentParticipantByte::
    ld a, [W_Battle_CurrentParticipantTeam]
    cp 1
    jr z, .opponentTeam
    
.partnerTeam
    ld d, 0
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    ld e, a
    ld hl, $D5BA ;TODO WTF
    add hl, de
    ld a, [hl]
    inc a
    ld [hl], a
    ret
    
.opponentTeam
    ld d, 0
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    ld e, a
    ld hl, $D5BD ;TODO WTF
    add hl, de
    ld a, [hl]
    inc a
    ld [hl], a
    ret
    
SECTION "Battle Participant Management 3", ROMX[$64DE], BANK[$5]
Battle_AdvanceToNextParticipantInFullOpponentTeam::
    ld h, b
    ld l, c
    ld a, [hl]
    ld d, a
    
    inc hl
    ld a, [hl]
    ld h, b
    ld l, c
    ld [hl], a
    
    inc hl
    inc hl
    ld a, [hl]
    ld h, b
    ld l, c
    inc hl
    ld [hl], a
    
    ld a, d
    ld h, b
    ld l, c
    
    inc hl
    inc hl
    ld [hl], a
    
    ret
    
Battle_AdvanceToNextParticipantInPartialTeam::
    ld h, b
    ld l, c
    ld a, [hl]
    ld d, a
    inc hl
    
    ld a, [hl]
    ld h, b
    ld l, c
    ld [hl], a
    
    ld a, d
    ld h, b
    ld l, c
    inc hl
    ld [hl], a
    
    ret
    
Battle_AdvanceToNextParticipantInFullPartnerTeam::
    ld h, b
    ld l, c
    ld a, [hl]
    ld d, a
    
    inc hl
    inc hl
    ld a, [hl]
    ld h, b
    ld l, c
    ld [hl], a
    
    inc hl
    ld a, [hl]
    ld h, b
    ld l, c
    inc hl
    inc hl
    ld [hl], a
    
    ld a, d
    ld h, b
    ld l, c
    
    inc hl
    ld [hl], a
    
    ret

Battle_AdvanceToNextPartnerInverse::
    ld bc, W_Battle_PartnerDenjuuTurnOrder
    ld a, [W_Battle_NumActivePartners]
    cp M_Battle_TeamSize
    jr z, .fullTeam
    
.partialTeam
    jp Battle_AdvanceToNextParticipantInPartialTeam
    
.fullTeam
    jp Battle_AdvanceToNextParticipantInFullOpponentTeam

SECTION "Battle Participant Management 4", ROMX[$653B], BANK[$5]
Battle_AdvanceToNextPartner::
    ld bc, W_Battle_PartnerDenjuuTurnOrder
    ld a, [W_Battle_NumActivePartners]
    cp M_Battle_TeamSize
    jr z, .fullTeam
    
.partialTeam
    jp Battle_AdvanceToNextParticipantInPartialTeam
    
.fullTeam
    jp Battle_AdvanceToNextParticipantInFullPartnerTeam

Battle_AdvanceToNextOpponent::
    ld bc, W_Battle_OpponentDenjuuTurnOrder
    ld a, [W_Battle_NumActiveOpponents]
    cp M_Battle_TeamSize
    jr z, .fullTeam
    
.partialTeam
    jp Battle_AdvanceToNextParticipantInPartialTeam
    
.fullTeam
    jp Battle_AdvanceToNextParticipantInFullOpponentTeam
    
SECTION "Battle Participant Management 5", ROMX[$657B], BANK[$5]
Battle_PrepActivePartnerDenjuu::
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    call Battle_StagePartnerStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    call Battle_LoadDenjuuResourcesPartner
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    
    ret

Battle_PrepActiveOpponentDenjuu::
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    call Battle_StageOpponentStats
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    call Battle_LoadDenjuuResourcesOpponent
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    
    ret