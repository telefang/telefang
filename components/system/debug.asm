INCLUDE "telefang.inc"

SECTION "Debug Number Display Init Tracking", WRAM0[$C7E6]
W_Debug_DisableNumberRefresh:: ds 1

SECTION "Debug Map Selector Feature",  ROMX[$5FAF],  BANK[$B]
Debug_StateMapSelector::
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Left
	jr z, .leftNotPressed
	ld a, [W_Overworld_AcreType]
	inc a
	ld [W_Overworld_AcreType], a
	cp $35
	jr c, .updateNumbers
	xor a
	ld [W_Overworld_AcreType], a
	jr .updateNumbers

.leftNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, [W_Overworld_AcreType]
	dec a
	ld [W_Overworld_AcreType], a
	cp $35
	jr c, .updateNumbers
	ld a, $34
	ld [W_Overworld_AcreType], a
	jr .updateNumbers

.rightNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Up
	jr z, .upNotPressed
	call Debug_MapSelectorDecAcre
	jr .updateNumbers

.upNotPressed
	ld a, [W_JPInput_TypematicBtns]
	and M_JPInput_Down
	jr z, .updateNumbersMaybe
	call Debug_MapSelectorIncAcre
	jr .updateNumbers

.updateNumbersMaybe
	ld a, [W_Debug_DisableNumberRefresh]
	or a
	jr nz, .dontUpdateNumbers

.updateNumbers
	M_AuxJmp Banked_Debug_ADVICE_DrawDigitsForMapSelector

.dontUpdateNumbers
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	ret z
	xor a
	ld [W_Debug_DisableNumberRefresh], a
	ld a, $50
	ld [$C902], a
	ld a, $40
	ld [$C901], a
	ld a, 2
	ld [W_Overworld_State], a
	ld a, 7
	ld [W_SystemSubState], a
	ld a, 4
	jp LCDC_SetupPalswapAnimation
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
	nop
	nop
	nop
	nop

SECTION "Debug Map Selector Feature 2",  ROMX[$603C],  BANK[$B]
Debug_MapSelectorIncAcre::
	ld a, [$C906]
	inc a
	and $3F
	ld [$C906], a
	call $2793
	ld a, [$C903]
	cp $FF
	ret nz
	jr Debug_MapSelectorIncAcre

Debug_MapSelectorDecAcre::
	ld a, [$C906]
	dec a
	and $3F
	ld [$C906], a
	call $2793
	ld a, [$C903]
	cp $FF
	ret nz
	jr Debug_MapSelectorDecAcre

SECTION "Debug Draw Digits Advice Code", ROMX[$6E00], BANK[$1]
Debug_ADVICE_DrawDigitsForMapSelector::
	M_AdviceSetup
	ld a, [W_Overworld_AcreType]
	ld de, $8940
	call Debug_ADVICE_DrawDigits
	ld a, [$C906]
	ld e, $70
	call Debug_ADVICE_DrawDigits
	ld a, d ; a can be set to anything except 0 here, so we will save a byte by copying from the d register instead of using ld a,1.
	ld [W_Debug_DisableNumberRefresh], a
	M_AdviceTeardown
	ret

Debug_ADVICE_DrawDigits::
	ld b, a
	and $F0
	swap a
	add a
	add a
	add a
	add a
	ld c, a
	ld a, b
	ld b, 0
	ld hl, .debugLeft
	add hl, bc
	ld c, a
	ld b, 8

.loopA
	di

.wfbA
	ldh a, [REG_STAT]
	and 2
	jr nz, .wfbA

	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ei
	inc de
	dec b
	jr nz, .loopA

	ld a, c
	and $F
	add a
	add a
	add a
	add a
	ld c, a
	ld hl, .debugRight
	add hl, bc
	ld b, 8

.loopB
	di

.wfbB
	ldh a, [REG_STAT]
	and 2
	jr nz, .wfbB

	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ei
	inc de
	dec b
	jr nz, .loopB
	ret

.debugLeft
	INCBIN "build/components/system/debug_left.2bpp"

.debugRight
	INCBIN "build/components/system/debug_right.2bpp"
