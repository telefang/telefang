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
	ld de, W_Map_LocationStaging + $10
	ld [de], a
	pop hl
	pop de
	pop bc
	pop af
	ret
	
SECTION "Encounter Screen TFanger Article Table Advice", ROMX[$5E40], BANK[$1C]
Encounter_ADVICE_TFangerNameAndArticleLoader::
	call StringTable_LoadName75
	push bc
	push de
	push hl
	push af
	ld a, [W_StringTable_ROMTblIndex]
	ld e, a
	ld d, 0
	sla e
	rl d
	push de
	ld hl, Encounter_ADVICE_TFangerArticleTable
	add hl, de
	
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	push bc
	pop hl
	ld de, W_Map_LocationStaging
	ld b, $F
	
.copyLoopA
	ld a, [hli]
	cp $E0
	jr z, .abandonLoopA
	ld [de], a
	inc de
	dec b
	jr nz, .copyLoopA
	
.abandonLoopA
	
	ld a, $E0
	ld [de], a
	pop de
	ld hl, Encounter_ADVICE_TFangerArticleTableB
	add hl, de
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	push bc
	pop hl
	ld de, W_Map_LocationStaging + $10
	ld b, $F
	
.copyLoopB
	ld a, [hli]
	cp $E0
	jr z, .abandonLoopB
	ld [de], a
	inc de
	dec b
	jr nz, .copyLoopB
	
.abandonLoopB
	
	ld a, $E0
	ld [de], a
	
	pop af
	pop hl
	pop de
	pop bc
	ret