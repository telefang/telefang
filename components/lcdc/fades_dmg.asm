INCLUDE "telefang.inc"

SECTION "SGB Palette Buffer", WRAM0[$C800]
W_SGB_FadeMethod:: ds 1
W_SGB_PreloadedFadeStageA:: ds 1
W_SGB_PreloadedFadeStageB:: ds 4
W_SGB_PreloadedFadeStageC:: ds 4
W_SGB_PreloadedFadeStageD:: ds 4
W_SGB_PalCommandBuffer:: ds 1
W_SGB_Colour00Buffer:: ds 2
W_SGB_Colour01Buffer:: ds 2
W_SGB_Colour02Buffer:: ds 2
W_SGB_Colour03Buffer:: ds 2
W_SGB_Colour11Buffer:: ds 2
W_SGB_Colour12Buffer:: ds 2
W_SGB_Colour13Buffer:: ds 2
W_SGB_Colour21Buffer:: ds 2
W_SGB_Colour22Buffer:: ds 2
W_SGB_Colour23Buffer:: ds 2
W_SGB_Colour31Buffer:: ds 2
W_SGB_Colour32Buffer:: ds 2
W_SGB_Colour33Buffer:: ds 2
W_SGB_Colour00Fade23Buffer:: ds 2
W_SGB_Colour01Fade23Buffer:: ds 2
W_SGB_Colour02Fade23Buffer:: ds 2
W_SGB_Colour03Fade23Buffer:: ds 2
W_SGB_Colour11Fade23Buffer:: ds 2
W_SGB_Colour12Fade23Buffer:: ds 2
W_SGB_Colour13Fade23Buffer:: ds 2
W_SGB_Colour21Fade23Buffer:: ds 2
W_SGB_Colour22Fade23Buffer:: ds 2
W_SGB_Colour23Fade23Buffer:: ds 2
W_SGB_Colour31Fade23Buffer:: ds 2
W_SGB_Colour32Fade23Buffer:: ds 2
W_SGB_Colour33Fade23Buffer:: ds 2
W_SGB_Colour00Fade13Buffer:: ds 2
W_SGB_Colour01Fade13Buffer:: ds 2
W_SGB_Colour02Fade13Buffer:: ds 2
W_SGB_Colour03Fade13Buffer:: ds 2
W_SGB_Colour11Fade13Buffer:: ds 2
W_SGB_Colour12Fade13Buffer:: ds 2
W_SGB_Colour13Fade13Buffer:: ds 2
W_SGB_Colour21Fade13Buffer:: ds 2
W_SGB_Colour22Fade13Buffer:: ds 2
W_SGB_Colour23Fade13Buffer:: ds 2
W_SGB_Colour31Fade13Buffer:: ds 2
W_SGB_Colour32Fade13Buffer:: ds 2
W_SGB_Colour33Fade13Buffer:: ds 2

SECTION "LCDC Palette Fade DMG", ROMX[$7C2D], BANK[3]
LCDC_PaletteFadeDMG::
	ld a, [W_SGB_DetectSuccess]
	or a
	jr z, .noSGB

	ld a, [W_SGB_FadeMethod]
	dec a
	jp z, LCDC_PredefinedPaletteFadeSGB
	dec a
	jp z, LCDC_PaletteFadeSGB

.noSGB
	ld a, [W_LCDC_FadeType]
	ld d, 0
	ld e, a
	sla e
	rl d
	sla e
	rl d
	ld hl, LCDC_DMGPaletteFades
	add hl, de

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [W_LCDC_PaletteAnimFrame]
	ld d, 0
	ld e, a
	add hl, de

	ld a, [hl]
	ld [W_ShadowREG_BGP], a

	ld d, 0
	ld e, 5
	add hl, de
	ld a, [hl]
	ld [W_ShadowREG_OBP0], a

	ld d, 0
	ld e, 5
	add hl, de
	ld a, [hl]
	ld [W_ShadowREG_OBP1], a

	ld a, [W_LCDC_PaletteAnimFrame]
	inc a
	ld [W_LCDC_PaletteAnimFrame], a
	ret

LCDC_PaletteFadeSGB::
	ld a, [W_LCDC_PaletteAnimWaitCounter]
	or a

; Subtract one frame from the wait counter to account for the time to send one packet to the sgb.
; We will subtract again later if two packets are required.

	jr z, .dontAdjust
	dec a
	ld [W_LCDC_PaletteAnimWaitCounter], a

.dontAdjust
	ld a, [W_LCDC_FadeType]
	and 1
	jr nz, .fadeOut

.fadeIn
	ld a, [W_LCDC_PaletteAnimFrame]
	or a
	jp z, LCDC_PredefinedPaletteFadeSGB.stageAIn
	dec a
	jr z, .stageB
	dec a
	jr z, .stageC
	jr .stageD

.fadeOut
	ld a, [W_LCDC_PaletteAnimFrame]
	or a
	jr z, .stageD
	dec a
	jr z, .stageC
	dec a
	jr z, .stageB
	jp LCDC_PredefinedPaletteFadeSGB.stageAOut

.stageB
	ld d, (2 << 5) + (M_SGB_Pal01 << 3) + 1
	M_AuxJmp Banked_PatchUtils_CommitSGBBufferToSGB_CBE
	ld d, (2 << 5) + (M_SGB_Pal23 << 3) + 1
	jr .secondPacketAdjust

.stageC
	ld d, (1 << 5) + (M_SGB_Pal01 << 3) + 1
	M_AuxJmp Banked_PatchUtils_CommitSGBBufferToSGB_CBE
	ld d, (1 << 5) + (M_SGB_Pal23 << 3) + 1
	jr .secondPacketAdjust

.stageD
	ld d, (0 << 5) + (M_SGB_Pal01 << 3) + 1
	M_AuxJmp Banked_PatchUtils_CommitSGBBufferToSGB_CBE
	ld d, (0 << 5) + (M_SGB_Pal23 << 3) + 1

.secondPacketAdjust
	M_AuxJmp Banked_PatchUtils_CommitSGBBufferToSGB_CBE
	
	ld a, [W_LCDC_PaletteAnimWaitCounter]
	or a
	jr z, .dontAdjustTwo
	dec a
	ld [W_LCDC_PaletteAnimWaitCounter], a

.dontAdjustTwo
	ld a, [W_LCDC_PaletteAnimFrame]
	inc a
	ld [W_LCDC_PaletteAnimFrame], a
	ret

LCDC_PredefinedPaletteFadeSGB::
	ld a, [W_LCDC_PaletteAnimWaitCounter]
	or a

; Subtract one frame from the wait counter to account for the time to send one packet to the sgb.

	jr z, .dontAdjust
	dec a
	ld [W_LCDC_PaletteAnimWaitCounter], a

.dontAdjust
	ld a, [W_LCDC_FadeType]
	and 1
	jr nz, .fadeOut

.fadeIn
	ld a, [W_LCDC_PaletteAnimFrame]
	or a
	jr z, .stageAIn
	dec a
	jr z, .stageB
	dec a
	jr z, .stageC
	jr .stageD

.fadeOut
	ld a, [W_LCDC_PaletteAnimFrame]
	or a
	jr z, .stageD
	dec a
	jr z, .stageC
	dec a
	jr z, .stageB
	jr .stageAOut

.stageAIn
	ld a, $E4
	ld [W_ShadowREG_BGP], a
	ld a, $E0
	ld [W_ShadowREG_OBP0], a
	ld a, $D2
	ld [W_ShadowREG_OBP1], a
	jr .stageA

.stageAOut
	ld a, [W_LCDC_FadeType]
	and 2
	jr z, .fadeToWhite
	ld a, $FF

.fadeToWhite
	ld [W_ShadowREG_BGP], a
	ld [W_ShadowREG_OBP0], a
	ld [W_ShadowREG_OBP1], a

.stageA
	ld a, [W_SGB_PreloadedFadeStageA]
	ld b, a
	ld c, a
	ld d, a
	ld e, a
	jr .setPalette

.stageB
	ld hl, W_SGB_PreloadedFadeStageB
	jr .copyToRegisters

.stageC
	ld hl, W_SGB_PreloadedFadeStageC
	jr .copyToRegisters

.stageD
	ld hl, W_SGB_PreloadedFadeStageD

.copyToRegisters
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a

.setPalette
	xor a
	ld hl, W_SGB_SpotPalette
	ld [hl], $51 ;PAL_SET
	inc hl
	ld [hl], b
	inc hl
	ld [hli], a
	ld [hl], c
	inc hl
	ld [hli], a
	ld [hl], d
	inc hl
	ld [hli], a
	ld [hl], e
	inc hl
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	call SGB_SendConstructedPaletteSetPacket
	ld a, [W_LCDC_PaletteAnimFrame]
	inc a
	ld [W_LCDC_PaletteAnimFrame], a
	ret
