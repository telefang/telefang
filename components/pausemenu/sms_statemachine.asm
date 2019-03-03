INCLUDE "telefang.inc"

SECTION "Pause Menu SMS State Machine", ROMX[$52E3], BANK[$4]
PauseMenu_SMSStateMachine::
    call $56E7
    ld a, [W_SystemSubSubState]
    ld hl, .stateTbl
    call System_IndexWordList
    jp hl
    
.stateTbl
    dw PauseMenu_SubStateSMSInit
    dw PauseMenu_SubStateSMSGraphicInit
    dw PauseMenu_SubStateSMSGraphicIdle
    dw PauseMenu_SubStateSMSListingInit
    dw PauseMenu_SubStateSMSListingIdle
    dw PauseMenu_SubStateSMSContentsInit
    dw PauseMenu_SubStateSMSContentsIdle
    dw PauseMenu_SubStateSMSExit0
    dw PauseMenu_SubStateSMSExit1
    dw PauseMenu_SubStateSMSExit2

;State 0C 13 00
PauseMenu_SubStateSMSInit:
    ld hl, $9400
    ld b, $38
    call PauseMenu_ClearScreenTiles
    
    xor a
    ld [W_MelodyEdit_DataCurrent], a
    ld [W_MelodyEdit_DataCount], a
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    call PauseMenu_SelectTextStyle
    
    ld a, $40
    ld [W_MainScript_TileBaseIdx], a
    
    xor a
    ld [$C90B], a
    jp System_ScheduleNextSubSubState
    
;State 0C 13 01
PauseMenu_SubStateSMSGraphicInit::
    ld e, 6
    call PauseMenu_LoadMenuMap0
    call PauseMenu_LoadMsgsGraphic
    call PauseMenu_CountActiveSMS
    call PauseMenu_DrawSMSMessageCount
    jp System_ScheduleNextSubSubState
    
;State 0C 13 02
PauseMenu_SubStateSMSGraphicIdle::
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .noBBtn
    
.bBtn
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    jp .exitSMSScreen
    
.noBBtn
    ld a, [H_JPInput_Changed]
    and M_JPInput_A
    ret z
    
.aBtn
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    cp 0
    jr z, .exitSMSScreen
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    
    ld hl, $9400
    ld b, 6
    call PauseMenu_ClearInputTiles
    jp System_ScheduleNextSubSubState
    
.exitSMSScreen
    ld a, M_PauseMenu_SubStateSMSExit0
    ld [W_SystemSubSubState], a
    ret
    
PauseMenu_SubStateSMSListingInit::
    ld bc, $1A
    
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .isCgb
    
.isDmg
    ld bc, $54
    
.isCgb
    call Banked_LoadMaliasGraphics
    
    ld e, $3D
    call PauseMenu_LoadMenuMap0
    ld bc, $10B
    ld e, $22
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_MelodyEdit_DataCurrent]
    call PauseMenu_DrawSMSListingEntry
    
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
    jr nz, .noCursors
    
.cursors
    xor a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
.noCursors
    jp System_ScheduleNextSubSubState
    
;State 0C 13 04
PauseMenu_SubStateSMSListingIdle::
    ld a, [W_MelodyEdit_DataCount]
    cp 1
    jr z, .noCursors
    
.cursors
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_IterateCursorAnimation
    
.noCursors
    jp PauseMenu_SMSListingInputHandler
    
;State 0C 13 05
PauseMenu_SubStateSMSContentsInit::
    ld e, $57
    call PauseMenu_LoadMenuMap0
    jp System_ScheduleNextSubSubState
    
;State 0C 13 06
PauseMenu_SubStateSMSContentsIdle::
    ld a, [H_JPInput_Changed]
    and M_JPInput_A
    ret z
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    
    ld hl, $9400
    ld b, 6
    call PauseMenu_CGBClearInputTiles
    
    ld a, 3
    ld [W_SystemSubSubState], a
    ret
    
;State 0C 13 07
PauseMenu_SubStateSMSExit0::
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    call PauseMenu_ClearArrowMetasprites
    jp System_ScheduleNextSubSubState

SECTION "Pause Menu SMS State Machine 2", ROMX[$7F47], BANK[$4]
PauseMenu_SubStateSMSExit1::
    xor a
    ld [W_MainScript_TextStyle], a
    jp PauseMenu_ExitToCentralMenu
    
PauseMenu_SubStateSMSExit2::
    jp $5B27

PauseMenu_LoadMainGraphics::
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .cgbGfx
    
.dmgGfx
    ld bc, $54
    call Banked_LoadMaliasGraphics
    ld bc, $55
    jp Banked_LoadMaliasGraphics

.cgbGfx
    ld bc, $1A
    call Banked_LoadMaliasGraphics
    ld bc, $1B
    jp Banked_LoadMaliasGraphics