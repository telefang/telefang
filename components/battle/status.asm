INCLUDE "telefang.inc"

SECTION "Status Effect Gfx Table", ROMX[$7E00], BANK[$1]
DenjuuStatusEffectGfx::
	INCBIN "build/components/battle/status.1bpp"
	
SECTION "Draw Status Effect Gfx", ROMX[$4800], BANK[$1]
MainScript_ADVICE_DrawStatusEffectGfx::
	push hl
	ld de,DenjuuStatusEffectGfx
	ld l,b
	ld h,0
	sla l
	sla l
	sla l
	sla l
	sla l
	rl h
	add hl,de
	push hl
	pop de
	pop hl
	ld b,$20

.statusEffectWriteLoop
	ld a,[de]
	di
	call YetAnotherWFB
	ld [hli],a
	ld [hli],a
	ei
	inc de
	dec b
	jr nz, .statusEffectWriteLoop
	ret
   
MainScript_ADVICE_DrawStatusEffectGfx_END::