INCLUDE "telefang.inc"

SECTION "Link Menu State Machine", ROMX[$4028], BANK[$1F]
LinkMenu_StateMachine::
	ld a, [W_Battle_SubSubState]
	cp 0
	jr z, .checkConnectionErrorState
	cp 6
	jr z, .checkConnectionErrorState
	cp $A
	jr z, .checkConnectionErrorState
	cp $B
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
	ld a, $E
	ld [W_Battle_SubSubState], a

.dontFireConnectionErrorState
	ld a, [W_Battle_SubSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkMenu_StateFadeOutFromTitlemenuPrepare
	dw LinkMenu_StateFadeOutFromTitlemenu
	dw LinkMenu_StateDrawConnectionConfirmationScreen
	dw LinkMenu_StateFadeIntoConnectionConfirmationScreen
	dw LinkMenu_StateConnectionConfirmationMessage
	dw LinkMenu_StateConnectionConfirmationInputHandler
	dw LinkMenu_StateCheckConnectionValid
	dw LinkMenu_StateFadeOutFromConnectionConfirmationScreen
	dw LinkMenu_StateDrawMenuScreen
	dw LinkMenu_StateFadeIntoMenuScreen
	dw LinkMenu_StateMenuScreenInputHandler
	dw LinkMenu_StateOpenSubscreen
	dw LinkMenu_StateConnectionLostFadeOutPrepare
	dw LinkMenu_StateConnectionLostFadeOut
	dw LinkMenu_StateConnectionLost
	dw LinkMenu_StateExitToTitlemenu
	dw LinkMenu_StatePostConfirmConnectingMessage
	dw LinkMenu_StateConnectionFailed

; Fade out from title menu prep.
LinkMenu_StateFadeOutFromTitlemenuPrepare::
	xor a
	ld [W_Encounter_AlreadyInitialized], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	jp Battle_IncrementSubSubState

LinkMenu_StateFadeOutFromTitlemenu::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	call Status_ExpandNumericalTiles
	ld a, $C3
	ld [W_ShadowREG_LCDC], a
	xor a
	ld [W_ShadowREG_SCX], a
	ld [W_ShadowREG_SCY], a
	ld [W_ShadowREG_WX], a
	ld [W_ShadowREG_WY], a
	xor a
	ld [W_Battle_LoopIndex], a
	ld [$DC20], a
	ld [$DC58], a
	call SerIO_ResetConnection
	jp Battle_IncrementSubSubState

LinkMenu_StateDrawConnectionConfirmationScreen::
	call ClearGBCTileMap0
	call ClearGBCTileMap1
	call LCDC_ClearMetasprites
	ld bc, 2
	call Banked_CGBLoadBackgroundPalette
	ld bc, $40
	call Banked_LoadMaliasGraphics
	ld bc, $41
	call Banked_LoadMaliasGraphics
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
	ld a, $C3
	ld [W_ShadowREG_LCDC], a
	xor a
	ld [W_ShadowREG_SCX], a
	ld [W_ShadowREG_SCY], a
	ld [W_ShadowREG_WX], a
	ld [W_ShadowREG_WY], a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 3) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	call LinkMenu_ADVICE_LoadSGBFilesConnection
	ld c, $91
	call Battle_QueueMessage
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	jp Battle_IncrementSubSubState

LinkMenu_StateFadeIntoConnectionConfirmationScreen::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp Battle_IncrementSubSubState

LinkMenu_StateConnectionConfirmationMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 0
	call Banked_Status_LoadUIGraphics
	ld a, $20
	ld [W_LCDC_MetaspriteAnimationBank], a
	call $60EC
	xor a
	ld [W_Victory_UserSelection], a
	call SerIO_PlaceChoiceCursor
	ld a, 0
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	ld c, $92
	call Battle_QueueMessage
	jp Battle_IncrementSubSubState

LinkMenu_StateConnectionConfirmationInputHandler::
	call LCDC_IterateAnimationComplex
	call Banked_MainScriptMachine
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .leftLoopToRight
	ld a, 0
	ld [W_Victory_UserSelection], a
	jr .placeCursor

.leftLoopToRight
	ld a, 1
	ld [W_Victory_UserSelection], a
	jr .placeCursor

.leftNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .rightLoopToLeft
	ld a, 1
	ld [W_Victory_UserSelection], a
	jr .placeCursor

.rightLoopToLeft
	ld a, 0
	ld [W_Victory_UserSelection], a

.placeCursor
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jp SerIO_PlaceChoiceCursor

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr nz, .noSelected
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 0
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_Victory_UserSelection]
	cp 1
	jr z, .noSelected

.yesSelected
	ld c, $72
	call Battle_QueueMessage
	ld a, $1E
	ld [W_Battle_LoopIndex], a
	ld a, $10
	ld [W_Battle_SubSubState], a
	ret

.noSelected
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	ld a, 0
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	ld a, $F
	ld [W_Battle_SubSubState], a
	ret

LinkMenu_StatePostConfirmConnectingMessage::
	call Banked_MainScriptMachine
	ld a, [W_Battle_LoopIndex]
	dec a
	ld [W_Battle_LoopIndex], a
	ret nz
	ld a, 6
	ld [W_Battle_SubSubState], a
	ret

LinkMenu_StateCheckConnectionValid::
	call Banked_MainScriptMachine
	call $4575
	ld a, [$DC58]
	cp 1
	jr z, .badConnection
	cp 2
	jr z, .goodConnection
	ret

.badConnection
	ld a, 5
	ld [W_Sound_NextSFXSelect], a
	ld a, $1E
	ld [W_Battle_LoopIndex], a
	ld a, $11
	ld [W_Battle_SubSubState], a
	ret

.goodConnection
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp Battle_IncrementSubSubState

LinkMenu_StateConnectionFailed::
	call Banked_MainScriptMachine
	ld a, [W_Battle_LoopIndex]
	dec a
	ld [W_Battle_LoopIndex], a
	ret nz
	xor a
	ld [W_Battle_SubSubState], a
	ld [W_LinkMenu_ErrorMessageIndex], a
	ld a, 4
	ld [W_SystemSubState], a
	ret

LinkMenu_StateFadeOutFromConnectionConfirmationScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp Battle_IncrementSubSubState

; LinkMenu_StateDrawMenuScreen is version-specific.

SECTION "Link Menu State Machine 2", ROMX[$42DB], BANK[$1F]
LinkMenu_StateFadeIntoMenuScreen::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp Battle_IncrementSubSubState

LinkMenu_StateMenuScreenInputHandler::
	ld a, 0
	ld [W_LCDC_NextMetaspriteSlot], a
	call LCDC_IterateAnimationComplex
	ld a, 1
	ld [W_LCDC_NextMetaspriteSlot], a
	call LCDC_IterateAnimationComplex
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Up
	jr z, .upNotPressed
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .loopUpToBottom
	dec a
	ld [W_Victory_UserSelection], a
	jr .positionCursor

.loopUpToBottom
	ld a, 2
	ld [W_Victory_UserSelection], a
	jr .positionCursor

.upNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_Down
	jr z, .downNotPressed
	ld a, [W_Victory_UserSelection]
	cp 2
	jr z, .loopDownToTop
	inc a
	ld [W_Victory_UserSelection], a
	jr .positionCursor

.loopDownToTop
	ld a, 0
	ld [W_Victory_UserSelection], a

.positionCursor
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	call $441B
	ld a, 0
	ld [W_LCDC_NextMetaspriteSlot], a
	call LCDC_BeginAnimationComplex
	ld a, 1
	ld [W_LCDC_NextMetaspriteSlot], a
	call LCDC_BeginAnimationComplex
	ret

.downNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_Victory_UserSelection]
	inc a
	ld [W_SerIO_ProcessOutByte], a
	ld a, 1
	ld [W_Battle_OpponentUsingLinkCable], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp Battle_IncrementSubSubState
LinkMenu_StateOpenSubscreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	xor a
	ld [W_Battle_SubSubState], a
	ld [W_Battle_4thOrderSubState], a
	xor a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	call Banked_SaveClock_RetrieveWorkingStateFromSaveData
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .vsSelected
	cp 1
	jr z, .tradeSelected
	cp 2
	jr z, .meloDTransferSelected

.vsSelected
jp System_ScheduleNextSubState

.tradeSelected
	ld a, 2
	ld [W_SystemSubState], a
	ret

.meloDTransferSelected
	ld a, 3
	ld [W_SystemSubState], a
	ret

LinkMenu_StateConnectionLostFadeOutPrepare::
; Possibly unused state.
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp Battle_IncrementSubSubState

LinkMenu_StateConnectionLostFadeOut::
; Possibly unused state.
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp Battle_IncrementSubSubState

LinkMenu_StateConnectionLost::
	xor a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	xor a
	ld [W_Battle_SubSubState], a
	ld [W_Battle_4thOrderSubState], a
	ld a, 4
	ld [W_SystemSubState], a
	ret

LinkMenu_StateExitToTitlemenu::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, 0
	ldh [REG_SB], a
	ld a, $81
	ldh [REG_SC], a
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret
