INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Selected Item", WRAM0[$CAE0]
W_FusionLabEvo_SelectedItem:: ds 1

SECTION "Fusion/Lab Evolution Scroll State", WRAM0[$CAEB]
W_FusionLabEvo_ScrollState:: ds 1

SECTION "Fusion/Lab Evolution Draw Item Data", ROMX[$510F], BANK[$2A]
FusionLabEvo_DrawItemData::
	ld a, [W_FusionLabEvo_ScrollState]
	cp a, 1
	ret nz
	ld a, 2
	ld [W_FusionLabEvo_ScrollState], a
	ld a, [W_FusionLabEvo_SelectedItem]
	ld b, a
	dec b
	ld a, [$C2B5]
	add b
	ld b, a
	ld a, BANK(MainScript_LoadItemNameAsArg3)
	ld hl, MainScript_LoadItemNameAsArg3
	call CallBankedFunction_int
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
	ld a, [$CAEE]
	or a
	jr z, .jpA
	ld a, b
	add a, $40
	ld b, a

.jpA
	ld a, b
	ld hl, W_PauseMenu_InventoryQuantities - 1
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]
	call Status_DecimalizeStatValue
	ld a, $C7
	ld hl, $8B80
	call Banked_MainScript_DrawLetter
	ld a, [W_GenericRegPreserve]
	swap a
	and a, $F
	add a, $BB
	ld hl, $8B90
	call Banked_MainScript_DrawLetter
	ld a, [W_GenericRegPreserve]
	and a, $F
	add a, $BB
	ld hl, $8BA0
	call Banked_MainScript_DrawLetter
	ret

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
	add a, $BB
	ld hl, $8900
	call Banked_MainScript_DrawLetter
	ld a, [W_GenericRegPreserve]
	and a, $F
	add a, $BB
	ld hl, $8910
	call Banked_MainScript_DrawLetter
	pop de
	ld a, d
	cp a, 99
	jr nz, .notMaxLevel

	; This writes " MAX" instead of the current exp when the level is 99.
	
	add sp, 2
	ld hl, $8920
	ld a, 0
	call Banked_MainScript_DrawLetter
	ld hl, $8930
	ld a, $AA
	call Banked_MainScript_DrawLetter
	ld hl, $8940
	ld a, $9E
	call Banked_MainScript_DrawLetter
	ld hl, $8950
	ld a, $B5
	jp Banked_MainScript_DrawLetter

.notMaxLevel
	pop hl
	srl h
	rr l
	call FusionLabEvo_DecimalizeExp
	ld hl, $8920
	ld a, [Malias_CmpSrcBank]
	add a, $BB
	call Banked_MainScript_DrawLetter
	ld hl, $8930
	ld a, [W_GenericRegPreserve]
	add a, $BB
	call Banked_MainScript_DrawLetter
	ld hl, $8940
	ld a, [Malias_DeCmpDst]
	add a, $BB
	call Banked_MainScript_DrawLetter
	ld hl, $8950
	ld a, 0
	jp Banked_MainScript_DrawLetter

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
