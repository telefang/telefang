INCLUDE "telefang.inc"

SECTION "Credits Text Address Buffer", WRAM0[$C387]
W_Credits_TextAddressBuffer:: ds 2

SECTION "Credits Text Position", WRAM0[$C383]
W_Credits_TextHorizontalPosition:: ds 1
W_Credits_TextVerticalPosition:: ds 1
W_Credits_TextCharacterNumber:: ds 1

SECTION "Credits Message Table", ROMX[$6D7A], BANK[$E]
Credits_MessageTable::
; Included for reference.

SECTION "Credits - Initiate First Screen", ROMX[$60FD], BANK[$E]
Credits_InitiateFirstScreen::
	ld a, $E
	ld [W_PreviousBank], a
	call Credits_ADVICE_Prepare
	ld a, 3
	ld [$C381], a
	ld a, 5
	ld [$C382], a
	ld a, [Credits_MessageTable]
	ld [W_Credits_TextAddressBuffer], a
	ld a, [Credits_MessageTable + 1]
	ld [W_Credits_TextAddressBuffer + 1], a
	ld bc, 1
	ld a, $33
	ld hl, $6601
	call CallBankedFunction_int
	call Credits_ParseAndRenderText
	call $6145
	call Credits_ADVICE_ResetSGBColours
	jp System_ScheduleNextSubState
	nop
	
Credits_ADVICE_VWFNextTile:
	ld a, [W_MainScript_VWFOldTileMode]
	cp 1
	ld a, [W_MainScript_TilesDrawn]
	jr c, .noIncrement
	inc a
	ld [W_MainScript_TilesDrawn], a
	call Credits_ADVICE_ClearFutureTile
	
.noIncrement
	ret
	
SECTION "Credits - Parse and Render Text", ROMX[$6286], BANK[$E]
Credits_ParseAndRenderText::
	call Credits_ADVICE_PrepareForDrawing

.nextCharacter
	ld a, [W_Credits_TextAddressBuffer + 1]
	ld h, a
	ld a, [W_Credits_TextAddressBuffer]
	ld l, a

.postLinebreak
	ld a, [hli]
	ld c, a
	cp $E1
	jr z, .endCodeFound
	cp $E2
	jr z, .lineBreakFound
	cp $F2
	jr z, .boldFontRequested
	ld a, h
	ld [W_Credits_TextAddressBuffer + 1], a
	ld a, l
	ld [W_Credits_TextAddressBuffer], a
	call Credits_ADVICE_DrawCharacter
	jr .nextCharacter

.boldFontRequested
	ld a, 2
	ld [W_MainScript_ADVICE_FontToggle], a
	jr .postLinebreak

.lineBreakFound
	call Credits_ADVICE_Newline
	jr .postLinebreak

.endCodeFound
	call Credits_ADVICE_Newline
	ld b, [hl]
	inc hl
	ld a, h
	ld [W_Credits_TextAddressBuffer + 1], a
	ld a, l
	ld [W_Credits_TextAddressBuffer], a
	xor a
	ret

Credits_ADVICE_ResetSGBColours::
	ld a, [W_SGB_DetectSuccess]
	or a
	ret z

	ld a, [W_GameboyType]
	cp M_BIOS_CPU_CGB
	ret z

	xor a
	ld b, a
	ld c, a
	ld d, a
	ld e, a
	ld [W_MainScript_TextStyle], a
	jp Banked_SGB_ConstructPaletteSetPacket

SECTION "Credits - Draw Character", ROMX[$622D], BANK[$E]
Credits_DrawCharacter::
; Legacy code. Most likely safe to remove, but we have room to burn, so it is easier to keep it.
	ld hl, $9000
	ld a, [W_Credits_TextCharacterNumber]
	ld e, a
	ld d, 0
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	add hl, de
	ld a, c
	call Banked_MainScript_DrawLetter
	ld hl, $9800
	ld a, [$C381]
	ld e, a
	ld a, [W_Credits_TextHorizontalPosition]
	add e
	ld e, a
	ld d, 0
	add hl, de
	ld a, [$C382]
	ld e, a
	ld a, [W_Credits_TextVerticalPosition]
	add e
	ld e, a
	ld d, 0
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	add hl, de
	ld a, [W_Credits_TextCharacterNumber]
	ld b, a

.jpA
	ldh a, [REG_STAT]
	and a, 2
	jr nz, .jpA
	ld [hl], b
	ret

SECTION "Credits - Patch Utils", ROMX[$62DD], BANK[$E]
Credits_ADVICE_Prepare::
	xor a
	ld [W_MainScript_TilesDrawn], a
	ld [W_Credits_TextHorizontalPosition], a
	ld [W_Credits_TextVerticalPosition], a
	ld [W_MainScript_ADVICE_FontToggle], a
	ld [W_MainScript_TextStyle], a
	ld [$C386], a
	ld [$C38B], a
	ld [$C38A], a
	inc a
	ld [W_Credits_TextCharacterNumber], a
	ld [W_MainScript_TileBaseIdx], a
	ld [W_OAM_SpritesReady], a
	ret
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

Credits_ADVICE_DrawCharacter::
	ld a, [W_MainScript_TilesDrawn]
	ld b, a
	ld a, [W_MainScript_TileBaseIdx]
	add b
	call LCDC_TileIdx2Ptr
	ld a, c
	call Banked_MainScript_DrawLetter
	call Credits_ADVICE_VWFNextTile
	ret
	nop
	nop
	nop
	nop

Credits_ADVICE_Newline::
	xor a
	ld [W_MainScript_VWFLetterShift], a
	ld [W_MainScript_VWFCurrentLetter], a
	ld [W_MainScript_ADVICE_FontToggle], a
	ld [W_Credits_TextHorizontalPosition], a
	push hl
	ld hl, $CFD0
	ld b, $10

.clearCompositeAreaLoop
	ld [hli], a
	dec b
	jr nz, .clearCompositeAreaLoop
	ld a, [W_MainScript_TilesDrawn]
	inc a
	ld b, a
	ld a, [W_MainScript_TileBaseIdx]
	add b
	ld [W_MainScript_TileBaseIdx], a

.tileMapLoop
	ld hl, $9800
	ld a, [$C381]
	ld e, a
	ld a, [W_Credits_TextHorizontalPosition]
	inc a
	ld [W_Credits_TextHorizontalPosition], a
	dec a
	add e
	ld e, a
	ld d, 0
	add hl, de
	ld a, [$C382]
	ld e, a
	ld a, [W_Credits_TextVerticalPosition]
	add e
	ld e, a
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	add hl, de
	ld a, [W_Credits_TextCharacterNumber]
	ld c, a

.jpA
	ldh a, [REG_STAT]
	and a, 2
	jr nz, .jpA
	ld [hl], c
	ld a, c
	inc a
	ld [W_Credits_TextCharacterNumber], a
	dec b
	jp nz, .tileMapLoop
	pop hl
	xor a
	ld [W_Credits_TextHorizontalPosition], a
	ld [W_MainScript_TilesDrawn], a

; Handle successive linebreaks without repeating the logic above.

.linebreakLoop
	ld a, [W_Credits_TextVerticalPosition]
	inc a
	ld [W_Credits_TextVerticalPosition], a
	ld a, [hli]
	cp $E2
	jr z, .linebreakLoop
	dec hl
	call Credits_ADVICE_ClearFirstTile
	ret
	nop
	nop
	nop
	nop
	
Credits_ADVICE_ClearFutureTile::
	push hl
	ld a, [W_MainScript_TilesDrawn]
	ld b, a
	ld a, [W_MainScript_TileBaseIdx]
	add b
	inc a
	jr Credits_ADVICE_ClearFirstTile.beginClear

Credits_ADVICE_ClearFirstTile::
; Clear the first tile on a line in case that line wasn't written to prior to a linebreak.
	push hl
	ld a, [W_MainScript_TileBaseIdx]

.beginClear
	call LCDC_TileIdx2Ptr
	ld b, $10

.jpA
	ldh a, [REG_STAT]
	and a, 2
	jr nz, .jpA
	xor a
	ld [hl], a
	inc hl
	dec b
	jr nz, .jpA
	pop hl
	ret
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
Credits_ADVICE_PrepareForDrawing::
	xor a
	ld [W_MainScript_TilesDrawn], a
	ld [W_Credits_TextHorizontalPosition], a
	ld [W_Credits_TextVerticalPosition], a
	ld [W_MainScript_VWFOldTileMode], a
	inc a
	ld [W_Credits_TextCharacterNumber], a
	ld [W_MainScript_TileBaseIdx], a
	call Credits_ADVICE_ClearFirstTile
	ret
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
