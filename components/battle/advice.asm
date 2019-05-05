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
