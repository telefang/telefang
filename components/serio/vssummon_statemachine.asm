INCLUDE "telefang.inc"

SECTION "VsSummon Memory 1", WRAMX[$D42E], BANK[1]
W_VsSummon_NumContactsSelected:: ds 1

SECTION "VsSummon Memory 2", WRAMX[$D4BA], BANK[1]
W_VsSummon_SelectionBuffer:: ds 6

SECTION "VsSummon Memory 3", WRAMX[$D5D0], BANK[1]
W_VsSummon_ParticipantStatisticsBuffer:: ds $10

SECTION "Link Comms Vs-Mode Summon Screen Machine", ROMX[$48F1], BANK[$1F]
SerIO_VsSummonStateMachine::
    ld a, [W_Battle_4thOrderSubState]
    cp $C
    jr z, .runSubstate
    cp $B
    jr z, .runSubstate
    
    call $461B
    
    ld a, [Malias_CmpSrcBank]
    or a
    jr z, .runSubstate
    
    ld c, M_Battle_MessageConnectionError
    call Battle_QueueMessage
    
    ld a, $C
    ld [W_Battle_4thOrderSubState], a
    
.runSubstate
    ld a, [W_Battle_4thOrderSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl
    
.stateTable
    dw VsSummon_StateInitialiseVariables
    dw VsSummon_StateFadeInAndDrawArrows
    dw VsSummon_StateDetermineWhoGetsFirstTurn
    dw VsSummon_StateQueueSelectUpToMessage
    dw VsSummon_StateInputHandler
    dw VsSummon_StateDrawSelectedContactPortrait
    dw VsSummon_StateDisplaySelectedContactPortrait
    dw VsSummon_StatePrintConfirmationDialogue
    dw VsSummon_StateConfirmationInputHandler
    dw VsSummon_StatePrepareFadeOut
    dw VsSummon_StateEnterBattle
    dw VsSummon_StateConnectionErrorExitToTitlemenu
    dw VsSummon_StateConnectionError
    dw VsSummon_StateFetchPartnerParticipantStatistics
    dw VsSummon_StateReceiveOpponentTeamStats
    dw VsSummon_StateSendPartnerTeamStats
    dw VsSummon_StateOpenDenjuuStatusScreen
    dw VsSummon_StateWaitForOpponent
    dw VsSummon_StateFadeOutAndDrawScreen

SerIO_VsSummonPrivateString_Page::
;"リスト" - $493F
    db $28, $0D, $14, 0, 0
    
SerIO_VsSummonPrivateString_Separator::
;"/" - $4944
    db $CB, 0, 0

VsSummon_StateInitialiseVariables::
    ld hl, W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantSpecies
    call $5AFA
    ld hl, W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantSpecies
    call $5AFA
    ld hl, W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantSpecies
    call $5AFA
    ld hl, W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantSpecies
    call $5AFA
    ld hl, W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantSpecies
    call $5AFA
    ld hl, W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantSpecies
    call $5AFA
    ld a, 3
    ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantLocation], a
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantLocation], a
    ld a, 0
    ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLocation], a
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLocation], a
    ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantLocation], a
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantLocation], a
    ld a, 0
    ld [$D5A8], a
    ld a, 2
    ld [$D4E5], a
    ld a, 1
    ld [W_Battle_NumActivePartners], a
    ld a, 1
    ld [W_Battle_NumActiveOpponents], a
    xor a
    ld [W_VsSummon_ParticipantStatisticsBuffer + 0], a
    ld [W_VsSummon_ParticipantStatisticsBuffer + 1], a
    ld [W_VsSummon_ParticipantStatisticsBuffer + 2], a
    ld [W_VsSummon_ParticipantStatisticsBuffer + 3], a
    ld [W_VsSummon_ParticipantStatisticsBuffer + 4], a
    xor a
    ld [W_Battle_PartnerDenjuuTurnOrder], a
    ld [W_Battle_OpponentDenjuuTurnOrder], a
    inc a
    ld [$D475], a
    ld [$D478], a
    inc a
    ld [$D476], a
    ld [$D479], a
    xor a
    ld [$D412], a
    ld [$D4EA], a
    xor a
    ld [W_ShadowREG_SCX], a
    ld [W_ShadowREG_SCY], a
    ld [W_ShadowREG_WX], a
    ld [W_ShadowREG_WY], a
    ld [W_VsSummon_NumContactsSelected], a
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    ld [W_VsSummon_SelectionBuffer + 0], a
    ld [W_VsSummon_SelectionBuffer + 1], a
    ld [W_VsSummon_SelectionBuffer + 2], a
    ld [W_VsSummon_SelectionBuffer + 3], a
    ld [W_VsSummon_SelectionBuffer + 4], a
    ld [W_VsSummon_SelectionBuffer + 5], a
    ld [$D5BA], a
    ld [$D5BB], a
    ld [$D5BC], a
    ld [$D5BD], a
    ld [$D5BE], a
    ld [$D5BF], a
    ld [$D5C0], a
    ld [$D5C1], a
    ld [$D5C2], a
    ld [$D5C3], a
    ld [$D5C4], a
    ld [$D5C5], a
    ld [$D5CA], a
    ld [$D5CB], a
    ld [$D5CC], a
    ld [$D49D], a
    ld [$D49E], a
    ld [$D49F], a
    ld [$D4A8], a
    ld [$D4A9], a
    ld [$D4AA], a
    ld [$D450], a
    ld [$D451], a
    ld [$D452], a
    ld [$D453], a
    ld [$D430], a
    ld [$D431], a
    ld [$D432], a
    ld [$D433], a
    ld a, [W_Encounter_AlreadyInitialized]
    cp 1
    jp z, .skipInitialisation
    xor a
    ld [W_Summon_SelectedPageContact], a
    ld [W_Summon_CurrentPage], a
    ld [W_Summon_MaxPages], a
    ld a, 3
    ld [W_Summon_MaxRemainingParticipantsForSelection], a
    ld [W_Summon_RemainingParticipantsForSelection], a
    call SaveClock_EnterSRAM2
    ld hl, $A001
    ld de, $10

; The rest of the code in this substate is abysmal.
    ld b, 0
    ld a, $FE
    ld c, a
    ld a, b
    cp 0
    jr z, .jrZThatAlwaysFires

.countContactsLoop
    add hl, de

.jrZThatAlwaysFires
    ld a, [hl]
    cp 0
    jr z, .emptySlot
    inc b

.emptySlot
    dec c
    ld a, c
    jr nz, .countContactsLoop
    ld a, b
    ld [W_Victory_ContactsPresent], a
    call $5620
    ld a, [W_Status_NumDuplicateDenjuu]
    dec a
    ld b, 0
    ld a, a ; Why would anyone do this?
    ld c, a
    ld d, 0
    ld a, 3
    ld e, a
    call $0628
    ld a, c
    ld [W_Summon_MaxPages], a
    call $5602
    call $555F

.skipInitialisation
    call SaveClock_ExitSRAM
    ld a, 1
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $12
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StateFadeOutAndDrawScreen::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, [W_Encounter_AlreadyInitialized]
    cp 1
    jr nz, .skipDuringInitialRun
    ld bc, $15
    call Banked_LoadMaliasGraphics

.skipDuringInitialRun
    ld bc, $12
    call Banked_CGBLoadBackgroundPalette
    ld a, $28
    call PauseMenu_CGBStageFlavorPalette
    ld bc, $15
    call Banked_LoadMaliasGraphics
    ld hl, $8800
    call $556B
    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    ld hl, $390
    add hl, de
    push hl
    pop bc
    xor a
    call CGBLoadBackgroundPaletteBanked
    ld a, 0
    call Banked_Status_LoadUIGraphics
    ld a, 5
    ld [$CA65], a
    ld hl, $9400
    ld a, $20
    call MainScript_DrawEmptySpaces
    ld bc, 0
    ld e, $D
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, 0
    ld e, $D
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    ld bc, 0
    ld e, $B7
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, $105
    ld e, $8C
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    ld hl, $9882
    ld a, 3
    call $559A
    ld de, SerIO_VsSummonPrivateString_Page
    ld hl, $9100
    ld b, 8
    call Banked_MainScript_DrawStatusText
    ld a, [W_Summon_MaxPages]
    inc a
    ld hl, $9831
    ld c, 1
    call Encounter_DrawTileDigits
    call $5694
    call $5796
    call SerIO_SummonDrawNicknames
    call $5905
    call SaveClock_EnterSRAM2
    ld a, [W_Summon_SelectedPageContact]
    ld d, a
    call SerIO_IndexContactArrayByPage
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
    call SaveClock_ExitSRAM
    ld a, $13
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, 1
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StateFadeInAndDrawArrows::
    ld a, 0
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, [W_Summon_MaxPages]
    cp 1
    jr c, .noPageArrowsRequired
    call $5A8D

.noPageArrowsRequired
    call $58CE
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    ld a, 0
    ld bc, 4
    call CGBLoadObjectPaletteBanked
    ld a, 1
    ld [W_CGBPaletteStagedOBP], a
    ld a, [W_Encounter_AlreadyInitialized]
    cp 1
    jr nz, .branchOnInitialRun
    xor a
    ld [W_Encounter_AlreadyInitialized], a
    ld a, 3
    ld [W_Battle_4thOrderSubState], a
    ret

.branchOnInitialRun
    jp SerIO_Increment4thOrderSubState

VsSummon_StateDetermineWhoGetsFirstTurn::
    ld a, [W_SerIO_SentMysteryPacket]
    cp 0
    jr z, .noFirstTurn
    ld a, 1
    ld [W_Battle_OpponentUsingLinkCable], a
    jr .exit

.noFirstTurn
    ld a, 0
    ld [W_Battle_OpponentUsingLinkCable], a

.exit
    jp SerIO_Increment4thOrderSubState

VsSummon_StateQueueSelectUpToMessage::
    ld h, 0
    ld a, 3
    ld l, a
    call Battle_MessageNumbersToText
    ld c, $6A
    call Battle_QueueMessage
    jp SerIO_Increment4thOrderSubState

VsSummon_StateInputHandler::
    call LCDC_IterateAnimationComplex
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Up
    jr z, .upNotPressed
    ld a, [W_Summon_SelectedPageContact]
    cp 0
    jr z, .upNotPressed
    dec a
    ld [W_Summon_SelectedPageContact], a
    jr .changeSelectedContact

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

.changeSelectedContact
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, 5
    ld [W_Battle_4thOrderSubState], a
    ret

.downNotPressed
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Left
    jr z, .leftNotPressed
    ld a, [W_Summon_MaxPages]
    cp 0
    jp z, .rightNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Summon_CurrentPage]
    cp 0
    jr z, .lastPagePlz
    dec a
    ld [W_Summon_CurrentPage], a
    jr .changePage

.lastPagePlz
    ld a, [W_Summon_MaxPages]
    ld [W_Summon_CurrentPage], a
    jr .changePage

.leftNotPressed
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Right
    jp z, .rightNotPressed
    ld a, [W_Summon_MaxPages]
    cp 0
    jp z, .rightNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Summon_MaxPages]
    ld b, a
    ld a, [W_Summon_CurrentPage]
    cp b
    jr z, .firstPagePlz
    inc a
    ld [W_Summon_CurrentPage], a
    jr .changePage

.firstPagePlz
    ld a, 0
    ld [W_Summon_CurrentPage], a

.changePage
    xor a
    ld [W_Summon_SelectedPageContact], a
    ld a, 0
    ld [W_MetaSpriteConfig1], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld hl, $9400
    ld a, $18
    call MainScript_DrawEmptySpaces
    call $555F
    call $5602
    call $5694
    call $5796
    call SerIO_SummonDrawNicknames
    call SaveClock_ExitSRAM
    xor a
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    call $596C
    call $597C
    ld a, 5
    ld [W_Battle_4thOrderSubState], a
    ret

.rightNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    jp z, .aNotPressed
    ld a, [W_VsSummon_NumContactsSelected]
    cp 0
    jr nz, .notFirstSelection
    ld a, 1
    ld [W_VsSummon_SelectionBuffer + 0], a
    ld a, [W_Summon_CurrentPage]
    ld [W_VsSummon_SelectionBuffer + 1], a
    ld a, [W_Summon_SelectedPageContact]
    ld [W_VsSummon_SelectionBuffer + 2], a
    jr .checkSelection

.notFirstSelection
    ld a, 1
    ld [W_VsSummon_SelectionBuffer + 3], a
    ld a, [W_Summon_CurrentPage]
    ld [W_VsSummon_SelectionBuffer + 4], a
    ld a, [W_Summon_SelectedPageContact]
    ld [W_VsSummon_SelectionBuffer + 5], a

.checkSelection
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
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
    call $5949
    ld a, [$CB00]
    ld [W_Status_SelectedContactIndex], a
    ld a, [W_Summon_RemainingParticipantsForSelection]
    dec a
    ld [W_Summon_RemainingParticipantsForSelection], a
    call $59FD
    ld a, [W_VsSummon_NumContactsSelected]
    inc a
    ld [W_VsSummon_NumContactsSelected], a
    jp .repositionSelectorArrow

.contactBOfPageSelected
    ld a, [W_Summon_ContactBOfCurrentPageSelected]
    cp 1
    jp z, .queueConfirmationMessage
    ld a, 1
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld a, 1
    call $5949
    ld a, [$CB00]
    ld [W_Status_SelectedContactIndex], a
    ld a, [W_Summon_RemainingParticipantsForSelection]
    dec a
    ld [W_Summon_RemainingParticipantsForSelection], a
    call $59FD
    ld a, [W_VsSummon_NumContactsSelected]
    inc a
    ld [W_VsSummon_NumContactsSelected], a
    jp .repositionSelectorArrow

.contactCOfPageSelected
    ld a, [W_Summon_ContactCOfCurrentPageSelected]
    cp 1
    jp z, .queueConfirmationMessage
    ld a, 1
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    ld a, 2
    call $5949
    ld a, [$CB00]
    ld [W_Status_SelectedContactIndex], a
    ld a, [W_Summon_RemainingParticipantsForSelection]
    dec a
    ld [W_Summon_RemainingParticipantsForSelection], a
    call $59FD
    ld a, [W_VsSummon_NumContactsSelected]
    inc a
    ld [W_VsSummon_NumContactsSelected], a

.repositionSelectorArrow
    ld a, [W_VsSummon_NumContactsSelected]
    cp 3
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
    ld a, 5
    ld [W_Battle_4thOrderSubState], a

.dontReposition
    ret

.aNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed
    ld a, 0
    ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLocation], a
    ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantLocation], a
    ld a, 0
    ld [W_VsSummon_NumContactsSelected], a
    xor a
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    call $596C
    xor a
    ld [W_VsSummon_SelectionBuffer + 0], a
    ld [W_VsSummon_SelectionBuffer + 1], a
    ld [W_VsSummon_SelectionBuffer + 2], a
    ld [W_VsSummon_SelectionBuffer + 3], a
    ld [W_VsSummon_SelectionBuffer + 4], a
    ld [W_VsSummon_SelectionBuffer + 5], a
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
    ld a, [W_VsSummon_NumContactsSelected]
    cp 0
    jr z, .startNotPressed
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
    ld a, $10
    ld [W_Battle_4thOrderSubState], a
    ret

.selectNotPressed
    call Banked_MainScriptMachine
    ret

.queueConfirmationMessage
    ld c, $1E
    call Battle_QueueMessage
    xor a
    ld [W_Victory_UserSelection], a
    call SerIO_PlaceChoiceCursor
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    ld a, 7
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StateDrawSelectedContactPortrait::
    ld bc, $105
    ld e, $8B
    ld a, 0
    call Banked_RLEDecompressTMAP0
    call SaveClock_EnterSRAM2
    ld a, [W_Summon_SelectedPageContact]
    ld d, a
    call SerIO_IndexContactArrayByPage
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
    jp SerIO_Increment4thOrderSubState

VsSummon_StateDisplaySelectedContactPortrait::
    ld bc, $105
    ld e, $92
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, $105
    ld e, $8C
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    call $58CE
    ld a, 4
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StatePrintConfirmationDialogue::
    call Banked_MainScriptMachine
    ld a, [W_Battle_LoopIndex]
    inc a
    ld [W_Battle_LoopIndex], a
    cp $A
    ret c
    xor a
    ld [W_Battle_LoopIndex], a
    jp SerIO_Increment4thOrderSubState

VsSummon_StateConfirmationInputHandler::
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
    jp SerIO_PlaceChoiceCursor

.rightNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed
    jp .noSelected

.bNotPressed
    call LCDC_IterateAnimationComplex
    call Banked_MainScriptMachine
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    jr z, .aNotPressed
    ld a, [W_Victory_UserSelection]
    cp 0
    jr z, .yesSelected

.noSelected
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    xor a
    ld [W_VsSummon_NumContactsSelected], a
    ld [W_VsSummon_SelectionBuffer + 0], a
    ld [W_VsSummon_SelectionBuffer + 1], a
    ld [W_VsSummon_SelectionBuffer + 2], a
    ld [W_VsSummon_SelectionBuffer + 3], a
    ld [W_VsSummon_SelectionBuffer + 4], a
    ld [W_VsSummon_SelectionBuffer + 5], a
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    call $596C
    call $58CE
    ld c, $6A
    call Battle_QueueMessage
    ld a, 4
    ld [W_Battle_4thOrderSubState], a
    ret

.aNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    ret z
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .noSelected

.yesSelected
    ld a, [W_VsSummon_NumContactsSelected]
    cp 1
    jr z, .oneSelected
    cp 2
    jr z, .twoSelected
    cp 3
    jr z, .threeSelected

.twoSelected
    ld a, 1
    ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLocation], a
    jr .oneSelected

.threeSelected
    ld a, 1
    ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLocation], a
    ld [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantLocation], a

.oneSelected
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    xor a
    ld [W_MetaSpriteConfig1], a
    ld [$C120], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    xor a
    ld [W_Battle_LoopIndex], a
    xor a
    ld [$D45B], a
    ld a, [W_VsSummon_NumContactsSelected]
    ld [W_SerIO_ProcessOutByte], a
    ld c, $72
    call Battle_QueueMessage
    ld a, $11
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StateWaitForOpponent::
    ld hl, W_SerIO_RecvBuffer
    ld a, [W_Battle_NextSerIOByteIn]
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hl]
    cp 0
    jr nz, .loc_4FA9
    call Banked_MainScriptMachine
    ret

.loc_4FA9
    ld a, [hl]
    ld [$D42F], a
    ld [$D5C7], a
    ld a, [W_Battle_NextSerIOByteIn]
    inc a
    ld [W_Battle_NextSerIOByteIn], a
    ld a, $D
    ld [W_Battle_4thOrderSubState], a
    ret
 
VsSummon_StateConnectionError::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    call SerIO_ResetConnection
    ld a, $10
    ld [$CF96], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $B
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StateFetchPartnerParticipantStatistics::
    ld hl, W_VsSummon_ParticipantStatisticsBuffer
    ld b, $10

.bufferClearLoop
    ld a, 0
    ldi [hl], a
    dec b
    jr nz, .bufferClearLoop
    call SaveClock_EnterSRAM2
    ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantContactID]
    ld hl, S_SaveClock_StatisticsArray
    call Battle_IndexStatisticsArray
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 0], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 1], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 2], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 3], a
    ld a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 4], a
    ld a, [W_VsSummon_NumContactsSelected]
    cp 1
    jr z, .noMoreDenjuuToParse
    call SaveClock_EnterSRAM2
    ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantContactID]
    ld hl, S_SaveClock_StatisticsArray
    call Battle_IndexStatisticsArray
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 5], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 6], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 7], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + 8], a
    ld a, $20
    ld [W_VsSummon_ParticipantStatisticsBuffer + 9], a
    ld a, [W_VsSummon_NumContactsSelected]
    cp 2
    jr z, .noMoreDenjuuToParse
    call SaveClock_EnterSRAM2
    ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantContactID]
    ld hl, S_SaveClock_StatisticsArray
    call Battle_IndexStatisticsArray
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + $A], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + $B], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + $C], a
    ldi a, [hl]
    ld [W_VsSummon_ParticipantStatisticsBuffer + $D], a
    ld a, $20
    ld [W_VsSummon_ParticipantStatisticsBuffer + $E], a

.noMoreDenjuuToParse
    ld a, $EC
    ld [W_VsSummon_ParticipantStatisticsBuffer + $F], a
    call SaveClock_ExitSRAM
    xor a
    ld [W_Battle_LoopIndex], a
    ld a, $F
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StateSendPartnerTeamStats::
    ld hl, W_VsSummon_ParticipantStatisticsBuffer
    ld d, 0
    ld a, [W_Battle_LoopIndex]
    ld e, a
    add hl, de
    ld a, [hl]
    inc a
    ld [W_SerIO_ProcessOutByte], a
    ld a, [W_Battle_LoopIndex]
    inc a
    ld [W_Battle_LoopIndex], a
    cp $10
    ret nz
    ld a, $E
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StateReceiveOpponentTeamStats::
    ld hl, W_SerIO_RecvBuffer
    ld a, [W_Battle_NextSerIOByteIn]
    add $F
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hl]
    cp $ED
    jr z, .aRetNZWouldHaveWorkedBetter
    ret

.aRetNZWouldHaveWorkedBetter
    ld de, W_VsSummon_ParticipantStatisticsBuffer
    ld a, 0
    ld [W_Battle_LoopIndex], a
    ld a, [W_Battle_NextSerIOByteIn]
    ld c, a

.copyLoop
    ld hl, W_SerIO_RecvBuffer
    ld b, 0
    add hl, bc
    push de
    push bc
    ld bc, 1
    call memcpy
    pop bc
    inc c
    pop de
    inc de
    ld a, [W_Battle_LoopIndex]
    inc a
    ld [W_Battle_LoopIndex], a
    cp $F
    jr nz, .copyLoop
    ld hl, W_VsSummon_ParticipantStatisticsBuffer
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantSpecies], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantLevel], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 0) + $A], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantPersonality], a
    inc hl
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantSpecies], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLevel], a
    cp 0
    jr z, .loc_5120
    ld a, 1
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLocation], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + $A], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantPersonality], a
    dec [hl]
    inc hl
    ld a, $20
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantMaxArrivalTime], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantSpecies], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantLevel], a
    cp 0
    jr z, .loc_5120
    ld a, 1
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantLocation], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + $A], a
    dec [hl]
    ldi a, [hl]
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantPersonality], a
    dec [hl]
    inc hl
    ld a, $20
    ld [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantMaxArrivalTime], a

.loc_5120
    ld a, [W_Battle_NextSerIOByteIn]
    add $F
    inc a
    ld [W_Battle_NextSerIOByteIn], a
    ld a, 9
    ld [W_Battle_4thOrderSubState], a
    ret

VsSummon_StatePrepareFadeOut::
    ld a, $10
    ld [$CF96], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp SerIO_Increment4thOrderSubState

VsSummon_StateEnterBattle::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, 2
    ld [$D4E5], a
    ld a, 1
    ld [W_Battle_NumActivePartners], a
    ld a, 1
    ld [W_Battle_NumActiveOpponents], a
    ld a, [W_VsSummon_NumContactsSelected]
    ld [$D5C6], a
    ld hl, W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantSpecies
    call $524D
    ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLevel]
    cp 0
    jr z, .noMorePartnerParticipants
    ld hl, W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantSpecies
    call $524D
    ld a, [W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantLevel]
    cp 0
    jr z, .noMorePartnerParticipants
    ld hl, W_Battle_PartnerParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantSpecies
    call $524D

.noMorePartnerParticipants
    ld hl, W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 0) + M_Battle_ParticipantSpecies
    call $524D
    ld a, [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantLevel]
    cp 0
    jr z, .noMoreOpponentParticipants
    ld hl, W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 1) + M_Battle_ParticipantSpecies
    call $524D
    ld a, [W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantLevel]
    cp 0
    jr z, .noMoreOpponentParticipants
    ld hl, W_Battle_OpponentParticipants + (M_Battle_ParticipantSize * 2) + M_Battle_ParticipantSpecies
    call $524D

.noMoreOpponentParticipants
    ld a, 1
    ld [W_Status_UseDenjuuNickname], a
    xor a
    ld [W_SerIO_IdleCounter], a
    xor a
    ld [W_VsSummon_NumContactsSelected], a
    ld [W_VsSummon_SelectionBuffer + 0], a
    ld [W_VsSummon_SelectionBuffer + 1], a
    ld [W_VsSummon_SelectionBuffer + 2], a
    ld [W_VsSummon_SelectionBuffer + 3], a
    ld [W_VsSummon_SelectionBuffer + 4], a
    ld [W_VsSummon_SelectionBuffer + 5], a
    ld [W_Summon_ContactAOfCurrentPageSelected], a
    ld [W_Summon_ContactBOfCurrentPageSelected], a
    ld [W_Summon_ContactCOfCurrentPageSelected], a
    call $596C
    xor a
    ld [W_SystemSubState], a
    ld [W_Battle_SubSubState], a
    ld [W_Battle_4thOrderSubState], a
    ld a, 7
    ld [W_SystemState], a
    ret

VsSummon_StateConnectionErrorExitToTitlemenu::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    call $06BC
    xor a
    ld [W_Battle_4thOrderSubState], a
    ld [W_Battle_SubSubState], a
    ld [W_SystemSubState], a
    ld a, 3
    ld [W_SystemState], a
    ret

VsSummon_StateOpenDenjuuStatusScreen::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, 1
    ld [W_Status_UseDenjuuNickname], a
    ld a, 0
    ld [W_MetaSpriteConfig1], a
    ld [$C120], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    call $596C
    ld a, [W_Summon_SelectedPageContact]
    ld d, a
    call SerIO_IndexCurrentContactPage
    ld [W_Status_SelectedContactIndex], a
    call SaveClock_EnterSRAM2
    ld a, [W_Summon_SelectedPageContact]
    ld d, a
    call SerIO_IndexContactArrayByPage
    ld hl, S_SaveClock_StatisticsArray
    call Battle_IndexStatisticsArray
    ldi a, [hl]
    ld [W_Status_SelectedDenjuuSpecies], a
    ldi a, [hl]
    ld [W_Status_SelectedDenjuuLevel], a
    inc hl
    ld a, [hl]
    ld [W_Status_SelectedDenjuuPersonality], a
    call SaveClock_ExitSRAM
    xor a
    ld [W_Status_SubState], a
    ld a, 9
    ld [W_SystemState], a
    ret
