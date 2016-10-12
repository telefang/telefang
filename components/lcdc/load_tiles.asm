INCLUDE "telefang.inc"

SECTION "Load Tiles WRAM", WRAM0[$CA52]
W_LCDC_LastBank:: ds 1

SECTION "Load Tiles Banked", ROM0[$372D]
Banked_LCDC_LoadTiles::
	push af
	ld a, [W_CurrentBank]
	ld [W_LCDC_LastBank], a
	pop af
	rst $10
	call LCDC_LoadTiles
	ld a, [W_LCDC_LastBank]
	rst $10
	ret

SECTION "Load Tiles", ROM0[$3801]
LCDC_LoadTiles::
	bit 0, c
	jr z, .evenCopy
	
.oddCopyLoop
	di
	
.oddCopyWait
	ld a, [REG_STAT]
	and 2
	jr nz, .oddCopyWait
	ld a, [de]
	ld [hli], a
	ei
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .oddCopyLoop
	ret
	
.evenCopy
	srl b
	rr c
	
.evenCopyLoop
	di
	
.evenCopyWait
	ld a, [REG_STAT]
	and 2
	jr nz, .evenCopyWait
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ei
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .evenCopyLoop
	ret