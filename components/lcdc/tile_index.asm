INCLUDE "telefang.inc"

SECTION "LCDC Tile Index To Ptr", ROM0[$35C2]
LCDC_TileIdx2Ptr::
	cp $80
	jr c, .firstPage
	swap a
	ld h, a
	and $F0
	ld l, a
	ld a, h
	and $F
	or $80
	ld h, a
	ret

.firstPage
	swap a
	ld h, a
	and $F0
	ld l, a
	ld a, h
	and $F
	or $90
	ld h, a
	ret