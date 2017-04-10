SECTION "Pause Menu Draw Functions", ROMX[$6492], BANK[$4]
PauseMenu_DrawCenteredNameBufferNoVWF::
    ld b, 0
    ld c, $D0
    jp PauseMenu_DrawCenteredNameBuffer.selectTargetTile
    
    nop
    
PauseMenu_DrawCenteredNameBuffer::
    ld b, 0
    ld c, $30
    
.selectTargetTile
    ld d, $C
    call Banked_MainScript_InitializeMenuText
    call Banked_MainScriptMachine
    jp Banked_MainScriptMachine