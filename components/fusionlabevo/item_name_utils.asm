INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Name Copying", ROMX[$52A2], BANK[$2A]
;TODO: What do these entry points do differently?
FusionLabEvo_LoadSpeciesNameEntryPointA::
    ld de, W_SaveClock_NicknameStaging
    ld a, b
    jr FusionLabEvo_LoadSpeciesName
    
FusionLabEvo_LoadSpeciesNameEntryPointB::
    ld de, W_MainScript_CenteredNameBuffer
    jr FusionLabEvo_LoadSpeciesName
    
FusionLabEvo_LoadSpeciesNameEntryPointC::
    ld de, W_SaveClock_NicknameStaging
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
    ld b, $10
    call Banked_Memcpy
    ld a, $E0
    ld [de], a
    ret
    
SECTION "Fusion/Lab Evolution Name Index Multiplier", ROM0[$EC]
FusionLabEvo_Multiplier::
    sla c
    rl b
    ret