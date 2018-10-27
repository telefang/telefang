INCLUDE "telefang.inc"

SECTION "Pause Menu State Machine", ROMX[$45C0], BANK[$4]
PauseMenu_GameStateMachine::
    ld a, [W_SystemSubState]
    ld hl, .state_list
    call System_IndexWordList
    jp [hl]
    
.state_list
    dw PauseMenu_StateLoadGraphics,PauseMenu_StateLoadMenuHalves,PauseMenu_StateLoadPalettes,PauseMenu_StateLoadDMGCompatibility,PauseMenu_StateAnimateMenuHalvesIn,$4681,$4743,$47D9; 0
    dw $47EE,$4807,$482E,$484E,$4866,$4872,$4883,$489C; 8
    dw $4A49,$4E5B,$4EE7,$52E3,$5023,$507E,$50EE,$48AB; 16
    dw $5417,$48CB,$4907,$4936,$4953,$4969,$49A8,$49A9; 24
    dw $49AA,$49DC,$49F3,$4A09

;State 0C 00
PauseMenu_StateLoadGraphics::
    call ClearGBCTileMap0
    call ClearGBCTileMap1
    call LCDC_ClearMetasprites
    call PauseMenu_LoadMenuResources
    jp System_ScheduleNextSubState
    
;State 0C 01
PauseMenu_StateLoadMenuHalves::
    call PauseMenu_LoadPhoneHalves
    jp System_ScheduleNextSubState

;State 0C 02
PauseMenu_StateLoadPalettes::
    call PauseMenu_CGBLoadPalettes
    
    ld a, $A7
    ld [W_ShadowREG_WX], a
    
    xor a
    ld [W_ShadowREG_WY], a
    
    ld a, $50
    ld [W_ShadowREG_SCX], a
    
    xor a
    ld [W_ShadowREG_SCY], a
    call PauseMenu_DrawMenuItemsAndFrame
    jp System_ScheduleNextSubState

;State 0C 03
PauseMenu_StateLoadDMGCompatibility::
    call LCDC_DMGSetupDirectPalette
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld [W_CGBPaletteStagedOBP], a
    
    ld a, $32
    call Sound_IndexMusicSetBySong
    
    ld [W_Sound_NextBGMSelect], a
    jp System_ScheduleNextSubState

;State 0C 04
PauseMenu_StateAnimateMenuHalvesIn::
    ld a, $E3
    ld [W_ShadowREG_LCDC], a
    
    xor a
    ld [W_ShadowREG_SCY], a
    
    ld a, [W_ShadowREG_SCX]
    sub $10
    ld [W_ShadowREG_SCX], a
    
    ld a, [W_ShadowREG_WX]
    sub $10
    ld [W_ShadowREG_WX], a
    
    cp $58
    ret nc
    
    ld a, $58
    ld [W_ShadowREG_WX], a
    
    ld a, 0
    ld [W_ShadowREG_SCX], a
    
    jp System_ScheduleNextSubState