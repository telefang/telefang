INCLUDE "telefang.inc"

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