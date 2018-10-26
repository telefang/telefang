INCLUDE "telefang.inc"

SECTION "Sound Test Utilities Menu", WRAM0[$CB40]
W_TitleMenu_SoundMenuEffectSelect:: ds 1
W_TitleMenu_SoundMenuTrackSelect:: ds 1
W_TitleMenu_SoundMenuOption:: ds 1

SECTION "Sound Test Utilities", ROMX[$6BBC], BANK[$4]
TitleMenu_SoundTestInputHandler::
    ld a, [H_JPInput_Changed]
    and 2
    jp nz, .b_button_pressed
    
.test_up_pressed
    ld a, [H_JPInput_Changed]
    and $40
    jr z, .test_down_pressed
    
.up_pressed
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_TitleMenu_SoundMenuOption]
    dec a
    cp M_TitleMenu_SoundMenuOptionBGM - 1
    jr nz, .no_wrap_menu_up
    
.wrap_menu_up
    ld a, 2

.no_wrap_menu_up
    ld [W_TitleMenu_SoundMenuOption], a
    jp TitleMenu_DrawSoundTestNumbersAndCursors

.test_down_pressed
    ld a, [H_JPInput_Changed]
    and $80
    jr z, .test_menu_option
    
.down_pressed
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_TitleMenu_SoundMenuOption]
    inc a
    cp M_TitleMenu_SoundMenuOptionExit + 1
    jr nz, .no_wrap_menu_down
    
.wrap_menu_down
    xor a

.no_wrap_menu_down
    ld [W_TitleMenu_SoundMenuOption], a
    jp TitleMenu_DrawSoundTestNumbersAndCursors

.test_menu_option
    ld a, [W_TitleMenu_SoundMenuOption]
    cp a, M_TitleMenu_SoundMenuOptionSFX
    jr z, .sfx_option_handler
    
    cp a, M_TitleMenu_SoundMenuOptionExit
    jp z, .exit_option_handler
    
.bgm_option_handler
    ld a, [W_JPInput_TypematicBtns]
    and $20
    jr z, .test_right_pressed_on_bgm
    
.left_pressed_on_bgm
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_TitleMenu_SoundMenuTrackSelect]
    dec a
    cp -1
    jr nz, .no_wrap_bgm_left
    
.wrap_bgm_left
    ld a, M_TitleMenu_SoundMenuBGMCount
    
.no_wrap_bgm_left
    ld [W_TitleMenu_SoundMenuTrackSelect], a
    jp TitleMenu_DrawSoundTestNumbersAndCursors

.test_right_pressed_on_bgm
    ld a, [W_JPInput_TypematicBtns]
    and $10
    jr z, .test_a_pressed_on_bgm
    
.right_pressed_on_bgm
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_TitleMenu_SoundMenuTrackSelect]
    inc a
    cp (M_TitleMenu_SoundMenuBGMCount + 1)
    jr c, .no_wrap_bgm_right
    
.wrap_bgm_right
    xor a
    
.no_wrap_bgm_right
    ld [W_TitleMenu_SoundMenuTrackSelect], a
    jp TitleMenu_DrawSoundTestNumbersAndCursors

.test_a_pressed_on_bgm
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .no_button_pressed_on_bgm
    
.a_pressed_on_bgm
    ld a, [W_TitleMenu_SoundMenuTrackSelect]
    call TitleMenu_MapBGMTrackToInternalID
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    ret
    
.no_button_pressed_on_bgm
    ret
    
.sfx_option_handler
    ld a, [W_JPInput_TypematicBtns]
    and $20
    jr z, .test_right_pressed_on_sfx
    
.left_pressed_on_sfx
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_TitleMenu_SoundMenuEffectSelect]
    cp 0
    jr nz, .no_wrap_sfx_left
    
.wrap_sfx_left
    ld a, (M_TitleMenu_SoundMenuSFXCount + 1)
    
.no_wrap_sfx_left
    dec a
    ld [W_TitleMenu_SoundMenuEffectSelect], a
    jp TitleMenu_DrawSoundTestNumbersAndCursors

.test_right_pressed_on_sfx
    ld a, [W_JPInput_TypematicBtns]
    and $10
    jr z, .test_a_pressed_on_sfx
    
.right_pressed_on_sfx
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_TitleMenu_SoundMenuEffectSelect]
    cp M_TitleMenu_SoundMenuSFXCount
    jr c, .no_wrap_sfx_right
    
.wrap_sfx_right
    ld a, -1
    
.no_wrap_sfx_right
    inc a
    ld [W_TitleMenu_SoundMenuEffectSelect], a
    jp TitleMenu_DrawSoundTestNumbersAndCursors

.test_a_pressed_on_sfx
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .test_b_pressed_on_sfx
    
.a_pressed_on_sfx
    ld a, [W_TitleMenu_SoundMenuEffectSelect]
    inc a
    ld [W_Sound_NextSFXSelect], a
    ret
    
.test_b_pressed_on_sfx
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .no_button_pressed_on_sfx
    
.b_pressed_on_sfx
    ld a, 1
    ld [W_Sound_NextSFXSelect], a
    
.no_button_pressed_on_sfx
    ret
    
.exit_option_handler
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .no_button_pressed_on_exit
    
.b_button_pressed
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    call LCDC_ClearMetasprites
    
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    ld bc, 0
    ld e, $10
    call PauseMenu_LoadMap0
    jp System_ScheduleNextSubState

.no_button_pressed_on_exit
    ret

TitleMenu_DrawSoundTestNumbersAndCursors::
    ld b, $48
    ld c, $50
    ld d, 1
    ld a, [W_TitleMenu_SoundMenuOption]
    cp M_TitleMenu_SoundMenuOptionBGM
    jr z, .bgm_cursor_position
    cp M_TitleMenu_SoundMenuOptionSFX
    jr z, .sfx_cursor_position
    
.exit_cursor_position
    ld b, $78
    ld c, $80
    ld d, 0
    jr .position_cursor
    
.sfx_cursor_position
    ld b, $60
    ld c, $68
    ld d, 1
    
.bgm_cursor_position
.position_cursor
    ld a, $10
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, b
    add a, 2
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, 0
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_Bank], a
    
    ld a, $30
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, c
    add a, 2
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, d
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, 0
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_Bank], a
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld a, [W_TitleMenu_SoundMenuTrackSelect]
    ld hl, $9945
    call PauseMenu_DecimalizeAndDrawBothDigits
    
    ld a, [W_TitleMenu_SoundMenuEffectSelect]
    ld hl, $99A4
    jp PauseMenu_DrawDecimalizedValue
    
TitleMenu_MapBGMTrackToInternalID::
    ld e, a
    ld hl, .track_mapping
    ld d, 0
    add hl, de
    ld a, [hl]
    ret
    
.track_mapping
    db   3,   4,   5,   6,   7,   8,   9,  $A; 0
    db  $B, $12, $13, $14, $15, $16, $17, $18; 8
    db $19, $1A, $1B, $22, $23, $24, $25, $26; 16
    db $27, $28, $29, $2A, $2B, $2C, $2D, $2E; 24
    db $32, $33, $34, $35, $36, $37, $38, $39; 32
