INCLUDE "telefang.inc"

SECTION "Intro Scene 4 SGB Gfx (Speed)", ROMX[$7600], BANK[$2]
AttractModeScene4SGBGfx1::
	INCBIN "build/versions/speed/gfx/intro/fungus_shigeki_sgb1.2bpp"

AttractModeScene4SGBGfx2::
	INCBIN "build/versions/speed/gfx/intro/fungus_shigeki_sgb2.2bpp"

SECTION "Intro Scene 5 and 6 Version-Specific Patch Code", ROMX[$6000], BANK[$2]
AttractMode_VersionSpecificWarning::
	db "VersionSpecificCodeStartsHere"

AttractMode_StateDrawScene5SGB::
	call LCDC_ClearMetasprites
	ld bc, $36
	call AttractMode_LoadMaliasGraphicsPair
	ld bc, 0
	ld e, $D
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $FF
	ld [W_System_CountdownTimer], a
	ld a, 8
	ld [$C463], a
	jp System_ScheduleNextSubState

AttractMode_StatePanScene5SGB::
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

AttractMode_StateDrawScene6SGB::
	call LCDC_ClearMetasprites
	ld bc, $38
	call AttractMode_LoadMaliasGraphicsPair
	ld bc, 0
	ld e, $E
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 3
	ld [W_System_CountdownTimer], a
	xor a
	ld [$C463], a
	ld a, $40
	ld [W_ShadowREG_SCX], a
	ld a, $28
	ld b, $3C
	ld c, b
	ld d, b
	ld e, b
	call Banked_SGB_ConstructPaletteSetPacket
	jp System_ScheduleNextSubState
