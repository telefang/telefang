INCLUDE "telefang.inc"

SECTION "Calls Menu State Machine", ROMX[$50EE], BANK[$4]
CallsMenu_StateMachine::
    call PauseMenu_DrawClockSprites
    ld a, [W_SystemSubSubState]
    ld hl, .state_table
    call System_IndexWordList
    jp hl
    
.state_table
    dw CallsMenu_StateInitCallsHistory
    dw CallsMenu_StateDrawNoMessageIndicator
    dw CallsMenu_StateNoMessageIndicatorIdle
    dw CallsMenu_StateDrawHistoryEntry
    dw CallsMenu_StateEntryListingIdle
    dw CallsMenu_StateDialQueuedPhoneNumber
    dw CallsMenu_StateFadeToOutboundCallScreen
    dw CallsMenu_StateDrawOutboundCallScreen
    dw CallsMenu_StateFadeInOutboundCall
    dw CallsMenu_StateOutboundCallScriptIdle
    dw CallsMenu_StateFadeBackToEntryListing
    dw CallsMenu_StateDie
    dw CallsMenu_StateReturnToPauseMenu
    dw PauseMenu_SubStateSMSExit1
    dw PauseMenu_SubStateSMSExit2
    
;State 0C 16 00
CallsMenu_StateInitCallsHistory::
    xor a
    ld [W_MelodyEdit_DataCurrent], a
    ld [W_MelodyEdit_DataCount], a
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    call PauseMenu_SelectTextStyle
    
    ld a, $40
    ld [W_MainScript_TileBaseIdx], a
    jp System_ScheduleNextSubSubState
    
;State 0C 16 01
CallsMenu_StateDrawNoMessageIndicator::
    call CallsMenu_GetCallHistoryEntryCount
    
    ld a, [W_MelodyEdit_DataCount]
    cp 0
    jr nz, .skip_indicator_graphic
    
.load_indicator_graphic
    call PauseMenu_LoadMsgsGraphic
    
    ld e, 6
    call PauseMenu_LoadMenuMap0
    call PauseMenu_DrawSMSMessageCount
    jp System_ScheduleNextSubSubState

.skip_indicator_graphic
    ld hl, $9400
    ld b, 4
    call PauseMenu_ClearScreenTiles
    
    ld a, M_CallsMenu_StateDrawHistoryEntry
    ld [W_SystemSubSubState], a
    ret
    
;State 0C 16 02
CallsMenu_StateNoMessageIndicatorIdle::
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .test_a_pressed
    
.b_pressed
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    jp .exit

.test_a_pressed
    ld a, [H_JPInput_Changed]
    and 1
    ret z
    
.a_pressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
.exit
    ld a, M_CallsMenu_StateReturnToPauseMenu
    ld [W_SystemSubSubState], a
    ret

;State 0C 16 03
CallsMenu_StateDrawHistoryEntry::
    ld bc, $1A
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .cgb_resource
    
.dmg_resource
    ld bc, $54
    
.cgb_resource
    call Banked_LoadMaliasGraphics
    
    ld e, $3C
    call PauseMenu_LoadMenuMap0
    
    ld bc, $10B
    ld e, $22
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_MelodyEdit_DataCurrent]
    call CallsMenu_DrawCallHistoryEntry
    
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_InitializeCursor
    
    ld a, $B
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_InitializeCursor
    
    ld a, $40
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, 8
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $60
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, [W_MelodyEdit_DataCount]
    cp 1
    jr nz, .has_cursors
    
.no_cursors
    xor a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a

.has_cursors
    jp System_ScheduleNextSubSubState
    
;State 0C 16 04
CallsMenu_StateEntryListingIdle::
    ld a, [W_MelodyEdit_DataCount]
    cp 1
    jr z, .no_cursors
    
.has_cursors
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_IterateCursorAnimation
    
.no_cursors
    jp CallsMenu_EntryListingInputHandler
    
;State 0C 16 05
CallsMenu_StateDialQueuedPhoneNumber::
    jp CallsMenu_DialQueuedPhoneNumber
    
;State 0C 16 06
CallsMenu_StateFadeToOutboundCallScreen::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    call PhoneConversation_OutboundConfigureScreen
    
    xor a
    ld [W_MainScript_TextStyle], a
    
    ld a, 1
    ld [W_Status_CalledFromContactScreen], a
    jp System_ScheduleNextSubSubState
    
;State 0C 16 07
CallsMenu_StateDrawOutboundCallScreen::
    call ClearGBCTileMap0
    call ClearGBCTileMap1
    call LCDC_ClearMetasprites
    call CallsMenu_IndexCallHistory
    
    push af
    
    ld [W_PhoneConversation_CalledDenjuu], a
    call CallsMenu_IndexContactSpecies
    call PhoneConversation_DrawOutboundCallScreen
    
    pop af
    
    call PauseMenu_ContactsMenuDrawSelectedDenjuu
    
    ld e, $1C
    ld bc, $603
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    xor a
    ld [W_CGBPaletteStagedBGP], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, 2
    ld [W_Overworld_PowerAntennaPattern], a
    jp System_ScheduleNextSubSubState
    
;State 0C 16 08
CallsMenu_StateFadeInOutboundCall::
    ld a, 0
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, $85
    ld [W_MainScript_WindowBorderAttribs], a
    
    ld a, $A0
    ld [W_MainScript_TileBaseIdx], a
    call $70C
    
    ld d, $C
    call $520
    jp System_ScheduleNextSubSubState
    
;State 0C 16 09
CallsMenu_StateOutboundCallScriptIdle::
    call Banked_MainScriptMachine
    
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    ret nz
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp System_ScheduleNextSubSubState

;State 0C 16 0A
CallsMenu_StateFadeBackToEntryListing::
    ld a, 1
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    xor a
    ld [W_Overworld_PowerAntennaPattern], a
    call LCDC_ClearMetasprites
    call PauseMenu_LoadMenuResources
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld bc, 0
    ld e, $10
    call PauseMenu_LoadMap0
    
    ld bc, 0
    ld e, $11
    call PauseMenu_LoadMap1
    call PauseMenu_CGBLoadPalettes
    call PauseMenu_ConfigureScreen
    call LCDC_DMGSetupDirectPalette
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld [W_CGBPaletteStagedOBP], a
    
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    xor a
    ld [W_Status_CalledFromContactScreen], a
    
    ld hl, $9400
    ld b, $38
    call PauseMenu_CGBClearInputTiles
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    
    ld a, 1
    ld [W_SystemSubSubState], a
    call PauseMenu_SelectTextStyle
    
    ld a, [W_PhoneConversation_CalledDenjuu]
    jp PhoneConversation_OutboundIncrementFD
    
;State 0C 16 0B
CallsMenu_StateDie::
    ret
    
;State 0C 16 0C
CallsMenu_StateReturnToPauseMenu::
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    call PauseMenu_ClearArrowMetasprites
    jp System_ScheduleNextSubSubState
