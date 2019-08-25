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
	xor a
	ld b, a
	ld c, a
	ld d, a
	ld e, a
	jp Banked_SGB_ConstructPaletteSetPacket