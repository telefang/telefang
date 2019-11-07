INCLUDE "telefang.inc"

SECTION "Title Screen SGB Advice", ROMX[$7F50], BANK[$2]
TitleScreen_ADVICE_LoadSGBFiles::
    call AttractMode_ADVICE_CheckSGB
    ret z

    ld bc, $A401
    call AttractMode_ADVICE_IdentifyFadePalettesCommon
    ld a, $4A
    ld [W_SGB_PreloadedFadeStageA], a
    ld c, 2
    jp Banked_SGB_ConstructATFSetPacket

TitleScreen_ADVICE_LoadSGBFadeOut::
    call Banked_LCDC_SetupPalswapAnimation
    call AttractMode_ADVICE_CheckSGB
    ret z

    ld bc, $9C01
    jp AttractMode_ADVICE_IdentifyFadePalettesCommon

TitleScreen_ADVICE_CorruptionLoadSGBFadeOut::
    call Banked_LCDC_SetupPalswapAnimation
    call AttractMode_ADVICE_CheckSGB
    ret z
    ld bc, $BC30
    jp AttractMode_ADVICE_IdentifyFadePalettesCommon
    
TitleScreen_ADVICE_RecolorVersionBand::
    call AttractMode_ADVICE_CheckSGB
    jp z, System_ScheduleNextSubState
    
    ;Replace the version band sprite tiles
    ld bc, $5f
    call Banked_LoadMaliasGraphics
    
    ;The version band on the titlescreen is designed to consume all four colors.
    ;On SGB, we need all four of our palettes to have a black value, which also
    ;changes the version band's color to black. Since I'm too lazy to add a
    ;separate set of resources for the same tilemap, let's instead just OR that
    ;particular tile with our own value
    ld hl, $9902
    
.wfbLoopNewTile
    ld a, [REG_STAT]
    and 2
    jr nz, .wfbLoopNewTile
    
    ld a, $FF
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    
    ld hl, $990E
    
.wfbLoopNewTile2
    ld a, [REG_STAT]
    and 2
    jr nz, .wfbLoopNewTile2
    
    ld a, $FF
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    
    jp System_ScheduleNextSubState
    
TitleScreen_ADVICE_UnloadSGBFiles::
    ;Load a neutral ATF
    xor a
    ld b, a
    ld c, a
    ld d, a
    ld e, a
    call Banked_SGB_ConstructPaletteSetPacket
    jp System_ScheduleNextSubState

GameOver_ADVICE_LoadSGBFadeOut::
    call Banked_LCDC_SetupPalswapAnimation
    call AttractMode_ADVICE_CheckSGB
    ret z

    ld bc, $AC19
    jp AttractMode_ADVICE_IdentifyFadePalettesCommon

SECTION "SGB Packet Advice 7", ROMX[$7BD0], BANK[$1]
TitleScreen_ADVICE_IdentifyFadePalettesCommon::
    ld hl, W_SGB_FadeMethod
    ld a, 1
    ld [hli], a
    ld a, $4B
    ld [hli], a
    ld a, b
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    ld a, c
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    ret
