INCLUDE "telefang.inc"

SECTION "Main Script Arrow Position Variable", WRAM0[$C9D7]
W_MainScript_ArrowPosition:: ds 1

SECTION "Main Script Arrow Display", ROMX[$4484], BANK[$B]
MainScript_ArrowInput::

; Check if "left" was pressed.

	ldh a, [H_JPInput_Changed]
	and a, $20
	jr z, .skipLeftAction

; Check if the arrow is positioned to the right.

	ld a, [W_MainScript_ArrowPosition]
	cp a, 1
	jr z, .skipRightAction

; Store the new arrow position.

	ld a, 1
	ld [W_MainScript_ArrowPosition], a

; Schedule SFX.

	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	jr .skipRightAction

; Check if "b" or "right" were pressed.

.skipLeftAction
	ldh a, [H_JPInput_Changed]
	and a, $12
	jr z, .skipRightAction

; Check if the arrow is positioned to the left.

	ld a,[W_MainScript_ArrowPosition]
	cp a, 0
	jr z, .skipRightAction

; Store the new arrow position.
	
	ld a, 0
	ld [W_MainScript_ArrowPosition], a

; Schedule SFX.

	ld a, 2
	ld [W_Sound_NextSFXSelect], a

; Register "b" is loaded the relative offset from W_Status_NumericalTileIndex where the relevant "arrow" or "not arrow" tiles are found. So $F means "no arrow" and $E means "arrow".
; Register "c" is loaded with the tile mapping position relative to the start of the row the second line of text resides on.
; First up is the left arrow position.

.skipRightAction
	ld b, $F
	ld a, [W_MainScript_ArrowPosition]
	or a
	jr z, .notLeftPos
	ld b, $E
  
.notLeftPos
	ld c, 2

; Map the relevant left arrow tile.

	push bc
	call MainScript_MapArrowTile
	pop bc
	
; And now the right arrow position.

	ld a, [W_MainScript_SecondAnswerTile]
	and a, $F
	add a, 2
	ld c, a

; Set "b" to $E if it was $F and vice versa.

	ld a, b
	xor 1
	ld b, a

; Map the relevant right arrow tile.

	call MainScript_MapArrowTile
	ret

MainScript_MapArrowTile::

; Calculate the start of the row the last line of text is typically printed and store in "hl". For example this would be $98A0 if the window was at the top of the screen.

	ld a, [W_MainScript_WindowLocation]
	add a, 4
	push bc
	call $4B68
	pop bc

; Add "c" to "hl", except "c" is treated as signed. This is awesome for obvious reasons. If "c" is set to $A2 before calling MainScript_MapArrowTile then it will position the arrow (or blank space for said arrow) at the start of the first line if you ever wanted to... *coughverticalselection*cough*

	push bc
	call $4C32
	pop bc

; Calculate the tile index being mapped.

	ld a, [W_Status_NumericalTileIndex]
	add b
	ld b, a

; Map the tile.

	di
	call WaitForBlanking
	ld [hl], b
	ei
	ret
