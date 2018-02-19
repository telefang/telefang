INCLUDE "telefang.inc"

SECTION "Zukan Species State 1", WRAM0[$CB72]
W_Zukan_LastKnownSpecies:: ds 1

SECTION "Zukan Species State 2", WRAM0[$CB76]
W_Zukan_ObtainedEntriesCount:: ds 1

SECTION "Zukan Species State 3", WRAM0[$CD23]
W_Zukan_SelectedSpecies:: ds 1

SECTION "Zukan Draw Utils 1", ROMX[$7139], BANK[$4]
Zukan_DrawOverviewNumericalIndex::
    ld a, [W_Zukan_SelectedSpecies]
    inc a
    ld hl, $99C2
    call PauseMenu_DrawDecimalizedValue
    
    ld a, $EE
    call vmempoke
    
    ld a, [W_Zukan_LastKnownSpecies]
    inc a
    ld hl, $99C6
    call PauseMenu_DrawDecimalizedValue
    
    ld a, [W_Zukan_ObtainedEntriesCount]
    ld hl, $9A23
    jp PauseMenu_DrawDecimalizedValue

SECTION "Zukan Draw Utils 2", ROMX[$7E81], BANK[$4]
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

SECTION "Zukan Draw Utils 3", ROMX[$7F70], BANK[$4]
Zukan_DrawSpeciesPageText::
    call Zukan_GetSpeciesPageStatus
    cp M_Zukan_SpeciesKnown
    jr z, .draw_question_marks
    
.draw_species_text
    ld a, [W_Zukan_SelectedSpecies]
    ld c, a
    jr .draw_result
    
.draw_question_marks
    ld c, $AE
    
.draw_result
    ld a, Banked_Zukan_ADVICE_DrawSpeciesPageText & $FF
    jp PatchUtils_AuxCodeJmp
    
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    
Zukan_UpdateOverviewCursorsNumbersAndNextState::
    ld e, $5C
    call PauseMenu_LoadMenuMap0
    
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_InitializeCursor
    
    ld a, $B
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_InitializeCursor
    call PauseMenu_UpdateZukanOverviewCursorAnimations
    call Zukan_DrawOverviewNumericalIndex
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    jp System_ScheduleNextSubSubState

SECTION "Zukan Draw Advice", ROMX[$43C0], BANK[$1]
Zukan_ADVICE_DrawSpeciesPageText::
    ld a, [W_PreviousBank]
    push af
    
    ld a, BANK(Zukan_ADVICE_DrawSpeciesPageText)
    ld [W_PreviousBank], a
    
    ld a, 14
    ld [W_MainScript_VWFNewlineWidth], a
    
    ld a, 3
    ld [W_MainScript_VWFWindowHeight], a
    
    ld a, [W_MainScript_State]
    cp 2
    jr z, .text_idling
    
.text_not_running
    ld b, $11
    ld d, $A
    call Banked_MainScript_InitializeMenuText
    
    jr .drawing_loop
    
.text_idling
    ;We're in idle state. Normally, we'd just run MainScriptMachine some more,
    ;but that will also trigger some text movement animation that won't work for
    ;UI text in general and is broken on custom windows anyway. So we skip it.
    ld a, M_MainScript_CCInterpreter
    ld [W_MainScript_State], a
    
.drawing_loop
    call Banked_MainScriptMachine
    
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    jr z, .text_exhausted
    cp 2
    jr z, .text_exhausted
    jr .drawing_loop
    
.text_exhausted
    ld a, M_MainScript_DefaultWindowWidth
    ld [W_MainScript_VWFNewlineWidth], a
    
    ld a, M_MainScript_DefaultWindowHeight
    ld [W_MainScript_VWFWindowHeight], a
    
    pop af
    ld [W_PreviousBank], a
    ld [W_CurrentBank], a
    ret
    
Zukan_ADVICE_DrawSpeciesPageText_END::