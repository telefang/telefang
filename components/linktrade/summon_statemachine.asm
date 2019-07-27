INCLUDE "telefang.inc"

SECTION "Link Trade Summon Screen State Machine", ROMX[$6546], BANK[$1F]
LinkTrade_SummonStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	cp 5
	jr z, .dontFireConnectionErrorState
	cp 6
	jr z, .dontFireConnectionErrorState
	call $461B
	ld a, [Malias_CmpSrcBank]
	or a
	jr z, .dontFireConnectionErrorState
	xor a
	ld [W_MetaSpriteConfig1], a
	ld [$C0C0], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld c, $74
	call Battle_QueueMessage
	ld a, 5
	ld [W_Battle_4thOrderSubState], a

.dontFireConnectionErrorState
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkTrade_StateInitialiseVariables
	dw LinkTrade_StateFadeInAndDrawArrows
	dw LinkTrade_StateInputHandler
	dw LinkTrade_StateDrawSelectedContactPortrait
	dw LinkTrade_StateDisplaySelectedContactPortrait
	dw LinkTrade_StateConnectionError
	dw LinkTrade_StateConnectionErrorExitToTitlemenu
	dw LinkTrade_StatePrintConfirmationDialogue
	dw LinkTrade_StateConfirmationInputHandler
	dw LinkTrade_StateParseContactForTrading
	dw LinkTrade_StatePerformExchange
	dw LinkTrade_StateParseTradedContact
	dw LinkTrade_StateFadeOutAndExit
	dw LinkTrade_StateOpenDenjuuStatusScreen
	dw LinkTrade_StateFadeOutAndDrawScreen

LinkTrade_StateInitialiseVariables::
	ld a, 0
	call VsSummon_ADVICE_DrawOkIndicator
	ld a, [W_PauseMenu_PhoneState]
	ld e, a
	ld d, 0
	ld hl, $390
	add hl, de
	push hl
	pop bc
	xor a
	call CGBLoadBackgroundPaletteBanked
	ld a, 5
	ld [$CA65], a
	xor a
	ld [W_ShadowREG_SCX], a
	ld [W_ShadowREG_SCY], a
	ld [W_ShadowREG_WX], a
	ld [W_ShadowREG_WY], a
	ld [W_VsSummon_NumContactsSelected], a
	ld [W_Summon_ContactAOfCurrentPageSelected], a
	ld [W_Summon_ContactBOfCurrentPageSelected], a
	ld [W_Summon_ContactCOfCurrentPageSelected], a
	ld [W_VsSummon_SelectionBuffer], a
	ld [W_VsSummon_SelectionBuffer + 1], a
	ld [W_VsSummon_SelectionBuffer + 2], a
	ld [W_VsSummon_SelectionBuffer + 3], a
	ld [W_VsSummon_SelectionBuffer + 4], a
	ld [W_VsSummon_SelectionBuffer + 5], a
	call VsSummon_ADVICE_ExitStatusScreen
	cp 1
	jp z, .skipInitialisation
	xor a
	ld [W_Summon_SelectedPageContact], a
	ld [W_Summon_CurrentPage], a
	ld [W_Summon_MaxPages], a
	xor a
	ld [W_Encounter_AlreadyInitialized], a
	call $6BE3
	call SaveClock_ExitSRAM
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
	call $5602
	call $555F

.skipInitialisation
	xor a
	ld [W_Encounter_AlreadyInitialized], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $E
	ld [W_Battle_4thOrderSubState], a
	ret

LinkTrade_StateFadeOutAndDrawScreen::
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
	call VsSummon_ADVICE_PrepareTextStyle
	ld a, $20
	call MainScript_DrawEmptySpaces
	ld bc, 0
	ld e, $D
	M_AuxJmp Banked_Summon_ADVICE_LoadSGBFiles
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
	call LinkTrade_ADVICE_DrawDenjuuIndicators
	call $6D1C
	call SerIO_SummonDrawNicknames
	call $5905
	ld c, $75
	call Battle_QueueMessage
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
	call VsSummon_ADVICE_LoadDenjuuPalette
	call SaveClock_ExitSRAM
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 1
	ld [W_Battle_4thOrderSubState], a
	ret

LinkTrade_StateFadeInAndDrawArrows::
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
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateInputHandler::
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
	ld a, 3
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
	call LinkTrade_ADVICE_DrawDenjuuIndicators
	call $6D1C
	call SerIO_SummonDrawNicknames
	xor a
	ld [W_Summon_ContactAOfCurrentPageSelected], a
	ld [W_Summon_ContactBOfCurrentPageSelected], a
	ld [W_Summon_ContactCOfCurrentPageSelected], a
	call $596C
	call $597C
	ld a, 3
	ld [W_Battle_4thOrderSubState], a
	ret

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	jp z, .aNotPressed
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
	jp .jpLeapfrog

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
	jp .jpLeapfrog

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

.jpLeapfrog
	jp .queueConfirmationMessage

.aNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr z, .bNotPressed
	xor a
	ld [W_Summon_ContactAOfCurrentPageSelected], a
	ld [W_Summon_ContactBOfCurrentPageSelected], a
	ld [W_Summon_ContactCOfCurrentPageSelected], a
	call $596C
	xor a
	ld [W_VsSummon_SelectionBuffer], a
	ld [W_VsSummon_SelectionBuffer + 1], a
	ld [W_VsSummon_SelectionBuffer + 2], a
	ld [W_VsSummon_SelectionBuffer + 3], a
	ld [W_VsSummon_SelectionBuffer + 4], a
	ld [W_VsSummon_SelectionBuffer + 5], a
	ld c, $75
	call Battle_QueueMessage
	ld a, 0
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
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
	ld a, $D
	ld [W_Battle_4thOrderSubState], a
	ret

.selectNotPressed
	call Banked_MainScriptMachine_InstantDisplayHack
	ret

.queueConfirmationMessage
	ld a, 0
	ld [W_MetaSpriteConfig1], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
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

LinkTrade_StateDrawSelectedContactPortrait::
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
	ld c, $01
	ld de, $8B80
	call Banked_Battle_LoadDenjuuPortrait
	pop af
	call VsSummon_ADVICE_LoadDenjuuPalette
	ld a, 1
	ld [W_CGBPaletteStagedBGP], a
	call SaveClock_ExitSRAM
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateDisplaySelectedContactPortrait::
	ld bc, $105
	ld e, $92
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, $105
	ld e, $8C
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	call $58CE
	ld a, 2
	ld [W_Battle_4thOrderSubState], a
	ret

LinkTrade_StateConnectionError::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	call SerIO_ResetConnection
	ld a, $10
	ld [$CF96], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateConnectionErrorExitToTitlemenu::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	call $06BC
	xor a
	call LinkVictory_ADVICE_OnExit
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret

LinkTrade_StatePrintConfirmationDialogue::
	call Banked_MainScriptMachine
	ld a, [W_Battle_LoopIndex]
	inc a
	ld [W_Battle_LoopIndex], a
	cp $A
	ret c
	xor a
	ld [W_Battle_LoopIndex], a
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateConfirmationInputHandler::
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
	and M_JPInput_Start
	jr z, .startNotPressed
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .yesSelected

.noSelected
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	xor a
	ld [W_VsSummon_NumContactsSelected], a
	ld [W_VsSummon_SelectionBuffer], a
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
	ld c, $75
	call Battle_QueueMessage
	ld a, 2
	ld [W_Battle_4thOrderSubState], a
	ret

.startNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .noSelected

.yesSelected
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	xor a
	ld [W_MetaSpriteConfig1], a
	ld [$C120], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	call $596C
	xor a
	ld [W_Battle_LoopIndex], a
	xor a
	ld [$D45B], a
	ld c, $72
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateParseContactForTrading::
	ld a, [W_Summon_SelectedPageContact]
	ld d, a
	call SerIO_IndexContactArrayByPage
	ld [W_Victory_DefectedContact], a
	call SaveClock_EnterSRAM2
	ld hl, S_SaveClock_StatisticsArray
	ld a, [W_Victory_DefectedContact]
	call Battle_IndexStatisticsArray
	ld de, $DC60
	ld bc, $10
	call memcpy
	call SaveClock_EnterSRAM2
	ld hl, S_SaveClock_NicknameArray
	ld a, [W_Victory_DefectedContact]
	ld de, 6
	cp 0
	jr z, .skipNicknameAddressLoop

.nicknameAddressLoop
	add hl, de
	dec a
	jr nz, .nicknameAddressLoop

.skipNicknameAddressLoop
	ld de, $DC70
	ld bc, 6
	call memcpy
	call SaveClock_EnterSRAM2
	ld hl, S_SaveClock_StatisticsArray
	ld a, [W_Victory_DefectedContact]
	call Battle_IndexStatisticsArray
	push hl
	ld a, [hli]
	call LinkTrade_ADVICE_RememberDefectedSpecies
	ld a, [hl]
	ld [W_Victory_DefectedContactLevel], a
	pop hl
	ld a, $10

.zeroFillLoop
	ld [hl], 0
	inc hl
	dec a
	jr nz, .zeroFillLoop
	ld a, [W_Victory_ContactsPresent]
	dec a
	ld [W_Victory_ContactsPresent], a
	ld a, [W_Victory_DefectedContact]
	ld c, a
	call $06A4
	ld a, 0
	ld [W_PauseMenu_CurrentContact], a
	ld hl, $9580
	ld a, 8
	call MainScript_DrawEmptySpaces
	ld hl, $9580
	ld a, [W_Victory_DefectedContact]
	call Status_DrawDenjuuNickname
	call SaveClock_ExitSRAM
	ld c, $72
	call Battle_QueueMessage
	xor a
	ld [W_Battle_LoopIndex], a
	jp SerIO_Increment4thOrderSubState

LinkTrade_StatePerformExchange::
	call Banked_MainScriptMachine
	ld hl, $DC60
	ld d, 0
	ld a, [W_Battle_LoopIndex]
	ld e, a
	add hl, de
	ld a, [hl]
	ld a, [hl]
	cp $FF
	jr z, .truncateFE
	inc a

.truncateFE
	ld [W_SerIO_ProcessOutByte], a
	ld a, [W_Battle_LoopIndex]
	inc a
	ld [W_Battle_LoopIndex], a
	cp $16
	ret nz
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateParseTradedContact::
	call Banked_MainScriptMachine
	ld hl, W_SerIO_RecvBuffer
	ld a, [W_Battle_NextSerIOByteIn]
	add $16
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp 0
	ret z
	ld de, $DC60
	ld a, 0
	ld [W_Battle_LoopIndex], a
	ld a, [W_Battle_NextSerIOByteIn]
	ld c, a

.copyLoopA
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
	cp $16
	jr nz, .copyLoopA
	ld hl, $DC60
	ld b, $16

.copyLoopB
	ld a, [hl]
	cp $FF
	jr z, .truncateFE
	dec a

.truncateFE
	ld [hli], a
	dec b
	jr nz, .copyLoopB
	call SaveClock_EnterSRAM2
	ld hl, $A001
	ld de, $10
	ld b, 0

.searchLoop
	add hl, de
	inc b
	ld a, [hl]
	cp 0
	jr nz, .searchLoop
	ld a, b
	ld [$D4A7], a
	ld a, [$D4A7]
	ld hl, S_SaveClock_StatisticsArray
	call Battle_IndexStatisticsArray
	ld d, h
	ld e, l
	ld hl, $DC60
	ld bc, $10
	call memcpy
	ld a, [$D4A7]
	ld hl, S_SaveClock_NicknameArray
	ld de, 6
	cp 0
	jr z, .skipNicknameAddressLoop

.nicknameAddressLoop
	add hl, de
	dec a
	jr nz, .nicknameAddressLoop

.skipNicknameAddressLoop
	ld d, h
	ld e, l
	ld hl, $DC70
	ld bc, 6
	call memcpy
	ld a, [W_Battle_NextSerIOByteIn]
	add $16
	ld [W_Battle_NextSerIOByteIn], a
	call SaveClock_EnterSRAM2
	ld a, [$D4A7]
	ld hl, $B800
	ld b, 0
	ld c, a
	add hl, bc
	ld [hl], $47
	call Banked_SaveClock_StoreWorkingStateToSaveData
	call SaveClock_ExitSRAM
	ld a, $10
	ld [$CF96], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp SerIO_Increment4thOrderSubState

LinkTrade_StateFadeOutAndExit::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	xor a
	call LinkTrade_ADVICE_UnloadSGBFiles
	jp Battle_IncrementSubSubState

LinkTrade_StateOpenDenjuuStatusScreen::
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
	ld a, [hli]
	ld [W_Status_SelectedDenjuuSpecies], a
	ld a, [hli]
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
