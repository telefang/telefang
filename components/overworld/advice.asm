INCLUDE "telefang.inc"

SECTION "Overworld Last SGB Outdoor Acre Colour", WRAM0[$C7E1]
W_Overworld_LastSGBOutdoorAcreColour:: ds 1

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

	ld a, [$C904]
	cp $F
	jr z, .dementiasMansion

	call Overworld_ADVICE_GetPaletteIndexFromSGBPaletteIndexTable
	or a
	jr z, .inTheGreatOutdoors
	dec a
	jr .setPalette

.dementiasMansion
	ld a, 2
	jr .setPalette

.inTheGreatOutdoors
	call Overworld_ADVICE_GetOutdoorAcrePaletteIndex
	ld [W_Overworld_LastSGBOutdoorAcreColour], a

.setPalette
	
	call Overworld_ADVICE_LoadSGBFiles_SetPalette
	
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

Overworld_ADVICE_LoadSGBFiles_SetPalette::
	ld b, a
	ld c, b

	; Ensure darkest colour is black
	ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBColorSize * 3)
	add a
	add a
	add a
	add l
	ld l, a

	xor a
	ld [hli], a
	ld [hl], a
	
	ld a, M_SGB_Pal01 << 3 + 1
	call PatchUtils_CommitStagedCGBToSGB
	ret

Overworld_ADVICE_LoadSGBPaletteByAcre::
	M_AdviceSetup

	call $2B72

	call PauseMenu_ADVICE_CheckSGB
	jr z, .exit

	call Overworld_ADVICE_GetPaletteIndexFromSGBPaletteIndexTable
	or a
	jr nz, .exit

	call Overworld_ADVICE_GetOutdoorAcrePaletteIndex

	; We only want to send a packet if the palette is actually changing.
	ld b, a
	ld a, [W_Overworld_LastSGBOutdoorAcreColour]
	cp b
	jr z, .exit

	ld a, b
	ld [W_Overworld_LastSGBOutdoorAcreColour], a
	call Overworld_ADVICE_LoadSGBFiles_SetPalette

.exit
	M_AdviceTeardown
	ret

Overworld_ADVICE_SGBShopTextStyle::
	call PauseMenu_ADVICE_CheckSGB
	ret z
	ld h, 7
	call Banked_SGB_ConstructATTRBLKPacket
	call Overworld_ADVICE_IsShop
	jr nz, .notShop
	ld h, $D
	call Banked_SGB_ConstructATTRBLKPacket
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

Overworld_ADVICE_GetPaletteIndexFromSGBPaletteIndexTable::
	ld hl, Overworld_SGBPaletteIndexTable
	ld a, [$C905]
	add l
	ld l, a
	jr nc, .noIncH
	inc h

.noIncH
	ld a, [hl]
	ret

Overworld_SGBPaletteIndexTable::
	db 0, 0, 0, 2
	db 0, 3, 3, 2
	db 1, 2, 1, 1
	db 2, 4, 4, 1
	db 2, 3, 3, 3

Overworld_ADVICE_GetOutdoorAcrePaletteIndex::
	ld a, [$C904]
	dec a
	dec a
	jr z, .upperLeft
	dec a
	jr z, .upperRight
	dec a
	jr z, .lowerLeft
	dec a
	jr z, .lowerRight
	dec a
	jr z, .upperLeft
	dec a
	jr z, .upperRight
	dec a
	jr z, .lowerLeft
	dec a
	jr z, .lowerRight

.default
	ld a, 3
	ret

.upperLeft
	ld hl, Overworld_ADVICE_SGBColourByAcreTable_TopLeft
	jr .getAcrePaletteIndex

.upperRight
	ld hl, Overworld_ADVICE_SGBColourByAcreTable_TopRight
	jr .getAcrePaletteIndex

.lowerLeft
	ld hl, Overworld_ADVICE_SGBColourByAcreTable_BottomLeft
	jr .getAcrePaletteIndex

.lowerRight
	ld hl, Overworld_ADVICE_SGBColourByAcreTable_BottomRight

.getAcrePaletteIndex
	ld a, [$C906]
	add l
	ld l, a
	jr nc, .noIncH
	inc h

.noIncH
	ld a, [hl]
	ret

Overworld_ADVICE_SGBColourByAcreTable_TopLeft::
	db 3,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0
	db 0,0,0,0,3,0,0,0
	db 0,0,0,0,3,0,0,0
	db 0,0,0,3,3,3,3,3
	db 4,4,0,3,3,1,1,3
	db 4,4,3,3,3,3,1,1
	db 4,4,3,3,3,3,1,1

Overworld_ADVICE_SGBColourByAcreTable_BottomLeft::
	db 4,4,3,3,3,2,2,2
	db 3,3,3,3,3,2,2,2
	db 3,3,3,3,3,2,3,3
	db 3,3,3,2,2,2,3,3
	db 3,3,3,2,3,3,3,3
	db 3,3,3,2,3,3,3,3
	db 3,3,3,2,3,3,3,3
	db 3,3,3,2,3,3,3,3

Overworld_ADVICE_SGBColourByAcreTable_TopRight::
	db 0,0,0,0,0,3,3,3
	db 0,3,3,3,3,3,3,3
	db 0,3,3,3,3,3,3,3
	db 0,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3
	db 1,3,3,3,3,3,3,3
	db 1,3,1,1,1,3,3,3

Overworld_ADVICE_SGBColourByAcreTable_BottomRight::
	db 2,1,1,1,1,1,3,3
	db 2,3,3,1,1,1,3,3
	db 2,3,3,1,1,3,3,3
	db 2,3,3,1,1,3,3,2
	db 3,3,3,1,1,1,2,2
	db 3,3,3,1,2,2,2,2
	db 3,3,3,1,2,2,2,2
	db 3,3,3,1,2,2,2,2
