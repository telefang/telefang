INCLUDE "telefang.inc"

SECTION "Map Screen Advice Code", ROMX[$59F0], BANK[$1]
Map_ADVICE_DrawScreen::
	M_AdviceSetup

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	ld a, BANK(MapAcreSGBGfxA)
	ld hl, $9000
	ld de, MapAcreSGBGfxA
	ld bc, $800
	call Banked_LCDC_LoadTiles
	ld a, BANK(MapAcreSGBGfxB)
	ld hl, $8800
	ld de, MapAcreSGBGfxB
	ld bc, $280
	call Banked_LCDC_LoadTiles
	ld a, BANK(MapCursorGfx)
	ld hl, $8000
	ld de, MapCursorGfx
	ld bc, $490
	call Banked_LCDC_LoadTiles
	ld a, BANK(MapBackgroundSGBGfx)
	ld hl, $8C00
	ld de, MapBackgroundSGBGfx
	ld bc, $C0
	call Banked_LCDC_LoadTiles
	jr .exit

.noSGB
	ld a, BANK(MapAcreGfxA)
	ld hl, $9000
	ld de, MapAcreGfxA
	ld bc, $800
	call Banked_LCDC_LoadTiles
	ld a, BANK(MapAcreGfxB)
	ld hl, $8800
	ld de, MapAcreGfxB
	ld bc, $280
	call Banked_LCDC_LoadTiles
	ld a, BANK(MapCursorGfx)
	ld hl, $8000
	ld de, MapCursorGfx
	ld bc, $490
	call Banked_LCDC_LoadTiles
	ld a, BANK(MapBackgroundGfx)
	ld hl, $8C00
	ld de, MapBackgroundGfx
	ld bc, $C0
	call Banked_LCDC_LoadTiles

.exit
	M_AdviceTeardown
	ret

Map_ADVICE_UnloadSGBFiles::
	M_AdviceSetup

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	xor a
	ld b, a
	ld c, a
	ld d, a
	ld e, a
	call Banked_SGB_ConstructPaletteSetPacket

	xor a
	ld [W_MainScript_TextStyle], a

.noSGB
	call PauseMenu_ADVICE_SMSResetLine
	xor a
	ld [W_byte_C9CF], a

	M_AdviceTeardown
	ret

Map_ADVICE_LoadSGBFiles::
	M_AdviceSetup

	ld b, 7
	call $33AF

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	ld b, M_LCDC_CGBStagingAreaStride * 3
	
	ld de, .colourTable
	ld hl, W_LCDC_CGBStagingBGPaletteArea
	ld b, 3
	
.paletteLoop
	inc hl
	inc hl
	ld c, 6
	
.colourLoop
	ld a, [de]
	ld [hli], a
	inc de
	
	dec c
	jr nz, .colourLoop
	dec b
	jr nz, .paletteLoop

	ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 7) + (M_LCDC_CGBColorSize * 0)
	ld a, [hli]
	ld b, a
	ld a, [hli]
	inc hl
	ld [hld], a
	ld a, b
	ld [hl], a

	ld c, $D
	call Banked_SGB_ConstructATFSetPacket
	
	ld a, M_SGB_Pal01 << 3 + 1
	ld b, 0
	ld c, 1
	call PatchUtils_CommitStagedCGBToSGB
	
	ld a, M_SGB_Pal23 << 3 + 1
	ld b, 2
	ld c, 7
	call PatchUtils_CommitStagedCGBToSGB

	ld a, 3
	ld [W_MainScript_TextStyle], a

.noSGB
	M_AdviceTeardown
	ret

.colourTable
	dw $1DD2, $00CE, $48C6
	dw $1DD2, $0A43, $48C6
	dw $1DD2, $4932, $48C6

Map_ADVICE_WindowUnloadSGBFiles::
	M_AdviceSetup

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	ld c, $D
	call Banked_SGB_ConstructATFSetPacket

.noSGB
	M_AdviceTeardown
	ret

Map_ADVICE_WindowLoadSGBFiles::
	M_AdviceSetup

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	ld a, [W_Map_CursorYPosBuffer]
	ld c, $E
	cp $4C
	jr nc, .cursorOnBottomHalf
	inc c

.cursorOnBottomHalf
	call Banked_SGB_ConstructATFSetPacket

	ld hl, $8F00
	ld b, $28
	call Zukan_ADVICE_TileLightColourReverse

	ld l, $60
	ld b, $28
	call Zukan_ADVICE_TileLightColourReverse

	ld l, $C0
	ld b, 8
	call Zukan_ADVICE_TileLowByteBlanketFill

.noSGB
	M_AdviceTeardown
	ret

SECTION "Dungeon Map Screen Advice Code", ROMX[$6290], BANK[$1]
DungeonMap_ADVICE_DrawScreen::
	M_AdviceSetup

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	ld a, BANK(MapBackgroundDungeonSGBGfx)
	ld hl, $9400
	ld de, MapBackgroundDungeonSGBGfx
	ld bc, $C0
	call Banked_LCDC_LoadTiles
	jr .exit

.noSGB

	ld a, BANK(MapBackgroundGfx)
	ld hl, $9400
	ld de, MapBackgroundGfx
	ld bc, $C0
	call Banked_LCDC_LoadTiles

.exit
	M_AdviceTeardown
	ret

DungeonMap_ADVICE_LoadSGBFiles::
	M_AdviceSetup

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 7) + (M_LCDC_CGBColorSize * 0)
	ld a, [hli]
	ld b, a
	ld a, [hli]
	inc hl
	ld [hld], a
	ld a, b
	ld [hl], a

	ld hl, $8F00
	ld b, $28
	call Zukan_ADVICE_TileLightColourReverse

	ld l, $60
	ld b, $20
	call Zukan_ADVICE_TileLightColourReverse

	ld hl, $8E00
	ld b, $40
	call Zukan_ADVICE_TileLowByteBlanketFill

	ld c, $15
	call Banked_SGB_ConstructATFSetPacket

	ld a, M_SGB_Pal01 << 3 + 1
	ld bc, 1
	call PatchUtils_CommitStagedCGBToSGB
	
	ld a, M_SGB_Pal23 << 3 + 1
	ld bc, $207
	call PatchUtils_CommitStagedCGBToSGB

	ld a, 3
	ld [W_MainScript_TextStyle], a

.noSGB
	M_AdviceTeardown
	ret
