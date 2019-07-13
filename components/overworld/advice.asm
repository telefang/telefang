INCLUDE "telefang.inc"

SECTION "Overworld Palette SGB Advice", ROMX[$7A8E], BANK[$B]
Overworld_ADVICE_PaletteLoader::
	call Overworld_WindowFlavourPaletteLoader
	M_PrepAuxJmp Banked_Overworld_ADVICE_LoadSGBFiles
	jp PatchUtils_AuxCodeJmp

SECTION "Overworld Palette SGB Advice 2", ROMX[$66F0], BANK[$1]
Overworld_ADVICE_LoadSGBFiles::
	M_AdviceSetup

	call PauseMenu_ADVICE_CheckSGB
	jr z, .exit

	ld hl, Overworld_SGBPaletteIndexTable
	ld a, [$C905]
	add l
	ld l, a
	jr nc, .noIncH
	inc h

.noIncH
	ld a, [hl]
	or a
	jr z, .inTheGreatOutdoors
	dec a
	jr .setPalette

.inTheGreatOutdoors
	call Overworld_ADVICE_GetOutdoorAcrePaletteIndex

.setPalette
	ld b, a
	ld c, b
	ld a, M_SGB_Pal01 << 3 + 1
	call PatchUtils_CommitStagedCGBToSGB
	
	ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 7)
	call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

	ld c, $1F
	call Banked_SGB_ConstructATFSetPacket
	
	ld a, M_SGB_Pal23 << 3 + 1
	ld bc, $607
	call PatchUtils_CommitStagedCGBToSGB

	call Overworld_ADVICE_IsShop
	jr nz, .notShopScreen
    ld a, 3
    ld [W_MainScript_TextStyle], a
    ld hl, $8C00
    ld b, $C0
    call Zukan_ADVICE_TileLowByteBlanketFill
	ld h, $D
	call Banked_SGB_ConstructATTRBLKPacket
	jr .exit

.notShopScreen
	xor a
	ld [W_MainScript_TextStyle], a

.exit
	M_AdviceTeardown
	ret

Overworld_ADVICE_SGBShopTextStyle::
	call PauseMenu_ADVICE_CheckSGB
	ret z
	call Overworld_ADVICE_IsShop
	jr nz, .notShop
	ld a, 3
	jr .setTextStyle

.notShop
	xor a

.setTextStyle
	ld [W_MainScript_TextStyle], a
	ret

Overworld_ADVICE_IsShop::
	ld a, [$C905]
	cp 6
	ret nz
	ld a, [$C390]
	cp $15
	ret

Overworld_SGBPaletteIndexTable::
	db 0, 0, 0, 3
	db 0, 3, 3, 3
	db 3, 3, 3, 3
	db 2, 4, 3, 3
	db 3, 3, 3, 3

Overworld_ADVICE_GetOutdoorAcrePaletteIndex::
	; This may be expanded on later, but for now we will just use green for everything.
	ld a, 3
	ret
