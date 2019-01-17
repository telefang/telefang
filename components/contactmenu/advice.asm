INCLUDE "telefang.inc"

SECTION "Contact Menu SGB Recolour Overview Advice", ROMX[$5625], BANK[$1]
ContactMenu_ADVICE_LoadSGBFilesOverview_Common::
    ;Do nothing if no SGB detected.
    ld a, [W_SGB_DetectSuccess]
    or a
    jr z, .return

    ;Do nothing if CGB hardware detected.
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .return

    ld c, 9
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 2
    call PatchUtils_CommitStagedCGBToSGB

.return
    ret

ContactMenu_ADVICE_LoadSGBFilesOverview::
    M_AdviceSetup

    call ContactMenu_ADVICE_LoadSGBFilesOverview_Common

    ld bc, $12

    M_AdviceTeardown
    ret
