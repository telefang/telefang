INCLUDE "telefang.inc"

SECTION "Status Effect Gfx Table", ROMX[$7D80], BANK[$1]
DenjuuStatusEffectGfx::
	INCBIN "build/components/battle/status.1bpp"
	
SECTION "Draw Status Effect Gfx", ROMX[$4840], BANK[$1]
MainScript_ADVICE_DrawStatusEffectGfx::
	push hl
	ld de, DenjuuStatusEffectGfx
	ld c, b
	ld b, 0
	sla c
	sla c
	sla c ; * 1 tile
	ld h, b
	ld l, c
	sla l ; * 2 tiles
	sla l ; * 4 tiles
	rl h
	add hl, bc ; + * 1 tile
	add hl, de
	push hl
	pop de
	pop hl
	ld b, $50 / 2 ; 5 tiles, 2 bytes at a time.

.statusEffectWriteLoop
	ld a,[de]
	di
	call YetAnotherWFB
	ld [hli], a
	ld [hli], a
	ei
	inc de
	dec b
	jr nz, .statusEffectWriteLoop

	ret
   
MainScript_ADVICE_DrawStatusEffectGfx_END::