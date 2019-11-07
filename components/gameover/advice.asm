INCLUDE "telefang.inc"

SECTION "Game Over Advice Code", ROMX[$63B0], BANK[$1]
GameOver_ADVICE_LoadSGBFiles::
    M_AdviceSetup

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld hl, $9020
    ld b, $F0
    call Zukan_ADVICE_TileLightColourReverse
    ld b, $F0
    call Zukan_ADVICE_TileLightColourReverse
    ld b, $20
    call Zukan_ADVICE_TileLightColourReverse

    ld bc, $B419
    call TitleScreen_ADVICE_IdentifyFadePalettesCommon
    ld a, $4A
    ld [W_SGB_PreloadedFadeStageA], a
    ld c, $1A
    call Banked_SGB_ConstructATFSetPacket

.return
    call PauseMenu_ADVICE_SMSResetLine
    ld bc, 0
    ld e, $72

    M_AdviceTeardown
    ret

