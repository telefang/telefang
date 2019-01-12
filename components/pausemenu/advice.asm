INCLUDE "telefang.inc"

SECTION "Pause Menu Load SGB Files", ROMX[$5540], BANK[$1]
Banked_PauseMenu_ADVICE_LoadSGBFiles::
    M_AdviceSetup
    ld a, 5
    ld [W_SystemSubState], a
    jp TitleMenu_ADVICE_LoadSGBFiles_externalEntry

SECTION "Pause Menu Load SGB Files 2", ROMX[$5580], BANK[$1]
PauseMenu_ADVICE_LoadSGBFilesMelody::
    M_AdviceSetup

    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a

    ld c, 7
    call Banked_SGB_ConstructATFSetPacket

    M_AdviceTeardown
    ret
