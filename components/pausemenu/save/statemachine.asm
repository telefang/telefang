INCLUDE "telefang.inc"

SECTION "Pause Menu Save State Machine", ROMX[$5023], BANK[$4]
PauseMenu_SaveStateMachine::
    call PauseMenu_DrawClockSprites
    
    ld a, [W_SystemSubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl
    
.stateTable
    dw PauseMenu_SubStateSaveLoadGraphics
    dw PauseMenu_SubStateSaveInputHandler
    dw PauseMenu_SubStateSaveAnimation
    dw PauseMenu_SubStateSaveConfirm
    dw PauseMenu_SubStateSMSExit1
    dw PauseMenu_SubStateSMSExit2

;State 0C 14 00
PauseMenu_SubStateSaveLoadGraphics::
    ld e, $32
    call PauseMenu_LoadMenuMap0
    
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_InitializeCursor
    
    xor a
    ld [W_MelodyEdit_DataCurrent], a
    call PauseMenu_PositionSaveCursor
    jp System_ScheduleNextSubSubState
    
;State 0C 14 01
PauseMenu_SubStateSaveInputHandler::
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_IterateCursorAnimation
    jp PauseMenu_SaveInputHandler
    
;State 0C 14 02
PauseMenu_SubStateSaveAnimation::
    ld a, [W_System_CountdownTimer]
    dec a
    ld [W_System_CountdownTimer], a
    
    cp 0
    ret nz
    
    ld e, $34
    call PauseMenu_LoadMenuTilemap0
    jp System_ScheduleNextSubSubState
    
;State 0C 14 03
PauseMenu_SubStateSaveConfirm::
    ld a, [H_JPInput_Changed]
    and M_JPInput_A + M_JPInput_B
    ret z
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    jp System_ScheduleNextSubSubState