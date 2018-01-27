INCLUDE "telefang.inc"

SECTION "Victory Level-Up Memory", WRAMX[$D40A], BANK[$1]
W_Victory_LeveledUpParticipant:: ds 1

SECTION "Victory Level-Up States", ROMX[$4957], BANK[$1D]
;State 08 00 00 05
Victory_SubStateStatWindowPalette::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    ret nz
    
    ld a, 7
    ld bc, $B
    call CGBLoadBackgroundPaletteBanked
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    
    ld a, $28
    call PauseMenu_CGBStageFlavorPalette
    
    ld a, $38
    call PauseMenu_CGBStageFlavorPalette
    
    ld a, M_Victory_SubStateDrawStatWindow
    ld [W_Battle_4thOrderSubState], a
    
    ret

;State 08 00 00 0D
Victory_SubStateDrawStatWindow::
    call Victory_ADVICE_SubStateDrawStatWindow
    ld hl, $9450
    ld b, 8
    call Banked_MainScript_DrawStatusText
    
    ld de, Victory_ADVICE_BattleScreenPrivateStrings_defense
    ld hl, $94A0
    ld b, 8
    call Banked_MainScript_DrawStatusText
    
    ld de, Victory_ADVICE_BattleScreenPrivateStrings_denma
    ld hl, $94F0
    ld b, 8
    call Banked_MainScript_DrawStatusText
    
    ld de, Victory_ADVICE_BattleScreenPrivateStrings_denmaAtk
    ld hl, $9540
    ld b, 8
    call Banked_MainScript_DrawStatusText
    
    ld de, Victory_ADVICE_BattleScreenPrivateStrings_denmaDef
    ld hl, $9590
    ld b, 8
    call Banked_MainScript_DrawStatusText
    
    ld bc, $A00
    ld e, $9D
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, $A00
    ld e, $8F
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld a, [W_Victory_LeveledUpParticipant]
    ld hl, W_Battle_PartnerParticipants
    call Victory_CopyParticipantIntoActiveSlot
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld hl, $9850
    ld c, 0
    call Encounter_DrawTileDigits
    
.hpStat
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseHP
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $9890
    ld c, 0
    call Encounter_DrawTileDigits
    
    ld a, [W_Battle_RetrSpeciesByte]
    push af
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    dec b
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseHP
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    pop af
    sub b
    cp 0
    jr z, .speedStat
    
.hpIncreaseIndicator
    push af
    
    ld bc, $F05
    ld e, $B8
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    pop af
    
    ld hl, $98B2
    ld c, 1
    call Status_DrawStatValueSmall

.speedStat
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseSpeed
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $98F0
    ld c, 0
    call Encounter_DrawTileDigits
    
    ld a, [W_Battle_RetrSpeciesByte]
    push af
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    dec b
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseSpeed
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    pop af
    sub b
    cp 0
    jr z, .attackStat
    
.speedIncreaseIndicator
    push af
    
    ld bc, $F08
    ld e, $B8
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    pop af
    
    ld hl, $9912
    ld c, 1
    call Status_DrawStatValueSmall

.attackStat
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseAttack
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $9930
    ld c, 0
    call Encounter_DrawTileDigits
    
    ld a, [W_Battle_RetrSpeciesByte]
    push af
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    dec b
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseAttack
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    pop af
    sub b
    cp 0
    jr z, .defenseStat
    
.attackIncreaseIndicator
    push af
    
    ld bc, $F0A
    ld e, $B8
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    pop af
    
    ld hl, $9952
    ld c, 1
    call Status_DrawStatValueSmall

.defenseStat
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseDefense
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $9970
    ld c, 0
    call Encounter_DrawTileDigits
    
    ld a, [W_Battle_RetrSpeciesByte]
    push af
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    dec b
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseDefense
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    pop af
    sub b
    cp 0
    jr z, .denmaAtkStat
    
.defenseIncreaseIndicator
    push af
    
    ld bc, $F0C
    ld e, $B8
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    pop af
    
    ld hl, $9992
    ld c, 1
    call Status_DrawStatValueSmall

.denmaAtkStat
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseDenmaAttack
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $99B0
    ld c, 0
    call Encounter_DrawTileDigits
    
    ld a, [W_Battle_RetrSpeciesByte]
    push af
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    dec b
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseDenmaAttack
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    pop af
    sub b
    cp 0
    jr z, .denmaDefStat
    
.denmaAtkIncreaseIndicator
    push af
    
    ld bc, $F0E
    ld e, $B8
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    pop af
    
    ld hl, $99D2
    ld c, 1
    call Status_DrawStatValueSmall

.denmaDefStat
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseDenmaDefense
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $99F0
    ld c, 0
    call Encounter_DrawTileDigits
    
    ld a, [W_Battle_RetrSpeciesByte]
    push af
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantLevel]
    ld b, a
    dec b
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld c, M_Battle_SpeciesBaseDenmaDefense
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    pop af
    sub b
    cp 0
    jr z, .exitState
    
.denmaDefIncreaseIndicator
    push af
    
    ld bc, $F10
    ld e, $B8
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    pop af
    
    ld hl, $9A12
    ld c, 1
    call Status_DrawStatValueSmall
    
.exitState
    ld a, M_Victory_SubStateStatWindowIdle
    ld [W_Battle_4thOrderSubState], a
    ret
    
;State 08 00 00 0C
Victory_SubStateStatWindowIdle::
    ld a, [W_FrameCounter]
    and 7
    jr nz, .inputCheck
    
.iconAnimation
    ld hl, $9100
    call Victory_UpdateStatIconAnimation
    
.inputCheck
    ld a, [H_JPInput_Changed]
    and 1
    ret z
    
    ld a, [W_Victory_LeveledUpParticipant]
    cp 0
    jr z, .leveledFirst
    
    cp 1
    jr z, .leveledSecond
    
    jr .leveledThird
    
.leveledFirst
    ld a, M_Battle_LocationPresent
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLocation], a
    jr .teardownStatWindow
    
.leveledSecond
    ld a, M_Battle_LocationPresent
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLocation], a
    jr .teardownStatWindow
    
.leveledThird
    ld a, M_Battle_LocationPresent
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLocation], a
    
.teardownStatWindow
    ld bc, $A00
    ld e, $9F
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, $A00
    ld e, $91
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld bc, $C
    ld e, $80
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, M_Victory_SubStateCheckMoveUnlocks
    ld [W_Battle_4thOrderSubState], a
    ret
    
;State 08 00 00 0F
Victory_SubStateCheckMoveUnlocks::
    ld a, [W_Victory_LeveledUpParticipant]
    cp 0
    jr z, .leveledFirst
    
    cp 1
    jr z, .leveledSecond
    
    jr .leveledThird
    
.leveledFirst
    ld hl, W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLevel
    call Victory_CheckPartnerMoveUnlocks
    jr .checkIfUnlockHappened
    
.leveledSecond
    ld hl, W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLevel
    call Victory_CheckPartnerMoveUnlocks
    jr .checkIfUnlockHappened
    
.leveledThird
    ld hl, W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLevel
    call Victory_CheckPartnerMoveUnlocks

.checkIfUnlockHappened
    ld a, [W_Victory_UnlockedMove]
    cp 0
    jr z, .noUnlockedMoves
    
.unlockedMoves
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_battle_attacks
    call StringTable_LoadName75
    
    ld bc, W_StringTable_StagingLocDbl
    call Victory_CopyIntoTableStaging
    call Victory_CopyIntoArg1
    
    ld c, $34
    call Battle_QueueMessage
    
    ld a, [W_Battle_4thOrderSubState]
    inc a
    ld [W_Battle_4thOrderSubState], a
    
    ret
    
.noUnlockedMoves
    ld a, $17
    ld [W_Battle_4thOrderSubState], a
    ret
    
Victory_SubStateNewMoveMessage::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    ret nz
    
    ld a, $17
    ld [W_Battle_4thOrderSubState], a
    ret