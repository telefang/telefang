INCLUDE "telefang.inc"

SECTION "Link Menu Battle Screen State Machine", ROMX[$471A], BANK[$1F]
LinkMenu_BattleStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	cp $B
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
	ld a, 9
	ld [W_Battle_4thOrderSubState], a

.dontFireConnectionErrorState
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkMenu_StateBattleDrawScreen
	dw LinkMenu_StateBattleCheckForContacts
	dw LinkMenu_StateBattleConnectionCheckForContacts
	dw LinkMenu_StateBattleCheckContactCapacity
	dw LinkMenu_StateBattleQueueConnectingMessage
	dw LinkMenu_StateBattleConnectionCheckContactCapacity
	dw LinkMenu_StateBattleQueueAccessingMemoryMessage
	dw LinkMenu_StateBattleOkMessage
	dw LinkMenu_StateBattleExit
	dw LinkMenu_StateBattleConnectionLost
	dw LinkMenu_StateBattleFadeIn
	dw LinkMenu_StateBattleCheckConnection

LinkMenu_StateBattleDrawScreen::
	ld bc, 2
	call Banked_CGBLoadBackgroundPalette
	ld bc, 0
	ld e, $61
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $61
	xor a
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $500
	ld e, $BC
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, $500
	ld e, $BC
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld a, $C3
	ld [W_ShadowREG_LCDC], a
	xor a
	ld [W_ShadowREG_SCX], a
	ld [W_ShadowREG_SCY], a
	ld [W_ShadowREG_WX], a
	ld [W_ShadowREG_WY], a
	call LinkMenu_ADVICE_LoadSGBFilesBattle
	call Status_ExpandNumericalTiles
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $A
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateBattleFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld c, $72
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateBattleCheckConnection::
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
	cp 1
	jr z, .validConnection
	ld a, 3
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 9
	ld [W_Battle_4thOrderSubState], a
	ret

.validConnection
	ld a, 1
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateBattleCheckForContacts::
	ld a, [W_SaveClock_SaveCheckPassed]
	or a
	jr nz, .noContacts
	xor a
	ld [W_Status_NumDuplicateDenjuu], a
	ld b, 0
	ld hl, W_PauseMenu_ContactsArray

.contactCapacityCheckLoop
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
	ld a, $FE
	cp b
	jr z, .contactCapacityExitLoop
	inc b
	jr .contactCapacityCheckLoop

.contactCapacityExitLoop
	call SaveClock_ExitSRAM
	ld a, [W_Status_NumDuplicateDenjuu]
	cp 2
	jr c, .noContacts
	ld a, $F0
	ld [W_SerIO_ProcessOutByte], a
	jp SerIO_Increment4thOrderSubState

.noContacts
	ld a, $F9
	ld [W_SerIO_ProcessOutByte], a
	ld a, 1
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 9
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateBattleConnectionCheckForContacts::
	call Battle_ReadByteFromRecvBuffer
	cp 0
	ret z
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, [hl]
	cp $F0
	jp z, .nextState
	ld a, 3
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 9
	ld [W_Battle_4thOrderSubState], a
	ret

.nextState
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateBattleCheckContactCapacity::
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
	ld a, 9
	ld [W_Battle_4thOrderSubState], a
	ret

LinkMenu_StateBattleQueueConnectingMessage::
	ld c, $72
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateBattleConnectionCheckContactCapacity::
	call Banked_MainScriptMachine
	call Battle_ReadByteFromRecvBuffer
	cp 0
	ret z
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, [hl]
	cp $E0
	jp z, .contactsNotFull

.contactsFull
	ld a, 2
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 9
	ld [W_Battle_4thOrderSubState], a
	ret

.contactsNotFull
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateBattleQueueAccessingMemoryMessage::
	ld c, $79
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateBattleOkMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, $1E
	ld [W_Battle_LoopIndex], a
	ld c, $96
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMenu_StateBattleExit::
	call Banked_MainScriptMachine
	ld a, [W_Battle_LoopIndex]
	dec a
	ld [W_Battle_LoopIndex], a
	ret nz
	xor a
	call LinkMenu_ADVICE_SGBResetTextStyle
	jp Battle_IncrementSubSubState

LinkMenu_StateBattleConnectionLost::
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld a, 0
	ld [W_Battle_SubSubState], a
	ld a, 4
	ld [W_SystemSubState], a
	ret
