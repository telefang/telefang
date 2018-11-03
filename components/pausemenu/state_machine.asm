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
    dw PauseMenu_ContactSubstate,$4E5B,PauseMenu_InventoryStateMachine,PauseMenu_SMSStateMachine,PauseMenu_SaveStateMachine,$507E,$50EE,$48AB; 16
    dw Zukan_StateMachine,$48CB,$4907,$4936,$4953,$4969,$49A8,$49A9; 24
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

;State 0C 05
PauseMenu_StateInputHandler::
    call PauseMenu_ManageScrollAnimation
    call PauseMenu_DrawClockSprites
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld a, [W_JPInput_TypematicBtns]
    and $80
    jr z, .test_up_pressed
    
.down_pressed
    ld a, M_PauseMenu_StateAnimateMenuScrollUpOne
    jr .trigger_menu_animation
    
.test_up_pressed
    ld a, [W_JPInput_TypematicBtns]
    and $40
    jr z, .test_a_pressed
    
.up_pressed
    ld a, M_PauseMenu_StateAnimateMenuScrollDownOne
    
.trigger_menu_animation
    ld [W_SystemSubState], a
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ret
    
.test_a_pressed
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .test_b_pressed
    
.a_pressed
    ld a, [W_PauseMenu_SelectedMenuTilemap] ;this name probably needs a refactor
    cp M_PauseMenu_MenuItemContacts
    jr z, .trigger_contact_state
    cp M_PauseMenu_MenuItemCalls
    jr z, .trigger_calls_state
    cp M_PauseMenu_MenuItemMeloD
    jr z, .trigger_common_subscreen_state
    cp M_PauseMenu_MenuItemInventory
    jr z, .trigger_common_subscreen_state
    cp M_PauseMenu_MenuItemSMS
    jr z, .trigger_common_subscreen_state
    cp M_PauseMenu_MenuItemSave
    jr z, .trigger_common_subscreen_state
    cp M_PauseMenu_MenuItemOptions
    jr z, .trigger_common_subscreen_state
    cp M_PauseMenu_MenuItemExit
    jr z, .trigger_exit
    
.trigger_zukan
    ld a, M_PauseMenu_StateZukanSubscreen
    jr .trigger_subscreen_state
    
.trigger_calls_state
    ld a, M_PauseMenu_StateCallsSubscreen
    jr .trigger_subscreen_state

    ;This relies on most of the subscreen enumeration matching the order of the
    ;substate enumeration. However, they could have saved a few bytes if they
    ;reordered the substates to completely match the screen enumeration.
.trigger_common_subscreen_state
    add a, (M_PauseMenu_StateMeloDSubscreen - M_PauseMenu_MenuItemMeloD)
    jr .trigger_subscreen_state

.trigger_contact_state
    ld a, M_PauseMenu_StateContactSubscreen
    
.trigger_subscreen_state
    ld [W_SystemSubState], a
    
    xor a
    ld [W_SystemSubSubState], a
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ret
    
.test_b_pressed
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .test_select_pressed
    
.b_pressed
.trigger_exit
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, M_PauseMenu_StateExitToOverworld
    ld [W_SystemSubState], a
    ret
    
.test_select_pressed
    ld a, [H_JPInput_Changed]
    and 4
    jr z, .nothing_pressed
    
.select_pressed
    ld a, M_PhoneIME_Button1
    ld [W_PhoneIME_Button], a
    
    ld a, $FF
    ld [W_PhoneIME_LastPressedButton], a
    call PhoneIME_PlaceCursor
    
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ;TODO: Symbolize.
    ;These memory locations alias other bits of memory that are used for other purposes.
    ld bc, M_PhoneIME_DisplayedNumberSize
    ld hl, $D000
    call memclr
    
    ld bc, M_PhoneIME_DisplayedNumberSize
    ld hl, W_PhoneIME_DisplayedNumber
    call memclr
    
    xor a
    ld [W_PhoneIME_CurrentNumberLength], a
    ld [W_PauseMenu_NumberCallStatus], a
    ld [W_PauseMenu_ScrollAnimationTimer], a
    jp System_ScheduleNextSubState
    
.nothing_pressed
    ret

;State 0C 06
PauseMenu_StatePhoneIMEInputHandler::
    ld a, [W_PhoneIME_CurrentNumberLength]
    cp 0
    call z, PauseMenu_DrawClockSprites
    
    ld a, [H_JPInput_Changed]
    and 4
    jr z, .test_ime_input
    
.select_pressed
    ld a, [W_PhoneIME_CurrentNumberLength]
    cp 0
    jr z, .switch_to_menu_substate
    
.exit_ime
    call PauseMenu_LoadPhoneControlHint
    
    ld bc, $307
    call PauseMenu_DrawMenuItems
    call PhoneIME_PositionCursor
    
.switch_to_menu_substate
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 0
    call LCDC_ClearSingleMetasprite
    
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, M_PauseMenu_StateInputHandler
    ld [W_SystemSubState], a
    ret
    
.test_ime_input
    call PhoneIME_InputProcessing
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .test_b_pressed
    
.a_pressed
    call PauseMenu_PlayPhoneButtonSFX
    ld a, [W_PhoneIME_Button]
    cp M_PhoneIME_ButtonNote
    ret z
    cp M_PhoneIME_ButtonLeft
    ret z
    cp M_PhoneIME_ButtonRight
    ret z
    cp M_PhoneIME_ButtonConfirm
    jr nz, .numerical_btn_pressed
    
.confirm_btn_pressed
    call PauseMenu_StoreDialedContact
    
    ld a, $10
    ld [W_System_CountdownTimer], a
    jp System_ScheduleNextSubState
    
.numerical_btn_pressed
    ld a, [W_PhoneIME_CurrentNumberLength]
    cp 0
    jr nz, .store_number
    
    ld a, 1
    ld [W_PhoneIME_CurrentNumberLength], a
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    call PauseMenu_ClearClockSprites
    
.store_number
    jp PhoneIME_StoreNumber
    
.test_b_pressed
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .nothing_pressed
    
    ld a, [W_PauseMenu_ScrollAnimationTimer]
    cp 0
    jr z, .exit_ime
    
    dec a
    ld [W_PauseMenu_ScrollAnimationTimer], a
    
    ld e, a
    ld d, 0
    ld hl, $D000
    add hl, de
    
    xor a
    ld [hl], a
    
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    jp PhoneIME_DrawNumber
    
.nothing_pressed
    ret