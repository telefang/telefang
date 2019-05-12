INCLUDE "telefang.inc"

SECTION "Map Screen Location Loader WRAM", WRAM0[$CCC0]
W_Map_LocationStaging:: ds M_Map_LocationStagingSize

SECTION "Map Screen Location Loader", ROMX[$4508], BANK[$2A]
Map_LoadLocationName::
	ld a, b
	ld hl, StringTable_map_location_mapping

Map_LoadLocationName_extEnt::
	ld b, 0
	ld c, a
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, W_Map_LocationStaging
	
.copyLoop
	ld a, [hli]
	ld [de], a
	inc de
	cp $E0
	jr nz, .copyLoop
	
	ld a, BANK(MainScript_ADVICE_CountTextWidth)
	ld hl, MainScript_ADVICE_CountTextWidth
	ld bc, W_Map_LocationStaging
	ld d, $FF
	rst $20 ;call CallBankedFunction_int but smaller
	
	ld a, 128
	cp e
	ld a, 0
	jr nc, .storeToggle
	
.textOverflow
	inc a
	
.storeToggle
	ld [W_MainScript_ADVICE_FontToggle], a
	ret
	
	;TODO: FREE SPACE
	nop

SECTION "Dungeon Map Location Loader", ROMX[$4030], BANK[$62]
DungeonMap_LoadLocationName::
	ld hl, StringTable_map_dungeon_mapping
	ld a, [W_Overworld_AcreType]
	ld b, 0
	ld c, a
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, W_Map_LocationStaging
	
.copyLoop
	ld a, [hli]
	ld [de], a
	inc de
	cp $E0
	jr nz, .copyLoop
	
	ld a, BANK(MainScript_ADVICE_CountTextWidth)
	ld hl, MainScript_ADVICE_CountTextWidth
	ld bc, W_Map_LocationStaging
	ld d, $FF
	rst $20 ;call CallBankedFunction_int but smaller
	
	ld a, 128
	cp e
	ld a, 0
	jr nc, .storeToggle
	
.textOverflow
	inc a
	
.storeToggle
	ld [W_MainScript_ADVICE_FontToggle], a
	ld a, BANK(DungeonMap_StateDrawScreen)
	ret

SECTION "Dungeon Map Location Loader Bankcall", ROM0[$3DE4]
Banked_DungeonMap_LoadLocationName::
	rst $10
	call DungeonMap_LoadLocationName
	rst $10
	ret
