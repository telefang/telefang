INCLUDE "telefang.inc"

SECTION "Victory Participant Memory", WRAMX[$D4C9], BANK[$1]
W_Victory_UnlockedMove:: ds 1

SECTION "Victory Participant Utils", ROMX[$404F], BANK[$1D]
Victory_CopyParticipantIntoActiveSlot::
    ld bc, W_Battle_CurrentParticipant
    ld de, M_Battle_ParticipantSize
    
    cp 0
    jr z, .copyIntoCurrentParticipant
    
.indexSelectedParticipant
    add hl, de
    dec a
    jr nz, .indexSelectedParticipant
    
.copyIntoCurrentParticipant
    ld d, $10 ;this isn't all of the participant bytes...
    
.copyLoop
    ld a, [hli]
    ld [bc], a
    inc bc
    dec d
    jr nz, .copyLoop
    
    ret
    
Victory_LoadSpeciesNameAsArg1::
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call Banked_PauseMenu_ADVICE_LoadName75
    
    ld bc, W_StringTable_StagingLocDbl
    call Victory_CopyIntoTableStaging
    call Victory_CopyIntoArg1
    
    ret

Victory_CopyIntoTableStaging::
    ld hl, W_Battle_TableStringStaging
    ld a, M_StringTable_Load8AreaSize
    ld [W_Battle_LoopIndex], a
    
.copyLoop
    ld a, [bc]
    cp $C0
    jr z, .reterminateStr
    
    ld [hl], a
    inc hl
    inc bc
    
    ld a, [W_Battle_LoopIndex]
    dec a
    ld [W_Battle_LoopIndex], a
    
    jr nz, .copyLoop
    
.reterminateStr
    ld a, $E0
    ld [hl], a
    ld hl, W_Battle_TableStringStaging
    
    ret

Victory_CopyIntoArg1::
    ld de, W_MainScript_MessageArg1
    ld b, M_MainScript_MessageArg1Size
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop
    
    ret
    
Victory_CheckPartnerMoveUnlocks::
    xor a
    ld [W_Victory_UnlockedMove], a
    
    push hl
    ld a, [hld] ;Level
    ld b, a
    ld a, [hl] ;Species
    ld c, M_Battle_SpeciesMove3Level
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    pop hl
    ld a, [hl] ;Level
    cp b
    jr nz, .checkFourthMove
    
.thirdMoveUnlocked
    ld b, 0
    dec hl
    ld a, [hl]
    ld c, M_Battle_SpeciesMove3
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld [W_Victory_UnlockedMove], a
    
    jr .ret
    
.checkFourthMove
    push hl
    ld a, [hld] ;Level
    ld b, a
    ld a, [hl] ;Species
    ld c, M_Battle_SpeciesMove4Level
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    pop hl
    ld a, [hl] ;Level
    cp b
    jr nz, .ret
    
.fourthMoveUnlocked
    ld b, 0
    dec hl
    ld a, [hl]
    ld c, M_Battle_SpeciesMove4
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld [W_Victory_UnlockedMove], a
    
.ret
    ret