INCLUDE "telefang.inc"

SECTION "Pause Menu State Machine", ROMX[$45C0], BANK[$4]
PauseMenu_GameStateMachine::
    ld a, [W_SystemSubState]
    ld hl, .state_list
    call System_IndexWordList
    jp hl
    
.state_list
    dw PauseMenu_StateLoadGraphics
    dw PauseMenu_StateLoadMenuHalves
    dw PauseMenu_StateLoadPalettes
    dw PauseMenu_StateLoadDMGCompatibility
    dw PauseMenu_StateAnimateMenuHalvesIn
    dw PauseMenu_StateInputHandler
    dw PauseMenu_StatePhoneIMEInputHandler
    dw PauseMenu_StatePlayOutCallSFX
    dw PauseMenu_StatePlayCallSFX2
    dw PauseMenu_StateCheckCallStatusAndTransition
    dw PauseMenu_StateExitPhoneIME
    dw PauseMenu_StateAnimateMenuScrollUpOne
    dw PauseMenu_StateAnimateMenuScrollUpTwo
    dw PauseMenu_StateAnimateMenuScrollFinish
    dw PauseMenu_StateAnimateMenuScrollDownOne
    dw PauseMenu_StateAnimateMenuScrollDownTwo
    dw ContactMenu_StateMachine
    dw $4E5B
    dw PauseMenu_InventoryStateMachine
    dw PauseMenu_SMSStateMachine
    dw PauseMenu_SaveStateMachine
    dw OptionsMenu_StateMachine
    dw CallsMenu_StateMachine
    dw PauseMenu_StateExitToOverworld
    dw Zukan_StateMachine
    dw PauseMenu_StateTransitionToOutgoingCall
    dw PauseMenu_StateLoadOutgoingContactCallGraphics
    dw PauseMenu_StateFadeInAndQueueContactMessage
    dw PauseMenu_StateDeliverContactMessage
    dw PauseMenu_StateTransitionOutOfOutboundContactCall
    dw PauseMenu_State1E
    dw PauseMenu_State1F
    dw PauseMenu_StateLoadOutgoingSecretCallGraphics
    dw PauseMenu_StateFadeInAndQueueSecretMessage
    dw PauseMenu_StateDeliverSecretMessage
    dw PauseMenu_StateTransitionOutOfOutboundSecretCall

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
    
;State 0C 07
PauseMenu_StatePlayOutCallSFX::
    ld a, [W_System_CountdownTimer]
    dec a
    ld [W_System_CountdownTimer], a
    
    cp 0
    ret nz
    
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    jp System_ScheduleNextSubState
    
;State 0C 08
PauseMenu_StatePlayCallSFX2::
    ld a, $65
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PauseMenu_NumberCallStatus]
    cp 0
    jr z, .no_sound_effect
    
.use_failed_sound_effect
    ld a, $66
    ld [W_Sound_NextSFXSelect], a
    
.no_sound_effect
    ld a, $80
    ld [W_System_CountdownTimer], a
    jp System_ScheduleNextSubState

;State 0C 09
PauseMenu_StateCheckCallStatusAndTransition::
    ld a, [W_System_CountdownTimer]
    dec a
    ld [W_System_CountdownTimer], a
    
    cp 0
    ret nz
    
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, [W_PauseMenu_NumberCallStatus]
    cp 0
    jr z, .invalid_number
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, M_PauseMenu_StateTransitionToOutgoingCall
    ld [W_SystemSubState], a
    ret
    
.invalid_number
    jp System_ScheduleNextSubState

;State 0C 0A
PauseMenu_StateExitPhoneIME::
    call PauseMenu_LoadPhoneControlHint
    
    ld bc, $307
    call PauseMenu_DrawMenuItems
    call PhoneIME_PositionCursor
    
    ld de, $C0A0
    call LCDC_ClearSingleMetasprite
    
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, M_PauseMenu_StateInputHandler
    ld [W_SystemSubState], a
    ret
    
;State 0C 0B
PauseMenu_StateAnimateMenuScrollUpOne::
    call PauseMenu_LoadScrollAnimationFrameD2
    
    ld bc, $306
    call PauseMenu_DrawMenuItems
    
    ld a, [W_PauseMenu_SelectedMenuTilemap]
    inc a
    cp (M_PauseMenu_MenuItemZukan + 1)
    jr nz, .no_menu_wrap
    
.menu_wrap
    xor a
    
.no_menu_wrap
    ld [W_PauseMenu_SelectedMenuTilemap], a
    jp System_ScheduleNextSubState

;State 0C 0C
PauseMenu_StateAnimateMenuScrollUpTwo::
    call PauseMenu_LoadScrollAnimationFrameD1
    
    ld bc, $308
    call PauseMenu_DrawMenuItems
    jp System_ScheduleNextSubState

;State 0C 0D
PauseMenu_StateAnimateMenuScrollFinish::
    ld e, $12
    call PauseMenu_LoadMenuMap0
    
    ld bc, $307
    call PauseMenu_DrawMenuItems
    
    ld a, M_PauseMenu_StateInputHandler
    ld [W_SystemSubState], a
    ret

;State 0C 0E
PauseMenu_StateAnimateMenuScrollDownOne::
    call PauseMenu_LoadScrollAnimationFrameD1
    
    ld bc, $308
    call PauseMenu_DrawMenuItems
    
    ld a, [W_PauseMenu_SelectedMenuTilemap]
    dec a
    cp (M_PauseMenu_MenuItemContacts - 1)
    jr nz, .no_menu_wrap
    
.menu_wrap
    ld a, M_PauseMenu_MenuItemZukan
    
.no_menu_wrap
    ld [W_PauseMenu_SelectedMenuTilemap], a
    jp System_ScheduleNextSubState

;State 0C 0F
PauseMenu_StateAnimateMenuScrollDownTwo::
    call PauseMenu_LoadScrollAnimationFrameD2
    
    ld bc, $306
    call PauseMenu_DrawMenuItems
    
    ld a, M_PauseMenu_StateAnimateMenuScrollFinish
    ld [W_SystemSubState], a
    ret

;State 0C 17
PauseMenu_StateExitToOverworld::
    ld a, 1
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    xor a
    ld [W_Overworld_PowerAntennaPattern], a
    
    ld a, 5
    ld [W_SystemState], a
    
    ld a, $A
    ld [W_SystemSubState], a
    
    call PhoneConversation_OutboundConfigureScreen
    
    xor a
    ld [W_Status_CalledFromContactScreen], a
    ld [W_MainScript_TextStyle], a
    ret

;State 0C 19
PauseMenu_StateTransitionToOutgoingCall::
    ld a, 1
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    call PhoneIME_PositionCursor
    
    ld a, [W_PauseMenu_NumberCallStatus]
    cp 1
    jr z, .start_known_contact_call
    
.secret_denjuu_call
    call ContactEnlist_CheckContactLimit
    cp 0
    jr nz, .known_contact_call
    
    ld a, M_PauseMenu_StateLoadOutgoingSecretCallGraphics
    ld [W_SystemSubState], a
    ret

.known_contact_call
    ld a, [$CB01]
    ld e, a
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    ld hl, $7C0D       ; TODO: table of predetermined messages
    add hl, de
    ld a, [hli]
    ld [$CB01], a
    
    ld a, 3
    ld [W_PauseMenu_NumberCallStatus], a
    
.start_known_contact_call
    jp System_ScheduleNextSubState

;State 0C 1A
PauseMenu_StateLoadOutgoingContactCallGraphics::
    call LCDC_ClearMetasprites
    
    ld a, [$CB01]
    call PhoneConversation_DrawOutboundCallScreen
    
    xor a
    ld [W_CGBPaletteStagedBGP], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    call PhoneConversation_OutboundConfigureScreen
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, $85
    ld [W_MainScript_WindowBorderAttribs], a
    
    ld a, $A0
    ld [W_MainScript_TileBaseIdx], a
    
    ld a, 2
    ld [W_Overworld_PowerAntennaPattern], a
    jp System_ScheduleNextSubState

;State 0C 1B
;TODO: What do these unknown functions do?
PauseMenu_StateFadeInAndQueueContactMessage::
    ld a, 0
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    call $7C53
    
    ld a, [W_PauseMenu_NumberCallStatus]
    cp 3
    jr nz, .exit
    
    ld c, $FD
    ld b, 1
    
.exit
    ld d, $C
    call $520
    jp System_ScheduleNextSubState

;State 0C 1C
PauseMenu_StateDeliverContactMessage::
    call Banked_MainScriptMachine
    
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    ret nz
    
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp System_ScheduleNextSubState

;State 0C 1D
PauseMenu_StateTransitionOutOfOutboundContactCall::
    ld a, 1
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    xor a
    ld [W_Overworld_PowerAntennaPattern], a
    call PauseMenu_LoadMenuResources
    call PauseMenu_LoadPhoneHalves
    call PauseMenu_CGBLoadPalettes
    call PauseMenu_ConfigureScreen
    call PauseMenu_DrawMenuItemsAndFrame
    call LCDC_DMGSetupDirectPalette
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld [W_CGBPaletteStagedOBP], a
    
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, M_PauseMenu_StateInputHandler
    ld [W_SystemSubState], a
    
    xor a
    ld [W_SystemSubSubState], a
    ld [W_MainScript_TextStyle], a
    
    ld a, [W_PhoneConversation_CalledDenjuu]
    jp PhoneConversation_OutboundIncrementFD

;State 0C 1E
PauseMenu_State1E::
    ret

;State 0C 1F
PauseMenu_State1F::
    ret

;State 0C 20
PauseMenu_StateLoadOutgoingSecretCallGraphics::
    call LCDC_ClearMetasprites
    
    ld a, [$CB01]
    call $7C7E
    call PhoneConversation_DrawOutboundCallScreen
    
    xor a
    ld [W_CGBPaletteStagedBGP], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    call PhoneConversation_OutboundConfigureScreen
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, $85
    ld [W_MainScript_WindowBorderAttribs], a
    
    ld a, $A0
    ld [W_MainScript_TileBaseIdx], a
    
    ld a, 2
    ld [W_Overworld_PowerAntennaPattern], a
    jp System_ScheduleNextSubState

;State 0C 21
PauseMenu_StateFadeInAndQueueSecretMessage::
    ld a, 0
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    ld a, [$CB01]
    add a, $80
    ld c, a
    ld b, 1
    ld d, $C
    call $520
    jp System_ScheduleNextSubState

;State 0C 22
PauseMenu_StateDeliverSecretMessage::
    call Banked_MainScriptMachine
    
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    ret nz
    
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp System_ScheduleNextSubState

;State 0C 23
PauseMenu_StateTransitionOutOfOutboundSecretCall::
    ld a, 1
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    xor a
    ld [W_Overworld_PowerAntennaPattern], a
    call PauseMenu_LoadMenuResources
    call PauseMenu_LoadPhoneHalves
    call PauseMenu_CGBLoadPalettes
    call PauseMenu_ConfigureScreen
    call PauseMenu_DrawMenuItemsAndFrame
    call LCDC_DMGSetupDirectPalette
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld [W_CGBPaletteStagedOBP], a
    
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, 5
    ld [W_SystemSubState], a
    
    xor a
    ld [W_SystemSubSubState], a
    ld [W_MainScript_TextStyle], a
    
    ld a, [$CB01]
    call $7B79
    ret
