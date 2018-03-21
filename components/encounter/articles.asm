INCLUDE "telefang.inc"

SECTION "Encounter Screen Article Table Advice", ROMX[$5AB0], BANK[$1C]
Encounter_ADVICE_OpponentNameAndArticleLoader::
	call StringTable_LoadName75
	push af
	push bc
	push de
	push hl
	ld a, [W_StringTable_ROMTblIndex]
	ld e, a
	ld d, 0
	sla e
	rl d
	ld hl, Encounter_ADVICE_ArticleTable
	add hl, de
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	push bc
	pop hl
	ld de, W_Map_LocationStaging
	ld b, $10
	
.copyLoop
	ld a, [hli]
	cp $E0
	jr z, .abandonLoop
	ld [de], a
	inc de
	dec b
	jr nz, .copyLoop
	
.abandonLoop

	ld a, $E0
	ld [de], a
	pop hl
	pop de
	pop bc
	pop af
	ret