INCLUDE "telefang.inc"

SECTION "Pause Menu Load SGB Files", ROMX[$5540], BANK[$1]
Banked_PauseMenu_ADVICE_LoadSGBFiles::
    M_AdviceSetup
    ld a, 5
    ld [W_SystemSubState], a
    jp TitleMenu_ADVICE_LoadSGBFiles_externalEntry
