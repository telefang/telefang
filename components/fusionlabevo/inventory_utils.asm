INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Inventory Utils", ROMX[$4DAA], BANK[$2A]
FusionLabEvo_DetermineNextAndPreviousItems::
	ld a, 0
	ld [W_FusionLabEvo_PreviousItem], a
	ld [W_FusionLabEvo_SelectedItem], a
	ld [W_FusionLabEvo_NextItem], a
	ld [W_FusionLabEvo_NextNextItem], a

.determinePreviousItem
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer + 1]
	ld h, a
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer]
	ld l, a
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	or a
	jr z, .noPreviousItem
	ld b, a
	dec a
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a

.previousItemDetectionLoop
	ld a, [hld]
	or a
	jr nz, .setPreviousItem
	dec b
	jr nz, .previousItemDetectionLoop

.noPreviousItem
	jr .determineCurrentAndNextItems

.setPreviousItem
	ld a, b
	ld [W_FusionLabEvo_PreviousItem], a

.determineCurrentAndNextItems
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer + 1]
	ld h, a
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer]
	ld l, a
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	ld b, a
	ld de, W_FusionLabEvo_SelectedItem
	ld c, 0

.itemInventorySearchLoop
	ld a, [hli]
	or a
	jr z, .quantityIsZero
	ld a, b
	inc a
	ld [de], a
	inc de
	inc c
	ld a, c
	cp 3
	jr z, .exit

.quantityIsZero
	inc b
	ld a, [W_FusionLabEvo_InventoryQuantitiesLengthBuffer]
	cp b
	jr nz, .itemInventorySearchLoop

.exit
	ret

FusionLabEvo_CheckApplicableItemQuantities::
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer + 1]
	ld h, a
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer]
	ld l, a
	ld a, [W_FusionLabEvo_InventoryQuantitiesLengthBuffer]
	ld b, a

.searchLoop
	ld a, [hli]
	or a
	jr nz, .itemFound
	dec b
	jr nz, .searchLoop

.itemFound
	ret

FusionLabEvo_CorrectInFocusItemNumber::
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer + 1]
	ld h, a
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer]
	ld l, a
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]
	or a
	ret nz
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer + 1]
	ld h, a
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer]
	ld l, a
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	or a
	jr z, .searchForwardsForItem

.searchBackwardsForItem
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	ld b, a
	inc b

.backwardItemSearchLoop
	ld a, [hld]
	or a
	jr nz, .itemFoundBefore
	dec b
	jr nz, .backwardItemSearchLoop

.searchForwardsForItem
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer + 1]
	ld h, a
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressBuffer]
	ld l, a
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	ld b, a

.forwardItemSearchLoop
	ld a, [hli]
	or a
	jr nz, .itemFoundAfter
	inc b
	ld a, [W_FusionLabEvo_InventoryQuantitiesLengthBuffer]
	cp b
	jr nz, .forwardItemSearchLoop

.itemFoundAfter
	ld a, b
	ld [W_FusionLabEvo_InFocusItemNumber], a
	ret

.itemFoundBefore
	dec b
	ld a, b
	ld [W_FusionLabEvo_InFocusItemNumber], a
	ret

SECTION "Fusion/Lab Evolution Inventory Utils 2", ROMX[$520D], BANK[$2A]
FusionLabEvo_RememberLastItemOfFocus::
	ld bc, $89
	call Overworld_CheckFlagValue
	jr z, .isFusionEvo

.isLabEvo
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	ld [$C90C], a
	ret

.isFusionEvo
	ld a, [W_FusionLabEvo_InFocusItemNumber]
	ld [$C90E], a
	ret

SECTION "Fusion/Lab Evolution Inventory Utils 3", ROMX[$5858], BANK[$2A]
FusionLabEvo_CheckExpItemBonus::
	ld hl, $5A93
	ld a, [W_FusionLabEvo_PartnerSpecies]
	ld c, a
	ld b, 0
	add hl, bc
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	push hl
	ld bc, 8
	add hl, bc
	ld a, [hl]
	ld b, a
	ld a, [W_FusionLabEvo_SelectedItem]
	dec a
	cp b
	jr nz, .checkOtherExpItems

.largeAmountOfExp
	pop hl
	ld a, 3
	or a
	ret

.checkOtherExpItems
	pop hl
	ld a, [W_FusionLabEvo_SelectedItem]
	dec a
	ld b, a
	srl a
	srl a
	srl a
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, b
	ld c, 1
	and 7
	jr z, .skipLoop

.andMaskGenerationLoop
	sla c
	dec a
	jr nz, .andMaskGenerationLoop

.skipLoop
	ld a, [hl]
	and c
	ret z
	cp $12
	jr z, .smallAmountOfExp
	cp $1D
	jr z, .smallAmountOfExp
	cp $31
	jr z, .smallAmountOfExp
	cp $32
	jr z, .smallAmountOfExp
	cp $33
	jr nz, .someExp

.smallAmountOfExp
	ld a, 1
	or a
	ret

.someExp
	ld a, 2
	or a
	ret
