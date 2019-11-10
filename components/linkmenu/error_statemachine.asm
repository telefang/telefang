INCLUDE "telefang.inc"

SECTION "Link Menu Error Message Index", WRAMX[$DC4A], BANK[$1]
W_LinkMenu_ErrorMessageIndex:: ds 1

SECTION "Link Menu Error Screen State Machine", ROMX[$4443], BANK[$1F]
LinkMenu_ErrorStateMachine::
	ld a, [W_Battle_SubSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkMenu_StateErrorPrepareFadeOut
	dw LinkMenu_StateErrorFadeOut
	dw LinkMenu_StateErrorDrawScreen
	dw LinkMenu_StateErrorFadeIn
	dw LinkMenu_StateErrorPrintMessage
	dw LinkMenu_StateErrorExitToTitlemenu

LinkMenu_StateErrorPrepareFadeOut::
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp Battle_IncrementSubSubState

LinkMenu_StateErrorFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp Battle_IncrementSubSubState

LinkMenu_StateErrorDrawScreen::
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
	ld bc, $500
	ld e, $BF
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, $500
	ld e, $BF
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
	call $3F02
	ld a, [W_LinkMenu_ErrorMessageIndex]
	cp 0
	jr z, .errorMessageA
	cp 1
	jr z, .errorMessageB
	cp 2
	jr z, .errorMessageC
	cp 3
	jr z, .errorMessageD
	cp 4
	jr z, .errorMessageE
	cp 5
	jr z, .errorMessageF
	cp 6
	jr z, .errorMessageG
	cp 7
	jr z, .errorMessageH
	cp 8
	jr z, .errorMessageI

.errorMessageA
	ld c, $73
	call LinkMenu_ClearTilesAndQueueMessage
	jr .nextState

.errorMessageB
	ld c, $78
	call LinkMenu_ClearTilesAndQueueMessage
	jr .nextState

.errorMessageC
	ld c, $7D
	call LinkMenu_ClearTilesAndQueueMessage
	jr .nextState

.errorMessageD
	ld c, $77
	call LinkMenu_ClearTilesAndQueueMessage
	jr .nextState

.errorMessageE
	ld c, $74
	call LinkMenu_ClearTilesAndQueueMessage
	jr .nextState

.errorMessageF
	ld c, $7B
	call LinkMenu_ClearTilesAndQueueMessage
	jr .nextState

.errorMessageG
	ld c, $7A
	call LinkMenu_ClearTilesAndQueueMessage
	jr .nextState

.errorMessageH
	ld c, $89
	call LinkMenu_ClearTilesAndQueueMessage
	jr .nextState

.errorMessageI
	ld c, $8A
	call LinkMenu_ClearTilesAndQueueMessage

.nextState
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	jp Battle_IncrementSubSubState

LinkMenu_StateErrorFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp Battle_IncrementSubSubState

LinkMenu_StateErrorPrintMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, $10
	ld [$CF96], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp Battle_IncrementSubSubState

LinkMenu_StateErrorExitToTitlemenu::
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
	ld [W_Status_UseDenjuuNickname], a
	ld a, 3
	ld [W_SystemState], a
	ret
