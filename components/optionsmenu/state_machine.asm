INCLUDE "telefang.inc"

SECTION "Options Menu State Machine", ROMX[$507E], BANK[$4]
OptionsMenu_StateMachine::
    call PauseMenu_DrawClockSprites
    ld a, [W_SystemSubSubState]
    ld hl, .state_table
    call System_IndexWordList
    jp hl
    
.state_table
    dw OptionsMenu_StatePositionCursors
    dw OptionsMenu_StateDrawOptions
    dw OptionsMenu_StateNOP
    dw OptionsMenu_StateIdle
    dw OptionsMenu_StateNOP2
    dw OptionsMenu_StateNOP3
    dw PauseMenu_SubStateSMSExit1
    dw PauseMenu_SubStateSMSExit2
    
;State 0C 15 00
OptionsMenu_StatePositionCursors::
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_InitializeCursor
    
    ld a, 3
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_InitializeCursor
    
    xor a
    ld [W_PhoneIME_PressCount], a
    call OptionsMenu_PositionMenuCursors
    jp System_ScheduleNextSubSubState
    
;State 0C 15 01
OptionsMenu_StateDrawOptions::
    ld bc, 5
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .cgb_graphics
    
.dmg_graphics
    ld bc, $59
    
.cgb_graphics
    call Banked_LoadMaliasGraphics
    
    ld e, $17
    call PauseMenu_LoadMenuMap0
    call OptionsMenu_DrawSelectedOptions
    jp System_ScheduleNextSubSubState
    
;State 0C 15 02
OptionsMenu_StateNOP::
    jp System_ScheduleNextSubSubState
    
;State 0C 15 03
OptionsMenu_StateIdle::
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_IterateCursorAnimation
    jp OptionsMenu_InputHandler
    
;State 0C 15 04
OptionsMenu_StateNOP2::
    jp System_ScheduleNextSubSubState
    
;State 0C 15 05
OptionsMenu_StateNOP3::
    jp System_ScheduleNextSubSubState