INCLUDE "telefang.inc"

SECTION "Link Menu Trade Screen State Machine", ROMX[$6376], BANK[$1F]
LinkMenu_TradeStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	cp $A
	jr z, .checkConnectionErrorState
	cp 6
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
	ld a, 8
	ld [W_Battle_4thOrderSubState], a

.dontFireConnectionErrorState
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkMenu_StateTradeDrawScreen ; 00
	dw LinkMenu_StateTradeCheckForContacts ; 01
	dw LinkMenu_StateTradeConnectionCheckForContacts ; 02
	dw LinkMenu_StateTradeDoNotCheckContactCapacity ; 03
	dw LinkMenu_StateTradeConnectionCheckContactCapacity ; 04
	dw LinkMenu_StateTradeDoNothing ; 05
	dw LinkMenu_StateTradeOkMessage ; 06
	dw LinkMenu_StateTradeExit ; 07
	dw LinkMenu_StateTradeConnectionLost ; 08
	dw LinkMenu_StateTradeFadeIn ; 09
	dw LinkMenu_StateTradeCheckConnection ; 0A

LinkMenu_StateTradeDrawScreen::
	ld bc, 2
	call Banked_CGBLoadBackgroundPalette
	ld e, $61
	xor a
	ld b, a
	ld c, a
	call Banked_RLEDecompressTMAP0
	ld e, $61
	xor a
	ld b, a
	ld c, a
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $500
	ld e, $BD
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, $500
	ld e, $BD
	xor a
	ld [W_ShadowREG_SCX], a
	ld [W_ShadowREG_SCY], a
	ld [W_ShadowREG_WX], a
	ld [W_ShadowREG_WY], a
	call Banked_RLEDecompressAttribsTMAP0
	ld a, $C3
	ld [W_ShadowREG_LCDC], a
	call LinkMenu_ADVICE_LoadSGBFilesTrade
	call Status_ExpandNumericalTiles
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 9
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateTradeFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld c, $72
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateTradeCheckConnection::
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
	cp 2
	jr z, .validConnection
	ld a, 6
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 8
	ld [W_Battle_4thOrderSubState], a
	ret

.validConnection
	ld a, 1
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateTradeCheckForContacts::
	ld a, [W_SaveClock_SaveCheckPassed]
	or a
	jr nz, .noContacts
	xor a
	ld [W_Status_NumDuplicateDenjuu], a
	ld b, 0
	ld hl, W_PauseMenu_ContactsArray

.contactCapacityCheckLoop
	ld a, [W_PauseMenu_DeletedContact]
	cp b
	jr z, .contactSlotEmpty
	push hl
	push bc
	call SaveClock_EnterSRAM2
	ld hl, $A001
	ld a, b
	call Battle_IndexStatisticsArray
	ld a, [hl]
	pop bc
	pop hl
	cp 0
	jr z, .contactSlotEmpty
	ld a, [W_Status_NumDuplicateDenjuu]
	inc a
	ld [W_Status_NumDuplicateDenjuu], a

.contactSlotEmpty
	inc b
	ld a, $FE
	cp b
	jr nz, .contactCapacityCheckLoop
	call SaveClock_ExitSRAM
	ld a, [W_Status_NumDuplicateDenjuu]
	cp 1
	jr c, .noContacts
	ld a, $F0
	ld [W_SerIO_ProcessOutByte], a
	jp SerIO_Increment4thOrderSubState

.noContacts
	ld a, $FF
	ld [W_SerIO_ProcessOutByte], a
	ld a, 5
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 8
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateTradeConnectionCheckForContacts::
	call Battle_ReadByteFromRecvBuffer
	cp 0
	ret z
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, [hl]
	cp $F0
	jp z, .nextState
	ld a, 6
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 8
	ld [W_Battle_4thOrderSubState], a
	ret

.nextState
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateTradeDoNotCheckContactCapacity::
; The unused sections of code seem to check phone book capacity, which isn't required for trading numbers. Thus we always signal that the phone book has capacity.

	jr .phoneHasCapacity

.unusedCode
	ld hl, LinkVictory_RecruitmentPhoneMemoryTable
	ld a, [W_PauseMenu_PhoneState]
	cp 0
	jr z, .mathLoopNotRequired

.inefficientMathLoop
	inc hl
	dec a
	jr nz, .inefficientMathLoop

.mathLoopNotRequired
	ld a, [hl]
	ld b, a
	ld a, [W_Status_NumDuplicateDenjuu]
	cp b
	jr nc, .phoneLacksCapacity

.phoneHasCapacity
	ld a, $E0
	ld [W_SerIO_ProcessOutByte], a
	jp SerIO_Increment4thOrderSubState

.phoneLacksCapacity
	ld a, $EE
	ld [W_SerIO_ProcessOutByte], a
	ld a, 2
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 8
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateTradeConnectionCheckContactCapacity::
	call Battle_ReadByteFromRecvBuffer
	cp 0
	ret z
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, [hl]

; This jump should always fire unless the game on the other side of the link connection has been hacked to actually check phone book capacity.

	cp $E0
	jp z, .contactsNotFull

.contactsFull
	ld a, 2
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 8
	ld [W_Battle_4thOrderSubState], a
	ret

.contactsNotFull
	ld c, $7C
	call Battle_QueueMessage
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateTradeDoNothing::
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateTradeOkMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, $1E
	ld [W_Battle_LoopIndex], a
	ld c, $96
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateTradeExit::
	call Banked_MainScriptMachine
	ld a, [W_Battle_LoopIndex]
	dec a
	ld [W_Battle_LoopIndex], a
	ret nz
	xor a
	call LinkMenu_ADVICE_SGBResetTextStyle_PlusRenewPredefinedSGBFade
	jp Battle_IncrementSubSubState

LinkMenu_StateTradeConnectionLost::
	xor a
	ld [W_Battle_4thOrderSubState], a
	xor a
	ld [W_Battle_SubSubState], a
	ld a, 4
	ld [W_SystemSubState], a
	ret
