INCLUDE "telefang.inc"

SECTION "Battle Message Argument Memory", WRAMX[$D420], BANK[$1]
W_Battle_TableStringStaging:: ds M_StringTable_Load8AreaSize

SECTION "Battle Message Argument Memory 2", WRAMX[$D45A], BANK[$1]
W_Battle_LoopIndex:: ds 1

SECTION "Battle Message Argument Writers", ROMX[$4012], BANK[$5]
Battle_SetMessageArg2Denjuu::
    ld de, W_MainScript_MessageArg2
    ld c, M_StringTable_Load8AreaSize + 1
    jr Battle_SetMessageArg2Phrase.memcpy

Battle_SetMessageArg1Denjuu::
    ld de, W_MainScript_MessageArg1
    ld c, M_StringTable_Load8AreaSize + 1
    jr Battle_SetMessageArg2Phrase.memcpy

Battle_SetMessageArg2Phrase::
    ld de, W_MainScript_MessageArg2
    ld c, M_MainScript_MessageArg2Size
    
.memcpy
    ld b, 0
    jp memcpy

;Used for intermediary staging before writing to the message arguments.
;BC is the source address. Returns the string staging target as HL, perfect for
;then immediately calling SetMessageArgn functions.
Battle_CopyTableString::
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

SECTION "Battle Message Argument Loaders", ROMX[$42CD], BANK[$5]
Battle_LoadDenjuuSpeciesAsMessageArg1::
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    ld bc, W_StringTable_StagingLoc
    call Battle_CopyTableString
    jp Battle_SetMessageArg1Denjuu