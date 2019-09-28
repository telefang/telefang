INCLUDE "telefang.inc"

SECTION "Intro Scene 4 SGB Gfx (Speed)", ROMX[$7600], BANK[$2]
AttractModeScene4SGBGfx1::
	INCBIN "build/versions/speed/gfx/intro/fungus_shigeki_sgb1.2bpp"

AttractModeScene4SGBGfx2::
	INCBIN "build/versions/speed/gfx/intro/fungus_shigeki_sgb2.2bpp"

SECTION "Intro Scene 5 and 6 Version-Specific Patch Code", ROMX[$5900], BANK[$2]
AttractMode_VersionSpecificWarning::
	db "VersionSpecificCodeStartsHere"

AttractMode_StateDrawScene5SGB::
	call LCDC_ClearMetasprites
	ld hl, $9000
	ld de, AttractModeScene5SGBGfx1
	ld bc, $800
	call LCDC_LoadTiles
	ld hl, $8800
	ld de, AttractModeScene5SGBGfx2
	ld bc, $800
	call LCDC_LoadTiles
	ld bc, 0
	ld e, $12
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $2C
	ld bc, $4647
	ld de, $4849
	call Banked_SGB_ConstructPaletteSetPacket
	ld a, $FF
	ld [W_System_CountdownTimer], a
	ld a, 8
	ld [$C463], a
	jp System_ScheduleNextSubState

AttractMode_StatePanScene5SGB::
	ld a, [W_System_CountdownTimer]
	and 7
	jr nz, .doNotPanThisFrame
	ld a, [$C463]
	dec a
	ld [$C463], a
	jr .doNotSendPacket

.doNotPanThisFrame
	cp 7
	jr nz, .doNotSendPacket
	; Accelerate timer to compensate for time lost sending the packet.
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	inc a
	rlca
	rlca
	and 3
	add $29
	ld c, a
	call Banked_SGB_ConstructATFSetPacket

.doNotSendPacket
	ld a, [W_System_CountdownTimer]
	dec a
	ld [W_System_CountdownTimer], a
	or a
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

AttractModeScene5SGBGfx1::
	INCBIN "build/versions/speed/gfx/intro/gymnos1sgb.2bpp"

AttractModeScene5SGBGfx2::
	INCBIN "build/versions/speed/gfx/intro/gymnos2sgb.2bpp"
