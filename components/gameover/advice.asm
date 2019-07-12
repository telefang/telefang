INCLUDE "telefang.inc"

SECTION "Game Over Advice Code", ROMX[$63D0], BANK[$1]
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

    ld a, $1A
	ld bc, $191A
	ld de, $1B1C
	call Banked_SGB_ConstructPaletteSetPacket

.return
    call PauseMenu_ADVICE_SMSResetLine
    ld bc, 0
    ld e, $72

    M_AdviceTeardown
    ret
