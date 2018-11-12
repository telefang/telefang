INCLUDE "telefang.inc"

SECTION "Pause Menu SMS Arena", WRAM0[$CD90]
W_PauseMenu_SMSArena:: ds M_PauseMenu_SMSArenaSize

SECTION "SMS Patch Bookkeeping Variables", WRAM0[$CB46]
W_PauseMenu_SMSLineCount:: ds 1
W_PauseMenu_SMSScrollPos:: ds 1
W_PauseMenu_SMSScrollMax:: ds 1
W_PauseMenu_SMSOriginPtr:: ds 2
W_PauseMenu_SMSDrawAddressBuffer:: ds 2
W_PauseMenu_SMSArrowAnimationStage:: ds 1
W_PauseMenu_SMSLineAddressCache:: ds 2
W_PauseMenu_SMSLineNumberCache:: ds 1

SECTION "Pause Menu SMS Utils", ROMX[$7028], BANK[$4]
PauseMenu_SMSListingInputHandler::
    ld a, [H_JPInput_Changed]
    and M_JPInput_A
    jr z, .checkBBtn
    
.selectSMSText
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    call PauseMenu_ClearArrowMetasprites
    
    ld hl, $9400
    ld b, M_PauseMenu_SMSWindowWidth * M_PauseMenu_SMSWindowHeight
    call PauseMenu_ClearInputTiles
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, $85
    ld [W_MainScript_WindowBorderAttribs], a
    call PauseMenu_SelectTextStyle
    
    ld a, $40
    ld [W_MainScript_TileBaseIdx], a
    call PauseMenu_DrawSMSFromMessages
    
    jp System_ScheduleNextSubSubState
    
.checkBBtn
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .listingNavCheck
    
.dismissMenu
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    xor a
    ld [W_MainScript_TextStyle], a
    
    ld a, 7
    ld [W_SystemSubSubState], a
    
    ret

.listingNavCheck
    ld a, [W_MelodyEdit_DataCount]
    cp 1
    ret z
    
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Right
    jr z, .prevTraverseCheck
    
.moveToNext
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    dec a
    ld b, a
    
    ld a, [W_MelodyEdit_DataCurrent]
    cp b
    jr nz, .noLoadFF
    
    ld a, $FF
.noLoadFF
    inc a
    ld [W_MelodyEdit_DataCurrent], a
    jp PauseMenu_DrawSMSListingEntry
    
.prevTraverseCheck
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Left
    jr z, .idle
    
.moveToPrev
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    dec a
    ld b, a
    
    ld a, [W_MelodyEdit_DataCurrent]
    cp 0
    jr nz, .noLoadEnd
    
    ld a, [W_MelodyEdit_DataCount]
.noLoadEnd
    dec a
    ld [W_MelodyEdit_DataCurrent], a
    jp PauseMenu_DrawSMSListingEntry

.idle
    ret

PauseMenu_DrawSMSListingEntry::
    ld b, a
    ld a, [W_MelodyEdit_DataCount]
    dec a
    sub b
    
    ld e, a
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    ld hl, W_PauseMenu_SMSArena
    add hl, de
    
    ld a, [hli]
    dec a
    ld c, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld e, a
    
    push de
    call PauseMenu_CallsMenuDrawDenjuuNickname
    pop de
    push de
    
    ld a, d
    call Status_DecimalizeStatValue
    
    ld hl, $9962
    call PauseMenu_DrawTwoDigits
    
    pop de
    ld a, e
    call Status_DecimalizeStatValue
    
    ld hl, $9965
    call PauseMenu_DrawTwoDigits
    
    ld a, [W_MelodyEdit_DataCurrent]
    inc a
    call Status_DecimalizeStatValue
    
    ld hl, $99E2
    call PauseMenu_DrawTwoDigits
    
    ld a, [W_MelodyEdit_DataCount]
    call Status_DecimalizeStatValue
    
    ld hl, $99E5
    jp PauseMenu_DrawTwoDigits

SECTION "Pause Menu SMS Utils 2", ROMX[$6F31], BANK[$4]
PauseMenu_DrawSMSMessageCount::
    ld a, [W_MelodyEdit_DataCount]
    ld hl, $9942
    jp PauseMenu_DecimalizeAndDrawTwoDigits
    
PauseMenu_CountActiveSMS::
    xor a
    ld [W_MelodyEdit_DataCount], a
    
    ld hl, W_PauseMenu_SMSArena
    ld de, M_PauseMenu_SMSDataSize
    ld b, M_PauseMenu_SMSDataCount
    
.countLoop
    push hl
    ldi a, [hl]
    
    cp 0
    jr z, .nullEntry
    
    ld a, [W_MelodyEdit_DataCount]
    inc a
    ld [W_MelodyEdit_DataCount], a
    
.nullEntry
    pop hl
    add hl, de
    dec b
    jr nz, .countLoop
    ret

SECTION "Pause Menu SMS Utils 3", ROMX[$7798], BANK[$4]
PauseMenu_InitMultiMetaspriteField::
    ld [hl], a
    ld de, M_MetaSpriteConfig_Size
    add hl, de
    dec b
    jr nz, PauseMenu_InitMultiMetaspriteField
    ret

PauseMenu_LoadMsgsGraphic::
    ld hl, PhoneScreenNewTextsGfx
    ld de, $9400
    ld bc, PhoneScreenNewTextsGfx_END - PhoneScreenNewTextsGfx
    ld a, BANK(PhoneScreenNewTextsGfx)
    jp Banked_LCDC_LoadGraphicIntoVRAM
    
PauseMenu_DrawSMSFromMessages::
    ld a, (Banked_PauseMenu_ADVICE_DrawSMSFromMessages & $FF)
    jp PatchUtils_AuxCodeJmp

SECTION "Pause Menu SMS Utils 4", ROMX[$5B21], BANK[$4]
PauseMenu_ExitToCentralMenu::
    call PauseMenu_LoadMainGraphics
    jp System_ScheduleNextSubSubState
    
PauseMenu_ExitToCentralMenu2::
    call $7E37
    call $59CD
    
    ld a, 5
    ld [W_SystemSubState], a
    
    xor a
    ld [W_SystemSubSubState], a
    
    ret

SECTION "Pause Menu SMS Utils ADVICE", ROMX[$42A0], BANK[$1]
PauseMenu_ADVICE_DrawSMSFromMessages::
	M_AdviceSetup
	
	call PauseMenu_ADVICE_SMSLocateMessage
	call PauseMenu_ADVICE_SMSCountLines
	call PauseMenu_ADVICE_SMSDrawArrows
	call PauseMenu_ADVICE_SMSDrawArrowBob
	call PauseMenu_ADVICE_SMSLineSetInitialCache
	ld c, 0
	call PauseMenu_ADVICE_SMSFirstDrawHelper
	ld c, 1
	call PauseMenu_ADVICE_SMSFirstDrawHelper
	ld c, 2
	call PauseMenu_ADVICE_SMSFirstDrawHelper
	ld c, 3
	call PauseMenu_ADVICE_SMSFirstDrawHelper
	ld c, 4
	call PauseMenu_ADVICE_SMSFirstDrawHelper
	ld c, 5
	call PauseMenu_ADVICE_SMSFirstDrawHelper
	
	M_AdviceTeardown
	ret

SECTION "Pause Menu SMS Utils ADVICE 2", ROMX[$4C40], BANK[$1]
PauseMenu_ADVICE_SMSFirstDrawHelper::
	call PauseMenu_ADVICE_SMSLocateLineRelativeToCache
	ld a, c
	call PauseMenu_ADVICE_SMSFindLineForDrawing
	call PauseMenu_ADVICE_SMSDrawLine
	ret

PauseMenu_ADVICE_SMSLocateMessage::
	ld a, [W_MelodyEdit_DataCurrent]
	ld b, a
	ld a, [W_MelodyEdit_DataCount]
	dec a
	sub b
	ld e, a
	ld d, 0
	call PatchUtils_LimitBreak
	ld hl, W_PauseMenu_SMSArena
	add hl, de
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	ld c, a
	ld b, 1
	ld d, $C
	call Banked_MainScript_InitializeMenuText
	ld a, [W_MainScript_TextPtr]
	ld [W_PauseMenu_SMSOriginPtr], a
	ld a, [W_MainScript_TextPtr + 1]
	ld [W_PauseMenu_SMSOriginPtr + 1], a
	ret

PauseMenu_ADVICE_SMSLocateLineRelativeToCache::
; c is the line number we are searching for.
	call PauseMenu_ADVICE_SMSGetCachedLine
	ld b, a
	ld a, c
	or a
	jr z, .originPlz
	ld a, b
	cp c
	jr z, .exit
	jr c, .forwardLoop

.reverseLoop
	ld a, c
	cp b
	jr z, .exit
	dec hl
	dec hl
	push bc
	call MainScript_LoadFromBank
	pop bc
	cp $E2
	jr nz, .reverseLoop
	dec b
	jr .reverseLoop

.originPlz
	call PauseMenu_ADVICE_SMSGetOriginPointer
	ld b, 0
	jr .exit

.forwardLoop
	ld a, c
	cp b
	jr z, .exit
	push bc
	call MainScript_LoadFromBank
	pop bc
	cp $E1
	jr z, .endCodeFound
	cp $E2
	jr nz, .forwardLoop
	inc b
	jr .forwardLoop

.endCodeFound
	dec hl

.exit
	ld a, b
	call PauseMenu_ADVICE_SMSSetCachedLine
	call PauseMenu_ADVICE_SMSSetPointer
	ret

PauseMenu_ADVICE_SMSCountLines::
	call PauseMenu_ADVICE_SMSGetOriginPointer
	ld b, 0

.searchLoop
	call MainScript_LoadFromBank
	cp $E1
	jr z, .exitLoop
	cp $E2
	jr nz, .notNewLine
	ld a, b
	cp $FE
	jr z, .exitLoop
	inc b
	
.notNewLine
	jr .searchLoop

.exitLoop
	inc b
	ld a, b
	ld [W_PauseMenu_SMSLineCount], a
	cp 7
	jr nc, .canScroll
	xor a
	jr .storeMaxScroll

.canScroll
	ld b, 6
	sub b

.storeMaxScroll
	ld [W_PauseMenu_SMSScrollMax], a
	xor a
	ld [W_PauseMenu_SMSScrollPos], a
	ret
   
PauseMenu_ADVICE_SMSFindLineForDrawing::
	ld hl, $9400
	ld de, $60
	
.mathLoop
	or a
	jr z, .exitLoop
	add hl, de
	dec a
	jr .mathLoop

.exitLoop
	call PauseMenu_ADVICE_SMSSetDrawAddress
	ret

PauseMenu_ADVICE_SMSDrawLine::
	xor a
	ld [W_MainScript_VWFLetterShift], a
	ld [W_MainScript_VWFCurrentLetter], a
	ld [W_MainScript_ADVICE_FontToggle], a
	ld hl, $CFD0
	ld b, $10

.clearCompositeAreaLoop
	ld [hli], a
	dec b
	jr nz, .clearCompositeAreaLoop
	call PauseMenu_ADVICE_SMSGetDrawAddress
	ld b, $30
	call PauseMenu_ADVICE_SMSClearTiles
	call PauseMenu_ADVICE_SMSGetPointer

.nextCharacter
	call MainScript_LoadFromBank
	cp $D3
	jr nc, .endRead
	ld c, a
	call PauseMenu_ADVICE_SMSGetDrawAddress
	ld a, c
	call Banked_MainScript_DrawLetter
	ld a, [W_MainScript_VWFOldTileMode]
	cp 1
	jr c, .noIncrement
	call PauseMenu_ADVICE_SMSNextTile

.noIncrement
	call PauseMenu_ADVICE_SMSGetPointer
	inc hl
	call PauseMenu_ADVICE_SMSSetPointer
	jr .nextCharacter
	
.endRead
	ret

PauseMenu_ADVICE_SMSDrawArrows::
	ld b, $20
	ld hl, $97B0
	call PauseMenu_ADVICE_SMSClearTiles
	ld bc, $404
	ld l, $B4
	ld de, PauseMenu_ADVICE_SMSArrows
	ld a, [W_MainScript_TextStyle]
	cp 1
	jr z, .loopA
	inc hl

.loopA
	ld a, [de]
	call vmempoke
	inc hl
	inc de
	dec b
	jr nz, .loopA
	ld b, 8

.loopB
	inc hl
	dec b
	jr nz, .loopB
	dec c
	ld b, 4
	jr nz, .loopA
	ret
	
PauseMenu_ADVICE_SMSMapTiles::
	M_AdviceSetup
	ld e, $57
	ld bc, $106
	xor a
	push de
	call Banked_RLEDecompressTMAP0
	pop de
	ld bc, $106
	xor a
	call Banked_RLEDecompressAttribsTMAP0
	call PauseMenu_ADVICE_SMSMapArrows
	M_AdviceTeardown
	ret

PauseMenu_ADVICE_SMSMapArrows::
	xor a
	ld [W_PauseMenu_SMSArrowAnimationStage], a
	ld a, [W_PauseMenu_SMSScrollPos]
	or a
	jr z, .cantScrollUp
	ld b, $40
	call PauseMenu_ADVICE_SMSSetArrowState
	ld de, $7B01
	jr .mapTopArrow

.cantScrollUp
	ld de, $D000

.mapTopArrow
	call PauseMenu_ADVICE_SMSMapTopArrow
	ld a, [W_PauseMenu_SMSScrollMax]
	ld b, a
	ld a, [W_PauseMenu_SMSScrollPos]
	cp b
	jr z, .cantScrollDown
	ld b, $80
	call PauseMenu_ADVICE_SMSSetArrowState
	ld de, $7D01
	jr .mapBottomArrow

.cantScrollDown
	ld de, $D000

.mapBottomArrow
	call PauseMenu_ADVICE_SMSMapBottomArrow
	ret

PauseMenu_ADVICE_SMSMapArrow::
	call WaitForBlanking
	ld [hl], d
	inc hl
	ld a, d
	add e
	ld d, a
	call WaitForBlanking
	ld [hl], d
	ret

PauseMenu_ADVICE_SMSContentsCheckInput::
	M_AdviceSetup
	call PauseMenu_ADVICE_SMSScrollCheck
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	jr z, .noExit
	ld e, $2D
	ld bc, $106
	xor a
	push de
	call Banked_RLEDecompressTMAP0
	pop de
	ld bc, $106
	xor a
	call Banked_RLEDecompressAttribsTMAP0

.noExit
	ld b, a
	M_AdviceTeardown
	ret

PauseMenu_ADVICE_SMSScrollCheck::
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Up + M_JPInput_Down
	or a
	jr z, .animateArrows
	cp M_JPInput_Up
	jr nz, .checkDown
	call PauseMenu_ADVICE_SMSScrollUp
	jr .postScroll

.checkDown
	cp M_JPInput_Down
	jr nz, .postScroll
	call PauseMenu_ADVICE_SMSScrollDown
	jr .postScroll

.animateArrows
	call PauseMenu_ADVICE_SMSAnimateArrows

.postScroll
	ret

PauseMenu_ADVICE_SMSScrollUp::
	ld a, [W_PauseMenu_SMSScrollPos]
	or a
	ret z
	call PauseMenu_ADVICE_SMSMoveDownOldLines
	ld hl, $9640
	call PauseMenu_ADVICE_SMSSetDrawAddress
	ld a, [W_PauseMenu_SMSScrollPos]
	dec a
	ld [W_PauseMenu_SMSScrollPos], a
	ld c, a
	call PauseMenu_ADVICE_SMSLocateLineRelativeToCache
	call PauseMenu_ADVICE_SMSDrawLine
	ld hl, $9640
	ld de, $9400
	ld b, $60
	call PauseMenu_ADVICE_SMSBasicTileCopy
	call PauseMenu_ADVICE_SMSMapArrows
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ret

PauseMenu_ADVICE_SMSScrollDown::
	ld a, [W_PauseMenu_SMSScrollMax]
	ld b, a
	ld a, [W_PauseMenu_SMSScrollPos]
	cp b
	ret z
	cp $FA
	ret z
	call PauseMenu_ADVICE_SMSMoveUpOldLines
	ld hl, $95E0
	call PauseMenu_ADVICE_SMSSetDrawAddress
	ld a, [W_PauseMenu_SMSScrollPos]
	inc a
	ld [W_PauseMenu_SMSScrollPos], a
	ld c, 5
	add c
	ld c, a
	call PauseMenu_ADVICE_SMSLocateLineRelativeToCache
	call PauseMenu_ADVICE_SMSDrawLine
	call PauseMenu_ADVICE_SMSMapArrows
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ret

PauseMenu_ADVICE_SMSMoveUpOldLines::
	ld hl, $9460
	ld de, $9400
	ld bc, $1E0

.tileCopyLoop
	di
	call WaitForBlanking
	ld a, [hli]
	ld [de], a
	ei
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .tileCopyLoop
	ret

PauseMenu_ADVICE_SMSMoveDownOldLines::
	ld hl, $95DF
	ld de, $963F
	ld bc, $1E0

.tileCopyLoop
	di
	call WaitForBlanking
	ld a, [hld]
	ld [de], a
	ei
	dec de
	dec bc
	ld a, b
	or c
	jr nz, .tileCopyLoop
	ret

PauseMenu_ADVICE_SMSDrawArrowBob::
	ld b, $40
	ld hl, $9730
	call PauseMenu_ADVICE_SMSClearTiles
	ld hl, $97B4
	ld de, $9772
	ld b, $18
	call PauseMenu_ADVICE_SMSBasicTileCopy
	ld l, $D4
	ld e, $96
	ld b, $18
	call PauseMenu_ADVICE_SMSBasicTileCopy
	ld l, $B4
	ld e, $36
	ld b, $18
	call PauseMenu_ADVICE_SMSBasicTileCopy
	ld l, $D4
	ld e, $52
	ld b, $18
	call PauseMenu_ADVICE_SMSBasicTileCopy
	ret

PauseMenu_ADVICE_SMSBasicTileCopy::
	di
	call WaitForBlanking
	ld a, [hli]
	ld [de], a
	ei
	inc de
	dec b
	jr nz, PauseMenu_ADVICE_SMSBasicTileCopy
	ret

PauseMenu_ADVICE_SMSSetArrowState::
	ld a, [W_PauseMenu_SMSArrowAnimationStage]
	add b
	ld [W_PauseMenu_SMSArrowAnimationStage], a
	ret

PauseMenu_ADVICE_SMSAnimateArrows::
	ld a, [W_PauseMenu_SMSArrowAnimationStage]
	ld c, a
	and $3F
	cp $28
	jp z, PauseMenu_ADVICE_SMSAnimateStageA
	cp $18
	jp z, PauseMenu_ADVICE_SMSAnimateStageB
	cp $20
	jp z, PauseMenu_ADVICE_SMSAnimateStageC
	ld a, c
	inc a
	ld [W_PauseMenu_SMSArrowAnimationStage], a
	ret

PauseMenu_ADVICE_SMSAnimateStageA::
	bit 6, c
	jr z, .skipTopArrow
	ld de, $7B01
	call PauseMenu_ADVICE_SMSMapTopArrow

.skipTopArrow
	bit 7, c
	jr z, .skipBottomArrow
	ld de, $7D01
	call PauseMenu_ADVICE_SMSMapBottomArrow

.skipBottomArrow
	ld a, c
	and $C0
	ld c, $10
	add c
	ld [W_PauseMenu_SMSArrowAnimationStage], a
	ret

PauseMenu_ADVICE_SMSAnimateStageB::
	bit 6, c
	jr z, .skipTopArrow
	ld de, $7701
	call PauseMenu_ADVICE_SMSMapTopArrow

.skipTopArrow
	bit 7, c
	jr z, .skipBottomArrow
	ld de, $7901
	call PauseMenu_ADVICE_SMSMapBottomArrow

.skipBottomArrow
	ld a, c
	inc a
	ld [W_PauseMenu_SMSArrowAnimationStage], a
	ret

PauseMenu_ADVICE_SMSAnimateStageC::
	bit 6, c
	jr z, .skipTopArrow
	ld de, $7301
	call PauseMenu_ADVICE_SMSMapTopArrow

.skipTopArrow
	bit 7, c
	jr z, .skipBottomArrow
	ld de, $7501
	call PauseMenu_ADVICE_SMSMapBottomArrow

.skipBottomArrow
	ld a, c
	inc a
	ld [W_PauseMenu_SMSArrowAnimationStage], a
	ret

PauseMenu_ADVICE_SMSMapTopArrow::
	ld hl, $98E4
	jr PauseMenu_ADVICE_SMSMapBottomArrow.remoteJp

PauseMenu_ADVICE_SMSMapBottomArrow::
	ld hl, $9A04

.remoteJp
	call PauseMenu_ADVICE_SMSMapArrow
	ret

PauseMenu_ADVICE_SMSGetCachedLine::
	ld a, [W_PauseMenu_SMSLineAddressCache]
	ld l, a
	ld a, [W_PauseMenu_SMSLineAddressCache + 1]
	ld h, a
	ld a, [W_PauseMenu_SMSLineNumberCache]
	ret

PauseMenu_ADVICE_SMSLineSetInitialCache::
	call PauseMenu_ADVICE_SMSGetOriginPointer
	xor a
	; This continues into PauseMenu_ADVICE_SMSSetCachedLine because it saves 3 to 4 bytes of code.

PauseMenu_ADVICE_SMSSetCachedLine::
	ld [W_PauseMenu_SMSLineNumberCache], a
	ld a, l
	ld [W_PauseMenu_SMSLineAddressCache], a
	ld a, h
	ld [W_PauseMenu_SMSLineAddressCache + 1], a
	ret

PauseMenu_ADVICE_SMSArrows::
	INCBIN "build/components/pausemenu/sms_arrows.1bpp", 0, 16

PauseMenu_ADVICE_SMSClearTiles::
	ld a, [W_MainScript_TextStyle]
	cp 1
	jr nz, .gbTiles
	xor a
	call vmempoke
	ld a, $FF
	call vmempoke
	jr .nextLine

.gbTiles
	ld a, $FF
	call vmempoke
	xor a
	call vmempoke

.nextLine
	dec b
	jr nz, PauseMenu_ADVICE_SMSClearTiles
	ret

PauseMenu_ADVICE_SMSNextTile::
	call PauseMenu_ADVICE_SMSGetDrawAddress
	ld de, $10
	add hl, de
	call PauseMenu_ADVICE_SMSSetDrawAddress
	ret

PauseMenu_ADVICE_SMSGetOriginPointer::
	ld a, [W_PauseMenu_SMSOriginPtr]
	ld l, a
	ld a, [W_PauseMenu_SMSOriginPtr + 1]
	ld h, a
	ret

PauseMenu_ADVICE_SMSGetPointer::
	ld a, [W_MainScript_TextPtr]
	ld l, a
	ld a, [W_MainScript_TextPtr + 1]
	ld h, a
	ret

PauseMenu_ADVICE_SMSSetPointer::
	ld a, l
	ld [W_MainScript_TextPtr], a
	ld a, h
	ld [W_MainScript_TextPtr + 1], a
	ret

PauseMenu_ADVICE_SMSGetDrawAddress::
	ld a, [W_PauseMenu_SMSDrawAddressBuffer]
	ld l, a
	ld a, [W_PauseMenu_SMSDrawAddressBuffer + 1]
	ld h, a
	ret

PauseMenu_ADVICE_SMSSetDrawAddress::
	ld a, l
	ld [W_PauseMenu_SMSDrawAddressBuffer], a
	ld a, h
	ld [W_PauseMenu_SMSDrawAddressBuffer + 1], a
	ret
