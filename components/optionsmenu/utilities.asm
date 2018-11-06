INCLUDE "telefang.inc"

SECTION "Options Menu Utilities", ROMX[$6D63], BANK[$4]
OptionsMenu_PositionMenuCursors::
    ld b, $48
    ld c, $50
    ld d, 1
    
    ld a, [W_PhoneIME_PressCount]
    cp M_OptionsMenu_MenuMannerMode
    jr z, .position_manner_mode
    cp M_OptionsMenu_MenuClockDisplay
    jr z, .position_clock_display
    cp M_OptionsMenu_MenuWindowFlavor
    jr z, .position_window_flavor
    cp M_OptionsMenu_MenuBattleAnimation
    jr z, .position_battle_animation
    
.position_exit
    ld b, $88
    ld c, $90
    ld d, 0
    jr .position_manner_mode

.position_battle_animation
    ld b, $78
    ld c, $80
    ld d, 1
    jr .position_manner_mode
    
.position_window_flavor
    ld b, $68
    ld c, $70
    ld d, 1
    jr .position_manner_mode
    
.position_clock_display
    ld b, $58
    ld c, $60
    ld d, 1
    
.position_manner_mode
    ld a, 8
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $28
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, b
    add a, 2
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, c
    add a, 2
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, d
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, 0
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_Bank], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_Bank], a
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret

OptionsMenu_DrawSelectedOptions::
    ld e, $19
    ld a, [W_Overworld_MannerMode]
    cp 0
    jr z, .no_manners
    
.manners
    ld e, $18
    
.no_manners
    ld bc, $40A
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld e, $19
    ld a, [W_Overworld_ClockDisplay]
    cp 0
    jr z, .no_clock
    
.clock
    ld e, $18
    
.no_clock
    ld bc, $40C
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld e, $19
    ld a, [W_Battle_AnimationPlayback]
    cp 0
    jr z, .no_animation
    
.animation
    ld e, $18
    
.no_animation
    ld bc, $410
    ld a, 0
    jp Banked_RLEDecompressTMAP0
    
OptionsMenu_InputHandler::
    ld a, [H_JPInput_Changed]
    and 2
    jp nz, .b_button_pressed
    
    ld a, [W_JPInput_TypematicBtns]
    and $40
    jr z, .test_down_pressed
    
.up_pressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PhoneIME_PressCount]
    cp M_OptionsMenu_MenuMannerMode
    jr nz, .no_wrap_up
    
.wrap_up
    ld a, (M_OptionsMenu_MenuExit + 1)
    
.no_wrap_up
    dec a
    ld [W_PhoneIME_PressCount], a
    jp OptionsMenu_PositionMenuCursors

.test_down_pressed
    ld a, [W_JPInput_TypematicBtns]
    and $80
    jr z, .test_selected_option
    
.down_pressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PhoneIME_PressCount]
    cp M_OptionsMenu_MenuExit
    jr nz, .no_wrap_down
    
.wrap_down
    ld a, (M_OptionsMenu_MenuMannerMode - 1)
    
.no_wrap_down
    inc a
    ld [W_PhoneIME_PressCount], a
    jp OptionsMenu_PositionMenuCursors

.test_selected_option
    ld a, [W_PhoneIME_PressCount]
    cp M_OptionsMenu_MenuClockDisplay
    jr z, .test_clock_display_left
    cp M_OptionsMenu_MenuWindowFlavor
    jr z, .test_window_flavor_left
    cp M_OptionsMenu_MenuBattleAnimation
    jp z, .test_battle_animation_left
    cp M_OptionsMenu_MenuExit
    jp z, .test_menu_exit_confirm
    
.test_manner_mode_left
    ld a, [W_JPInput_TypematicBtns]
    and $20
    jr z, .test_manner_mode_right
    jr .manner_mode_switch
    
.test_manner_mode_right
    ld a, [W_JPInput_TypematicBtns]
    and $10
    ret z
    
.manner_mode_switch
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_Overworld_MannerMode]
    xor 1
    ld [W_Overworld_MannerMode], a
    jp OptionsMenu_DrawSelectedOptions
    
.test_clock_display_left
    ld a, [W_JPInput_TypematicBtns]
    and $20
    jr z, .test_clock_display_right
    jr .clock_display_switch
    
.test_clock_display_right
    ld a, [W_JPInput_TypematicBtns]
    and $10
    ret z
    
.clock_display_switch
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_Overworld_ClockDisplay]
    xor 1
    ld [W_Overworld_ClockDisplay], a
    jp OptionsMenu_DrawSelectedOptions

.test_window_flavor_left
    ld a, [W_JPInput_TypematicBtns]
    and $20
    jr z, .test_window_flavor_right
    
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PauseMenu_WindowFlavor]
    inc a
    and M_PauseMenu_WindowFlavorMango
    ld [W_PauseMenu_WindowFlavor], a
    call PauseMenu_CGBApplyWindowFlavor
    ret
    
.test_window_flavor_right
    ld a, [W_JPInput_TypematicBtns]
    and $10
    ret z
    
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PauseMenu_WindowFlavor]
    dec a
    and M_PauseMenu_WindowFlavorMango
    ld [W_PauseMenu_WindowFlavor], a
    call PauseMenu_CGBApplyWindowFlavor
    ret

.test_battle_animation_left
    ld a, [W_JPInput_TypematicBtns]
    and $20
    jr z, .test_battle_animation_right
    jr .battle_animation_switch
    
.test_battle_animation_right
    ld a, [W_JPInput_TypematicBtns]
    and $10
    ret z
    
.battle_animation_switch
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_Battle_AnimationPlayback]
    xor 1
    ld [W_Battle_AnimationPlayback], a
    jp OptionsMenu_DrawSelectedOptions

.test_menu_exit_confirm
    ld a, [H_JPInput_Changed]
    and 1
    ret z
    
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    jr .exit_options_menu

.b_button_pressed
    ld a, 4
    ld [W_Sound_NextSFXSelect], a

.exit_options_menu
    call PauseMenu_ClearArrowMetasprites
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    jp System_ScheduleNextSubSubState