INCLUDE "telefang.inc"

SECTION "Zukan Species State 1", WRAM0[$CB72]
W_Zukan_LastKnownSpecies:: ds 1

SECTION "Zukan Species State 2", WRAM0[$CB76]
W_Zukan_ObtainedEntriesCount:: ds 1

SECTION "Zukan Species State 3", WRAM0[$CD23]
W_Zukan_SelectedSpecies:: ds 1

SECTION "Zukan Draw Utils", ROMX[$7E81], BANK[$4]
Zukan_DrawSpeciesType::
    ld a, [W_Zukan_SelectedSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesType
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld de, StringTable_denjuu_habitats
    ld bc, $9380
    jp Banked_MainScript_DrawShortName
    
Zukan_GetSpeciesPageStatus::
    xor a
    ld [W_System_GenericCounter], a
    
    ld a, [W_Zukan_SelectedSpecies]
    call Zukan_CheckEntryObtained
    jr nz, .species_entry_obtained
    
    ld a, [W_Zukan_SelectedSpecies]
    call Zukan_CheckSpeciesKnown
    jr z, .return
    
    ld a, M_Zukan_SpeciesKnown
    jr .store_result
    
.species_entry_obtained
    ld a, M_Zukan_SpeciesObtained
    
.store_result
    ld [W_System_GenericCounter], a
    
.return
    ret
    
Zukan_LoadSpeciesPortraitAndNameIfKnown::
    call Zukan_GetSpeciesPageStatus
    cp M_Zukan_SpeciesUnknown
    jr z, .unknown_species
    
.known_species
    ld a, [W_Zukan_SelectedSpecies]
    ld c, 0
    ld de, $9400
    call Banked_Battle_LoadDenjuuPortrait
    
    ld a, [W_Zukan_SelectedSpecies]
    call Battle_LoadDenjuuPaletteOpponent
    
    ld a, [W_Zukan_SelectedSpecies]
    jp PauseMenu_ContactPrepName
    
.unknown_species
    ld a, M_Zukan_UnidentifiedSpecies
    ld c, 0
    ld de, $9400
    call Banked_Battle_LoadDenjuuPortrait
    
    ld a, M_Zukan_UnidentifiedSpecies
    call Battle_LoadDenjuuPaletteOpponent
    
    ld a, M_Zukan_UnidentifiedSpecies
    jp PauseMenu_ContactPrepName