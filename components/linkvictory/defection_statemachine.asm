INCLUDE "telefang.inc"

SECTION "Link Battle Defection State Machine", ROMX[$611A], BANK[$1F]
LinkVictory_DefectionStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	cp 4
	jr z, .jumpToState
	cp 5
	jr z, .jumpToState
	cp 7
	jr z, .jumpToState
	cp 8
	jr z, .jumpToState
	cp $A
	jr z, .jumpToState
	cp $B
	jr z, .jumpToState
	ld a, [$D4AC]
	cp 1
	jr z, .jumpToState
	call $461B
	ld a, [Malias_CmpSrcBank]
	or a
	jr z, .jumpToState
	ld a, 7
	ld [W_Battle_4thOrderSubState], a
	
.jumpToState
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .stateTable
	call System_IndexWordList
	jp hl
	
.stateTable
	dw LinkVictory_DefectionPrepareFadeFromBattle
	dw LinkVictory_FadeIntoDefectionScreen
	dw LinkVictory_DefectionLostNumberMessage
	dw LinkVictory_DefectionCommunicatePlz
	dw LinkVictory_DefectionFadeOut
	dw LinkVictory_DefectionExitToTitlemenu
	dw LinkVictory_DefectionTransmitDenjuuToOpponent
	dw LinkVictory_DefectionQueueConnectionClosedMessage
	dw LinkVictory_DefectionPrintConnectionClosedMessage
	dw LinkVictory_SubStateDrawDefectionScreen
	dw LinkVictory_DefectionConnectionClosedFadeOut
	dw LinkVictory_DefectionConnectionExitToTitlemenu

LinkVictory_DefectionQueueConnectionClosedMessage::
	ld c, $74
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkVictory_DefectionPrintConnectionClosedMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	call SerIO_ResetConnection
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $A
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_DefectionConnectionClosedFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkVictory_DefectionConnectionExitToTitlemenu::
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret

LinkVictory_DefectionPrepareFadeFromBattle::
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 9
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_SubStateDrawDefectionScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	
	ld bc, $16
	call Banked_LoadMaliasGraphics
	
	ld bc, $9
	call Banked_LoadMaliasGraphics
	
	ld bc, $E
	call Banked_CGBLoadBackgroundPalette
	
	ld a, $28
	call PauseMenu_CGBStageFlavorPalette
	
	ld bc, 0
	ld e, $70
	ld a, 0
	call Banked_RLEDecompressTMAP0
	
	ld bc, 0
	ld e, $70
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	
	ld bc, $605
	ld e, $91
	ld a, 0
	call Banked_RLEDecompressTMAP0
	
	ld bc, $605
	ld e, $8B
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	
	ld a, [W_Victory_ContactsPresent]
	cp 1
	jr z, .migrateContactId
	
.deindexLostContact
	call $06C4
	jr .processContactLoss
	
.migrateContactId
	ld a, [W_PauseMenu_DeletedContact]
	ld [W_Victory_DefectedContact], a

.processContactLoss
	call SaveClock_EnterSRAM2
	ld   hl, S_SaveClock_StatisticsArray
	ld   a, [W_Victory_DefectedContact]
	call Battle_IndexStatisticsArray
	ld de, $DC60
	ld bc, $10
	call memcpy
	call SaveClock_EnterSRAM2
	ld hl, S_SaveClock_NicknameArray
	ld a, [W_Victory_DefectedContact]
	ld de, 6
	cp a, 0
	jr z, .skipLoop

.nicknameAddressCalcLoop
	add hl, de
	dec a
	jr nz, .nicknameAddressCalcLoop

.skipLoop
	ld de, $DC70
	ld bc, 6
	call memcpy
	
	call SaveClock_EnterSRAM2
	
	ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuSpecies
	ld a, [W_Victory_DefectedContact]
	call Battle_IndexStatisticsArray
	
	push hl
	
	ld a, [hli]
	ld [W_Victory_DefectedContactSpecies], a
	ld a, [hl]
	ld [W_Victory_DefectedContactLevel], a
	
	pop hl
	
	ld a, M_SaveClock_DenjuuStatSize
	
.eraseLoop
	ld [hl], 0
	inc hl
	dec a
	jr nz, .eraseLoop
	
	call SaveClock_ExitSRAM
	
	ld a, [W_Victory_ContactsPresent]
	dec a
	ld [W_Victory_ContactsPresent], a
	
	ld a, [W_Victory_DefectedContact]
	ld c, a
	call $6A4
	
	ld a, 0
	ld [W_PauseMenu_CurrentContact], a
	
	call Banked_SaveClock_StoreWorkingStateToSaveData
	
	ld a, [W_Victory_DefectedContactSpecies]
	ld de, $9100
	call Status_LoadEvolutionIndicatorBySpecies
	
	ld a, [W_Victory_DefectedContactSpecies]
	push af
	ld c, 0
	ld de, $8800
	call Banked_Battle_LoadDenjuuPortrait
	
	pop af
	call Battle_LoadDenjuuPaletteOpponent
	
	ld hl, $9580
	ld a, 8
	call MainScript_DrawEmptySpaces
	
	ld hl, $9580
	ld a, [W_Victory_DefectedContact]
	call Status_DrawDenjuuNickname
	
	ld c, M_Battle_MessageDenjuuDefected
	call Battle_QueueMessage
	
	ld a, [W_Victory_DefectedContactLevel]
	ld hl, $984A
	ld c, 1
	call Encounter_DrawTileDigits
	
	ld a, $2E
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	
	xor a
	ld [W_Battle_LoopIndex], a
	ld a, 6
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_DefectionTransmitDenjuuToOpponent::
	ld hl, $DC60
	ld a, [W_Battle_LoopIndex]

	; Horribly inefficient way of adding a to hl.

	cp 0
	jr z, .skiploop

.addloop
	inc hl
	dec a
	jr nz, .addloop

.skiploop
	ld a, [hl]

	; W_SerIO_ProcessOutByte needs to be non-zero in order to transmit. However that means that $FF will be interpreted as $FE at the other end. This is unavoidable.

	cp $FF
	jr z, .fftruncate
	inc a

.fftruncate
	ld [W_SerIO_ProcessOutByte], a

	; Move to the next byte in the sequence.

	ld a, [W_Battle_LoopIndex]
	inc a
	ld [W_Battle_LoopIndex], a
	cp $16
	ret nz
	ld a, 1
	ld [W_Battle_4thOrderSubState], a
	ret

LinkVictory_FadeIntoDefectionScreen::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, $EE
	ld [W_SerIO_ProcessOutByte], a
	xor a
	ld [$D4AC], a
	jp SerIO_Increment4thOrderSubState

LinkVictory_DefectionLostNumberMessage::
	call Banked_MainScriptMachine
	call Battle_ReadByteFromRecvBuffer
	cp $EE
	jr nz, .noCommunication
	ld a, 1
	ld [$D4AC], a

.noCommunication
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld c, $72
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkVictory_DefectionCommunicatePlz::
	ld a, [$D4AC]
	cp 1
	jr z, .successfulCommunication
	call Battle_ReadByteFromRecvBuffer
	cp $EE
	jr z, .successfulCommunication
	jp Banked_MainScriptMachine

.successfulCommunication
	ld a, [W_Battle_NextSerIOByteIn]
	inc a
	ld [W_Battle_NextSerIOByteIn], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	jp SerIO_Increment4thOrderSubState

LinkVictory_DefectionFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkVictory_DefectionExitToTitlemenu::
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret
