INCLUDE "telefang.inc"

SECTION "Credits Text Address Buffer", WRAM0[$C387]
W_Credits_TextAddressBuffer:: ds 2

SECTION "Credits Text Position", WRAM0[$C383]
W_Credits_TextHorizontalPosition:: ds 1
W_Credits_TextVerticalPosition:: ds 1
W_Credits_TextCharacterNumber:: ds 1

SECTION "Credits Message Table", ROMX[$62DD], BANK[$E]
Credits_MessageTable::
; Included for reference.

SECTION "Credits - Initiate First Screen", ROMX[$60FD], BANK[$E]
Credits_InitiateFirstScreen::
	ld a, $E
	ld [W_PreviousBank], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, 0
	ld [$C386], a
	ld a, 0
	ld [$C38B], a
	ld a, 3
	ld [$C381], a
	ld a, 5
	ld [$C382], a
	ld a, [Credits_MessageTable]
	ld [W_Credits_TextAddressBuffer], a
	ld a, [Credits_MessageTable + 1]
	ld [W_Credits_TextAddressBuffer + 1], a
	ld a, 0
	ld [W_MainScript_TextStyle], a
	ld bc, 1
	ld a, $33
	ld hl, $6601
	call CallBankedFunction_int
	ld a, 0
	ld [$C38A], a
	call Credits_ParseAndRenderText
	call $6145
	jp System_ScheduleNextSubState
	
SECTION "Credits - Parse and Render Text", ROMX[$6286], BANK[$E]
Credits_ParseAndRenderText::
	ld a, 0
	ld [W_Credits_TextHorizontalPosition], a
	ld a, 0
	ld [W_Credits_TextVerticalPosition], a
	ld a, 1
	ld [W_Credits_TextCharacterNumber], a

.nextCharacter
	ld a, [W_Credits_TextAddressBuffer + 1]
	ld h, a
	ld a, [W_Credits_TextAddressBuffer]
	ld l, a

.postLinebreak
	ld a, [hli]
	ld c, a
	cp a, $E1
	jr z, .endCodeFound
	cp a, $E2
	jr z, .lineBreakFound
	ld a, h
	ld [W_Credits_TextAddressBuffer + 1], a
	ld a, l
	ld [W_Credits_TextAddressBuffer], a
	call Credits_DrawCharacter
	ld a, [W_Credits_TextHorizontalPosition]
	inc a
	ld [W_Credits_TextHorizontalPosition], a
	ld a, [W_Credits_TextCharacterNumber]
	inc a
	ld [W_Credits_TextCharacterNumber], a
	jr .nextCharacter

.lineBreakFound
	ld a, [W_Credits_TextVerticalPosition]
	inc a
	ld [W_Credits_TextVerticalPosition], a
	ld a, 0
	ld [W_Credits_TextHorizontalPosition], a
	inc hl
	jr .postLinebreak

.endCodeFound
	ld b, [hl]
	inc hl
	ld a, h
	ld [W_Credits_TextAddressBuffer + 1], a
	ld a, l
	ld [W_Credits_TextAddressBuffer], a
	xor a
	ret

SECTION "Credits - Draw Character", ROMX[$622D], BANK[$E]
Credits_DrawCharacter::
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
	ld d, $00
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
