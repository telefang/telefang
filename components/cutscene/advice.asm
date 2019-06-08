INCLUDE "telefang.inc"

SECTION "Cutscene SGB Colour Advice", ROMX[$7A50], BANK[$29]
Cutscene_ADVICE_CheckSGB::
	ld a, [W_GameboyType]
	cp M_BIOS_CPU_CGB
	ret z
	ld a, [W_SGB_DetectSuccess]
	or a
	ret

Cutscene_ADVICE_TileLightColourClear::
	ld d, h
	ld e, l

.loop
	inc l
	di

.wfb
	ld a, [REG_STAT]
	and 2
	jr nz, .wfb

	ld c, [hl]
	ld a, [de]
	and c
	ld [de], a
	ei
	inc hl
	inc e
	inc de
	dec b
	jr nz, .loop
	ret

Cutscene_ADVICE_LoadSGBFiles::
	call Zukan_ADVICE_CheckSGB
	ret z
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	or a
	jr z, Cutscene_ADVICE_LoadSGBFiles_AntennaTree
	dec a 
	jp z, .placeholderJumpPoint
	dec a 
	jp z, .placeholderJumpPoint

.placeholderJumpPoint
	ret
	
Cutscene_ADVICE_LoadSGBFiles_AntennaTree::
	ld a, BANK(CutsceneAntennaTreeSGBOverlayGfx)
	ld hl, $9480
	ld de, CutsceneAntennaTreeSGBOverlayGfx
	ld bc, $60
	call Banked_LCDC_LoadTiles
	ld hl, $91A0
	ld b, $10
	call Cutscene_ADVICE_TileLightColourClear
	ld hl, $9200
	ld b, $28
	call Cutscene_ADVICE_TileLightColourClear
	ld l, $70
	ld b, 8
	call Cutscene_ADVICE_TileLightColourClear
	ld l, $A0
	ld b, $28
	call Cutscene_ADVICE_TileLightColourClear
	ld hl, $9310
	ld b, $20
	call Cutscene_ADVICE_TileLightColourClear
	ld l, $60
	ld b, $10
	call Cutscene_ADVICE_TileLightColourClear
	ld l, $B0
	ld b, $20
	call Cutscene_ADVICE_TileLightColourClear
	ld b, $1E
	ld d, $99
	ld hl, .table

.loop
	di

.wfb
	ld a, [REG_STAT]
	and 2
	jr nz, .wfb
	ld e, [hl]
	xor a
	ld [de], a
	ei
	inc hl
	dec b
	jr nz, .loop

	ld a, $16
	ld bc, $506
	ld de, $708
	jp Banked_SGB_ConstructPaletteSetPacket

.table
	db $20, $21, $32, $33, $40, $41
	db $42, $43, $44, $45, $46, $47
	db $4B, $4C, $4D, $4E, $4F, $50
	db $63, $64, $65, $66, $6C, $6D
	db $6E, $84, $85, $86, $8C, $8D

SECTION "Cutscene - Antenna Tree SGB Overlay", ROMX[$42C0], BANK[$77]
CutsceneAntennaTreeSGBOverlayGfx::
	INCBIN "build/gfx/cutscene/antenna_tree_sgb_overlay.2bpp"
