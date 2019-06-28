INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution Animation Utils", ROMX[$4BD0], BANK[$2A]
FusionLabEvo_PrepareItemScroll::
	ld a, 1
	ld [W_ShadowREG_HBlankSecondMode], a
	ld a, 1
	ld [W_HBlank_SCYIndexAndMode], a
	ld hl, W_Battle_WindowOverlap
	ld a, $21
	ld [hli], a
	ld a, 0
	ld [hli], a
	ld a, $5F
	ld [hli], a
	ld a, 0
	ld [W_FusionLabEvo_ScrollPosition], a
	ld [hl], a
	ret

SECTION "Fusion/Lab Evolution Animation Utils 2", ROMX[$4F26], BANK[$2A]
FusionLabEvo_AnimateArrows::
	ld b, 1
	ld c, 1
	ld a, [W_FusionLabEvo_PreviousItem]
	or a
	jr nz, .hasPreviousItem
	ld b, 0

.hasPreviousItem
	ld a, [W_FusionLabEvo_NextItem]
	or a
	jr nz, .hasNextItem
	ld c, 0

.hasNextItem
	ld a, b
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, c
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, [W_SystemSubState]
	cp $1E
	jr z, .pointToSelectedItem
	ld a, $43
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, $42
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	inc a
	ld [W_FusionLabEvo_ArrowAnimationState], a
	call FusionLabEvo_CalculateArrowPosition
	add $34
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	cpl
	inc a
	call FusionLabEvo_CalculateArrowPosition
	add $6C
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, $44
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_YOffset], a
	ld a, $44
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_YOffset], a
	ret

.pointToSelectedItem
	ld a, 1
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, 1
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, $34
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, $6C
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, $42
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, $43
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	inc a
	ld [W_FusionLabEvo_ArrowAnimationState], a
	call FusionLabEvo_CalculateArrowPosition
	add $44
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_YOffset], a
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	cpl
	inc a
	call FusionLabEvo_CalculateArrowPosition
	add $44
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_YOffset], a
	ret

FusionLabEvo_CalculateArrowPosition::
	ld d, a
	sla d
	sla d
	sla d
	call $3058
	sra a
	sra a
	sra a
	sra a
	sra a
	ret

FusionLabEvo_AnimateMessageBoxInputIndicator::
	ld c, $C
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	bit 4, a
	jr nz, .inUpState
	ld c, $D

.inUpState
	ld a, [W_Status_NumericalTileIndex]
	add c
	ld c, a
	di
	call WaitForBlanking
	ld a, c
	ld [$9A11], a
	ei
	ret

FusionLabEvo_ItemSelectionScrollInputHandler::
	call FusionLabEvo_TypematicButtonsLogic
	ld a, [W_FusionLabEvo_ScrollAccelerator]
	or a
	ret nz
	ldh a, [H_JPInput_Changed]
	ld b, a
	ld a, [W_FusionLabEvo_TypematicBtns]
	or b
	and M_JPInput_Right
	jr z, .rightNotPressed
	ld a, [W_FusionLabEvo_NextItem]
	or a
	ret z
	dec a
	ld [W_FusionLabEvo_InFocusItemNumber], a
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_FusionLabEvo_NextNextItem]
	push af
	call FusionLabEvo_DetermineNextAndPreviousItems
	ld a, [W_FusionLabEvo_ScrollPositionIndex]
	ld b, a
	pop af
	ld c, a
	call FusionLabEvo_DrawItem
	ld a, 0
	ld [W_FusionLabEvo_ScrollState], a
	ld a, $12
	ld [W_FusionLabEvo_ScrollAccelerator], a
	ld a, [W_FusionLabEvo_ScrollPosition]
	add 1
	ld [W_FusionLabEvo_ScrollPosition], a
	ld a, [W_FusionLabEvo_ScrollPositionIndex]
	inc a
	jr .setScrollPositionIndex

.rightNotPressed
	ldh a, [H_JPInput_Changed]
	ld b, a
	ld a, [W_FusionLabEvo_TypematicBtns]
	or b
	and M_JPInput_Left
	ret z
	ld a, [W_FusionLabEvo_PreviousItem]
	or a
	ret z
	dec a
	ld [W_FusionLabEvo_InFocusItemNumber], a
	call FusionLabEvo_DetermineNextAndPreviousItems
	ld a, 2
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_FusionLabEvo_ScrollPositionIndex]
	ld b, a
	ld a, [W_FusionLabEvo_PreviousItem]
	ld c, a
	call FusionLabEvo_DrawItem
	ld a, 0
	ld [W_FusionLabEvo_ScrollState], a
	ld a, $EE
	ld [W_FusionLabEvo_ScrollAccelerator], a
	ld a, [W_FusionLabEvo_ScrollPosition]
	sub 1
	ld [W_FusionLabEvo_ScrollPosition], a
	ld a, [W_FusionLabEvo_ScrollPositionIndex]
	dec a

.setScrollPositionIndex
	and 3
	ld [W_FusionLabEvo_ScrollPositionIndex], a
	M_PrepAuxJmp Banked_FusionLabEvo_ADVICE_SwitchSGBPaletteLayout
	jp PatchUtils_AuxCodeJmp
	nop
	nop

FusionLabEvo_AnimateItemScrollPosition::
	ld a, [W_FusionLabEvo_ScrollAccelerator]
	or a
	ret z
	ld b, a
	ld a, [W_FusionLabEvo_ScrollPosition]
	add b
	ld [W_FusionLabEvo_ScrollPosition], a
	ld a, [W_FusionLabEvo_ScrollAccelerator]
	bit 7, a
	jr z, .decreaseToZero

.increaseToZero
	add 3
	ld [W_FusionLabEvo_ScrollAccelerator], a
	ret 

.decreaseToZero
	sub 3
	ld [W_FusionLabEvo_ScrollAccelerator], a
	ret

FusionLabEvo_TypematicButtonsLogic::
	ldh a, [H_JPInput_HeldDown]
	and M_JPInput_Left + M_JPInput_Right
	jr nz, .cantScrollATM
	ld a, [W_FusionLabEvo_ScrollState]
	or a
	jr nz, .cantScrollATM
	ld a, [W_FusionLabEvo_ScrollAccelerator]
	or a
	jr nz, .cantScrollATM
	ld a, 1
	ld [W_FusionLabEvo_ScrollState], a

.cantScrollATM
	ldh a, [H_JPInput_HeldDown]
	and M_JPInput_Left
	jr nz, .leftPressed
	ld a, $18
	ld [W_FusionLabEvo_LeftButtonHoldCountdownTimer], a

.leftPressed
	ld a, [W_FusionLabEvo_LeftButtonHoldCountdownTimer]
	or a
	jr z, .leftHoldTimerCantGoLower
	dec a
	ld [W_FusionLabEvo_LeftButtonHoldCountdownTimer], a

.leftHoldTimerCantGoLower
	ldh a, [H_JPInput_HeldDown]
	and M_JPInput_Right
	jr nz, .rightPressed
	ld a, $18
	ld [W_FusionLabEvo_RightButtonHoldCountdownTimer], a

.rightPressed
	ld a, [W_FusionLabEvo_RightButtonHoldCountdownTimer]
	or a
	jr z, .rightHoldTimerCantGoLower
	dec a
	ld [W_FusionLabEvo_RightButtonHoldCountdownTimer], a

.rightHoldTimerCantGoLower
	ldh a, [H_JPInput_HeldDown]
	and M_JPInput_Left
	jr nz, .stillPressingLeft
	ld a, [W_FusionLabEvo_TypematicBtns]
	and ($FF - M_JPInput_Left)
	ld [W_FusionLabEvo_TypematicBtns], a

.stillPressingLeft
	ld a, [W_FusionLabEvo_LeftButtonHoldCountdownTimer]
	or a
	jr nz, .leftNotHeldLongEnough
	ld a, [W_FusionLabEvo_TypematicBtns]
	or M_JPInput_Left
	ld [W_FusionLabEvo_TypematicBtns], a

.leftNotHeldLongEnough
	ldh a, [H_JPInput_HeldDown]
	and M_JPInput_Right
	jr nz, .stillPressingRight
	ld a, [W_FusionLabEvo_TypematicBtns]
	and ($FF - M_JPInput_Right)
	ld [W_FusionLabEvo_TypematicBtns], a

.stillPressingRight
	ld a, [W_FusionLabEvo_RightButtonHoldCountdownTimer]
	or a
	jr nz, .rightNotHeldLongEnough
	ld a, [W_FusionLabEvo_TypematicBtns]
	or M_JPInput_Right
	ld [W_FusionLabEvo_TypematicBtns], a

.rightNotHeldLongEnough
	ret

SECTION "Fusion/Lab Evolution Animation Utils 3", ROMX[$57AA], BANK[$2A]
FusionLabEvo_AnimateSprites::
	ld a, [W_SystemSubState]
	push af
	ld a, 4
	ld [W_SystemSubState], a
	ld a, $C
	ld hl, $479C
	call CallBankedFunction_int
	pop af
	ld [W_SystemSubState], a
	ret

FusionLabEvo_ClearSpriteConfig1::
	ld b, M_MetaSpriteConfig1_Count
	ld hl, W_MetaSpriteConfig1
	ld de, M_MetaSpriteConfig_Size
	xor a

.metaSpriteClearLoop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .metaSpriteClearLoop
	ret
