INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Name Copying", ROMX[$52A2], BANK[$2A]
;TODO: What do these entry points do differently?
FusionLabEvo_LoadSpeciesNameEntryPointA::
    ld de, W_MainScript_MessageArg3
    ld a, b
    jr FusionLabEvo_LoadSpeciesName
    
FusionLabEvo_LoadSpeciesNameEntryPointB::
    ld de, W_Map_LocationStaging
    jr FusionLabEvo_LoadSpeciesName
    
FusionLabEvo_LoadSpeciesNameEntryPointC::
    ld de, W_MainScript_MessageArg3
    ld a, [$CAED]
    
FusionLabEvo_LoadSpeciesName::
    ld hl, StringTable_denjuu_species
    ld c, a
    ld b, $0
    call FusionLabEvo_Multiplier
    call FusionLabEvo_Multiplier
    call FusionLabEvo_Multiplier
    call FusionLabEvo_Multiplier
    add hl, bc
    ld c, BANK(StringTable_denjuu_species)
    ld b, $8
    call Banked_Memcpy
    ld a, $E0
    ld [de], a
    ret
    
;FusionLabEvo_Multiplier is in components/system/patch_utils.asm
