INCLUDE "telefang.inc"

SECTION "Attract Mode Advice Code", ROMX[$5634], BANK[$2]
AttractMode_ADVICE_CheckSGB::
	ld a, [W_SGB_DetectSuccess]
	or a
	ret z

	ld a, [W_GameboyType]
	cp M_BIOS_CPU_CGB
	ret

AttractMode_ADVICE_LoadSGBFilesScene3::
	call System_ScheduleNextSubState
	call AttractMode_ADVICE_CheckSGB
	ret z
	call AttractMode_ADVICE_Scene3CorrectMetaspriteIndex.skipSGBCheck
	ld a, $22
	ld bc, $2728
	ld de, $292A
	jp Banked_SGB_ConstructPaletteSetPacket

AttractMode_ADVICE_Scene3CorrectMetaspriteIndexOnInit::
	call Banked_PauseMenu_InitializeCursor
	jr AttractMode_ADVICE_Scene3CorrectMetaspriteIndex.skipCursorIteration

AttractMode_ADVICE_Scene3CorrectMetaspriteIndex::
	call Banked_PauseMenu_IterateCursorAnimation

.skipCursorIteration
	call AttractMode_ADVICE_CheckSGB
	ret z

.skipSGBCheck
	ld a, [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index]
	cp $48
	ret z
	cp $49
	ret z
	add 4
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ret

AttractMode_ADVICE_UnloadSGBFiles::
	call System_ScheduleNextSubState
	call AttractMode_ADVICE_CheckSGB
	ret z

.skipSGBCheck
	xor a
	ld b, a
	ld c, a
	ld d, a
	ld e, a
	jp Banked_SGB_ConstructPaletteSetPacket

AttractMode_ADVICE_MapUndertiles::
	ld hl, $9914
	ld de, $19
	ld c, 6

.loop
	ld b, $E0
	di

.wfbA
	ld a, [REG_STAT]
	and 2
	jr nz, .wfbA
	ld a, b
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ei
	ld b, 1
	di

.wfbB
	ld a, [REG_STAT]
	and 2
	jr nz, .wfbB
	ld a, b
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ei
	add hl, de
	dec c
	jr nz, .loop
	ret

AttractMode_ADVICE_LoadSGBFilesScene1::
	call AttractMode_ADVICE_CheckSGB
	jr z, .noSGB

	ld a, $23
	ld bc, $2B2C
	ld de, $2D2E
	call Banked_SGB_ConstructPaletteSetPacket
	call AttractMode_ADVICE_MapUndertiles

	ld a, $4A
	jr .setMetaspriteIndex

.noSGB
	ld a, $40

.setMetaspriteIndex
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ret

AttractMode_ADVICE_LoadSGBFilesScene1_loadGfx::
	call AttractMode_ADVICE_CheckSGB
	jr z, .noSGB

	ld a, BANK(Scene1SGBGfx)
	ld hl, $8000
	ld de, Scene1SGBGfx
	ld bc, $440
	call Banked_LCDC_LoadTiles

	ld a, BANK(Scene1UndertileGfx)
	ld hl, $8E00
	ld de, Scene1UndertileGfx
	ld bc, $10
	jp Banked_LCDC_LoadTiles

.noSGB
	ld bc, $3A
	jp Banked_LoadMaliasGraphics

AttractMode_ADVICE_LoadSGBFilesScene1_postScroll::
	call AttractMode_ADVICE_CheckSGB
	jr z, .noSGB

	call AttractMode_ADVICE_MapUndertiles
	ld c, $24
    call Banked_SGB_ConstructATFSetPacket
	
	ld a, $4B
	jr .setMetaspriteIndex

.noSGB
	ld a, $41

.setMetaspriteIndex
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ret

AttractMode_ADVICE_LoadSGBFilesScene1_spriteChange::
	ld a, [W_System_CountdownTimer]
	cp $7E
	ret nz

	call AttractMode_ADVICE_CheckSGB
	jr z, .noSGB

	ld hl, $9958
	ld de, $1E
	
	ld c, 3

.loop
	ld b, $E0
	di

.wfbA
	ld a, [REG_STAT]
	and 2
	jr nz, .wfbA

	ld a, b
	ld [hli], a
	ld [hli], a
	ei
	add hl, de
	dec c
	jr nz, .loop

.noSGB
	ld a, [W_System_CountdownTimer]
	ret

AttractMode_ADVICE_Scene2CorrectMetaspriteIndexOnInit::
	call Banked_PauseMenu_InitializeCursor
	jr AttractMode_ADVICE_Scene2CorrectMetaspriteIndex.skipCursorIteration

AttractMode_ADVICE_Scene2CorrectMetaspriteIndex::
	call Banked_PauseMenu_IterateCursorAnimation

.skipCursorIteration
	call AttractMode_ADVICE_CheckSGB
	ret z

.skipSGBCheck
	ld a, [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index]
	cp $4C
	ret z
	cp $4D
	ret z
	add $A
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ret

AttractMode_ADVICE_LoadSGBFilesScene2::
	call System_ScheduleNextSubState
	call AttractMode_ADVICE_CheckSGB
	ret z
	ld a, $26
	ld bc, $3435
	ld de, $3637
	jp Banked_SGB_ConstructPaletteSetPacket

AttractMode_ADVICE_LoadSGBFilesScene4::
	call AttractMode_ADVICE_CheckSGB
	jr z, .noSGB

	ld hl, $9000
	ld de, AttractModeScene4SGBGfx1
	ld bc, $800
	call LCDC_LoadTiles
	ld hl, $8800
	ld de, AttractModeScene4SGBGfx2
	ld bc, $150
	call LCDC_LoadTiles
	ld bc, $3E
	call Banked_LoadMaliasGraphics
	ld bc, 0
	ld e, $11
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld a, $27
	ld bc, $3839
	ld de, $3A3B
	jp Banked_SGB_ConstructPaletteSetPacket

.noSGB
	ld bc, $34
	call AttractMode_LoadMaliasGraphicsPair
	ld bc, $3E
	call Banked_LoadMaliasGraphics
	ld bc, 0
	ld e, $C
	ld a, 1
	jp Banked_RLEDecompressTMAP0

AttractMode_ADVICE_Scene4CorrectMetaspriteIndexOnInit::
	call Banked_PauseMenu_InitializeCursor
	jr AttractMode_ADVICE_Scene4CorrectMetaspriteIndex.skipCursorIteration

AttractMode_ADVICE_Scene4CorrectMetaspriteIndex::
	call Banked_PauseMenu_IterateCursorAnimation

.skipCursorIteration
	call AttractMode_ADVICE_CheckSGB
	ret z

.skipSGBCheck
	ld a, [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index]
	cp $4E
	ret z
	cp $4F
	ret z
	add 8
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ret

AttractMode_StateFadeOutAndSGBBranch::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	call AttractMode_ADVICE_CheckSGB
	jp z, System_ScheduleNextSubState
	ld a, $23
	ld [W_SystemSubState], a
	jp AttractMode_ADVICE_UnloadSGBFiles.skipSGBCheck

AttractMode_StatePanScene6SGB::
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	or a
	ret nz
	ld a, [W_ShadowREG_SCX]
	and $21
	ld a, 4
	jr nz, .slowerPlz
	dec a

.slowerPlz
	ld [W_System_CountdownTimer], a
	ld a, [W_ShadowREG_SCX]
	dec a
	ld [W_ShadowREG_SCX], a
	or a
	ret nz
	ld a, $28
	ld bc, $3C40
	ld de, $4142
	call Banked_SGB_ConstructPaletteSetPacket
	ld a, $50
	ld [W_System_CountdownTimer], a
	jp System_ScheduleNextSubState

AttractMode_StateScene6PreFadeDelaySGB::
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	cp $4C
	jr z, .colourStageB
	cp $48
	jr z, .colourStageC
	or a
	ret nz
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $10
	ld [$CF96], a
	jp System_ScheduleNextSubState

.colourStageB
	ld a, $28
	ld bc, $3C43
	ld de, $4445
	jp Banked_SGB_ConstructPaletteSetPacket

.colourStageC
	ld a, $28
	ld bc, $3C3D
	ld de, $3E3F
	jp Banked_SGB_ConstructPaletteSetPacket

SECTION "Scene 1 SGB Gfx", ROMX[$79B0], BANK[$77]
Scene1UndertileGfx::
	INCBIN "build/gfx/intro/scene1_undertiles.2bpp"

Scene1SGBGfx::
	INCBIN "build/gfx/intro/shigeki_sprites1_sgb.2bpp"
