INCLUDE "telefang.inc"

SECTION "Map Screen Location Loader WRAM", WRAM0[$CCC0]
W_Map_LocationStaging: ds M_Map_LocationStagingSize

SECTION "Map Screen Location Loader", ROMX[$4508], BANK[$2A]
Map_LoadLocationName:
	ld a, b
	ld hl, StringTable_map_location_mapping
	ld b, 0
	ld c, a
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, W_Map_LocationStaging
	push hl
	jp .noAddedSpaces

;A bit of an explanation - the patch for this function is to just skip space
;counting, but it overwrites part of the loop target. Hence the weird macro
;down there. I'd like to avoid unnecessary byte changes.
.lengthCountLoop
	ld a, [hli]
	cp $E0
	jr nz, .lengthCountLoop - 1
	
	srl c
	ld a, c
	or a
	jr z, .noAddedSpaces
	
	ld a, 0
.spaceLoop
	ld [de], a
	inc de
	dec c
	jr nz, .spaceLoop
	
.noAddedSpaces
	pop hl
	
.copyLoop
	ld a, [hli]
	ld [de], a
	inc de
	cp $E0
	jr nz, .copyLoop
	ret