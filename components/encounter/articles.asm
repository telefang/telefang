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
	
SECTION "Battle Arrival Text Preparation", ROMX[$5D18], BANK[$1C]
Encounter_ADVICE_TFangerArticleTable::
; A temporary table for TFanger articles.
	dw .nil, .nil, .nil, .nil, .nil, .nil, .nil, .nil ; 07
	dw .nil, .nil, .nil, .nil, .nil, .nil, .nil, .nil ; 10
	dw .nil, .nil, .nil, .nil, .nil, .nil, .nil, .nil ; 17
	dw .nil, .nil, .nil, .nil, .nil, .nil, .nil, .nil ; 20
	dw .nil, .nil, .nil, .nil, .nil, .nil, .the, .nil ; 27
	dw .nil, .nil, .nil, .nil, .nil, .nil, .nil, .nil ; 30
	dw .nil                                           ; 31
	
.nil
	db $E0
	
.the
	db "The "
	db $E0