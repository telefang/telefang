INCLUDE "telefang.inc"

SECTION "Main Script Temporary Storage for Text Style", WRAM0[$C7CD]
W_MainScript_TextStylePreserve:: ds 1

SECTION "Battle Advice Code", ROMX[$50A0], BANK[$1]
Battle_ADVICE_ClearStatusEffectTilemaps::
    M_AdviceSetup

    ; Original replaced code.
    ld bc, $01
    call Banked_LoadMaliasGraphics

    ; And then we gotta clear the status effect tilemaps.
    ld hl, $9801 ; Partner's tiles
    ld bc, (2 << 8) | (5 / 2)
    xor a
.clearLoop
    di
    call YetAnotherWFB
    ld [hli], a
    ld [hli], a
    ei
    dec c
    jr nz, .clearLoop

    di
    call YetAnotherWFB
    ld [hli], a ; Aaand the fifth tile.
    ei
    
    ld hl, $9D01 ; Opponent's tiles
    dec b
    jr nz, .clearLoop

    M_AdviceTeardown
    ret

SECTION "Direct Battle Screen Exit To Overworld Advice Code", ROMX[$5100], BANK[$1]
Battle_ADVICE_ExitToOverworld::
    M_AdviceSetup
    ld a, M_System_GameStateOverworld
    ld [W_SystemState], a
    ld a, [W_SGB_DetectSuccess]
    or a
    jr z, .noSGB

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .noSGB

    xor a
    ld b, a
    ld c, a
    ld d, a
    ld e, a
    ld [W_MainScript_TextStyle], a
    call Banked_SGB_ConstructPaletteSetPacket

.noSGB
    M_AdviceTeardown
    ret

SECTION "Battle Advice Code 2", ROMX[$5F90], BANK[$1]
Battle_ADVICE_LoadDenjuuResources::
    M_AdviceSetup

    ld c, e
    ld a, c
    or a
    ld a, d
    jr z, .isOpponent
    ld de, $8B80
    jr .loadPortrait

.isOpponent
    ld de, $8800

; This "push af" also preserves the flags from the "or a" above.
.loadPortrait
    push af
    call Banked_Battle_LoadDenjuuPortrait
    pop af
    jr z, .isOpponentPalette
    call Battle_LoadDenjuuPalettePartner
    jr .checkSGB

.isOpponentPalette
    call Battle_LoadDenjuuPaletteOpponent

.checkSGB
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld a, M_SGB_Pal23 << 3 + 1
    ld bc, $607
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

Battle_ADVICE_LoadSGBFiles::
    M_AdviceSetup

    ld a, $20
    ld [W_LCDC_MetaspriteAnimationBank], a

; Skip this logic until later in development.
    xor a
    jr z, .return

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld a, 3
    ld [W_MainScript_TextStyle], a

    ld hl, $9010
    ld b, $48
    call Zukan_ADVICE_TileLightColourReverse

    ld hl, .table
    ld de, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 1) + (M_LCDC_CGBColorSize * 1)
	ld b, 6

.loop
    ld a, [hli]
	ld [de], a
	inc de
    dec b
    jr nz, .loop

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, $105
    call PatchUtils_CommitStagedCGBToSGB

    ld c, $13
    call Banked_SGB_ConstructATFSetPacket

.return
    M_AdviceTeardown
    ret

.table
    dw $233C, $7FE0, 0

SECTION "Battle Advice Code 3", ROMX[$42F0], BANK[$5]
Battle_ADVICE_DrawOpponentName::
    call Battle_ADVICE_TemporarilyClearTextStyle
    call Banked_MainScript_DrawName75
    jp Battle_ADVICE_DrawPartnerName.restoreTextStyle

SECTION "Battle Advice Code 4", ROMX[$6454], BANK[$5]
Battle_ADVICE_TemporarilyClearTextStyle::
    push af
    ld a, [W_MainScript_TextStyle]
    ld [W_MainScript_TextStylePreserve], a
    xor a
    ld [W_MainScript_TextStyle], a
    pop af
    ret

SECTION "Battle Advice Code 5", ROMX[$647A], BANK[$5]
Battle_ADVICE_DrawPartnerName::
    call Battle_ADVICE_TemporarilyClearTextStyle
    call Battle_DrawSpecifiedDenjuuNickname

.restoreTextStyle
    ld a, [W_MainScript_TextStylePreserve]
    ld [W_MainScript_TextStyle], a
    ret

; 6487
