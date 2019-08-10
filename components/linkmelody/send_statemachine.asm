INCLUDE "telefang.inc"

SECTION "Link Melody Sending State Machine", ROMX[$743E], BANK[$1F]
LinkMelody_SendingStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	cp 2
	jr z, .checkConnectionErrorState
	cp 3
	jr z, .checkConnectionErrorState
	cp 5
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
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 4
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, $C
	ld [W_Battle_4thOrderSubState], a

.dontFireConnectionErrorState
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkMelody_StateDrawSendingScreen
	dw LinkMelody_StateSendingFadeIn
	dw LinkMelody_StateSendingInputHandler
	dw LinkMelody_StateSendingConfirmationInputHandler
	dw LinkMelody_StatePrepareForSending
	dw LinkMelody_StateTransmitRingtone
	dw LinkMelody_StateMidTransmitHandshake
	dw LinkMelody_StateTransmitRingtoneSomeMore
	dw LinkMelody_StatePostTransmitHandshake
	dw LinkMelody_StateSendingCompleteMessage
	dw LinkMelody_StateSendingFadeOut
	dw LinkMelody_StateSendingExit
	dw LinkMelody_StateSendingConnectionLost

LinkMelody_UnusedStrings::
	db 5, $28, $73, $15, $29, 0, $BB, $BC ; オリジナル 01
	db 5, $28, $73, $15, $29, 0, $BB, $BD ; オリジナル 02
	db 5, $28, $73, $15, $29, 0, $BB, $BE ; オリジナル 03
	db 5, $28, $73, $15, $29, 0, $BB, $BF ; オリジナル 04
	db 5, $28, $73, $15, $29, 0, $BB, $C0 ; オリジナル 05
	db 5, $28, $73, $15, $29, 0, $BB, $C1 ; オリジナル 06
	db 5, $28, $73, $15, $29, 0, $BB, $C2 ; オリジナル 07
	db 5, $28, $73, $15, $29, 0, $BB, $C3 ; オリジナル 08

LinkMelody_StateDrawSendingScreen::
	ld bc, $40
	call Banked_LoadMaliasGraphics
	ld bc, $41
	call Banked_LoadMaliasGraphics
	ld a, $82
	ld [$CA65], a
	ld bc, 2
	call Banked_CGBLoadBackgroundPalette
	ld bc, 0
	ld e, $79
	ld a, 0
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $79
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld a, $10
	ld [$CF96], a
	ld c, $7F
	call Battle_QueueMessage
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateSendingFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, $20
	ld [W_LCDC_MetaspriteAnimationBank], a
	ld a, 0
	call $60E5
	xor a
	ld [W_Victory_UserSelection], a
	call LinkMelody_UpdateArrowPosition
	ld a, 0
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateSendingInputHandler::
	call LCDC_IterateAnimationComplex
	call Banked_MainScriptMachine
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Right
	jp z, .rightNotPressed
	ld a, [$CFC0]
	cp 0
	jr z, .jpA
	call $1BD1

.jpA
	ld a, [W_Victory_UserSelection]
	add $50
	add $80
	ld [W_Sound_NextRingtoneSelect], a
	ld a, 4
	ld [W_Sound_MusicSet], a
	ret

.rightNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Up
	jr z, .upNotPressed
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .loopUpToBottom
	dec a
	ld [W_Victory_UserSelection], a
	jr .updateArrow

.loopUpToBottom
	ld a, 7
	ld [W_Victory_UserSelection], a
	jr .updateArrow

.upNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Down
	jr z, .downNotPressed
	ld a, [W_Victory_UserSelection]
	cp 7
	jr z, .loopDownToTop
	inc a
	ld [W_Victory_UserSelection], a
	jr .updateArrow

.loopDownToTop
	ld a, 0
	ld [W_Victory_UserSelection], a

.updateArrow
	call $1BD1
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp LinkMelody_UpdateArrowPosition

.downNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, [$CFC0]
	cp 0
	jr z, .jpB
	call $1BD1

.jpB
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld c, $1E
	call Battle_QueueMessage
	xor a
	ld [W_Summon_SelectedPageContact], a
	call LinkMelody_PlaceChoiceCursor
	ld a, 0
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateSendingConfirmationInputHandler::
	call LCDC_IterateAnimationComplex
	call Banked_MainScriptMachine
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, [W_Summon_SelectedPageContact]
	cp 0
	jr z, .loopLeftToRight
	ld a, 0
	ld [W_Summon_SelectedPageContact], a
	jr .repositionCursor

.loopLeftToRight
	ld a, 1
	ld [W_Summon_SelectedPageContact], a
	jr .repositionCursor

.leftNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, [W_Summon_SelectedPageContact]
	cp 1
	jr z, .loopRightToLeft
	ld a, 1
	ld [W_Summon_SelectedPageContact], a
	jr .repositionCursor

.loopRightToLeft
	ld a, 0
	ld [W_Summon_SelectedPageContact], a

.repositionCursor
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp LinkMelody_PlaceChoiceCursor

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jp nz, .noSelected
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
	ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	call LinkMelody_UpdateArrowPosition
	ld c, $7F
	call Battle_QueueMessage
	ld a, 2
	ld [W_Battle_4thOrderSubState], a
	ret

.startNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, [W_Summon_SelectedPageContact]
	cp 1
	jr z, .noSelected

.yesSelected
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	xor a
	ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 0 + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	jp SerIO_Increment4thOrderSubState

LinkMelody_StatePrepareForSending::
	call LinkMelody_ReadSelectedRingtone
	ld a, $FF
	ld [$D45B], a
	ld hl, W_PauseMenu_ContactsArray

.incrementArrayItemsLoop
	ld a, [hl]
	cp $FE
	jr z, .doNotIncrement
	inc [hl]

.doNotIncrement
	inc hl
	ld a, [$D45B]
	dec a
	ld [$D45B], a
	jr nz, .incrementArrayItemsLoop

	ld a, $FF
	ld [$D45B], a
	ld hl, W_PauseMenu_ContactsArray + $FF

.incrementArrayItemsSecondLoop
	ld a, [hl]
	cp $FE
	jr z, .noIncrement
	inc [hl]

.noIncrement
	inc hl
	ld a, [$D45B]
	dec a
	ld [$D45B], a
	jr nz, .incrementArrayItemsSecondLoop

	xor a
	ld [W_Battle_LoopIndex], a
	ld a, $F0
	ld [W_SerIO_ProcessOutByte], a
	ld c, $84
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateTransmitRingtone::
	call Banked_MainScriptMachine
	ld hl, W_PauseMenu_ContactsArray
	ld d, 0
	ld a, [W_Battle_LoopIndex]
	ld e, a
	add hl, de
	ld a, [hl]
	ld [W_SerIO_ProcessOutByte], a
	ld a, [W_Battle_LoopIndex]
	cp $FF
	jr z, .finishedTransmitting
	ld a, [W_Battle_LoopIndex]
	inc a
	ld [W_Battle_LoopIndex], a
	ret

.finishedTransmitting
	xor a
	ld [W_Battle_LoopIndex], a
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateMidTransmitHandshake::
	call Battle_ReadByteFromRecvBuffer
	cp $FF
	ret nz
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateTransmitRingtoneSomeMore::
	call Banked_MainScriptMachine
	ld hl, W_PauseMenu_ContactsArray + $FF
	ld d, 0
	ld a, [W_Battle_LoopIndex]
	ld e, a
	add hl, de
	ld a, [hl]
	ld [W_SerIO_ProcessOutByte], a
	ld a, [W_Battle_LoopIndex]
	cp $E2
	jr z, .finishedTransmitting
	ld a, [W_Battle_LoopIndex]
	inc a
	ld [W_Battle_LoopIndex], a
	ret

.finishedTransmitting
	xor a
	ld [W_Battle_LoopIndex], a
	jp SerIO_Increment4thOrderSubState

LinkMelody_StatePostTransmitHandshake::
	call Battle_ReadByteFromRecvBuffer
	cp $FF
	ret nz
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld c, $85
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateSendingCompleteMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateSendingFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateSendingExit::
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret

LinkMelody_StateSendingConnectionLost::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld a, 2
	ld [W_Battle_SubSubState], a
	ld a, 4
	ld [W_SystemSubState], a
	ret
