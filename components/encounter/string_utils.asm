INCLUDE "telefang.inc"

SECTION "Encounter Staged-String Utilities", ROMX[$4357], BANK[$1C]
Encounter_CopyStagedStringToArg2::
    ld bc, W_StringTable_StagingLocDbl
    call Encounter_CopyToTableStringStaging
    jp Encounter_SetMessageArg2
    
Encounter_CopyToTableStringStaging::
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
    
Encounter_SetMessageArg2::
    ld de, W_MainScript_MessageArg2
    ld b, M_StringTable_Load8AreaSize
    
.loop
    ld a, [hli]
    ld [de], a
    
    inc de
    dec b
    
    jr nz, .loop
    
    ret