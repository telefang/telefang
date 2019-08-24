INCLUDE "telefang.inc"

SECTION "Attract Mode State Machine", ROMX[$40BF], BANK[$2]
AttractMode_StateMachine::
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A + M_JPInput_Start
	jr z, .doNotSkipToTitlescreen
	ld a, [W_SystemSubState]
	cp $20
	jr nc, .doNotSkipToTitlescreen
	ld a, $20
	ld [W_SystemSubState], a

.doNotSkipToTitlescreen
	ld a, [W_SystemSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	; Scene 1
	dw AttractMode_StateDrawScene1 ; 00
	dw AttractMode_StateFadeIn ; 01
	dw AttractMode_StatePanScene1 ; 02
	dw AttractMode_StateScene1DenjuuAppearance ; 03
	dw AttractMode_StateScene1PreFadeDelay ; 04
	dw AttractMode_StateFadeOut ; 05
	; Scene 2
	dw AttractMode_StateDrawScene2 ; 06
	dw AttractMode_StateFadeIn ; 07
	dw AttractMode_StateScene2AnimateMouth ; 08
	dw AttractMode_StateFadeOut ; 09
	; Scene 3
	dw AttractMode_StateDrawScene3 ; 0A
	dw AttractMode_StateFadeIn ; 0B
	dw AttractMode_StateScene3ScrollTrees ; 0C
	dw AttractMode_StateScene3AnimateMouth ; 0D
	dw AttractMode_StateScene3MoveDenjuuOffscreen ; 0E
	dw AttractMode_StateScene3ReverseScrollTrees ; 0F
	dw AttractMode_StateScene3FadeOut ; 10
	; Scene 4
	dw AttractMode_StateDrawScene4 ; 11
	dw AttractMode_StateFadeIn ; 12
	dw AttractMode_StateScene4AnimateMouth ; 13
	dw AttractMode_StateFadeOut ; 14
	; Scene 5
	dw AttractMode_StateDrawScene5 ; 15
	dw AttractMode_StateFadeIn ; 16
	dw AttractMode_StatePanScene5 ; 17
	dw AttractMode_StateFadeOut ; 18
	; Scene 6
	dw AttractMode_StateDrawScene6 ; 19
	dw AttractMode_StateFadeIn ; 1A
	dw AttractMode_StatePanScene6 ; 1B
	dw AttractMode_StateScene6PreFadeDelay ; 1C
	dw AttractMode_StateFadeOut ; 1D
	; Exit
	dw AttractMode_StateNaturalFinish ; 1E
	dw AttractMode_StateExitToTitlescreen ; 1F
	dw AttractMode_StatePrepareToSkip ; 20
	dw AttractMode_StateFadeOut ; 21
	dw AttractMode_StateExitToTitlescreen ; 22

AttractMode_NextState::
	; This is unused as far as I can tell. Maybe a former placeholder state?
	jp System_ScheduleNextSubState

AttractMode_StateDrawScene1::
	call ClearGBCTileMap0
	call ClearGBCTileMap1
	call LCDC_ClearMetasprites
	ld bc, $30
	call AttractMode_LoadMaliasGraphicsPair
	ld bc, $3A
	call Banked_LoadMaliasGraphics
	xor a
	ld [$C463], a
	ld a, 1
	ld [W_ShadowREG_HBlankSecondMode], a
	ld [W_HBlank_SCYIndexAndMode], a
	ld bc, 0
	ld e, 8
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, 8
	ld a, 1
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $20
	call Banked_CGBLoadBackgroundPalette
	ld bc, 5
	call Banked_CGBLoadObjectPalette
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $40
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	ld bc, $B068
	call TitleScreen_PositionSprite
	ld a, 1
	ld [W_OAM_SpritesReady], a
	xor a
	ld [W_ShadowREG_SCX], a
	ld a, $37
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld b, 1
	call Banked_System_CGBToggleClockspeed
	jp System_ScheduleNextSubState

AttractMode_StateFadeIn::
	ld a, 2
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp System_ScheduleNextSubState

AttractMode_StatePanScene1::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_FrameCounter]
	and 3
	ret nz
	ld a, [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset]
	dec a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, [W_ShadowREG_SCX]
	inc a
	ld [W_ShadowREG_SCX], a
	cp $40
	ret nz
	ld a, $40
	ld [W_System_CountdownTimer], a
	jp System_ScheduleNextSubState

AttractMode_StateScene1DenjuuAppearance::
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	cp 0
	ret nz
	ld bc, 0
	ld e, 9
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, 9
	ld a, 1
	call Banked_RLEDecompressAttribsTMAP0
	ld a, $80
	ld [W_System_CountdownTimer], a
	ld a, $41
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	jp System_ScheduleNextSubState

AttractMode_StateScene1PreFadeDelay::
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	cp 0
	ret nz
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState

AttractMode_StateFadeOut::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp System_ScheduleNextSubState

AttractMode_StateDrawScene2::
	call LCDC_ClearMetasprites
	ld bc, $32
	call Banked_LoadMaliasGraphics
	ld bc, $3C
	call Banked_LoadMaliasGraphics
	ld bc, 0
	ld e, $A
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $A
	ld a, 1
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $21
	call Banked_CGBLoadBackgroundPalette
	ld bc, 6
	call Banked_CGBLoadObjectPalette
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	xor a
	ld [W_ShadowREG_SCX], a
	ld a, $C0
	ld [W_System_CountdownTimer], a
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	ld bc, $5848
	call TitleScreen_PositionSprite
	ld a, 6
	ld [W_PauseMenu_SelectedCursorType], a
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	call Banked_PauseMenu_InitializeCursor
	ld a, 1
	ld [W_OAM_SpritesReady], a
	jp System_ScheduleNextSubState

AttractMode_StateScene2AnimateMouth::
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	call Banked_PauseMenu_IterateCursorAnimation
	ld a, [W_System_CountdownTimer]
	cp 0
	jr z, .nextState
	dec a
	ld [W_System_CountdownTimer], a
	ret

.nextState
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState

; AttractMode_StateDrawScene3 is version-specific.

SECTION "Attract Mode State Machine 2", ROMX[$42CD], BANK[$2]
AttractMode_StateScene3ScrollTrees::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_System_CountdownTimer]
	cp 0
	jr z, .slideInDenjuu
	dec a
	ld [W_System_CountdownTimer], a
	ld a, [W_ShadowREG_SCX]
	add 4
	ld [W_ShadowREG_SCX], a
	ret

.slideInDenjuu
	ld a, [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset]
	dec a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset], a
	cp $84
	ret nc
	ld a, 8
	ld [W_PauseMenu_SelectedCursorType], a
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	call Banked_PauseMenu_InitializeCursor
	ld a, $A0
	ld [W_System_CountdownTimer], a
	jp System_ScheduleNextSubState

AttractMode_StateScene3AnimateMouth::
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	call Banked_PauseMenu_IterateCursorAnimation
	ld a, [W_System_CountdownTimer]
	cp 0
	jr z, .nextState
	dec a
	ld [W_System_CountdownTimer], a
	ret

.nextState
	jp System_ScheduleNextSubState

AttractMode_StateScene3MoveDenjuuOffscreen::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset]
	inc a
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset], a
	cp $C0
	ret c
	ld a, $80
	ld [W_System_CountdownTimer], a
	jp System_ScheduleNextSubState

AttractMode_StateScene3ReverseScrollTrees::
	ld a, [W_System_CountdownTimer]
	cp 0
	jr z, .nextState
	dec a
	ld [W_System_CountdownTimer], a
	ld a, [W_ShadowREG_SCX]
	sub 4
	ld [W_ShadowREG_SCX], a
	ret

.nextState
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState

AttractMode_StateScene3FadeOut::
	; Keeps scrolling while fading out.
	ld a, [W_ShadowREG_SCX]
	sub 4
	ld [W_ShadowREG_SCX], a
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp System_ScheduleNextSubState

AttractMode_StateDrawScene4::
	call LCDC_ClearMetasprites
	ld bc, $34
	call AttractMode_LoadMaliasGraphicsPair
	ld bc, $3E
	call Banked_LoadMaliasGraphics
	ld bc, 0
	ld e, $C
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $C
	ld a, 1
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $23
	call Banked_CGBLoadBackgroundPalette
	ld bc, 8
	call Banked_CGBLoadObjectPalette
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $C0
	ld [W_System_CountdownTimer], a
	xor a
	ld [W_ShadowREG_SCX], a
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	ld bc, $8068
	call TitleScreen_PositionSprite
	ld a, 7
	ld [W_PauseMenu_SelectedCursorType], a
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	call Banked_PauseMenu_InitializeCursor
	ld a, 1
	ld [W_OAM_SpritesReady], a
	jp System_ScheduleNextSubState

AttractMode_StateScene4AnimateMouth::
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	call Banked_PauseMenu_IterateCursorAnimation
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	cp 0
	ret nz
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState

AttractMode_StateDrawScene5::
	call LCDC_ClearMetasprites
	ld bc, $36
	call AttractMode_LoadMaliasGraphicsPair
	ld bc, 0
	ld e, $D
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $D
	ld a, 1
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $24
	call Banked_CGBLoadBackgroundPalette
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $FF
	ld [W_System_CountdownTimer], a
	ld a, 8
	ld [$C463], a
	jp System_ScheduleNextSubState

AttractMode_StatePanScene5::
	ld a, [W_FrameCounter]
	and 7
	jr nz, .doNotPanThisFrame
	ld a, [$C463]
	dec a
	ld [$C463], a

.doNotPanThisFrame
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	cp 0
	ret nz
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState

AttractMode_StateDrawScene6::
	call LCDC_ClearMetasprites
	ld bc, $38
	call AttractMode_LoadMaliasGraphicsPair
	ld bc, 0
	ld e, $E
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $E
	ld a, 1
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $25
	call Banked_CGBLoadBackgroundPalette
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $A0
	ld [W_System_CountdownTimer], a
	xor a
	ld [$C463], a
	ld a, $40
	ld [W_ShadowREG_SCX], a
	jp System_ScheduleNextSubState

AttractMode_StatePanScene6::
	ld a, [W_FrameCounter]
	and 3
	ret nz
	ld a, [W_ShadowREG_SCX]
	dec a
	ld [W_ShadowREG_SCX], a
	cp 0
	ret nz
	ld a, $40
	ld [W_System_CountdownTimer], a
	jp System_ScheduleNextSubState

AttractMode_StateScene6PreFadeDelay::
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	cp 0
	ret nz
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	jp System_ScheduleNextSubState

AttractMode_StateNaturalFinish::
	ld a, $1F
	ld [W_SystemSubState], a
	ret

AttractMode_StateExitToTitlescreen::
	call LCDC_ClearMetasprites
	ld bc, 0
	call Banked_CGBLoadBackgroundPalette
	ld a, 1
	ld [W_CGBPaletteStagedBGP], a
	ld a, 1
	ld [W_SystemState], a
	xor a
	ld [W_SystemSubState], a
	ld [W_ShadowREG_SCX], a
	ld [W_ShadowREG_SCY], a
	ld [W_HBlank_SCYIndexAndMode], a
	ld [W_ShadowREG_HBlankSecondMode], a
	ld b, 0
	jp Banked_System_CGBToggleClockspeed

AttractMode_StatePrepareToSkip::
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	jp System_ScheduleNextSubState

AttractMode_LoadMaliasGraphicsPair::
	push bc
	call Banked_LoadMaliasGraphics
	pop bc
	inc bc
	jp Banked_LoadMaliasGraphics
