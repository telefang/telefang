INCLUDE "telefang.inc"

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
