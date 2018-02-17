INCLUDE "telefang.inc"

SECTION "Zukan Completion Flag Utils", ROMX[$7A3A], BANK[$4]
Zukan_CheckEntryObtained::
    ld e, a
    ld d, 0
    ld hl, M_Zukan_BaseEntryObtainedFlag
    jr Zukan_CheckSpeciesKnown.readflag
    
Zukan_CheckSpeciesKnown::
    ld e, a
    ld d, 0
    ld hl, M_Zukan_BaseSpeciesKnownFlag
    
.readflag
    add hl, de
    ld b, h
    ld c, l
    jp Overworld_CheckFlagValue