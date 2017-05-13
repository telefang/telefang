INCLUDE "telefang.inc"

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
    ld b, 9
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop
    
    ret