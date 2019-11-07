INCLUDE "telefang.inc"

SECTION "Save Corruption Screen SGB Colours", ROMX[$44C0], BANK[$1]
; Ideally you should keep the code in this section the same byte length for both versions.
TitleScreen_ADVICE_CorruptSaveLoadSGBFiles::
	M_AdviceSetup
	ld bc, $C
	call Banked_LoadMaliasGraphics
	call PauseMenu_ADVICE_CheckSGB
	jr z, .return

	ld a, BANK(CorruptionScreenSGBOverlay0Gfx)
	ld hl, $9470
	ld de, CorruptionScreenSGBOverlay0Gfx
	ld bc, $20
	call Banked_LCDC_LoadTiles

	ld a, BANK(CorruptionScreenSGBOverlay1Gfx)
	ld hl, $94E0
	ld de, CorruptionScreenSGBOverlay1Gfx
	ld bc, $30
	call Banked_LCDC_LoadTiles

	ld a, BANK(CorruptionScreenSGBOverlay2Gfx)
	ld hl, $9530
	ld de, CorruptionScreenSGBOverlay2Gfx
	ld bc, $70
	call Banked_LCDC_LoadTiles

	ld a, BANK(CorruptionScreenSGBOverlay3Gfx)
	ld hl, $95E0
	ld de, CorruptionScreenSGBOverlay3Gfx
	ld bc, $20 
	call Banked_LCDC_LoadTiles

	ld bc, $C430
	call TitleScreen_ADVICE_IdentifyFadePalettesCommon
	ld a, $4A
	ld [W_SGB_PreloadedFadeStageA], a
	ld c, $25
	call Banked_SGB_ConstructATFSetPacket

.return
	M_AdviceTeardown
	ret

SECTION "Save Corruption Screen SGB Tiles", ROMX[$4020], BANK[$77]
CorruptionScreenSGBOverlay0Gfx::
	INCBIN "build/versions/speed/gfx/screen/save_deleted_sgb0.2bpp"

CorruptionScreenSGBOverlay1Gfx::
	INCBIN "build/versions/speed/gfx/screen/save_deleted_sgb1.2bpp"

CorruptionScreenSGBOverlay2Gfx::
	INCBIN "build/versions/speed/gfx/screen/save_deleted_sgb2.2bpp"

CorruptionScreenSGBOverlay3Gfx::
	INCBIN "build/versions/speed/gfx/screen/save_deleted_sgb3.2bpp"
