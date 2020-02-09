INCLUDE "telefang.inc"

SECTION "Shop Number Gfx Table", ROMX[$7D00], BANK[$1]
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

	ld a, [W_MainScript_TextStyle]
	cp 3
	jr z, .textStyle3

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

.textStyle3
	ld c, $FF

.numberWriteLoopTextStyle3
	ld a, [de]
	di
	call YetAnotherWFB
	ld [hl], c
	inc hl
	ld [hli], a
	ei
	inc de
	dec b
	jr nz, .numberWriteLoopTextStyle3
	jp Battle_ADVICE_BattleArticle_teardown

SECTION "Fusion SGB Colours", ROMX[$6520], BANK[$1]
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

    ld a, 3
    ld [W_MainScript_TextStyle], a

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 1)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld hl, W_LCDC_CGBStagingOBPaletteArea + (M_LCDC_CGBStagingAreaStride * 1) + (M_LCDC_CGBColorSize * 2) + 1
    call FusionLabEvo_ADVICE_FixOBPaletteForSGB

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

FusionLabEvo_ADVICE_FixOBPaletteForSGB::
    ld a, [hld]
    ld b, a
    ld a, [hld]
    ld c, a
    ld a, b
    ld [hld], a
    ld a, c
    ld [hl], a
    ret

FusionLabEvo_ADVICE_LoadSGBFilesFusionAnimation::
	M_AdviceSetup

	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 1)
	call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld hl, W_LCDC_CGBStagingOBPaletteArea + (M_LCDC_CGBStagingAreaStride * 1) + (M_LCDC_CGBColorSize * 2) + 1
    call FusionLabEvo_ADVICE_FixOBPaletteForSGB

    ld c, $1D
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, $107
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld bc, $709
    call PatchUtils_CommitStagedCGBToSGB

.noSGB
	M_AdviceTeardown
	ret

FusionLabEvo_ADVICE_LoadSGBFilesEvolution::
	M_AdviceSetup

	ld a, 5
	call CGBLoadBackgroundPaletteBanked

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, $106
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld bc, $505
    call PatchUtils_CommitStagedCGBToSGB

.noSGB
	M_AdviceTeardown
	ret

FusionLabEvo_ADVICE_LoadSGBFilesItemSelection::
	M_AdviceSetup

	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation

	call PauseMenu_ADVICE_CheckSGB
	jr z, .noSGB

	ld a, 3
	ld [W_MainScript_TextStyle], a

    ld hl, $8880
    ld b, $10
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $8A00
    ld b, $70
    call Zukan_ADVICE_TileLightColourReverse

    ld hl, $8B00
    ld b, $40
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld b, $C0
    call Zukan_ADVICE_TileLowByteBlanketFill
	
    ld b, $68
    call Zukan_ADVICE_TileLightColourReverse

    ld c, $1C
    call Banked_SGB_ConstructATFSetPacket

	call FusionLabEvo_ADVICE_SGBPaletteLayoutLogic

.noSGB
	M_AdviceTeardown
	ret

FusionLabEvo_ADVICE_SwitchSGBPaletteLayout::
	M_AdviceSetup

	call PauseMenu_ADVICE_CheckSGB
	jr z, .return

	call FusionLabEvo_ADVICE_SGBPaletteLayoutLogic

.return
	M_AdviceTeardown
	ret

FusionLabEvo_ADVICE_SGBPaletteLayoutLogic::
	ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 1)
	call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

	ld a, [W_FusionLabEvo_ScrollPositionIndex]
	or a
	jr z, .position0
	dec a
	jr z, .position1
	dec a
	jr z, .position2

.position3
	ld a, M_SGB_Pal01 << 3 + 1
	ld bc, $103
	call PatchUtils_CommitStagedCGBToSGB
	ld bc, $405
	jr .continue

.position2
	ld a, M_SGB_Pal01 << 3 + 1
	ld bc, $106
	call PatchUtils_CommitStagedCGBToSGB
	ld bc, $304
	jr .continue

.position1
	ld a, M_SGB_Pal01 << 3 + 1
	ld bc, $105
	call PatchUtils_CommitStagedCGBToSGB
	ld bc, $603
	jr .continue

.position0
	ld a, M_SGB_Pal01 << 3 + 1
	ld bc, $104
	call PatchUtils_CommitStagedCGBToSGB
	ld bc, $506

.continue
	ld a, M_SGB_Pal23 << 3 + 1
	jp PatchUtils_CommitStagedCGBToSGB
