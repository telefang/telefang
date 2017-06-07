INCLUDE "telefang.inc"

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
    
SECTION "Pause Menu Draw Functions 2", ROMX[$7EF6], BANK[$4]
PauseMenu_CallsMenuDrawDenjuuNickname::
    call Banked_SaveClock_LoadDenjuuNicknameByIndex
    
    ld hl, W_SaveClock_NicknameStaging
    ld de, W_MainScript_CenteredNameBuffer
    call Banked_StringTable_ADVICE_PadCopyBuffer
    
    ld hl, $9400
    ld b, 6
    call PauseMenu_ClearInputTiles
    
    ld bc, W_SaveClock_NicknameStaging
    ld d, M_StringTable_Load8AreaSize
    ld hl, $9400
    jp MainScript_DrawCenteredStagedString

PauseMenu_ContactsMenuDrawDenjuuNickname::
    call PauseMenu_IndexContactArray
    
    ld c, a
    call Banked_SaveClock_LoadDenjuuNicknameByIndex
    
    ld hl, W_SaveClock_NicknameStaging
    ld de, W_MainScript_CenteredNameBuffer
    call Banked_StringTable_ADVICE_PadCopyBuffer
    
    ld hl, $9780
    ld b, 6
    call PauseMenu_ClearScreenTiles
    
    ld bc, W_SaveClock_NicknameStaging
    ld d, M_StringTable_Load8AreaSize
    ld hl, $9780
    jp MainScript_DrawCenteredStagedString
