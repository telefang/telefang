INCLUDE "telefang.inc"

;Text-drawing routine present in Telefang.
;For some reason they actually draw text out rather than using tiles to do it
;instead. It's completely unnecessary for Japanese text.

SECTION "MainScript Text Drawing Options", WRAM0[$CDB1]
W_MainScript_TextStyle:: ds 1

;Draw the letter at A.
;The 1bpp font is turned into a 2bpp color
SECTION "MainScript Text Drawing Routine", ROMX[$4E29], BANK[$B]
MainScript_DrawLetter::
	jp MainScript_ADVICE_StoreCurrentLetter

.COMEFROM_StoreCurrentLetter
	add a, a
	jr nc, .mulBy8
	inc b
.mulBy8
	sla a
	rl b
	sla a
	rl b
	ld c, a
	call MainScript_ADVICE_FontAddress
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	call MainScript_ADVICE_FontSelector
	ret

SECTION "MainScript Text Drawing Advice 2", ROMX[$79C1], BANK[$B]
MainScript_ADVICE_DrawLetter:
	ld b, 8
	ld a, $CF
	ld [W_MainScript_VWFCompositeArea], a
	ld a, $D0
	ld [W_MainScript_VWFCompositeArea + 1], a
	push hl
	push bc
	ld a, [W_MainScript_VWFCurrentLetter]
	ld h, MainScript_ADVICE_DrawLetterTable >> 8
	ld l, a
	xor a
	ld b, [hl]
	ld a, [W_MainScript_VWFLetterShift]
	add a, b
	bit 3, a
	jr nz, .onSecondTile
	xor a
	jr .doneCalculatingTile
.onSecondTile
	ld a, 1
.doneCalculatingTile
	pop bc
	pop hl
	
.tileShiftLoop
	push bc
	push de
	push hl
	push af
	di
	ld a, [W_MainScript_VWFCompositeArea]
	ld h, a
	ld a, [W_MainScript_VWFCompositeArea + 1]
	ld l, a
	ld b, [hl]
	inc hl
	ld c, [hl]
	dec hl
	ld a, [de]
	ld d, a
	ld e, 0
	ld a, [W_MainScript_VWFOldTileMode]
	cp 2
	jr z, .newlineMode
	cp 1
	jr z, .secondTileMode
	jr .firstTileMode
	
.newlineMode
	ld c, 0
	
.secondTileMode
	ld b, c
	
.firstTileMode
	ld a, [W_MainScript_VWFLetterShift]
	or a
	jr z, .stopShifting
	
.shiftLoop
	srl d
	rr e
	dec a
	jr nz, .shiftLoop
	
.stopShifting
	ld a, d
	or b
	ld b, a
	ld c, e
	ld [hl], b
	inc hl
	ld [hl], c
	inc hl
	ld a, h
	ld [W_MainScript_VWFCompositeArea], a
	ld a, l
	ld [W_MainScript_VWFCompositeArea + 1], a
	pop af
	pop hl
	ld d, h
	ld e, l
	push af
	ld a, b
	call MainScript_ADVICE_ExpandGlyphWithCurrentTextStyle
	pop af
	push hl
	push af
	or a
	jr z, .skipSecondWhatevercall
	ld hl, $10
	add hl, de
	ld a, c
	call MainScript_ADVICE_ExpandGlyphWithCurrentTextStyle
	
.skipSecondWhatevercall
	ei
	pop af
	pop hl
	pop de
	pop bc
	inc de
	dec b
	jr nz, .tileShiftLoop
	ld a, 0
	ld [W_MainScript_VWFOldTileMode], a
	ld b, MainScript_ADVICE_DrawLetterTable >> 8
	ld a, [W_MainScript_VWFCurrentLetter]
	ld c, a
	ld a, [W_MainScript_VWFDisable]
	or a
	jr z, .useWidthTable
	ld a, 8
	jr .addWidth
	
.useWidthTable
	ld a, [bc]
	inc a
	
.addWidth
	ld b, a
	ld a, [W_MainScript_VWFLetterShift]
	add a, b
	bit 3, a
	jr z, .noSecondTileShiftBack
	sub 8
	push af
	ld a, 1
	ld [W_MainScript_VWFOldTileMode], a
	ld a, [W_MainScript_VWFMainScriptHack]
	cp 1
	jr nz, .noNewlineHackToDisable
	ld a, 0
	ld [W_MainScript_VWFMainScriptHack], a
	
.noNewlineHackToDisable
	pop af
	
.noSecondTileShiftBack
	ld [W_MainScript_VWFLetterShift], a
	ret

SECTION "Main Script Text Drawing Advice", ROMX[$7B00], BANK[$B]
MainScript_ADVICE_DrawLetterTable::
; Should always be at the address XX00.
	INCBIN "build/components/mainscript/font.metrics.bin"

MainScript_ADVICE_StoreCurrentLetter:
	ld [W_MainScript_VWFCurrentLetter], a
	push hl
	ld b, 0
	jp MainScript_DrawLetter.COMEFROM_StoreCurrentLetter

SECTION "Main Script Text Drawing Advice 2", ROMX[$7C3F], BANK[$B]
MainScript_ADVICE_ExpandGlyphWithCurrentTextStyle::
	push bc
	ld b, a
	ld a, [W_MainScript_TextStyle]
	
	bit 0, a
	jr nz, .bit0One
	
.bit0Zero
	bit 1, a
	jr z, .mode0
	jr nz, .mode2
	
.bit0One
	bit 1, a
	jr z, .mode1
	
.mode3
	db $FA, $41, $FF ;ld a, [REG_STAT] - the long way
	and 2
	jr nz, .mode3
	
	ld a, $FF
	ld [hli], a
	ld a, b
	ld [hli], a
	jr .end
	
.mode0
	db $FA, $41, $FF ;ld a, [REG_STAT] - the long way
	and 2
	jr nz, .mode0
	
	ld a, b
	ld [hli], a
	ld [hli], a
	jr .end
	
.mode1
	db $FA, $41, $FF ;ld a, [REG_STAT] - the long way
	and 2
	jr nz, .mode1
	
	ld a, b
	ld [hli], a
	ld a, $FF
	ld [hli], a
	jr .end
	
.mode2
	ld a, b
	cpl
	ld b, a
	
.mode2Loop
	db $FA, $41, $FF ;ld a, [REG_STAT] - the long way
	and 2
	jr nz, .mode2Loop
	
	ld a, b
	ld [hli], a
	ld [hli], a
	
.end
	pop bc
	ret
	
SECTION "Main Script Font Selector", ROMX[$7FC0], BANK[$B]
MainScript_ADVICE_FontSelector::
	ld a, [W_MainScript_ADVICE_FontToggle]
	and a
	jr nz, .drawNarrowCharacter
	call MainScript_ADVICE_DrawLetter
	ret
.drawNarrowCharacter
	ld a,[W_PreviousBank]
	push bc
	push af
	ld a, BANK(MainScript_ADVICE_FontSelector)
	ld [W_PreviousBank],a

	M_AuxJmp Banked_MainScript_ADVICE_DrawNarrowLetter

	ld b,a
	pop af
	ld [W_PreviousBank],a
	ld a,b
	pop bc
	ret
	
MainScript_ADVICE_FontAddress::
	ld a, [W_MainScript_ADVICE_FontToggle]
	cp 1
	jr z, .useNarrowCharacter
	cp 2
	jr z, .useBoldCharacter
	ld hl, MainScript_Font
	ret
	
.useBoldCharacter
	ld a, [W_MainScript_VWFCurrentLetter]
	cp $B8
	jr nc, .useNarrowCharacter
	ld hl, MainScript_BoldFont
	ret
	
.useNarrowCharacter
	ld hl, MainScript_NarrowFont
	ret
	
SECTION "Main Script Bold Text Drawing Advice1", ROMX[$71C0], BANK[$1]
MainScript_ADVICE_SelectFontTableMethodA::
	ld l, a
	push af
	ld a, [W_MainScript_ADVICE_FontToggle]
	cp 2
	jr nz, .useNarrowCharacter
	pop af
	ld h, MainScript_ADVICE_DrawBoldLetterTable >> 8
	ret
	
.useNarrowCharacter
	pop af
	ld h, MainScript_ADVICE_DrawNarrowLetterTable >> 8
	ret
	
MainScript_ADVICE_SelectFontTableMethodB::
	ld c, a
	push af
	ld a, [W_MainScript_ADVICE_FontToggle]
	cp 2
	jr nz, .useNarrowCharacter
	pop af
	ld b, MainScript_ADVICE_DrawBoldLetterTable >> 8
	ret
	
.useNarrowCharacter
	pop af
	ld b, MainScript_ADVICE_DrawNarrowLetterTable >> 8
	ret
	

SECTION "Main Script Narrow Text Drawing Advice1", ROMX[$7400], BANK[$1]
;BC = text string (presumed WRAM, not bankable)
;D = string length (bytes)
;Returns E = string length (pixels)
;Clobbers a, hl, flags; arguments not preserved
MainScript_ADVICE_CountNarrowTextWidth::
	 ld e, 0
    
.sizingLoop
    ld a, [bc]
    cp $E0
    jr z, .finishedMeasuring
    
    ;Index the font sizing array
    ld h, MainScript_ADVICE_DrawNarrowLetterTable >> 8
    ld l, a
    ld a, [hl]
    
    inc a ;Widths are stored with implicit 1px between characters for... some reason
    add e
    ld e, a
    
    inc bc
    dec d
    jr nz, .sizingLoop

.finishedMeasuring
    ; Remove the last post-letter 1-pixel space if there was any text.
    ld a, e
    cp 0
    ret z
    dec e

    ret

;This is a copy of MainScript_ADVICE_DrawLetter for rendering a narrow font
;because bank $B lacks room for the narrow font & other things.
MainScript_ADVICE_DrawNarrowLetter::
	M_AdviceSetup
	
	ld b, 8
	ld a, $CF
	ld [W_MainScript_VWFCompositeArea], a
	ld a, $D0
	ld [W_MainScript_VWFCompositeArea + 1], a
	push hl
	push bc
	ld a, [W_MainScript_VWFCurrentLetter]
	call MainScript_ADVICE_SelectFontTableMethodA
	xor a
	ld b, [hl]
	ld a, [W_MainScript_VWFLetterShift]
	add a, b
	bit 3, a
	jr nz, .onSecondTile
	xor a
	jr .doneCalculatingTile
	
.onSecondTile
	ld a, 1
	
.doneCalculatingTile
	pop bc
	pop hl
	
.tileShiftLoop
	push bc
	push de
	push hl
	push af
	di
	ld a, [W_MainScript_VWFCompositeArea]
	ld h, a
	ld a, [W_MainScript_VWFCompositeArea + 1]
	ld l, a
	ld b, [hl]
	inc hl
	ld c, [hl]
	dec hl
	ld a, [de]
	ld d, a
	ld e, 0
	ld a, [W_MainScript_VWFOldTileMode]
	cp 2
	jr z, .newlineMode
	cp 1
	jr z, .secondTileMode
	jr .firstTileMode
	
.newlineMode
	ld c, 0
	
.secondTileMode
	ld b, c
	
.firstTileMode
	ld a, [W_MainScript_VWFLetterShift]
	or a
	jr z, .stopShifting
	
.shiftLoop
	srl d
	rr e
	dec a
	jr nz, .shiftLoop
	
.stopShifting
	ld a, d
	or b
	ld b, a
	ld c, e
	ld [hl], b
	inc hl
	ld [hl], c
	inc hl
	ld a, h
	ld [W_MainScript_VWFCompositeArea], a
	ld a, l
	ld [W_MainScript_VWFCompositeArea + 1], a
	pop af
	pop hl
	ld d, h
	ld e, l
	push af
	ld a, b
	call MainScript_ADVICE_ExpandNarrowGlyphWithCurrentTextStyle
	pop af
	push hl
	push af
	or a
	jr z, .skipSecondWhatevercall
	ld hl, $10
	add hl, de
	ld a, c
	call MainScript_ADVICE_ExpandNarrowGlyphWithCurrentTextStyle
	
.skipSecondWhatevercall
	ei
	pop af
	pop hl
	pop de
	pop bc
	inc de
	dec b
	jr nz, .tileShiftLoop
	ld a, 0
	ld [W_MainScript_VWFOldTileMode], a
	ld a, [W_MainScript_VWFCurrentLetter]
	call MainScript_ADVICE_SelectFontTableMethodB
	ld a, [W_MainScript_VWFDisable]
	or a
	jr z, .useWidthTable
	ld a, 8
	jr .addWidth
	
.useWidthTable
	ld a, [bc]
	inc a
	
.addWidth
	ld b, a
	ld a, [W_MainScript_VWFLetterShift]
	add a, b
	bit 3, a
	jr z, .noSecondTileShiftBack
	sub 8
	push af
	ld a, 1
	ld [W_MainScript_VWFOldTileMode], a
	ld a, [W_MainScript_VWFMainScriptHack]
	cp 1
	jr nz, .noNewlineHackToDisable
	ld a, 0
	ld [W_MainScript_VWFMainScriptHack], a
	
.noNewlineHackToDisable
	pop af
	
.noSecondTileShiftBack
	ld [W_MainScript_VWFLetterShift], a
	
	M_AdviceTeardown
	ret
	
SECTION "Main Script Bold Text Drawing Advice", ROMX[$6B00], BANK[$1]
MainScript_ADVICE_DrawBoldLetterTable::
; Should always be at the address XX00.
	INCBIN "build/components/mainscript/font_bold.metrics.bin"
	
SECTION "Main Script Narrow Text Drawing Advice", ROMX[$7C00], BANK[$1]
MainScript_ADVICE_DrawNarrowLetterTable::
; Should always be at the address XX00.
	INCBIN "build/components/mainscript/font_narrow.metrics.bin"

SECTION "MainScript Narrow Text Drawing Advice 2", ROMX[$7BB6], BANK[$1]
MainScript_ADVICE_ExpandNarrowGlyphWithCurrentTextStyle::
;This is a copy of MainScript_ADVICE_ExpandGlyphWithCurrentTextStyle intended to ba called by MainScript_ADVICE_DrawNarrowLetter.
	push bc
	ld b, a
	ld a, [W_MainScript_TextStyle]
	
	bit 0, a
	jr nz, .bit0One
	
.bit0Zero
	bit 1, a
	jr z, .mode0
	jr nz, .mode2
	
.bit0One
	bit 1, a
	jr z, .mode1
	
.mode3
	ld a, [REG_STAT]
	and 2
	jr nz, .mode3
	
	ld a, $FF
	ld [hli], a
	ld a, b
	ld [hli], a
	jr .end
	
.mode0
	ld a, [REG_STAT]
	and 2
	jr nz, .mode0
	
	ld a, b
	ld [hli], a
	ld [hli], a
	jr .end
	
.mode1
	ld a, [REG_STAT]
	and 2
	jr nz, .mode1
	
	ld a, b
	ld [hli], a
	ld a, $FF
	ld [hli], a
	jr .end
	
.mode2
	ld a, b
	cpl
	ld b, a
	
.mode2Loop
	ld a, [REG_STAT]
	and 2
	jr nz, .mode2Loop
	
	ld a, b
	ld [hli], a
	ld [hli], a
	
.end
	pop bc
	ret