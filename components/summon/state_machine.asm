INCLUDE "telefang.inc"

SECTION "Summon Memory 1", WRAMX[$D413], BANK[1]
W_Summon_SelectedPageCount:: ds 1
W_Summon_SelectedPageContact:: ds 1

SECTION "Summon Memory 2", WRAMX[$D4A0], BANK[1]
W_Summon_CurrentPage:: ds 1
W_Summon_MaxPages:: ds 1

SECTION "Summon Memory 3", WRAMX[$D404], BANK[1]
W_Summon_BattleMaxParticipants:: ds 1

SECTION "Summon Memory 4", WRAMX[$D429], BANK[1]
W_Summon_RemainingParticipantsForSelection:: ds 1

SECTION "Summon Memory 5", WRAMX[$D42B], BANK[1]
W_Summon_MaxRemainingParticipantsForSelection:: ds 1

SECTION "Summon Memory 6", WRAMX[$D47C], BANK[1]
W_Summon_ContactAOfCurrentPageSelected:: ds 1
W_Summon_ContactBOfCurrentPageSelected:: ds 1
W_Summon_ContactCOfCurrentPageSelected:: ds 1

SECTION "Summon Screen State Machine", ROMX[$4AFD], BANK[$1C]
Summon_StateMachine::
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]
    
.stateTable
    dw Summon_StateInitialiseVariables ; 00
    dw Summon_StateFadeOutIntoSummonScreen ; 01
    dw Summon_StateEnter ; 02
    dw Summon_StateFadeInAndDrawArrows ; 03
    dw Summon_StateContactAvailabilityJumpAndDrawArrowSelector ; 04
    dw Summon_StateSkipToBattle ; 05
    dw Summon_StateInputHandler ; 06
    dw Summon_StateDrawSelectedContactPortrait ; 07
    dw Summon_StateDisplaySelectedContactPortrait ; 08
    dw Summon_StateEnterStatusScreen ; 09
    dw Summon_StatePrintConfirmationDialogue ; 0A
    dw Summon_StateConfirmationInputHandler ; 0B
    dw Summon_StateFadeOut ; 0C
    dw Summon_StateEnterBattle ; 0D
    dw $7F5C ; 0E

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
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
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
    ld a, [W_Summon_RemainingParticipantsForSelection]
    cp b
    jr c, .jpA
    ld a, [W_Status_NumDuplicateDenjuu]
    ld [W_Summon_MaxRemainingParticipantsForSelection], a
    ld a, [W_Summon_MaxRemainingParticipantsForSelection]
    ld [W_Summon_RemainingParticipantsForSelection], a

.jpA
    ld h, 0
    ld a, [W_Summon_MaxRemainingParticipantsForSelection]
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

Summon_StateFadeInAndDrawArrows::
    ld a, 0
    call Banked_LCDC_PaletteFade
    or a
    ret z
    call Encounter_LoadSelectedIndicatorResources
    ld a, [W_Summon_MaxPages]
    cp 1
    jr c, .noArrowsRequired
    call $52AA

.noArrowsRequired
    jp   Battle_IncrementSubSubState

Summon_StateContactAvailabilityJumpAndDrawArrowSelector::
    ld a, [W_Victory_ContactsPresent]
    cp 1
    jr z, .noContactsAvailable
    ld a, [W_Summon_BattleMaxParticipants]
    cp 1
    jr z, .noContactsAvailable
    ld a, [W_Status_NumDuplicateDenjuu]
    cp 0
    jp z, .noContactsAvailable
    call $53DE
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    ld a, 6
    ld [W_Battle_SubSubState], a
    ret

.noContactsAvailable
    jp Battle_IncrementSubSubState

Summon_StateSkipToBattle::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $10
    ld [$CF96], a
    ld a, $C
    ld [W_Battle_SubSubState], a
    ret

Summon_StateInputHandler::
    call Banked_MainScriptMachine
    call LCDC_IterateAnimationComplex
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Left
    jr z, .leftNotPressed

    ld a, [W_Summon_MaxPages]
    cp 0
    jp z, .noPageInteraction
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Summon_CurrentPage]
    cp 0
    jr z, .onFirstPage
    dec a
    ld [W_Summon_CurrentPage], a
    jr .pagePossiblyChanged

.onFirstPage
    ld a, [W_Summon_MaxPages]
    ld [W_Summon_CurrentPage], a
    jr .pagePossiblyChanged

.leftNotPressed
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Right
    jp z, .noPageInteraction
    ld a, [W_Summon_MaxPages]
    cp 0
    jp z, .noPageInteraction
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Summon_MaxPages]
    ld b, a
    ld a, [W_Summon_CurrentPage]
    cp b
    jr z, .onLastPage
    inc a
    ld [W_Summon_CurrentPage], a
    jr .pagePossiblyChanged

.onLastPage
    ld a, 0
    ld [W_Summon_CurrentPage], a

.pagePossiblyChanged
    xor a
    ld [W_Summon_SelectedPageContact], a
    ld a, 0
    ld [W_MetaSpriteConfig1], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld hl, $9400
    ld a, $18
    call MainScript_DrawEmptySpaces
    call $531F
    call $5301
    call $5374
    call $55CE
    call Summon_DrawPageContactNames
    call SaveClock_ExitSRAM
    xor a
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    call $5467
    call $52C9
    ld a, 7
    ld [W_Battle_SubSubState], a
    ret

.noPageInteraction
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Up
    jr z, .upNotPressed
    ld a, [W_Summon_SelectedPageContact]
    cp 0
    jr z, .upNotPressed
    dec a
    ld [W_Summon_SelectedPageContact], a
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, 7
    ld [W_Battle_SubSubState], a
    ret

.upNotPressed
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Down
    jp z, .downNotPressed
    ld a, [W_Summon_SelectedPageCount]
    sub 1
    ld b, a
    ld a, [W_Summon_SelectedPageContact]
    cp b
    jp z, .downNotPressed
    inc a
    ld [W_Summon_SelectedPageContact], a
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, 7
    ld [W_Battle_SubSubState], a
    ret

.downNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    jp z, .aNotPressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_ContactsPresent]
    cp 1
    jr nz, .contactCheckPassed
    ld a, [W_Summon_RemainingParticipantsForSelection]
    cp 0
    jr nz, .contactCheckPassed
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $10
    ld [$CF96], a
    ld a, 4
    ld [W_Battle_SubSubState], a
    ret

.contactCheckPassed
    ld a, 1
    ld [$D4BA], a
    ld a, [W_Summon_CurrentPage]
    ld [$D4BB], a
    ld a, [W_Summon_SelectedPageContact]
    ld [$D4BC], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, [W_Summon_SelectedPageContact]
    cp 0
    jp z, .contactAOfPageSelected
    cp 1
    jp z, .contactBOfPageSelected
    cp 2
    jp z, .contactCOfPageSelected

.contactAOfPageSelected
    ld a, [W_Summon_ContactAOfCurrentPageSelected]
    cp 1
    jp z, .queueConfirmationMessage
    ld a, 1
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld a, 0
    call $5446
    ld a, [$CB00]
    ld [W_Status_SelectedContactIndex], a
    ld a, [W_Summon_RemainingParticipantsForSelection]
    dec a
    ld [W_Summon_RemainingParticipantsForSelection], a
    call $5477
    ld a, [$D42E]
    inc a
    ld [$D42E], a
    jp .repositionSelectorArrow

.contactBOfPageSelected
    ld a, [W_Summon_ContactBOfCurrentPageSelected]
    cp 1
    jp z, .queueConfirmationMessage
    ld a, 1
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld a, 1
    call $5446
    ld a, [$CB00]
    ld [W_Status_SelectedContactIndex], a
    ld a, [W_Summon_RemainingParticipantsForSelection]
    dec a
    ld [W_Summon_RemainingParticipantsForSelection], a
    call $5477
    ld a, [$D42E]
    inc a
    ld [$D42E], a
    jp .repositionSelectorArrow

.contactCOfPageSelected
    ld a, [W_Summon_ContactCOfCurrentPageSelected]
    cp 1
    jp z, .queueConfirmationMessage
    ld a, 1
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    ld a, 2
    call $5446
    ld a, [$CB00]
    ld [W_Status_SelectedContactIndex], a
    ld a, [W_Summon_RemainingParticipantsForSelection]
    dec a
    ld [W_Summon_RemainingParticipantsForSelection], a
    call $5477
    ld a, [$D42E]
    inc a
    ld [$D42E], a

.repositionSelectorArrow
    ld a, [W_Summon_RemainingParticipantsForSelection]
    cp 0
    jp z, .queueConfirmationMessage
    ld a, [W_Summon_SelectedPageCount]
    cp 1
    jr z, .dontReposition
    cp 2
    jr z, .repositionIfNotSecond
    cp 3
    jr z, .repositionIfNotThird

.repositionIfNotSecond
    ld a, [W_Summon_SelectedPageContact]
    cp 1
    jr z, .dontReposition
    jr .doReposition

.repositionIfNotThird
    ld a, [W_Summon_SelectedPageContact]
    cp 2
    jr z, .dontReposition

.doReposition
    ld a, [W_Summon_SelectedPageContact]
    inc a
    ld [W_Summon_SelectedPageContact], a
    ld a, 7
    ld [W_Battle_SubSubState], a

.dontReposition
    ret

.aNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    ld a, [$D42E]
    cp 1
    jp z, .queueConfirmationMessage
    ld a, 0
    ld [$D51D], a
    ld [$D533], a
    ld a, 1
    ld [$D42E], a
    xor a
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    call $5467
    xor a
    ld [$D4BA], a
    ld [$D4BB], a
    ld [$D4BC], a
    ld c, $6A
    call Battle_QueueMessage
    ld a, [W_Summon_RemainingParticipantsForSelection]
    cp 1
    jr nz, .deselectByBConditionNotValid
    ld a, [W_Summon_MaxRemainingParticipantsForSelection]
    cp 1
    jr z, .deselectByBConditionNotValid
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    ld a, [W_Summon_RemainingParticipantsForSelection]
    inc a
    ld [W_Summon_RemainingParticipantsForSelection], a

.deselectByBConditionNotValid
    ret

.bNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Start
    jp z, .startNotPressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    jr .queueConfirmationMessage

.startNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Select
    jp z, .selectNotPressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, 9
    ld [W_Battle_SubSubState], a
    ret

.selectNotPressed
    call Banked_MainScriptMachine
    ret

.queueConfirmationMessage
    ld c, $1E
    call Battle_QueueMessage
    xor a
    ld [W_Victory_UserSelection], a
    call Encounter_PlaceSelectIndicator
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    ld a, $A
    ld [W_Battle_SubSubState], a
    ret

Summon_StateDrawSelectedContactPortrait::
    ld bc, $105
    ld e, $8B
    ld a, 0
    call Banked_RLEDecompressTMAP0
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
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    call SaveClock_ExitSRAM
    jp Battle_IncrementSubSubState

Summon_StateDisplaySelectedContactPortrait::
    ld bc, $105
    ld e, $92
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, $105
    ld e, $8C
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    ld a, [W_Victory_ContactsPresent]
    cp 1
    jr z, .skipToBattle
    ld a, [W_Summon_BattleMaxParticipants]
    cp 1
    jr z, .skipToBattle
    ld a, [W_Status_NumDuplicateDenjuu]
    cp 0
    jp z, .skipToBattle
    call $53DE
    ld a, 6
    ld [W_Battle_SubSubState], a
    ret

.skipToBattle
    ld a, 5
    ld [W_Battle_SubSubState], a
    ret

Summon_StateEnterStatusScreen::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, 0
    ld [W_MetaSpriteConfig1], a
    ld [$C120], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    call $5467
    ld a, [W_Summon_SelectedPageContact]
    ld d, a
    call Summon_IndexCursorToContactSlotID
    ld [W_Status_SelectedContactIndex], a
    xor a
    ld [W_Status_SubState], a
    ld a, 9
    ld [W_SystemState], a
    ret

Summon_StatePrintConfirmationDialogue::
    call Banked_MainScriptMachine
    ld a, [W_Battle_LoopIndex]
    inc a
    ld [W_Battle_LoopIndex], a
    cp $A
    ret c
    xor a
    ld [W_Battle_LoopIndex], a
    ld a, $B
    ld [W_Battle_SubSubState], a
    ret
Summon_StateConfirmationInputHandler:: ;50AE
    call LCDC_IterateAnimationComplex
    call Banked_MainScriptMachine
 
; Lets double-check that those "OK!" sprites are all displaying correctly.
 
    ld a, [W_Summon_ContactAOfCurrentPageSelected]
    cp 1
    jr nz, .contactANotSelected
    ld a, 0
    call $5446

.contactANotSelected
    ld a, [W_Summon_ContactBOfCurrentPageSelected]
    cp 1
    jr nz, .contactBNotSelected
    ld a, 1
    call $5446

.contactBNotSelected
    ld a, [W_Summon_ContactCOfCurrentPageSelected]
    cp 1
    jr nz, .contactCNotSelected
    ld a, 2
    call $5446

.contactCNotSelected
    ld a, [W_Summon_MaxRemainingParticipantsForSelection]
    cp 0
    jp z, .noDenjuu

    ld a, [W_Victory_ContactsPresent]
    cp 0
    jp z, .noDenjuu

    ldh a, [H_JPInput_Changed]
    and M_JPInput_Left
    jr z, .leftNotPressed
    ld a, [W_Victory_UserSelection]
    cp 0
    jr z, .arrowRightOnLeft
    ld a, 0
    ld [W_Victory_UserSelection], a
    jr .moveArrow

.arrowRightOnLeft
    ld a, 1
    ld [W_Victory_UserSelection], a
    jr .moveArrow

.leftNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Right
    jr z, .rightNotPressed
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .arrowLeftOnRight
    ld a, 1
    ld [W_Victory_UserSelection], a
    jr .moveArrow

.arrowLeftOnRight
    ld a, 0
    ld [W_Victory_UserSelection], a

.moveArrow
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    jp Encounter_PlaceSelectIndicator

.rightNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed
    jr .noSelected

.bNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    ret z
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .noSelected
    jp .yesSelected

.noSelected
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    call $53DE
    ld a, 0
    ld [$D51D], a
    ld [$D533], a
    ld a, 1
    ld [$D42E], a
    xor a
    ld [$D4BA], a
    ld [$D4BB], a
    ld [$D4BC], a
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    call $5467
    ld a, [W_Summon_MaxRemainingParticipantsForSelection]
    ld [W_Summon_RemainingParticipantsForSelection], a
    ld c, $6A
    call Battle_QueueMessage
    ld a, 6
    ld [W_Battle_SubSubState], a
    ret

; Fires in the impossible (in terms of standard gameplay) situation where no Denjuu can be summoned into battle.

.noDenjuu
    ldh a, [H_JPInput_Changed]
    and 3
    ret z
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .noSelected

.yesSelected
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, [$D42E]
    cp 1
    jr z, .jpC
    cp 2
    jr z, .jpA
    cp 3
    jr z, .jpB

.jpA
    ld a, 1
    ld [$D51D], a
    jr .jpC

.jpB
    ld a, 1
    ld [$D51D], a
    ld [$D533], a

.jpC
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    xor a
    ld [W_MetaSpriteConfig1], a
    ld [$C120], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    call $5467
    ld a, $10
    ld [$CF96], a
    ld a, $C
    ld [W_Battle_SubSubState], a
    ret

Summon_StateFadeOut::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    jp Battle_IncrementSubSubState

Summon_StateEnterBattle::
    ld a, [$D42E]
    ld [$D5C6], a

    ld hl, W_Battle_PartnerParticipants
    call $5550
    ld a, [$D517]
    cp 0
    jr z, .jpA
    ld hl, $D516
    call $5550
    ld a, [$D52D]
    cp 0
    jr z, .jpA
    ld hl, $D52C
    call $5550

.jpA
    ld hl, W_Battle_OpponentParticipants
    call $5550
    ld a, [$D559]
    cp 0
    jr z, .jpB
    ld hl, $D558
    call $5550
    ld a, [$D56F]
    cp 0
    jr z, .jpB
    ld hl, $D56E
    call $5550

.jpB
    ld a, [$C955]
    ld [$D502], a
    xor a
    ld [W_Battle_SubSubState], a
    jp System_ScheduleNextSubState
