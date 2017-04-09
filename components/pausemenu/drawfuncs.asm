SECTION "Pause Menu Draw Functions", ROMX[$649A], BANK[$4]
PauseMenu_DrawCenteredNameBuffer::
    ld b, 0
    ld c, $30
    ld d, $C
    call Banked_MainScript_InitializeMenuText
    call Banked_MainScriptMachine
    jp Banked_MainScriptMachine