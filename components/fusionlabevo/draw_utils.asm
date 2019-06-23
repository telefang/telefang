INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Draw Utils", ROMX[$4BAD], BANK[$2A]
FusionLabEvo_GetWindowFlavourColour::
	ld a, [$C91A]
	cp $C7
	jr c, .notGreyedOut

.greyedOut
	ld a, $B
	ld hl, $64ED
	call CallBankedFunction_int
	ld a, BANK(FusionLabEvo_GetWindowFlavourColour)
	ld [W_PreviousBank], a
	ret

.notGreyedOut
	ld a, $B
	ld hl, $6526
	call CallBankedFunction_int
	ld a, BANK(FusionLabEvo_GetWindowFlavourColour)
	ld [W_PreviousBank], a
	ret

SECTION "Fusion/Lab Evolution Draw Utils 2", ROMX[$4BED], BANK[$2A]
FusionLabEvo_ItemSelectionScreenCleanup::
	ld a, 0
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld a, 0
	ld [W_ShadowREG_HBlankSecondMode], a
	ld [W_HBlank_SCYIndexAndMode], a
	ld hl, $9880
	ld a, 0
	ld bc, $100
	call $3775
	ld b, 0
	ld a, 0
	ld c, a
	call FusionLabEvo_DrawItem
	ld b, 1
	ld a, 0
	ld c, a
	call FusionLabEvo_DrawItem
	ld b, 2
	ld a, 0
	ld c, a
	call FusionLabEvo_DrawItem
	ld b, 3
	ld a, 0
	ld c, a
	call FusionLabEvo_DrawItem
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ret

FusionLabEvo_MapTopAndBottomWindows::
	ld de, $4C38
	ld hl, $9800
	ld b, 4
	ld c, $14
	ld a, 0
	call FusionLabEvo_MapTilesRectangle
	call FusionLabEvo_MapBottomWindowTiles
	ld d, 8
	ld bc, $20
	ld hl, $9880
	ld a, 3
	call LCDC_InitAttributesSquare
	ret

FusionLabEvo_MapTilesRectangle::
	push bc
	push hl
	push af
	ld b, 0
	call LCDC_InitAttributesLine
	ld a, $38
	call Banked_LCDC_LoadTiles
	pop af
	pop hl
	ld bc, $20
	add hl, bc
	pop bc
	dec b
	jr nz, FusionLabEvo_MapTilesRectangle
	ret

FusionLabEvo_MapBottomWindowTiles::
	ld de, $4CB0
	ld hl, $9980
	ld b, 6
	ld c, $14
	ld a, 1
	jp FusionLabEvo_MapTilesRectangle

FusionLabEvo_MapBottomWindowTilesAlt::
	ld de, $4CB0
	ld hl, $9980
	ld b, 6
	ld c, $14
	ld a, 5
	jp FusionLabEvo_MapTilesRectangle

FusionLabEvo_MapTilesRectangleAlt::
	push bc
	push hl
	push af
	ld b, 0
	ld a, $38
	call Banked_LCDC_LoadTiles
	pop af
	pop hl
	ld bc, $20
	add hl, bc
	pop bc
	dec b
	jr nz, FusionLabEvo_MapTilesRectangleAlt
	ret

FusionLabEvo_MapItems::
	ld a, $38
	ld hl, $98C0
	ld de, $4E18
	ld bc, $A0
	call Banked_LCDC_LoadTiles
	ld a, [W_GameboyType]
	cp M_BIOS_CPU_CGB
	ret nz
	ld a, 1
	ldh [REG_VBK], a
	ld a, $38
	ld hl, $98C0
	ld de, $4EB8
	ld bc, $A0
	call Banked_LCDC_LoadTiles
	ld a, 0
	ldh [REG_VBK], a
	ret

FusionLabEvo_DrawItem::
	call FusionLabEvo_LoadItemPalette
	ld d, BANK(PauseMenu_Items0)
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer]
	add c
	dec a
	cp $22
	jr c, .itemBank0

.itemBank1
	inc d
	sub $22

.itemBank0
	ld e, a
	ld a, d
	ld [W_PauseMenu_CurrentItemGraphicBank], a
	push bc
	ld d, 0
	ld bc, $1E0
	call System_Multiply16
	ld hl, $4000
	add hl, de
	ld d, h
	ld e, l
	pop bc
	ld a, b
	add a
	ld hl, .table
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	or a
	jr z, .noItem
	ld a, [W_PauseMenu_CurrentItemGraphicBank]
	ld bc, $01E0
	jp Banked_LCDC_LoadTiles

.table
	dw $9010
	dw $9210
	dw $9410
	dw $9610

.noItem
	ld b, $F0

FusionLabEvo_DrawItem_itemGfxClearLoop::
	di

.wfb
	ldh a, [REG_STAT]
	and 2
	jr nz, .wfb

	xor a
	ld [hli], a
	ld [hli], a
	ei 
	dec b
	jr nz, FusionLabEvo_DrawItem_itemGfxClearLoop
	ret

SECTION "Fusion/Lab Evolution Draw Utils 3", ROMX[$4D48], BANK[$2A]
FusionLabEvo_LoadItemPalette::
	ld a, c
	or a
	ret z
	push bc
	ld a, BANK(FusionLabEvo_LoadItemPalette)
	ld [W_PreviousBank], a
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer]
	dec c
	add c
	ld c, a
	ld d, b
	ld b, 0
	ld hl, $1E0
	add hl, bc
	ld b, h
	ld c, l
	ld a, d
	add 3
	call CGBLoadBackgroundPaletteBanked
	ld a, 1
	ld [W_CGBPaletteStagedBGP], a
	pop bc
	ret

FusionLabEvo_LoadSelectedItemObjectPalette::
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer]
	dec c
	add c
	ld c, a
	ld d, b
	ld b, 0
	ld hl, $200
	add hl, bc
	ld b, h
	ld c, l
	ld a, 1
	call CGBLoadObjectPaletteBanked
	ret

FusionLabEvo_DrawVisibleItems::
	call FusionLabEvo_DetermineNextAndPreviousItems
	ld b, 0
	ld a, [W_FusionLabEvo_PreviousItem]
	ld c, a
	call FusionLabEvo_DrawItem
	ld b, 1
	ld a, [W_FusionLabEvo_SelectedItem]
	ld c, a
	call FusionLabEvo_DrawItem
	ld b, 2
	ld a, [W_FusionLabEvo_NextItem]
	ld c, a
	call FusionLabEvo_DrawItem
	ld b, 3
	ld a, [W_FusionLabEvo_NextNextItem]
	ld c, a
	call FusionLabEvo_DrawItem
	ret

SECTION "Fusion/Lab Evolution Draw Utils 5", ROMX[$5279], BANK[$2A]
FusionLabEvo_ClearMessageBox::
	ld a, $C0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $E0
	ld [W_Status_NumericalTileIndex], a
	ld a, 1
	ld [$CA65], a
	ld d, $C
	ld b, 0
	call $33D6
	ld a, 2
	ld [$CADA], a
	ld a, $B
	ld hl, $4CE5
	call CallBankedFunction_int
	call FusionLabEvo_MapBottomWindowTiles
	jp $2CC4
