INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Draw Item Data", ROMX[$510F], BANK[$2A]
FusionLabEvo_DrawItemData::
	ld a, [W_FusionLabEvo_ScrollState]
	cp 1
	ret nz
	ld a, 2
	ld [W_FusionLabEvo_ScrollState], a
	ld a, [W_FusionLabEvo_SelectedItem]
	ld b, a
	dec b
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer]
	add b
	ld b, a
	ld a, BANK(MainScript_LoadItemNameAsArg3)
	ld hl, MainScript_LoadItemNameAsArg3
	call CallBankedFunction_int

FusionLabEvo_DrawItemData_extEntry::
	ld a, $B0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $E0
	ld [W_Status_NumericalTileIndex], a
	ld a, 0
	ld [$CA65], a
	ld d, 0
	ld b, 0
	ld c, $BA
	call $33D6
	ld a, 2
	ld [$CADA], a
	ld a, BANK(MainScript_ClearTilesShopWindow)
	ld hl, MainScript_ClearTilesShopWindow
	call CallBankedFunction_int
	ld a, $38
	ld hl, $9822
	ld de, $4C4E
	ld bc, 8
	call Banked_LCDC_LoadTiles
	call $2CC4
	ld a, [W_FusionLabEvo_SelectedItem]
	ld b, a
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .isFusionEvo
	ld a, b
	add a, $40
	ld b, a

.isFusionEvo
	ld a, b
	ld hl, W_PauseMenu_InventoryQuantities - 1
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]
	call Status_DecimalizeStatValue
	ld a, $A
	ld hl, $8B90
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld a, [W_GenericRegPreserve]
	swap a
	and a, $F
	ld hl, $8BA0
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld a, [W_GenericRegPreserve]
	and a, $F
	ld hl, $8BB0
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ret
	
	nop
	nop
	nop
	nop

SECTION "Fusion/Lab Evolution Draw Partner Stats", ROMX[$52D1], BANK[$2A]
FusionLabEvo_DrawPartnerStats::
	ld a, $29
	ld hl, $5509
	call CallBankedFunction_int
	push bc
	push de
	ld a, d
	call Status_DecimalizeStatValue
	ld a, [W_GenericRegPreserve]
	swap a
	and a, $F
	ld hl, $8900
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld a, [W_GenericRegPreserve]
	and a, $F
	ld hl, $8910
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	pop de
	ld a, d
	cp a, 99
	jr nz, .notMaxLevel

	; This writes " MAX" instead of the current exp when the level is 99.
	
	add sp, 2
	ld hl, $8920
	ld a, $B
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld hl, $8930
	ld a, $C
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld hl, $8940
	ld a, $D
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld hl, $8950
	ld a, $E
	jp PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx

.notMaxLevel
	pop hl
	srl h
	rr l
	call FusionLabEvo_DecimalizeExp
	ld hl, $8920
	ld a, [Malias_CmpSrcBank]
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld hl, $8930
	ld a, [W_GenericRegPreserve]
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld hl, $8940
	ld a, [Malias_DeCmpDst]
	call PatchUtils_Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx
	ld hl, $8950
	ld a, 0
	jp Banked_MainScript_DrawLetter

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

FusionLabEvo_DecimalizeExp::
	ld bc, -100
	ld a, -1

.jpA
	inc a
	ld d, h
	ld e, l
	add hl, bc
	jr c, .jpA
	ld h, d
	ld l, e
	ld [Malias_CmpSrcBank], a
	ld bc, -10
	ld a, -1

.jpB
	inc a
	ld d, h
	ld e, l
	add hl, bc
	jr c, .jpB
	ld [W_GenericRegPreserve], a
	ld a, e
	ld [Malias_DeCmpDst], a
	ret
