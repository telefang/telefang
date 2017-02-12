INCLUDE "components/status/statetbl.inc"

SECTION "Status Screen State Machine Vars", WRAMX[$D41F], BANK[1]
W_Status_SubState: ds 1

SECTION "Status Screen State Machine Vars 2", WRAMX[$D456], BANK[1]
W_Status_UseDenjuuNickname: ds 1

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
    dw Status_StateInitGraphics,Status_StateInitTilemaps,Status_StateDrawDenjuu,$4D7A
    dw $4DBB,$4F2D,$4F96,$4E98
    dw $4F1D

Status_TextTable: ;4BA7
    INCBIN "script/status/ui_strings_1.stringtbl"
    INCBIN "script/status/ui_strings_2.stringtbl" ;4BB1

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

.loacContactInfo:
    call Status_LoadContactInfo

.placeDenjuuGraphic:
    ld a, [W_Status_SelectedDenjuuSpecies]
    push af
    ld c, 1
    ld de, $8800
    call Banked_Status_LoadDenjuuGraphic
    pop af
    call Status_LoadDenjuuPalette
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
    ld de, $7928
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
    call Banked_SetupPalswapAnimation
    jp Status_IncrementSubState