;Banksafe versions of functions that switch banks on their own or exist in other
;banks. These functions restore the previous bank in different ways, not all of
;which are safe to recursively use. Only a few actually read and stack the
;current bank; others assume W_PreviousBank (only set by the state machines...)
;is valid. In practice this doesn't seem to matter for most functions...

SECTION "Banked Call Helper WRAM", WRAM0[$CB26]
W_System_BankedArg: ds 1

;These bits of memory are just random things used by a lot of crap at once
SECTION "System Memory Junk Drawer", WRAM0[$CB20]
W_System_GenericCounter:: ds 1

SECTION "Banked Call Helpers 0", ROM0[$04A7]
Banked_LCDC_PaletteFadeCGB::
    ld a, BANK(LCDC_PaletteFadeCGB)
    rst $10
    call LCDC_PaletteFadeCGB
    push af
    rst $18
    pop af
    ret

Banked_LoadMaliasGraphics::
    call LoadMaliasGraphics
    rst $18
    ret

Banked_CGBLoadBackgroundPalette::
    call CGBLoadBackgroundPalette
    rst $18
    ret

Banked_CGBLoadObjectPalette::
    call CGBLoadObjectPalette
    rst $18
    ret

Banked_SGB_ConstructPaletteSetPacket::
    push af
    ld a, BANK(SGB_ConstructPaletteSetPacket)
    rst $10
    pop af
    call SGB_ConstructPaletteSetPacket
    rst $18
    ret

Banked_RLEDecompressTMAP0::
    ld [W_System_BankedArg], a
    ld a, [W_CurrentBank]
    push af
    ld a, [W_System_BankedArg]
    call RLEDecompressTMAP0
    pop af
    rst $10
    ret

Banked_RLEDecompressAttribsTMAP0::
    ld [W_System_BankedArg], a
    ld a, [W_CurrentBank]
    push af
    ld a, [W_System_BankedArg]
    call RLEDecompressAttribsTMAP0
    pop af
    rst $10
    ret

Banked_RLEDecompressAttribsTMAP1::
    ld [W_System_BankedArg], a
    ld a, [W_CurrentBank]
    push af
    ld a, [W_System_BankedArg]
    call RLEDecompressAttribsTMAP1
    pop af
    rst $10
    ret

Banked_RLEDecompressTMAP1::
    ld [W_System_BankedArg], a
    ld a, [W_CurrentBank]
    push af
    ld a, [W_System_BankedArg]
    call RLEDecompressTMAP1
    pop af
    rst $10
    ret

Banked_LCDC_SetupPalswapAnimation::
    call LCDC_SetupPalswapAnimation
    rst $18
    ret

Banked_LCDC_PaletteFade::
    call LCDC_PaletteFade
    push af
    rst $18
    pop af
    ret

Banked_Battle_LoadDenjuuPortrait::
    call Battle_LoadDenjuuPortrait
    rst $18
    ret

Banked_Encounter_LoadTFangerPortrait::
    call Encounter_LoadTFangerPortrait
    rst $18
    ret
    
SECTION "Banked Call Helpers Number Niiiiininininine", ROM0[$528]
Banked_MainScript_InitializeMenuText::
    ld a, BANK(MainScript_InitializeMenuText)
    rst $10
    call MainScript_InitializeMenuText
    rst $18
    ret
    
Banked_MainScriptMachine::
    ld a, BANK(MainScriptMachine)
    rst $10
    call MainScriptMachine
    rst $18
    ret
    
Banked_LCDC_LoadGraphicIntoVRAM::
    rst $10
    call LCDC_LoadGraphicIntoVRAM
    rst $18
    ret
    
    ;Another banksafe function, but I don't know what it is yet.
    call $1887 ;AKA the first year Groundhog Day was observed
    rst $18
    ret
    
Banked_Status_LoadUIGraphics::
    call Status_LoadUIGraphics
    rst $18
    ret

SECTION "Banked Call Helpers", ROM0[$0560]
Banked_MainScript_DrawStatusText::
    call MainScript_DrawStatusText
    rst $18
    ret

Banked_MainScript_DrawName75::
    call MainScript_DrawName75
    rst $18
    ret

Banked_MainScript_DrawShortName::
    call MainScript_DrawShortName
    rst $18
    ret
    
Banked_Encounter_LoadSceneryTiles::
    call Encounter_LoadSceneryTiles
    rst $18
    ret
    
;dunno - $574
    call $1BB3
    rst $18
    ret
    
Banked_PhoneConversation_LoadSceneryTiles::
    call PhoneConversation_LoadSceneryTiles
    rst $18
    ret
    
;dunno - $57E
    call $1AC6
    rst $18
    ret
    
Banked_PhoneConversation_LoadPhoneFrameTiles::
    call PhoneConversation_LoadPhoneFrameTiles
    rst $18
    ret
    
Banked_Sound_PlaySample::
    call Sound_PlaySample
    rst $18
    ret

Banked_Battle_LoadSpeciesData::
    push af
    ld a, $75
    rst $10
    pop af
    call Battle_LoadSpeciesData
    rst $18
    ret

Banked_MainScript_DrawHabitatString::
    ld a, $75
    rst $10
    call MainScript_DrawHabitatString
    rst $18
    ret

Banked_MainScript_DrawStatusEffectString::
    ld a, $75
    rst $10
    call MainScript_DrawStatusEffectString
    rst $18
    ret
    
Banked_Status_LoadDenjuuEvolutionIndicator::
    call Status_LoadDenjuuEvolutionIndicator
    rst $18
    ret
    
Banked_Status_LoadDenjuuTypeIcon::
    call Status_LoadDenjuuTypeIcon
    rst $18
    ret
    
Banked_Status_LoadDenjuuTypeIconPalette::
    call Status_LoadDenjuuTypeIconPalette
    rst $18
    ret

SECTION "Banked Call Helpers 6", ROM0[$05D9]
Banked_Battle_LoadNextLevelExp::
    push af
    ld a, $27
    rst $10
    pop af
    call Battle_LoadNextLevelExp
    rst $18
    ret

SECTION "Banked Call Helpers 4", ROM0[$05ED]
Banked_Battle_LoadLevelupData::
    push af
    ld a, $27
    rst $10
    pop af
    call Battle_LoadLevelupData
    rst $18
    ret

SECTION "Banked Call Helpers 2", ROM0[$0609]
Banked_PauseMenu_InitializeCursor::
    ld a, [W_CurrentBank]
    push af
    ld a, [W_PauseMenu_SelectedCursorType]
    call PauseMenu_InitializeCursor
    pop af
    rst $10
    ret
    
Banked_PauseMenu_IterateCursorAnimation::
    ld a, [W_CurrentBank]
    push af
    call PauseMenu_IterateCursorAnimation
    pop af
    rst $10
    ret
    
Banked_StringTable_LoadBattlePhrase::
    ld a, $75 ;Symbolic representation of bank suspended until disassembly
              ;of battle system
    rst $10
    call StringTable_LoadBattlePhrase
    rst $18
    ret

SECTION "Banked Call Helpers 8", ROM0[$0650]
Banked_Status_DrawPhoneNumber::
    push af
    ld a, BANK(Status_DrawPhoneNumber)
    rst $10
    pop af
    call Status_DrawPhoneNumber
    rst $18
    ret

Banked_SaveClock_LoadDenjuuNicknameByStatPtr::
    ld a, [W_CurrentBank]
    push af
    ld a, BANK(SaveClock_LoadDenjuuNicknameByStatPtr)
    rst $10
    call SaveClock_LoadDenjuuNicknameByStatPtr
    pop af
    rst $10
    ret

SECTION "Banked Call Helpers 67", ROM0[$069C]
Banked_SaveClock_LoadDenjuuNicknameByIndex::
    ld a, BANK(SaveClock_LoadDenjuuNicknameByIndex)
    rst $10
    call SaveClock_LoadDenjuuNicknameByIndex
    rst $18
    ret
    
SECTION "Banked Call Helpers けつばん", ROM0[$20F6]
Banked_PhoneConversation_DetermineSceneryType::
    ld a, [W_CurrentBank]
    push af
    ld a, BANK(PhoneConversation_DetermineSceneryType)
    rst $10
    call PhoneConversation_DetermineSceneryType
    ld a, b
    ld [W_Encounter_SceneryType], a
    pop af
    rst $10
    ret
    
SECTION "Banked Call Helpers 3", ROM0[$2FC7]
Banked_MainScript_DrawLetter::
    push af
    ld a, [W_CurrentBank]
    ld [W_LCDC_LastBank], a
    ld a, $B
    rst $10
    pop af
    call MainScript_DrawLetter
    ld a, [W_LCDC_LastBank]
    rst $10
    ret
    
SECTION "Banked Call Helpers Theta Prime", ROM0[$3F22]
Banked_Battle_IncrementCurrentParticipantByte::
    ld a, BANK(Battle_IncrementCurrentParticipantByte)
    rst $10
    call Battle_IncrementCurrentParticipantByte
    rst $18
    ret