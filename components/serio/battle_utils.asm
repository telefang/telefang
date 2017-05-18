INCLUDE "telefang.inc"

SECTION "VS Battle Copied Functions 1", ROMX[$60A7], BANK[$1F]
SerIO_LoadDenjuuSpeciesAsMessageArg1::
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    ld bc, W_StringTable_StagingLoc
    call SerIO_BattleCopyTableString
    jp SerIO_CopyIntoArg1
    
SerIO_BattleCopyTableString::
    ld hl, W_Battle_TableStringStaging
    ld a, M_StringTable_Load8AreaSize
    ld [W_Battle_LoopIndex], a
    
.loop
    ld a, [bc]
    cp $C0
    jr z, .terminate
    
    ld [hl], a
    inc hl
    inc bc
    
    ld a, [W_Battle_LoopIndex]
    dec a
    ld [W_Battle_LoopIndex], a
    
    jr nz, .loop
    
.terminate
    ld a, $E0
    ld [hl], a
    
    ld hl, W_Battle_TableStringStaging
    ret
    
SerIO_CopyIntoArg1::
    ld de, W_MainScript_MessageArg1
    ld b, M_MainScript_MessageArg1Size
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop
    
    ret