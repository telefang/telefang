INCLUDE "telefang.inc"

SECTION "Pause Menu Screen Resource Utils", ROMX[$7E27], BANK[$4]
PauseMenu_LoadPhoneHalves::
    ld bc, 0
    ld e, $10
    call PauseMenu_LoadMap0
    
    ld bc, 0
    ld e, $11
    call PauseMenu_LoadMap1
    
PauseMenu_LoadPhoneControlHint::
    ld e, $12
    call PauseMenu_LoadMenuMap0
    
    ld bc, $30F
    ld e, $20
    call PauseMenu_LoadMap0
    
    ld bc, $310
    ld e, $21
    jp PauseMenu_LoadMap0
    
SECTION "Pause Menu Screen Resource Utils 2", ROMX[$7E58], BANK[$4]
PauseMenu_ConfigureScreen::
    ld a, $E3
    ld [W_ShadowREG_LCDC], a
    
    ld a, $58
    ld [W_ShadowREG_WX], a
    
    xor a
    ld [W_ShadowREG_WY], a
    
    xor a
    ld [W_ShadowREG_SCX], a
    ld [W_ShadowREG_SCY], a
    ret
    
SECTION "Pause Menu Screen Resource Utils 3", ROMX[$7A0B], BANK[$4]
PauseMenu_LoadMenuResources::
    call PauseMenu_LoadMainGraphics
    
    ld bc, $11
    call Banked_LoadMaliasGraphics
    
    xor a
    ld [W_PauseMenu_NextPhoneIME], a
    call PauseMenu_LoadPhoneGraphics
    jp PauseMenu_LoadPhoneIMEGraphics