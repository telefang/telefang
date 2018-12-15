INCLUDE "telefang.inc"

SECTION "Status Screen State Machine Vars", WRAMX[$D41F], BANK[1]
W_Status_SubState:: ds 1

SECTION "Status Screen State Machine Vars 2", WRAMX[$D456], BANK[1]
W_Status_UseDenjuuNickname:: ds 1

SECTION "Status Screen State Machine Vars 3", WRAMX[$D4B0], BANK[1]
W_Status_NumDuplicateDenjuu: ds 1

SECTION "Status Screen Home Utils", ROM0[$3CFD]
Status_IncrementSubState::
    ld hl, W_Status_SubState
    inc [hl]
    ret

SECTION "Status Screen State Machine", ROMX[$4B8B], BANK[$02]
Status_GameStateMachine::
    ld a, [W_Status_SubState]
    ld hl, Status_GameStateTable
    call System_IndexWordList
    jp [hl]

Status_GameStateTable:
    dw Status_StateInitGraphics
    dw Status_StateInitTilemaps
    dw Status_StateDrawDenjuu
    dw Status_StateFadeScreen
    dw Status_StateUserJPInput
    dw Status_StateExit
    dw Status_StateSwitchTab
    dw Status_StateSwitchDenjuu
    dw Status_StateSwitchDenjuuCleanup

Status_TextTable: ;4BA7
    INCBIN "build/script/status/ui_strings_1.stringtbl"
    INCBIN "build/script/status/ui_strings_2.stringtbl" ;4BB1

SECTION "Status Screen State Implementations", ROMX[$4C81], BANK[$02]
Status_StateInitGraphics:
    ld bc, $E
    call Banked_LoadMaliasGraphics
    ld a, $F0
    ld [$C91E], a
    call Status_ExpandNumericalTiles
    ld bc, $16
    call Banked_CGBLoadBackgroundPalette
    ld a, 0
    call PauseMenu_CGBStageFlavorPalette
    ld a, 0
    call Banked_Status_LoadUIGraphics
    ld a, [W_Status_CalledFromContactScreen]
    cp 0
    jp z, .checkNickUsed
    call Status_LoadContactInfo
    jr .placeDenjuuGraphic

.checkNickUsed
    ld a, [W_Status_UseDenjuuNickname]
    cp 0
    jr z, .loadSpecialInfo
    call Status_LoadContactInfo
    jr .placeDenjuuGraphic

.loadSpecialInfo
    ld a, [W_SystemSubState]
    cp 1
    jr nz, .loadContactInfo
    call Status_LoadSpecialInfo ;Like LoadContactInfo but it loads from $D5B6
    jr .placeDenjuuGraphic

.loadContactInfo:
    call Status_LoadContactInfo

.placeDenjuuGraphic:
    ld a, [W_Status_SelectedDenjuuSpecies]
    push af
    ld c, 1
    ld de, $8800
    call Banked_Battle_LoadDenjuuPortrait
    pop af
    call Battle_LoadDenjuuPalettePartner
    xor a
    ld [W_Status_CurrentTab], a
    jp Status_IncrementSubState

Status_StateInitTilemaps:
    ld bc, 0
    ld e, 1
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, 0
    ld e, 1
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    jp Status_IncrementSubState

Status_StateDrawDenjuu:
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld de, $9200
    call Status_LoadEvolutionIndicatorBySpecies
    ld a, [W_Status_SelectedDenjuuPersonality]
    call Banked_Status_LoadDenjuuTypeIcon
    ld a, [W_Status_SelectedDenjuuPersonality]
    call Banked_Status_LoadDenjuuTypeIconPalette
    ld hl, $9300
    ld a, 8
    call MainScript_DrawEmptySpaces
    ld a, [W_Status_UseDenjuuNickname]
    cp 1
    jr z, .isNicknamedDenjuu
    ld a, [W_SystemSubState]
    cp 1
    jr z, .drawDenjuuName
    
.isNicknamedDenjuu:
    ld a, [W_Status_SelectedDenjuuIndex]
    ld hl, $9300
    call Status_DrawDenjuuNickname
    jr .drawDenjuuWithProgressionTab

.drawDenjuuName:
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld de, $4000
    ld bc, $9300
    call MainScript_DrawCenteredName75
    
.drawDenjuuWithProgressionTab:
    ld a, [W_Status_SelectedDenjuuPersonality]
    ld bc, $8D80
    ld de, StringTable_denjuu_personalities
    call MainScript_DrawCenteredName75
    call Banked_MainScript_DrawHabitatString
    call Status_DrawDenjuuMoves
    ld de, Status_TextTable
    ld hl, $8E00
    ld b, 8
    call Banked_MainScript_DrawStatusText
    ld a, [W_Status_CurrentTab]
    cp M_Status_StateInitGraphics
    jr nz, .drawSelectedTab
    call Status_LoadCurrentTabTMAP
    call Status_DrawDenjuuProgressionStats
    call Status_DrawDenjuuPhoneNumber

.drawSelectedTab:
    ld a, [W_Status_CurrentTab]
    add a, 2
    ld e, a
    ld bc, 9
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp Status_IncrementSubState

; Execute fade processing. Once the screen has faded correctly, moves to the
; next state.
Status_StateFadeScreen:
    ld a, 0
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, [W_Status_UseDenjuuNickname]
    cp 1
    jr z, .zeroChoiceJmp

.zeroChoiceJmp
    ld a, [W_Status_NumDuplicateDenjuu]
    cp 1
    jr z, .noDupDenjuus
    
;This code appears to be adding some kind of sprites for something.
;Probably up/down indicators for multi-contact lists?
    ld a, $20
    ld [W_LCDC_MetaspriteAnimationBank], a
    ld a, $D7
    ld [W_LCDC_MetaspriteAnimationIndex], a
    ld a, 0
    ld [W_LCDC_NextMetaspriteSlot], a
    ld a, $28
    ld [W_LCDC_MetaspriteAnimationXOffsets], a
    ld a, 0
    ld [W_LCDC_MetaspriteAnimationYOffsets], a
    call LCDC_BeginMetaspriteAnimation
    ld a, 0
    ld bc, 4
    call CGBLoadObjectPaletteBanked
    ld a, 1
    ld [W_CGBPaletteStagedOBP], a

.noDupDenjuus
    jp Status_IncrementSubState

; Processes button imputs when not already switching between tabs or denjuu.
; User can press Left/Right to select tabs; Up/Down to select denjuu.
Status_StateUserJPInput:
    ld a, [W_FrameCounter]
    and 3
    jr nz, .notEighthFrame
    ld hl, $91B0
    call Status_ShiftBackgroundTiles

.notEighthFrame
    ld a, [W_Status_UseDenjuuNickname]
    cp 1
    jr z, .dupeDenjuuScroll
    
.dupeDenjuuScroll
    ld a, [W_Status_NumDuplicateDenjuu]
    cp 1
    jr z, .tabScroll
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Up
    jr z, .dupeDenjuuScrollFwd
    ld a, [W_Status_SelectedContactIndex]
    cp 0
    jr z, .contactNegWraparound
    dec a
    ld [W_Status_SelectedContactIndex], a
    jr .gotoSwitchDenjuuState
    
.contactNegWraparound
    ld a, [W_Status_NumDuplicateDenjuu]
    dec a
    ld [W_Status_SelectedContactIndex], a
    jr .gotoSwitchDenjuuState
    
.dupeDenjuuScrollFwd
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Down
    jr z, .tabScroll
    ld a, [W_Status_NumDuplicateDenjuu]
    ld b, a
    ld a, [W_Status_SelectedContactIndex]
    inc a
    cp b
    jr z, .contactPosWraparound
    ld [W_Status_SelectedContactIndex], a
    jr .gotoSwitchDenjuuState
    
.contactPosWraparound
    ld a, 0
    ld [W_Status_SelectedContactIndex], a
    
.gotoSwitchDenjuuState
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, M_Status_StateSwitchDenjuu
    ld [W_Status_SubState], a
    ret

.tabScroll
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Right
    jr z, .tabScrollBack
    ld a, [W_Status_CurrentTab]
    inc a
    cp 3
    jr nz, .noTabWrapForward
    xor a

.noTabWrapForward
    ld [W_Status_CurrentTab], a
    jp .tabStateChanged

.tabScrollBack
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Left
    jr z, .managementMenuEnter
    ld a, [W_Status_CurrentTab]
    cp 0
    jr nz, .noTabWrapBack
    ld a, 3
    
.noTabWrapBack
    dec a
    ld [W_Status_CurrentTab], a

.tabStateChanged
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, M_Status_StateSwitchTab
    ld [W_Status_SubState], a
    ret

.managementMenuEnter
    ld a, [W_Status_CalledFromContactScreen]
    cp 0
    jp z, .statusScreenExit
    ld a, [H_JPInput_Changed]
    and M_JPInput_A
    jr z, .statusScreenExit
    ld a, 2
    ld [W_Status_CalledFromContactScreen], a
    jr .gotoContactMgmtScreen

.statusScreenExit
    ld a, [W_Status_CalledFromContactScreen]
    cp 0
    jp z, .unchangedScreen
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .unchangedScreen
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    jr .gotoContactScreen
    
.unchangedScreen
    ld a, [H_JPInput_Changed]
    and M_JPInput_A + M_JPInput_B
    ret z
    
.gotoContactMgmtScreen
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
.gotoContactScreen
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, [W_Status_CalledFromContactScreen]
    cp 0
    jp nz, .nextState
    ld a, 1
    ld [W_Encounter_AlreadyInitialized], a
    
.nextState
    jp Status_IncrementSubState

Status_StateSwitchDenjuu:
    ld bc, $101
    ld e, $8B
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_SerIO_ConnectionState]
    cp 1
    jr z, .loadFromContacts
    ld a, [W_SystemSubState]
    cp 1
    jr nz, .loadFromContacts
    call Status_LoadSpecialInfo
    jr .renderNewDenjuu
    
.loadFromContacts
    call Status_LoadContactInfo
    
.renderNewDenjuu
    ld a, [W_Status_SelectedDenjuuSpecies]
    push af
    ld c, 1
    ld de, $8800
    call Banked_Battle_LoadDenjuuPortrait
    pop af
    call Battle_LoadDenjuuPalettePartner
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld de, $9200
    call Status_LoadEvolutionIndicatorBySpecies
    
    ld a, [W_Status_SelectedDenjuuPersonality]
    call Banked_Status_LoadDenjuuTypeIcon
    ld a, [W_Status_SelectedDenjuuPersonality]
    call Banked_Status_LoadDenjuuTypeIconPalette
    
    ld hl, $9300
    ld a, 8
    call MainScript_DrawEmptySpaces
    
    ld a, [W_SystemSubState]
    cp 1
    jr nz, .drawNickname
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld de, StringTable_denjuu_species
    ld bc, $9300
    call MainScript_DrawCenteredName75
    jr .drawPersonality

.drawNickname
    ld a, [W_Status_SelectedDenjuuIndex]
    ld hl, $9300
    call Status_DrawDenjuuNickname

.drawPersonality
    ld a, [W_Status_SelectedDenjuuPersonality]
    ld bc, $8D80
    ld de, StringTable_denjuu_personalities
    call MainScript_DrawCenteredName75
    
    call Banked_MainScript_DrawHabitatString
    call Status_DrawDenjuuMoves
    jp Status_IncrementSubState

Status_StateSwitchDenjuuCleanup
    ld bc, $101
    ld e, $B9
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld a, M_Status_StateSwitchTab
    ld [W_Status_SubState], a
    ret

Status_StateExit
    ld a, [W_Status_CalledFromContactScreen]
    cp 0
    jr nz, .fadeOut
    
    ld a, [W_SystemSubState]
    cp 1
    jr nz, .exit
    ld a, [W_SerIO_ConnectionState]
    cp 1
    jr z, .exit
    
.fadeOut
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a ;what a beautiful JoJoke!
    ret z
    
.exit
    xor a
    ld [W_Status_SubState], a
    xor a
    ld [W_MetaSpriteConfig1], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld a, [W_Status_CalledFromContactScreen]
    cp 0
    jr z, .noManagementScreen
    
    ld a, [W_SystemSubSubState]
    inc a
    ld [W_SystemSubSubState], a
    ld a, $C
    ld [W_SystemState], a
    ret ; Return to 0C 00 +1

.noManagementScreen
    ld a, [W_SerIO_ConnectionState]
    cp 1
    jr z, .loc_8F80
    cp 2
    jr z, .loc_8F8B
    
    ld a, 6
    ld [W_SystemState], a
    ld a, 0
    ld [$D400], a
    ret ; Return to 06 00
    
.loc_8F80
    ld a, $F
    ld [W_SystemState], a
    ld a, 0
    ld [$D401], a
    ret ; Return to 0F 00
    
.loc_8F8B
    ld a, $F
    ld [W_SystemState], a
    ld a, 0
    ld [$D401], a
    ret ; Return to 0F 00
    
Status_StateSwitchTab:
    call Status_LoadCurrentTabTMAP
    ld a, [W_Status_CurrentTab]
    cp 0
    jr z, .tab0
    cp 1
    jr z, .tab1
    jr .tab2

.tab0
    call Status_EnterTab0
    jr .nextState

.tab1
    call Status_EnterTab1
    jr .nextState

.tab2
    call Status_EnterTab2

.nextState
    ld a, M_Status_StateUserJPInput
    ld [W_Status_SubState], a
    ret