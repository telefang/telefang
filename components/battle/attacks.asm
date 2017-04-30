INCLUDE "telefang.inc"

SECTION "Battle Attack WRAM", WRAMX[$D46F], BANK[$1]
W_Battle_LastAttackID:: ds 1
W_Battle_DenjuuHasNickname:: ds 1

SECTION "Battle Stage Attack Name", ROMX[$43F9], BANK[$5]
Battle_SetAttackNameArg2::
    ld c, M_Battle_SpeciesMove1
    add a, c
    ld c, a
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    
    ld hl, StringTable_battle_attacks
    ld [W_StringTable_ROMTblIndex], a
    ld [W_Battle_LastAttackID], a
    call StringTable_LoadName75
    
    ld bc, W_StringTable_StagingLoc
    call Battle_CopyTableString
    jp Battle_SetMessageArg2Denjuu