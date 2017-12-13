INCLUDE "telefang.inc"

SECTION "Title Menu State Machine", ROMX[$4000], BANK[$4]
TitleMenu_GameStateMachine::
    ld a, [W_SystemSubState]
    ld hl, TitleMenu_StateTable
    call System_IndexWordList
    jp [hl]
    
;TODO: disassemble
TitleMenu_StateTable
    dw TitleMenu_StateSetupPalettes, TitleMenu_StateLoadGraphics, TitleMenu_StateLoadTMaps, TitleMenu_StateDrawMenu, TitleMenu_StatePositionMenuHalves, TitleMenu_StateCommitMenuPalettes, TitleMenu_StatePlayMenuBGM, TitleMenu_StateAnimateMenuHalvesIn ;07
    dw TitleMenu_StateMenuInputHandler, TitleMenu_StateAnimateMenuScrollUpOne, TitleMenu_StateAnimateMenuScrollUpTwo, TitleMenu_StateAnimateMenuScrollFinish, TitleMenu_StateAnimateMenuScrollDownOne, TitleMenu_StateAnimateMenuScrollDownTwo, TitleMenu_StateFadeToOverworldContinue, TitleMenu_StateLoadTimeInputScreen ;0F
    dw TitleMenu_StateResetTimeDrawWidget, TitleMenu_StateTimeInputHandler, TitleMenu_StateLoadNameInputScreen, TitleMenu_StateClearNameInput, TitleMenu_StateNameInput, TitleMenu_StateStorePlayerName, TitleMenu_StateInitNewGame, TitleMenu_StateFadeToOverworldNewGame ;17
    dw $437F, $43A5, $43B4, $43E2, $4400, $440E, $4424, $406E ;1F
    dw TitleMenu_StateInitNickname, TitleMenu_StateFadeNickname, TitleMenu_StateNickname, TitleMenu_StateSaveNickname, $457D ;24
    
; State 03 00 is version-specific.
    
SECTION "Title Menu State Machine 2", ROMX[$406E], BANK[$4]
; State 03 01, 03 1F
TitleMenu_StateLoadGraphics
    call ClearGBCTileMap0
    call ClearGBCTileMap1
    call LCDC_ClearMetasprites
    call PauseMenu_LoadMainGraphics
    
    ld bc, $11
    call Banked_LoadMaliasGraphics
    call PauseMenu_LoadPhoneGraphics
    call PauseMenu_LoadPhoneIMEGraphics
    jp System_ScheduleNextSubState
    
; State 03 02
TitleMenu_StateLoadTMaps::
    ld a, 1
    ld [W_RLEAttribMapsEnabled], a
    
    ld bc, 0
    ld e, $10
    call PauseMenu_LoadMap0
    
    ld e, $12
    call PauseMenu_LoadMenuMap0
    
    ld bc, $30F
    ld e, $20
    call PauseMenu_LoadMap0
    
    ld bc, 0
    ld e, $11
    call PauseMenu_LoadMap1
    
    xor a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld [$CB39], a
    ld [$CB3C], a
    
    ld a, 3
    ld [$CB3A], a
    
    jp System_ScheduleNextSubState
    
; State 03 03
TitleMenu_StateDrawMenu::
    ld a, $10
    ld [$CB39], a
    
    ld b, 0
    ld a, [$C434]
    cp 0
    jr z, .jmp1
    
    ld b, 3
    
.jmp1
    ld a, b
    ld [W_PauseMenu_SelectedMenuItem], a
    
    ld a, [W_SerIO_ConnectionState]
    cp 0
    jr z, .jmp2
    
    ld a, 2
    ld [W_PauseMenu_SelectedMenuItem], a
    
.jmp2
    xor a
    ld [W_SerIO_ConnectionState], a
    ld [$C900], a
    
    call TitleMenu_ScrollMenu_refresh
    jp System_ScheduleNextSubState
    
; State 03 04
TitleMenu_StatePositionMenuHalves::
    call PauseMenu_CGBLoadPalettes
    ld a, $A7
    ld [W_ShadowREG_WX], a
    ld a, $50
    ld [W_ShadowREG_SCX], a
    jp System_ScheduleNextSubState
    
; State 03 05
TitleMenu_StateCommitMenuPalettes::
    call LCDC_DMGSetupDirectPalette
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld [W_CGBPaletteStagedOBP], a
    jp System_ScheduleNextSubState
    
; State 03 06
TitleMenu_StatePlayMenuBGM::
    ld a, (Banked_TitleMenu_ADVICE_LoadSGBFiles & $FF)
    call PatchUtils_AuxCodeJmp
	 
    nop
    nop
    nop
    jp System_ScheduleNextSubState
    
; State 03 07
TitleMenu_StateAnimateMenuHalvesIn::
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
    
    xor a
    ld [W_ShadowREG_SCX], a
    
    jp System_ScheduleNextSubState
    
; State 03 08
TitleMenu_StateMenuInputHandler::
    call TitleMenu_ScrollMenu
    
    ld a, [W_JPInput_TypematicBtns]
    and $80
    jr z, .checkUpPress
    
.downPress
    ld a, M_TitleMenu_StateAnimateMenuScrollUpOne
    jr .gotoScrollAnimation
    
.checkUpPress
    ld a, [W_JPInput_TypematicBtns]
    and $40
    jr z, .checkAPress
    
.upPress
    ld a, M_TitleMenu_StateAnimateMenuScrollDownOne
    
.gotoScrollAnimation
    ld [W_SystemSubState], a
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ret
    
.checkAPress
    ld a, [H_JPInput_Changed]
    and 1
    jp z, .noInputToProcess
    
.aPress
    xor a
    ld [W_SerIO_ConnectionState], a
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp M_TitleMenu_ItemContinue
    jr z, .continueSelected
    
    cp M_TitleMenu_ItemNewGame
    jp z, .newGameSelected
    
    cp M_TitleMenu_ItemSoundTest
    jr z, .soundTestSelected
    
    cp M_TitleMenu_ItemLink
    jr z, .linkSelected
    
    ret
    
.linkSelected
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, 1
    ld [W_SerIO_ConnectionState], a
    
    xor a
    ld [W_SystemSubState], a
    ld [W_Battle_SubSubState], a
    
    ld a, (Banked_TitleMenu_ADVICE_UnloadSGBFilesLink & $FF)
    call PatchUtils_AuxCodeJmp
    ret
    
.soundTestSelected
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld bc, $104
    ld e, $3B
    call PauseMenu_LoadMap0
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, M_TitleMenu_StateLoadSoundTestScreen
    ld [W_SystemSubState], a
    jp $6CD3
    
.continueSelected
    ld a, [$C434]
    cp 1
    jr z, .saveInvalidated
    
.savePresent
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, $10
    ld [$CF96], a
    
    ld a, M_TitleMenu_StateFadeToOverworldContinue
    ld [W_SystemSubState], a
    
    ret
    
.saveInvalidated
    ld a, 5
    ld [W_Sound_NextSFXSelect], a
    ret
    
.newGameSelected
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, M_TitleMenu_StateLoadTimeInputScreen
    ld [W_SystemSubState], a
    
    xor a
    ld [$CB39], a
    ld [$CB3A], a
    
    ret
    
.noInputToProcess
    ret
    
; State 03 09
TitleMenu_StateAnimateMenuScrollUpOne::
    ld e, $1E
    call PauseMenu_LoadScrollAnimationFrame
    call TitleMenu_DrawUpScrollMenuItems
    jp System_ScheduleNextSubState
    
; State 03 0A
TitleMenu_StateAnimateMenuScrollUpTwo::
    ld e, $1F
    call PauseMenu_LoadScrollAnimationFrame
    
    ld bc, $307
    call TitleMenu_DrawMenuItems_custCoords
    jp System_ScheduleNextSubState
    
; State 03 0B
TitleMenu_StateAnimateMenuScrollFinish::
    ld e, $12
    call PauseMenu_LoadScrollAnimationFrame
    
    ld bc, $307
    call TitleMenu_DrawMenuItems_custCoords
    
    ld a, 8
    ld [W_SystemSubState], a
    ret
    
; State 03 0C
TitleMenu_StateAnimateMenuScrollDownOne::
    ld e, $1F
    call PauseMenu_LoadScrollAnimationFrame
    call TitleMenu_DrawDownScrollMenuItems
    jp System_ScheduleNextSubState
    
; State 03 0D
TitleMenu_StateAnimateMenuScrollDownTwo::
    ld e, $1E
    call PauseMenu_LoadScrollAnimationFrame
    
    ld bc, $306
    call TitleMenu_DrawMenuItems_custCoords
    
    ld a, $B
    ld [W_SystemSubState], a
    ret

; State 03 0E
TitleMenu_StateFadeToOverworldContinue::
    ld a, 1
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    ld a, $C3
    ld [W_ShadowREG_LCDC], a
    
    xor a
    ld [W_ShadowREG_SCX], a
    ld [W_ShadowREG_SCY], a
    ld [W_ShadowREG_WX], a
    ld [W_ShadowREG_WY], a
    ld [W_PauseMenu_CurrentPhoneIME], a
    
    ld a, (Banked_TitleMenu_ADVICE_UnloadSGBFilesOverworld & $FF)
    call PatchUtils_AuxCodeJmp
    
    xor a
    ld [W_SystemSubState], a
    
    call $5C1
    
    ld b, 1
    call $3768
    
    ld a, 1
    ld [$C900], a
    
    ret
    
; State 03 0F
TitleMenu_StateLoadTimeInputScreen::
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    
    ld a, [$C434]
    cp 0
    jr nz, .skipTilemapLoad
    
    ld bc, $D
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .useCGBTmap
    
.useDMGTmap
    ld bc, $56
    
.useCGBTmap
    call Banked_LoadMaliasGraphics
    
    ld a, $1B
    ld [W_SystemSubState], a
    
    ret
    
.skipTilemapLoad
    jp System_ScheduleNextSubState

; State 03 10
TitleMenu_StateResetTimeDrawWidget::
    ld bc, $104
    ld e, $14
    call PauseMenu_LoadMap0
    call TitleMenu_ResetRTC
    
    ld a, 5
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size
    call Banked_PauseMenu_InitializeCursor
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    call TitleMenu_DrawTimeSetWidget
    jp System_ScheduleNextSubState

; State 03 11
TitleMenu_StateTimeInputHandler::
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size
    call Banked_PauseMenu_IterateCursorAnimation
    jp TitleMenu_TimeEntryProcessing
    
; State 03 12
TitleMenu_StateLoadNameInputScreen::
    ld a, 7
    ld [W_MetaSpriteConfig1 + M_LCDC_MetaSpriteData_TileID], a
    
    ld b, $50
    ld c, $50
    ld de, W_MetaSpriteConfig1
    call PauseMenu_PositionCursor
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    call PauseMenu_PhoneIMEPlaceCursor
    jp System_ScheduleNextSubState

; State 03 13
TitleMenu_StateClearNameInput::
    ld hl, $9780 ;Tile no. 78
    ld b, M_MainScript_PlayerNameSize
    call PauseMenu_ClearInputTiles
    xor a
    ld [W_MainScript_WindowBorderAttribs], a
    call PauseMenu_SelectTextStyle
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, M_PhoneMenu_IMELatinUpper
    ld [W_PauseMenu_CurrentPhoneIME], a
    ld a, $FF
    ld [W_PauseMenu_PhoneIMELastPressedButton], a
    call TitleMenu_PositionNameCursor
    ld a, 2
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size
    call Banked_PauseMenu_InitializeCursor
    ld a, M_PhoneMenu_IMELatinLower
    ld [W_PauseMenu_NextPhoneIME], a
    call PauseMenu_LoadPhoneIMEGraphics
    call TitleMenu_ClearCharaName
    call PauseMenu_DrawCenteredNameBufferNoVWF
    ld bc, $104
    ld e, $35
    call PauseMenu_LoadMap0
    call PauseMenu_LoadPhoneIMETilemap
    jp System_ScheduleNextSubState

; State 03 14
TitleMenu_StateNameInput::
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size
    call Banked_PauseMenu_IterateCursorAnimation
    call TitleMenu_PositionNameCursor
    jp TitleMenu_NameInputImpl
    
; State 03 15
TitleMenu_StateStorePlayerName::
    ld b, M_MainScript_PlayerNameSize + 1
    ld hl, W_MainScript_CenteredNameBuffer
    ld de, W_MainScript_PlayerName
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop
    
    jp System_ScheduleNextSubState
    
; State 03 16
TitleMenu_StateInitNewGame::
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, $10
    ld [$CF96], a
    jp System_ScheduleNextSubState
    
; State 03 17
TitleMenu_StateFadeToOverworldNewGame::
    ld a, 1
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    ld a, $C3
    ld [W_ShadowREG_LCDC], a
    
    xor a
    ld [W_ShadowREG_SCX], a
    ld [W_ShadowREG_SCY], a
    ld [W_ShadowREG_WX], a
    ld [W_ShadowREG_WY], a
    ld [W_PauseMenu_CurrentPhoneIME], a
    ld [W_MainScript_TextStyle], a
    
    ld a, (Banked_TitleMenu_ADVICE_UnloadSGBFilesOverworld & $FF)
    call PatchUtils_AuxCodeJmp
    
    xor a
    ld [W_SystemSubState], a
    
    ld b, 1
    call $3768
    call SaveClock_EraseSaveData
    call SaveClock_EraseLoadedSave
    call SaveClock_WriteDefaultSaveFile
    jp TitleMenu_StoreRTCValues
    
; TODO: Disassemble states 03 18 thru 03 20. (that's 8 states)

SECTION "Title Menu State Machine - Denjuu Nickname Input", ROMX[$4452], BANK[$4]
; State 03 20
TitleMenu_StateInitNickname::
    ld bc, $17
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .loadGraphic
    
.dmgGraphic
    ld bc, $58
    
.loadGraphic
    call Banked_LoadMaliasGraphics
    ld hl, $9700
    ld b, $10
    call PauseMenu_ClearScreenTiles
    
    ld bc, 0
    ld e, $10
    call PauseMenu_LoadMap0
    
    ld bc, 0
    ld e, $11
    call PauseMenu_LoadMap1
    
    ld bc, $104
    ld e, $3A
    call PauseMenu_LoadMap0
    
    xor a
    ld [W_MainScript_WindowBorderAttribs], a
    
    call PauseMenu_SelectTextStyle
    
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    
    call TitleMenu_ClearCharaName
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, $FF
    ld [W_PauseMenu_PhoneIMELastPressedButton], a
    call TitleMenu_PositionNameCursor
    
    ld a, 2
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size
    call Banked_PauseMenu_InitializeCursor
    
    ld a, M_PhoneMenu_IMELatinLower
    ld [W_PauseMenu_NextPhoneIME], a
    call PauseMenu_LoadPhoneIMEGraphics
    
    ld a, M_PhoneMenu_IMELatinUpper
    ld [W_PauseMenu_CurrentPhoneIME], a
    
    call PauseMenu_CGBLoadPalettes
    xor a
    ld [W_CGBPaletteStagedBGP], a
    ld a, $E3
    ld [W_ShadowREG_LCDC], a
    ld a, $58
    ld [W_ShadowREG_WX], a
    xor a
    ld [W_ShadowREG_WY], a
    xor a
    ld [W_ShadowREG_SCX], a
    ld [W_ShadowREG_SCY], a
    ld [W_PauseMenu_SelectedMenuItem], a
    
    ld a, 4
    ld [W_MelodyEdit_State], a
    
    call TitleMenu_PositionNicknameCursor
    call $5D40
    
    ld hl, $9700
    ld b, $10
    call PauseMenu_ClearInputTiles
    
    ld a, $70
    ld [W_MainScript_TileBaseIdx], a
    ld a, [$D480]
    ld [W_StringTable_ROMTblIndex], a
    
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    
    ld d, $C
    nop
    nop
    nop
    
    ld a, [$D480]
    call $7D46
    
    ld a, $C
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, $C120
    call Banked_PauseMenu_InitializeCursor
    
    ld a, $28
    ld [$C123], a
    ld a, $40
    ld [$C123 + 1], a
    
    ld a, 1
    ld [$C120], a
    ld a, 0
    ld [$C121], a
    
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    
    call TitleMenu_ClearCharaName
    
    ld a, [$D4A7]
    call TitleMenu_LoadDenjuuNicknameIntoBuffer
    call PauseMenu_PhoneIMESyncDenjuuNickname
    
    ld d, $C
    call PauseMenu_DrawCenteredNameBufferNoVWF
    call PauseMenu_LoadPhoneIMETilemap
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp System_ScheduleNextSubState
    
;State 03 21
TitleMenu_StateFadeNickname::
    ld a, 0
    call Banked_LCDC_PaletteFade
    or a
    ret z
    
    ld a, $32
    call $15F5
    ld [W_Sound_NextBGMSelect], a
    
    jp System_ScheduleNextSubState

;State 03 22
TitleMenu_StateNickname::
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size
    call Banked_PauseMenu_IterateCursorAnimation
    ld de, $C120
    call Banked_PauseMenu_IterateCursorAnimation
    
    call TitleMenu_PositionNicknameCursor
    jp TitleMenu_NicknameInputImpl
    
;State 03 23
TitleMenu_StateSaveNickname::
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $10
    ld [$CF96], a
    ld a, [$D4A7]
    
    call TitleMenu_SaveDenjuuNicknameFromBuffer
    jp System_ScheduleNextSubState