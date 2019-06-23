INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Name Copying", ROMX[$52A2], BANK[$2A]
;TODO: What do these entry points do differently?
FusionLabEvo_LoadSpeciesNameEntryPointA::
    ld de, W_MainScript_MessageArg3
    ld a, b
    jr FusionLabEvo_LoadSpeciesName
    
FusionLabEvo_LoadSpeciesNameEntryPointB::
    ld de, $CA00
    jr FusionLabEvo_LoadSpeciesName
    
FusionLabEvo_LoadSpeciesNameEntryPointC::
    ld de, W_MainScript_MessageArg3
    ld a, [W_FusionLabEvo_PartnerSpecies]
    
FusionLabEvo_LoadSpeciesName::
    ld hl, StringTable_denjuu_species
    ld c, a
    ld b, $0
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    ld c, BANK(StringTable_denjuu_species)
    ld b, $8
    call Banked_Memcpy
    ld a, $E0
    ld [de], a
    ret