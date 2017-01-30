INCLUDE "registers.inc"

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
	ld hl, MainScript_Font
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	call MainScript_ADVICE_DrawLetter
	ret
	ds $5C

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
	call $7C3F ;TODO: Disassemble mystery function
	pop af
	push hl
	push af
	or a
	jr z, .skipSecondWhatevercall
	ld hl, $10
	add hl, de
	ld a, c
	call $7C3F
	
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
	ld b, $7B
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
MainScript_ADVICE_DrawLetterTable:
;This table is consulted to determine the widths of every letter in the font.
;There are 256 entries.
db $07, $07, $07, $07, $07, $07, $06, $05, $06, $07, $07, $07, $07, $07, $07, $07
db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
db $04, $03, $03, $05, $04, $05, $05, $02, $02, $02, $03, $05, $02, $04, $01, $07
db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $03, $03, $04, $04, $04, $05
db $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05
db $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $02, $07, $02, $03, $04
db $02, $05, $04, $04, $04, $04, $03, $04, $04, $03, $03, $04, $03, $05, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $05, $04, $04, $04, $03, $01, $03, $07, $07
db $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05
db $05, $05, $05, $05, $05, $05, $05, $07, $07, $07, $07, $07, $07, $07, $03, $05
db $05, $04, $03, $04, $04, $05, $04, $03, $04, $04, $05, $04, $03, $04, $04, $05
db $04, $03, $04, $04, $04, $04, $04, $07, $07, $07, $07, $07, $07, $07, $07, $07
db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07

MainScript_ADVICE_StoreCurrentLetter:
	ld [W_MainScript_VWFCurrentLetter], a
	push hl
	ld b, 0
	jp MainScript_DrawLetter.COMEFROM_StoreCurrentLetter