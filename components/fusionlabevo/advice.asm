INCLUDE "telefang.inc"

SECTION "Shop Number Gfx Table", ROMX[$6A00], BANK[$1]
ShopNumberGfx::
	INCBIN "build/components/fusionlabevo/shop_numbers.1bpp"
	
SECTION "Draw Shop Number Gfx", ROMX[$5240], BANK[$1]
FusionLabEvo_ADVICE_DrawShopNumberGfx::
	M_AdviceSetup
	
	ld d, ShopNumberGfx >> 8
	sla e
	sla e
	sla e
	ld b, 8

.numberWriteLoop
	ld a, [de]
	di
	call YetAnotherWFB
	ld [hli], a
	ld [hli], a
	ei
	inc de
	dec b
	jr nz, .numberWriteLoop
	jp Battle_ADVICE_BattleArticle_teardown

SECTION "Fusion/Lab No Evolution Advice Code", ROMX[$6440], BANK[$1]
FusionLabEvo_ADVICE_LoadSGBFilesNoEvolution::
    M_AdviceSetup

    ld a, 1
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld hl, $8800
    ld b, $30
    call Zukan_ADVICE_TileLowByteBlanketFill
	
    ld hl, $8900
    ld b, $18
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $8B00
    ld b, $20
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $8C00
    ld b, $C0
    call Zukan_ADVICE_TileLowByteBlanketFill
	
    ld b, $68
    call Zukan_ADVICE_TileLightColourReverse

    ld a, 3
    ld [W_MainScript_TextStyle], a

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 1)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld hl, W_LCDC_CGBStagingOBPaletteArea + (M_LCDC_CGBStagingAreaStride * 1) + (M_LCDC_CGBColorSize * 2) + 1
    ld a, [hld]
    ld b, a
    ld a, [hld]
    ld c, a
    ld a, b
    ld [hld], a
    ld a, c
    ld [hl], a

    ld c, $1B
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 1
    ld c, 6
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 6
    ld c, 9
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

FusionLabEvo_ADVICE_LoadSGBFilesItemSelection::
	M_AdviceSetup

	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation

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

	ld a, $E0
	ld [W_Status_NumericalTileIndex], a
	call Status_ExpandNumericalTiles

.noSGB
	M_AdviceTeardown
	ret