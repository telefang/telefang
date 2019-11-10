INCLUDE "telefang.inc"

SECTION "Link Melody Receiving State Machine", ROMX[$77CE], BANK[$1F]
LinkMelody_ReceivingStateMachine::
	ld a, [W_Battle_4thOrderSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw LinkMelody_StateDrawReceivingScreen
	dw LinkMelody_StateReceivingFadeIn
	dw LinkMelody_StateReceivingInputHandler
	dw LinkMelody_StateReceivingConfirmationInputHandler
	dw LinkMelody_StateReceivingSaveRingtone
	dw LinkMelody_StateReceivingSaveCompleteMessage
	dw LinkMelody_StateReceivingFadeOut
	dw LinkMelody_StateReceivingExit

LinkMelody_StateDrawReceivingScreen::
	ld bc, 2
	call Banked_CGBLoadBackgroundPalette
	ld bc, $40
	call Banked_LoadMaliasGraphics
	ld bc, $41
	call Banked_LoadMaliasGraphics
	ld bc, 0
	ld e, $79
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $79
	xor a
	call Banked_RLEDecompressAttribsTMAP0
	ld a, $20
	ld [W_LCDC_MetaspriteAnimationBank], a
	xor a
	call $60E5
	xor a
	ld [W_Victory_UserSelection], a
	call LinkMelody_UpdateArrowPosition
	ld a, 0
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	call LinkMenu_ADVICE_LoadSGBFilesMelody
	ld c, $86
	call Battle_QueueMessage
	ld a, $10
	ld [$CF96], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateReceivingFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateReceivingInputHandler::
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

LinkMelody_StateReceivingConfirmationInputHandler::
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
	call LinkMelody_PlaceChoiceCursor
	ret

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr z, .bNotPressed
	jp .noSelected

.bNotPressed
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
	ld c, $86
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

LinkMelody_StateReceivingSaveRingtone::
	call LinkMelody_StoreReceivedRingtone
	call Banked_SaveClock_StoreWorkingStateToSaveData
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld c, $87
	call Battle_QueueMessage
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateReceivingSaveCompleteMessage::
	call Banked_MainScriptMachine
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation_PlusRenewPredefinedSGBFade
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateReceivingFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp SerIO_Increment4thOrderSubState

LinkMelody_StateReceivingExit::
	xor a
	ld [W_Battle_4thOrderSubState], a
	ld [W_Battle_SubSubState], a
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_SystemState], a
	ret
