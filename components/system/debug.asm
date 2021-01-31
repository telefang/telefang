INCLUDE "telefang.inc"

SECTION "Debug Map Selector Feature",  ROMX[$5FAF],  BANK[$B]
Debug_StateMapSelector::
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, [W_Overworld_AcreType]
	inc a
	ld [W_Overworld_AcreType], a
	cp $35
	jr c, .mapTiles
	ld a, 0
	ld [W_Overworld_AcreType], a
	jr .mapTiles

.leftNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, [W_Overworld_AcreType]
	dec a
	ld [W_Overworld_AcreType], a
	cp 2
	jr nc, .mapTiles
	ld a, $34
	ld [W_Overworld_AcreType], a
	jr .mapTiles

.rightNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Up
	jr z, .upNotPressed
	call Debug_MapSelectorDecAcre
	jr .mapTiles

.upNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Down
	jr z, .mapTiles
	call Debug_MapSelectorIncAcre

.mapTiles
	push af
	push hl
	push bc
	ld a, [W_Overworld_AcreType]
	ld hl, $9C01
	call $353B
	pop bc
	pop hl
	pop af
	push af
	push hl
	push bc
	ld a, [$C906]
	ld hl, $9C04
	call $353B
	pop bc
	pop hl
	pop af
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	ld a, $50
	ld [$C902], a
	ld a, $40
	ld [$C901], a
	ld a, 2
	ld [W_Overworld_State], a
	ld a, 7
	ld [W_SystemSubState], a
	ld a, 4
	jp LCDC_SetupPalswapAnimation

SECTION "Debug Map Selector Feature 2",  ROMX[$603C],  BANK[$B]
Debug_MapSelectorIncAcre::
	ld a, [$C906]
	inc a
	and $3F
	ld [$C906], a
	call $2793
	ld a, [$C903]
	cp $FF
	ret nz
	jr Debug_MapSelectorIncAcre

Debug_MapSelectorDecAcre::
	ld a, [$C906]
	dec a
	and $3F
	ld [$C906], a
	call $2793
	ld a, [$C903]
	cp $FF
	ret nz
	jr Debug_MapSelectorDecAcre
