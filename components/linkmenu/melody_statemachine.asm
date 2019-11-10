INCLUDE "telefang.inc"

SECTION "Link Menu Melo-D Transfer Screen State Machine", ROMX[$70E2], BANK[$1F]
LinkMenu_MeloDStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	cp $C
	jr z, .checkConnectionErrorState
	cp $D
	jr z, .checkConnectionErrorState
	cp 1
	jr z, .checkConnectionErrorState
	cp 3
	jr z, .checkConnectionErrorState
	cp 5
	jr z, .checkConnectionErrorState
	cp 6
	jr z, .checkConnectionErrorState
	cp 7
	jr nz, .dontFireConnectionErrorState

.checkConnectionErrorState
	call $461B
	ld a, [Malias_CmpSrcBank]
	or a
	jr z, .dontFireConnectionErrorState
	ld a, 5
	ld [W_Sound_NextSFXSelect], a
	ld a, 4
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, $A
	ld [W_Battle_4thOrderSubState], a

.dontFireConnectionErrorState
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkMenu_StateMeloDDrawScreen
	dw LinkMenu_StateMeloDCheckCurrentScreenResponse
	dw LinkMenu_StateMeloDBranchViaSendReceiveSelection
	dw LinkMenu_StateMeloDWillNowTransferMessage
	dw LinkMenu_StateMeloDOpenSendScreen
	dw LinkMenu_StateMeloDWaitForTransfer
	dw LinkMenu_StateMeloDReceive
	dw LinkMenu_StateMeloDReceiveSomeMore
	dw LinkMenu_StateMeloDDataReceivedMessage
	dw LinkMenu_StateMeloDOpenReceiveScreen
	dw LinkMenu_StateMeloDConnectionLost
	dw LinkMenu_StateMeloDFadeIn
	dw LinkMenu_StateMeloDAdvertiseCurrentScreen
	dw LinkMenu_StateMeloDSendReceiveInputHandler
	dw LinkMenu_StateMeloDCheckSendReceiveSelection

LinkMenu_StateMeloDDrawScreen::
	ld bc, 2
	call Banked_CGBLoadBackgroundPalette
	ld a, $82
	ld [$CA65], a
	ld bc, 0
	ld e, $61
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $61
	xor a
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $500
	ld e, $BE
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, $500
	ld e, $BE
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld a, $C3
	ld [W_ShadowREG_LCDC], a
	xor a
	ld [W_ShadowREG_SCX], a
	ld [W_ShadowREG_SCY], a
	ld [W_ShadowREG_WX], a
	ld [W_ShadowREG_WY], a
	call LinkMenu_ADVICE_LoadSGBFilesConnection
	call Status_ExpandNumericalTiles
	ld c, $72
	call LinkMenu_ClearTilesAndQueueMessage
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $B
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateMeloDFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateMeloDAdvertiseCurrentScreen::
	call Battle_ReadByteFromRecvBuffer
	cp 0
	jr nz, .connectionFound
	call Banked_MainScriptMachine
	ret

.connectionFound
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, [hl]
	cp 3
	jr z, .validConnection
	ld a, 8
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, $A
	ld [W_Battle_4thOrderSubState], a
	ret

.validConnection
	ld a, [W_SaveClock_SaveCheckPassed]
	or a
	jr z, .hasSaveData
	ld a, 7
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, $FF
	ld [W_SerIO_ProcessOutByte], a
	ld a, $A
	ld [W_Battle_4thOrderSubState], a
	ret

.hasSaveData
	ld a, $F0
	ld [W_SerIO_ProcessOutByte], a
	ld a, 1
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateMeloDCheckCurrentScreenResponse::
	call Battle_ReadByteFromRecvBuffer
	cp 0
	ret z
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, [hl]
	cp $F0
	jp z, .validResponse
	ld a, 8
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, $A
	ld [W_Battle_4thOrderSubState], a
	ret

.validResponse
	ld c, $C4
	call LinkMenu_ClearTilesAndQueueMessage
	call $60EC
	ld a, $20
	ld [W_LCDC_MetaspriteAnimationBank], a
	xor a
	ld [W_Victory_UserSelection], a
	call SerIO_PlaceChoiceCursor
	ld a, 0
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	ld a, $D
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateMeloDSendReceiveInputHandler::
	call LCDC_IterateAnimationComplex
	call Banked_MainScriptMachine
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .wrapToRight
	ld a, 0
	ld [W_Victory_UserSelection], a
	jr .placeCursor

.wrapToRight
	ld a, 1
	ld [W_Victory_UserSelection], a
	jr .placeCursor

.leftNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .wrapToLeft
	ld a, 1
	ld [W_Victory_UserSelection], a
	jr .placeCursor

.wrapToLeft
	ld a, 0
	ld [W_Victory_UserSelection], a

.placeCursor
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp SerIO_PlaceChoiceCursor

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr z, .bNotPressed

.receiveSelected
	ld a, 1
	ld [W_Victory_UserSelection], a
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	jr .continue

.bNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .receiveSelected

.sendSelected
	ld a, 3
	ld [W_Sound_NextSFXSelect], a

.continue
	xor a
	ld [W_MetaSpriteConfig1], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_Victory_UserSelection]
	inc a
	ld [W_SerIO_ProcessOutByte], a
	ld c, $72
	call LinkMenu_ClearTilesAndQueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateMeloDCheckSendReceiveSelection::
	call Battle_ReadByteFromRecvBuffer
	cp 0
	jr nz, .connectionFound
	call Banked_MainScriptMachine
	ret

.connectionFound
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, [W_Victory_UserSelection]
	inc a
	ld [W_Victory_UserSelection], a
	ld a, [hl]
	cp 1
	jp z, .linkBuddySelectedSend
	ld a, [W_Victory_UserSelection]
	ld b, a
	ld a, [hl]
	cp b
	jr z, .selectedSameOption
	ld a, 1
	ld [W_Battle_OpponentUsingLinkCable], a
	jr .nextState

.linkBuddySelectedSend
	ld a, [W_Victory_UserSelection]
	ld b, a
	ld a, [hl]
	cp b
	jr z, .selectedSameOption
	ld a, 0
	ld [W_Battle_OpponentUsingLinkCable], a

.nextState
	ld a, 2
	ld [W_Battle_4thOrderSubState], a
	ret

.selectedSameOption
	ld a, 8
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, $A
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateMeloDBranchViaSendReceiveSelection::
	ld bc, $1C4
	ld hl, W_PauseMenu_ContactsArray

.loop
	ld [hl], $FE
	inc hl
	dec bc
	jr nz, .loop
	ld a, [W_Battle_OpponentUsingLinkCable]
	cp 1
	jr z, .selectedSend

.selectedReceive
	ld c, $82
	call LinkMenu_ClearTilesAndQueueMessage
	xor a
	ld [W_Battle_LoopIndex], a
	ld a, 5
	ld [W_Battle_4thOrderSubState], a
	ret

.selectedSend
	ld c, $83
	call LinkMenu_ClearTilesAndQueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateMeloDWillNowTransferMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateMeloDOpenSendScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	xor a
	call LinkMenu_ADVICE_SGBResetTextStyle
	jp Battle_IncrementSubSubState

LinkMenu_StateMeloDWaitForTransfer::
	call Banked_MainScriptMachine
	call Battle_ReadByteFromRecvBuffer
	cp $F0
	ret nz
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld c, $93
	call LinkMenu_ClearTilesAndQueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateMeloDReceive::
	call Banked_MainScriptMachine
	call Battle_ReadByteFromRecvBuffer
	cp 0
	ret z
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	push hl
	ld hl, W_PauseMenu_ContactsArray
	ld d, 0
	ld a, [W_Battle_LoopIndex]
	ld e, a
	add hl, de
	pop de
	ld a, [de]
	ld [hl], a
	ld a, [W_Battle_LoopIndex]
	cp $FF
	jr z, .finishedReceiving
	ld a, [W_Battle_LoopIndex]
	inc a
	ld [W_Battle_LoopIndex], a
	ret

.finishedReceiving
	xor a
	ld [W_Battle_LoopIndex], a
	ld a, $FF
	ld [$D45B], a
	ld hl, W_PauseMenu_ContactsArray

.decrementArrayItemsLoop
	ld a, [hl]
	cp $FE
	jr z, .doNotDecrement
	dec [hl]

.doNotDecrement
	inc hl
	ld a, [$D45B]
	dec a
	ld [$D45B], a
	jr nz, .decrementArrayItemsLoop
	ld a, $FF
	ld [W_SerIO_ProcessOutByte], a
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateMeloDReceiveSomeMore::
	call Banked_MainScriptMachine
	call Battle_ReadByteFromRecvBuffer
	cp 0
	ret z
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	push hl
	ld hl, W_PauseMenu_ContactsArray + $FF
	ld d, 0
	ld a, [W_Battle_LoopIndex]
	ld e, a
	add hl, de
	pop de
	ld a, [de]
	ld [hl], a
	ld a, [W_Battle_LoopIndex]
	cp $E2
	jr z, .finishedReceiving
	ld a, [W_Battle_LoopIndex]
	inc a
	ld [W_Battle_LoopIndex], a
	ret

.finishedReceiving
	ld a, $FF
	ld [$D45B], a
	ld hl, W_PauseMenu_ContactsArray + $FF

.decrementArrayItemsLoop
	ld a, [hl]
	cp $FE
	jr z, .doNotDecrement
	dec [hl]

.doNotDecrement
	inc hl
	ld a, [$D45B]
	dec a
	ld [$D45B], a
	jr nz, .decrementArrayItemsLoop
	ld a, $FF
	ld [W_SerIO_ProcessOutByte], a
	ld c, $88
	call LinkMenu_ClearTilesAndQueueMessage
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	xor a
	ld [W_Battle_LoopIndex], a
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateMeloDDataReceivedMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateMeloDOpenReceiveScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	xor a
	call LinkMenu_ADVICE_SGBResetTextStyle
	ld a, 2
	ld [W_Battle_SubSubState], a
	ret

LinkMenu_StateMeloDConnectionLost::
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld a, 0
	ld [W_Battle_SubSubState], a
	ld a, 4
	ld [W_SystemSubState], a
	ret

LinkMenu_ClearTilesAndQueueMessage::
	ld b, 0
	ld d, $C
	ld a, $80
	ld [W_MainScript_TileBaseIdx], a
	jp $0520
