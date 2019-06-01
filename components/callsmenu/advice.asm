INCLUDE "telefang.inc"

SECTION "Calls Menu Advice Code 1", ROMX[$57D0], BANK[$1]
PauseMenu_ADVICE_LoadSGBFilesInboundCall::
    M_AdviceSetup

    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jp z, PauseMenu_ADVICE_LoadSGBFilesOutboundCall.return

    ld hl, $8C00
    ld b, $C0
    call Zukan_ADVICE_TileLowByteBlanketFill
    ld b, $68
    call Zukan_ADVICE_TileLightColourReverse

    ld a, 3
    ld [W_MainScript_TextStyle], a

    jr PauseMenu_ADVICE_LoadSGBFilesOutboundCall.extEntry

LateDenjuu_ADVICE_LoadSGBFiles::
    M_AdviceSetup

    ld a, 1
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jp z, PauseMenu_ADVICE_LoadSGBFilesOutboundCall.return

    jr PauseMenu_ADVICE_LoadSGBFilesOutboundCall.extEntry

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

.extEntry
    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)

    ; Create this label
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    call PauseMenu_ADVICE_FixSGBSceneryPalette
    ld c, $C
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 4
    call PatchUtils_CommitStagedCGBToSGB

    call PauseMenu_ADVICE_CGBToSGB56Shorthand

.return
    M_AdviceTeardown
    ret

PauseMenu_ADVICE_FixSGBSceneryPalette::
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
	ret
