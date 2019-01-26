INCLUDE "telefang.inc"

SECTION "Calls Menu Advice Code 1", ROMX[$57F0], BANK[$1]
PauseMenu_ADVICE_LoadSGBFilesOutboundCall::
    M_AdviceSetup

    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jp z, .return

    ld hl, $8800
    ld b, $68
    call Zukan_ADVICE_TileLightColourReverse

    ld a, 3
    ld [W_MainScript_TextStyle], a

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)

    ; Create this label
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld a, [W_Encounter_SceneryType]
    cp 5
    jr nz, .notsky

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 3)
    ld de, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 4)
    ld b, M_LCDC_CGBStagingAreaStride

.copyloop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyloop

    jr .notfield

.notsky
    or a
    jr nz, .notfield

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 3) + (M_LCDC_CGBColorSize * 2)
    ld de, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 4) + (M_LCDC_CGBColorSize * 2)

    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a

.notfield
    ld c, $C
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 4
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 6
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

PauseMenu_ADVICE_RedrawIndicatorsForSGBOutboundCall::
    M_AdviceSetup

    ld d, $C
    call $520

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld hl, $8FC0
    ld b, $10
    call Zukan_ADVICE_TileLowByteBlanketFill

.return
	
    M_AdviceTeardown
    ret
