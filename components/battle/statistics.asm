INCLUDE "telefang.inc"

SECTION "Battle Index Statistics Func", ROM0[$3D0E]
Battle_IndexStatisticsArray::
	push hl
	ld c, a
	ld e, M_SaveClock_DenjuuStatSize
	call System_Multiply8
	pop hl
	add hl, de
	ret
	
	
SECTION "Battle Statistics Advice", ROMX[$7E1D], BANK[$34]
;Given a denjuu statistics array, return what denjuu ID it is.
;If denjuu is null it will look for the denjuu ID in W_Victory_DefectedSpeciesForNickname.
Battle_ADVICE_GetDenjuuSpeciesFromStatistics::
	push af
	push hl
	push bc
	ld c, M_SaveClock_DenjuuStatSize
	
	;Check if denjuu statistics are present.
.dataCheckLoop
	ld a, [hl]
	cp 0
	jp nz, .dataIsPresent
	inc hl
	dec c
	jr nz, .dataCheckLoop
	
	pop bc
	pop hl
	pop af
	ld hl, W_Victory_DefectedSpeciesForNickname
	ld e, [hl]
	ld d, 0
	ret
	
	;Empty space
	db 0,0,0,0,0,0
	
.dataIsPresent
	pop bc
	pop hl
	pop af
	ld e, [hl]
	ld d, 0
	ret