INCLUDE "telefang.inc"

SECTION "Save Overwrite Subscreen Utils", ROMX[$7C8F], BANK[$4]
TitleMenu_SaveOverwriteInputHandler::
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .test_b_pressed
    
.a_pressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    cp 0
    jr nz, .cancel_save_overwrite
    
.allow_save_overwrite
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call LCDC_ClearSingleMetasprite
    
    ld bc, $104
    ld e, $5B
    call PauseMenu_LoadMap0
    jp System_ScheduleNextSubState
    
.test_b_pressed
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .test_up_pressed
    
.b_pressed
    ld a, 4
    ld [W_Sound_NextSFXSelect], a

.cancel_save_overwrite
    ld bc, $104
    ld e, $5B
    call PauseMenu_LoadMap0
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call LCDC_ClearSingleMetasprite
    
    ld a, M_TitleMenu_StateSaveOverwriteCancelled
    ld [W_SystemSubState], a
    ret
    
.test_up_pressed
    ld a, [W_JPInput_TypematicBtns]
    and $40
    jp z, .test_down_pressed
    jr .up_pressed
    
.test_down_pressed
    ld a, [W_JPInput_TypematicBtns]
    and $80
    jp z, .nothing_pressed
    
.down_pressed
.up_pressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    xor 1
    ld [W_MelodyEdit_DataCount], a
    jp TitleMenu_PositionSaveOverwriteCursor
    
.nothing_pressed
    ret
    
TitleMenu_PositionSaveOverwriteCursor::
    ld b, $10
    ld a, [W_MelodyEdit_DataCount]
    sla a
    sla a
    sla a
    add a, $78
    jp TitleMenu_PositionFirstCursor
    
SECTION "Save Overwrite Utilities 2", ROMX[$72A9], BANK[$4]
TitleMenu_PositionFirstCursor::
    ld c, a
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    jp PauseMenu_PositionCursor