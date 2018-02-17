INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Name Copying", ROMX[$52A2], BANK[$2A]
FusionLab_NameCopyEntryPointA::
    ld de, W_MainScript_MessageArg3
    ld a, b
    jr FusionLab_NameCopyMain
    
FusionLab_NameCopyEntryPointB::
    ld de, $CA00
    jr FusionLab_NameCopyMain
    
FusionLab_NameCopyEntryPointC::
    ld de, W_MainScript_MessageArg3
    ld a, [$CAED]
    
FusionLab_NameCopyMain::
    ld hl, $4000
    ld c, a
    ld b, $0
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    ld c, $75
    ld b, $8
    call Banked_Memcpy
    ld a, $E0
    ld [de], a
    ret