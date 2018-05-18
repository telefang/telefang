INCLUDE "telefang.inc"

SECTION "GBC Colour To SGB Colour Converter", ROMX[$7430], BANK[$1]
PatchUtils_ColourToSGB::

	push af
	push bc
	push hl
	ld h, 0
	ld bc, PatchUtils_ColourToSGB_Table
	
; Red
	push bc
	ld a, e
	call PatchUtils_ColourToSGB_LookupTable
	ld l, c
	pop bc

; Green
	push de
	push bc
	call PatchUtils_LimitBreak
	sla e
	rl d
	ld a, d
	call PatchUtils_ColourToSGB_LookupTable
	ld d, c
	ld e, 0
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	add hl, de
	pop bc
	pop de
	
; Blue
	push bc
	srl d
	srl d
	ld a, d
	call PatchUtils_ColourToSGB_LookupTable
	sla c
	sla c
	ld a, c
	add a, h
	ld h, a
	pop bc
	
	push hl
	pop de
	
	pop hl
	pop bc
	pop af
	ret

PatchUtils_ColourToSGB_LookupTable::
	and $1F
	add a, c
	ld c, a
	ld a, [bc]
	ld c, a
	ret

SECTION "GBC Colour To SGB Colour Table", ROMX[$7480], BANK[$1]

PatchUtils_ColourToSGB_Table::

; IMPORTANT!
; The address for this table cannot be between XXE1 and XXFF or the lookup function would fail.

	db $00, $00, $02, $05, $07, $08, $0A, $0C
	db $0D, $0E, $0F, $11, $12, $13, $14, $15
	db $16, $17, $18, $19, $1A, $1B, $1B, $1C
	db $1C, $1D, $1D, $1E, $1E, $1F, $1F, $1F