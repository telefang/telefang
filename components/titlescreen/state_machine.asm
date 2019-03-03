INCLUDE "telefang.inc"

SECTION "Title Screen State Machine Memory", WRAM0[$C3E4]
W_TitleScreen_FrameWaitCountdown:: ds 2

SECTION "Title Screen State Machine", ROMX[$493F], BANK[$2]
TitleScreen_StateMachine::
    ld a, [W_SystemSubState]
    ld hl, .stateTbl
    call System_IndexWordList
    jp hl
    
.stateTbl
    dw TitleScreen_StateLoadGraphicsAndSound
    dw TitleScreen_StateLoadTilemapsAndSprites
    dw TitleScreen_StateLoadPalettes
    dw TitleScreen_StateFadeIn
    dw TitleScreen_StateStageSprites
    dw TitleScreen_StatePlaySample
    dw TitleScreen_StateIdle
    dw TitleScreen_StateFadeOut
    dw TitleScreen_StateCorruptSaveCheck
    dw TitleScreen_StateCorruptSaveLoadPalettes
    dw TitleScreen_StateCorruptSaveLoadGraphics
    dw TitleScreen_StateCorruptSaveLoadTilemaps
    dw TitleScreen_StateFadeIn
    dw TitleScreen_StateStageSprites
    dw TitleScreen_StateCorruptSaveIdle
    dw TitleScreen_StateFadeOut
    dw TitleScreen_StateJumpToTitleMenu
    dw TitleScreen_StateFadeOut
    dw TitleScreen_StateJumpToAttract

; State 01 00
TitleScreen_StateLoadGraphicsAndSound::
    call ClearGBCTileMap0
    call ClearGBCTileMap1
    call LCDC_ClearMetasprites
    
    ld bc, $A
    call Banked_LoadMaliasGraphics
    
    ld bc, $B
    call Banked_LoadMaliasGraphics
    
    ld bc, 6
    call Banked_LoadMaliasGraphics
    
    xor a
    ld [W_Overworld_State], a
    
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld b, 0
    call Banked_System_CGBToggleClockspeed ;NOP'd in production carts
    jp System_ScheduleNextSubState
    
SECTION "Title Screen State Machine 2", ROMX[$4A1A], BANK[$2]
; State 01 02
TitleScreen_StateLoadPalettes::
    ld bc, $13
    call Banked_CGBLoadBackgroundPalette
    
    ld bc, $A
    call Banked_CGBLoadObjectPalette
    
    ld a, $10
    ld [$CB2C], a
    jp System_ScheduleNextSubState
    
; State 01 03, 01 0C
TitleScreen_StateFadeIn::
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp System_ScheduleNextSubState
    
; State 01 04, 01 0D
TitleScreen_StateStageSprites::
    ld a, 2
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    jp System_ScheduleNextSubState
    
; State 01 05
TitleScreen_StatePlaySample::
    ld a, 1
    ld [H_Sound_SampleSelect], a
    
    di
    call Banked_Sound_PlaySample
    ei
    
    ld a, $36
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, 2
    ld [W_TitleScreen_FrameWaitCountdown], a
    
    xor a
    ld [W_TitleScreen_FrameWaitCountdown + 1], a
    jp System_ScheduleNextSubState
    
; State 01 06
TitleScreen_StateIdle::
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 4 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, [W_FrameCounter]
    and 7
    jr nz, .dontBlinkSprite
    
.blinkSprite
    ld a, [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs]
    xor 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
.dontBlinkSprite
    ld a, [H_JPInput_Changed]
    and M_JPInput_A + M_JPInput_Start
    jr z, .checkAttractCountdown
    
.buttonPressed
    ld a, 9
    ld [W_Sound_NextSFXSelect], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, $10
    ld [$CF96], a
    jp System_ScheduleNextSubState

.checkAttractCountdown
    ld a, [W_TitleScreen_FrameWaitCountdown]
    ld b, a
    ld a, [W_TitleScreen_FrameWaitCountdown + 1]
    ld c, a
    dec bc
    ld a, b
    ld [W_TitleScreen_FrameWaitCountdown], a
    ld a, c
    ld [W_TitleScreen_FrameWaitCountdown + 1], a
    
    or b
    ret nz
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, $10
    ld [$CF96], a
    
    ld a, $11
    ld [W_SystemSubState], a
    ret
    
; State 01 07, 01 0F, 01 11
TitleScreen_StateFadeOut::
    ld a, 1
    call Banked_LCDC_PaletteFade
    
    or a
    ret z
    jp System_ScheduleNextSubState
    
; State 01 08
TitleScreen_StateCorruptSaveCheck::
    call LCDC_ClearMetasprites
    call SaveClock_CheckSaveIntegrity
    ld [W_SaveClock_SaveCheckPassed], a
    
    cp 0
    jr z, .validSavePresent
    cp 1
    jr z, .noSavePresent
    
.corruptedSavePresent
    jp System_ScheduleNextSubState
    
.validSavePresent
    ld a, [$BFFD] ;Save isn't readable if zero
    or a
    jr nz, .dontAllowSaveCheckToPass
    
.allowSaveCheckToPass
    ld a, 1
    ld [W_SaveClock_SaveCheckPassed], a
    
.dontAllowSaveCheckToPass
    ld a, 3
    ld [W_SystemState], a
    
    xor a
    ld [W_SystemSubState], a
    ret
    
.noSavePresent
    call SaveClock_EraseLoadedSave
    
    ld a, 3
    ld [W_SystemState], a
    
    xor a
    ld [W_SystemSubState], a
    ret
    
; State 01 09
TitleScreen_StateCorruptSaveLoadPalettes::
    ld bc, 0
    call Banked_CGBLoadBackgroundPalette
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    jp System_ScheduleNextSubState
    
; State 01 0A
TitleScreen_StateCorruptSaveLoadGraphics::
    ld bc, $C
    call Banked_LoadMaliasGraphics
    jp System_ScheduleNextSubState
    
; State 01 0B
TitleScreen_StateCorruptSaveLoadTilemaps::
    ld bc, 0
    ld e, 5
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, 0
    ld e, 5
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld bc, $18
    call Banked_CGBLoadBackgroundPalette
    jp System_ScheduleNextSubState
    
; State 01 0E
TitleScreen_StateCorruptSaveIdle::
    ld a, [H_JPInput_Changed]
    and M_JPInput_A + M_JPInput_Start
    ret z
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp System_ScheduleNextSubState
    
; State 01 10
TitleScreen_StateJumpToTitleMenu::
    call SaveClock_EraseSaveData
    call SaveClock_EraseLoadedSave
    
    ld a, 1
    ld [W_SaveClock_SaveCheckPassed], a
    
    ld a, 3
    ld [W_SystemState], a
    
    xor a
    ld [W_SystemSubState], a
    ret
    
; State 01 12
TitleScreen_StateJumpToAttract::
    ld a, 4
    ld [W_SystemState], a
    
    xor a
    ld [W_SystemSubState], a
    
    ret