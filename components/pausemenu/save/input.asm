INCLUDE "telefang.inc"

SECTION "Pause Menu Save Input", ROMX[$62EA], BANK[$4]
PauseMenu_SaveInputHandler::
    ld a, [H_JPInput_Changed]
    and 2 ;Button B
    jr nz, .button_b_pressed
    
    ld a, [W_JPInput_TypematicBtns]
    and $40 ;Up
    jr z, .check_down_pressed
    
.direction_pressed
    ld a, [W_MelodyEdit_DataCurrent]
    xor 1
    ld [W_MelodyEdit_DataCurrent], a
    
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    jp PauseMenu_PositionSaveCursor
    
.check_down_pressed
    ld a, [W_JPInput_TypematicBtns]
    and $80 ; Down
    jr z, .check_a_pressed
    jr .direction_pressed
    
.check_a_pressed
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .nothing_pressed
    
    xor a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1], a
    
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCurrent]
    cp 0
    jr z, .save_selected
    
.button_b_pressed
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call LCDC_ClearSingleMetasprite
    
    ld a, M_PauseMenu_SubStateSaveExit1
    ld [W_SystemSubSubState], a
    ret
    
.save_selected
    call Banked_SaveClock_StoreWorkingStateToSaveData
    
    ld bc, $106
    ld e, $33
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, M_PauseMenu_SaveAnimationDelay
    ld [W_System_CountdownTimer], a
    jp System_ScheduleNextSubSubState
    
.nothing_pressed
    ret
    
PauseMenu_PositionSaveCursor::
    ld c, $68
    ld a, [W_MelodyEdit_DataCurrent]
    cp 0
    jr z, .option_one
    
.option_two
    ld c, $78
    
.option_one
    ld b, $C
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call PauseMenu_PositionCursor
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret