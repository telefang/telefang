SECTION "Summon Memory 1", WRAMX[$D413], BANK[1]
W_Summon_SelectedPageCount:: ds 1
W_Summon_SelectedPageContact:: ds 1

SECTION "Summon Memory 2", WRAMX[$D4A0], BANK[1]
W_Summon_CurrentPage:: ds 1
W_Summon_MaxPages:: ds 1

SECTION "Summon Memory 3", WRAMX[$D404], BANK[1]
W_Summon_BattleMaxParticipants:: ds 1

SECTION "Summon Screen State Machine", ROMX[$4AFD], BANK[$1C]
Summon_StateMachine::
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]
    
.stateTable
    dw $4B53
    dw Summon_StateFadeOutIntoSummonScreen
    dw Summon_StateEnter
    dw $4D22
    dw $4D39
    dw $4D63
    dw $4D81
    dw $4FFD
    dw $5033
    dw $506C
    dw $5097
    dw $50AE
    dw $51CF
    dw $51D9
    dw $7F5C

Summon_PrivateStrings::
;る - $4B25
    db $5E

;でんじゃうがいません! - $4B26
    db $94, $63, $8D, $6B, $3A, $87, $39, $55, $45, $63, $B9, 0, 0
    
;ひき - $4B33
    db $52, $3E, 0

;よべます - $4B36
    db $5C, $7F, $55, $44, 0, 0

;よべません! - $4B3C
    db $5C, $7F, $55, $45, $63, $B9, 0
    
;だれもよべません - $4B43
.noDenjuu
    db $91, $5F, $59, $5C, $7F, $55, $45, $63
    
;リスト - $4B4B
.page
    db $28, $0D, $14, 0, 0
    
;/ - $4B50
.outOf
    db $CB, 0, 0

Section "Summon Screen", ROMX[$4B53], BANK[$1C]
Summon_StateInitialiseVariables::
    ld a, [W_Encounter_AlreadyInitialized]
    cp 1
    jp z, .exit
    xor a
    ld [W_Summon_SelectedPageContact], a
    ld [$D47C], a
    ld [$D47D], a
    ld [$D47E], a
    ld [$D408], a
    ld [$CB00], a
    ld [$D44E], a
    ld [W_Summon_CurrentPage], a
    ld [W_Summon_MaxPages], a
    ld [$D4BA], a
    ld [$D4BB], a
    ld [$D4BC], a
    ld [W_Victory_LeveledUpParticipant], a
    ld [W_StringTable_ROMTblIndex], a
    ld [W_Battle_LoopIndex], a
    ld a, 1
    ld [W_Status_SelectedContactIndex], a
    ld a, 1
    ld [$D42E], a
    ld a, [W_Victory_ContactsPresent]
    cp 1
    jp z, .exit
    ld a, [W_Summon_BattleMaxParticipants]
    cp 1
    jp z, .exit
    call $522C ; Parses Denjuu info from SRAM.
    call SaveClock_ExitSRAM
    call $5408 ; Deals with metasprites.
    jr .exit ; Useless jump.

.exit
    ld a, 1
    call Banked_LCDC_SetupPalswapAnimation
    jp Battle_IncrementSubSubState

; This state is used when fading out from the encounter screen and
; the check-your-own-Denjuu status screen into the summon screen.
Summon_StateFadeOutIntoSummonScreen::
    ld a, 1
    call Banked_LCDC_PaletteFade
    ; Apparently this is a "JoJoke", if kmeist's comment in the
    ; status screen state machine code is to be believed.
    or a
    ret z

    ld a, [W_Encounter_AlreadyInitialized]
    or a
    jp z, .encounterInitialized

    call $52C9 ; Initializes the encounter, I presume.

.encounterInitialized
    jp Battle_IncrementSubSubState

Summon_StateEnter::
    ld bc, $12
    call Banked_CGBLoadBackgroundPalette
    ld a, $28
    call PauseMenu_CGBStageFlavorPalette
    ld bc, $15
    call Banked_LoadMaliasGraphics
    ld hl, $8800
    call $57C8 ; Loads the phone border tiles to [hl].

    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    ld hl, $390
    add hl, de
    push hl
    
    pop bc
    xor a
    call CGBLoadBackgroundPaletteBanked

    ld hl, $9400
    ld a, 32
    call MainScript_DrawEmptySpaces

    ld bc, 0
    ld e, $0D
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, 0
    ld e, $0D
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0

    ld bc, 0
    ld e, $B7
    ld a, 0
    call Banked_RLEDecompressTMAP0

    ld hl, $9882
    ld a, [W_Overworld_SignalStrength]
    call Encounter_DrawSignalIndicator

    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles

    ld h, [hl]
    dec [hl]
    ld a, [W_Victory_ContactsPresent]
    cp 1
    jp z, .noContactsAvailable
    ld a, [W_Summon_BattleMaxParticipants]
    cp 1
    jp z, .noContactsAvailable
    ld a, [W_Status_NumDuplicateDenjuu]
    cp 0
    jp z, .noContactsAvailable

; This section of code runs only if you have contacts available to summon.

    ld a, [W_Status_NumDuplicateDenjuu]
    ld b, a
    ld a, [$D429]
    cp b
    jr c, .jpA
    ld a, [W_Status_NumDuplicateDenjuu]
    ld [$D42B], a
    ld a, [$D42B]
    ld [$D429], a

.jpA
    ld h, 0
    ld a, [$D42B]
    ld l, a
    call Battle_MessageNumbersToText
    ld c, $6A
    call Battle_QueueMessage
    ld bc, 0
    ld e, $95
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    call SaveClock_EnterSRAM2
    ld a, [W_Summon_SelectedPageContact]
    ld d, a
    call Summon_GetContactIDForCurrentPage
    ld hl, S_SaveClock_StatisticsArray
    call Battle_IndexStatisticsArray
    ld a, [hl]
    ld [$D490], a
    push af
    ld c, 1
    ld de, $8B80
    call Banked_Battle_LoadDenjuuPortrait
    pop af
    call Battle_LoadDenjuuPalettePartner
    ld a, [W_Status_NumDuplicateDenjuu]
    dec a
    ld b, 0
    ld a, a
    ld c, a
    ld d, 0
    ld a, 3
    ld e, a
    call $0628
    ld a, c
    ld [W_Summon_MaxPages], a
    ld a, 1
    ld [W_Status_SelectedContactIndex], a
    call $5301
    call $531F
    call $5374
    call $55CE
    call Summon_DrawPageContactNames
    jr .drawPagination


; This section of code runs only if your contacts are unavailable. That can mean either 1 bar of signal or no contacts.

.noContactsAvailable
    ld hl, $8B80
    ld a, $38
    call MainScript_DrawEmptySpaces
    ld bc, $B06
    ld e, $83
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld de, $4B43
    ld hl, $9180
    ld b, 8
    call Banked_MainScript_DrawStatusText
    ld a, [W_Victory_ContactsPresent]
    cp 1
    jr z, .couldntCallAnyoneMessage
    ld a, [W_Summon_BattleMaxParticipants]
    cp 1
    jr z, .noReceptionMessage
    ld a, [W_Status_NumDuplicateDenjuu]
    cp 0
    jr z, .noReceptionMessage

.couldntCallAnyoneMessage
    ld c, $33
    jr .queueMessage

.noReceptionMessage
    ld c, $6B

.queueMessage
    call Battle_QueueMessage

; This section of code is common to both contact and no contact screens, it draws the page numbers.

.drawPagination
    ld de, $4B4B
    ld hl, $9100
    ld b, 8
    call Banked_MainScript_DrawStatusText
    ld a, [W_Summon_MaxPages]
    inc a
    ld hl, $9831
    ld c, 1
    call Encounter_DrawTileDigits
    ld a, [W_Summon_CurrentPage]
    inc a
    ld hl, $982E
    ld c, 1
    call Encounter_DrawTileDigits

    call SaveClock_ExitSRAM
    ld a, 1
    call Banked_LCDC_SetupPalswapAnimation
    jp Battle_IncrementSubSubState
