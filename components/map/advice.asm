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

	ld a, $48
	ld [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 0) + (M_LCDC_CGBColorSize * 3) + 1], a
	ld [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 1) + (M_LCDC_CGBColorSize * 3) + 1], a
	ld [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 2) + (M_LCDC_CGBColorSize * 3) + 1], a
	
	ld a, [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 7) + (M_LCDC_CGBColorSize * 0)]
	ld [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 7) + (M_LCDC_CGBColorSize * 1)], a

	ld a, [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 7) + (M_LCDC_CGBColorSize * 0) + 1]
	ld [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 7) + (M_LCDC_CGBColorSize * 1) + 1], a

	ld a, $32
	ld [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 2) + (M_LCDC_CGBColorSize * 2)], a

	ld a, $49
	ld [W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 2) + (M_LCDC_CGBColorSize * 2)], a

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
