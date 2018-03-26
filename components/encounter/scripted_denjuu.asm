INCLUDE "telefang.inc"
	
SECTION "Load Scripted Denjuu", ROM0[$3E45]
Encounter_LoadScriptedDenjuu::
	ld hl, $4BFA
	ld de, 5
	ld a, [$D402]
	cp 0
	jr z, .skipLoopOnZero
	
.multiplyLoop
	add hl, de
	dec a
	jr nz, .multiplyLoop
	
.skipLoopOnZero
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLevel], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + $A], a
	inc hl
	ld a, [hl]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantPersonality], a
	ret
	
Encounter_LoadScriptedTFangerDenjuu::
	ld hl, $4E9D
	ld de, $12
	ld a, [$D402]
	cp 0
	jr z, .skipLoopOnZero
	
.multiplyLoop
	add hl, de
	dec a
	jr nz, .multiplyLoop
	
.skipLoopOnZero
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies],a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLevel], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantMaxArrivalTime], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + $A], a
	inc hl
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantPersonality], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantSpecies], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLevel], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantMaxArrivalTime], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + $A], a
	inc hl
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantPersonality], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantSpecies], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLevel], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantMaxArrivalTime], a
	ld a, [hli]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + $A], a
	inc  hl
	ld a, [hl]
	ld [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantPersonality], a
	ret
	