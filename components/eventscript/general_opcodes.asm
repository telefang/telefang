INCLUDE "telefang.inc"

; Not sure where to put these two vars yet, so they can stay here for now.

SECTION "Shop Item Price Staging", WRAM0[$CADC]
; This is the price of the shop item you are holding as a negative number.
W_Shop_ItemPriceStaging:: ds 2

SECTION "Shop Player Total Chiru", WRAM0[$C910]
; This is the price of the shop item you are holding as a negative number.
W_Shop_PlayerTotalChiru:: ds 2

SECTION "Event Action - Warp Player and Continue", ROMX[$428F], BANK[$F]
EventScript_WarpPlayerAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_Overworld_AcreType], a
	ld a, [W_EventScript_ParameterB]
	ld [$C906], a
	ld a, [W_EventScript_ParameterC]
	ld b, a
	inc a
	ld c, a
	and a, $F0
	add a, 8
	ld [$C901], a
	ld a, c
	swap a
	and a, $F0
	ld [$C902], a
	ld a, [W_SystemSubState]
	cp a, 1
	jr z, .jpA
	ld a, 7
	ld [W_SystemSubState], a
	ld a, $F
	ld [W_PreviousBank], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld b, 4
	call EventScript_CalculateNextOffset
	xor a
	ret

.jpA
	ld a, 0
	ld [W_SystemSubState], a
	ld b, 4
	call EventScript_CalculateNextOffset
	xor a
	ret

SECTION "Event Action - Wait X Frames and Continue", ROMX[$4247], BANK[$F]
EventScript_WaitXFramesAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_EventScript_WaitFrames], a
	ld b, 2
	call EventScript_CalculateNextOffset
	
; It should be noted that if the carry flag is set at the end of an action then it will immediately continue to the next action in the sequence without waiting a frame.
; Generally "xor a" is used to reset the carry flag, and "scf" is used to set it.
	
	xor a
	ret

SECTION "Event Action - Wait For Button Press and Continue", ROMX[$4254], BANK[$F]
EventScript_WaitForButtonPressAndContinue::
; Waits for buttons A or B to be pressed before continuing.
	ldh a, [H_JPInput_Changed]
	and a, 3
	jr nz, .buttonPressed
	xor a
	ret

.buttonPressed
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret
	
SECTION "Event Action - Set Reception and Continue", ROMX[$4EB6], BANK[$F]
EventScript_SetReceptionAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_Overworld_SignalStrength], a
	ld b, 0
	ld a, $29
	ld hl, $503B
	call CallBankedFunction_int
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Schedule SFX and Continue", ROMX[$4802], BANK[$F]
EventScript_ScheduleSFXAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_Sound_NextSFXSelect], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Set Music and Continue", ROMX[$480F], BANK[$F]
EventScript_SetMusicAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret
	
SECTION "Event Action - Output Message and Continue", ROMX[$4222], BANK[$F]
EventScript_OutputMessageAndContinue::
	ld hl, W_EventScript_ParameterA
	ld a, [hli]
	ld b, a
	ld c, [hl]
	call $33C9
	ld b, 3
	call EventScript_CalculateNextOffset
	ld a, [W_EventScript_WaitFrames]
	or a
	jr nz, .weAreWaitingAlready
	ld a, 8
	ld [W_EventScript_WaitFrames], a
	
.weAreWaitingAlready
	xor a
	ret

SECTION "Event Action - Shop Price Message and Continue", ROMX[$485A], BANK[$F]
EventScript_ShopPriceMessageAndContinue::
; Loads the message box with the specified message.
	ld hl, W_EventScript_ParameterA
	ld a, [hli]
	ld b, a
	ld c, [hl]
	call $33C9
; Compares the item price to the player's total and sets or resets a flag to be used later.
	ld a, [W_Shop_ItemPriceStaging]
	cpl
	ld e, a
	ld a, [W_Shop_ItemPriceStaging + 1]
	cpl
	ld d, a
	inc de
	ld a, [W_Shop_PlayerTotalChiru + 1]
	ld h, a
	ld a, [W_Shop_PlayerTotalChiru]
	ld l, a
	add hl, de
	jr c, .enoughChiru
	ld bc, $C3B
	call Overworld_SetFlag
	jr .priceToString

.enoughChiru
	ld bc, $C3B
	call Overworld_ResetFlag

; Converts the item price to a string and stores it at $CA00 for use by the message.
.priceToString
	ld a, [W_Shop_ItemPriceStaging]
	ld l, a
	ld a, [W_Shop_ItemPriceStaging + 1]
	ld h, a
	call EventScript_ShopPriceNumbersToText
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_ShopPriceNumbersToText::
	ld de, $CA00
	ld b, 0
	push de
	ld c, 0
	ld de, -10000

.fifthDigitFromRightCalcLoop
	inc c
	add hl, de
	jr c, .fifthDigitFromRightCalcLoop
	ld de, 10000
	add hl, de
	pop de
	ld a, c
	dec a
	or a
	jr z, .fifthDigitFromRightIsZeroSkip
	add a, $BB
	ld [de], a
	inc de
	ld b, 1

.fifthDigitFromRightIsZeroSkip
	push de
	ld c, 0
	ld de, -1000
  
.fourthDigitFromRightCalcLoop
	inc c
	add hl, de
	jr c, .fourthDigitFromRightCalcLoop
	ld de, 1000
	add hl, de
	pop de
	ld a, c
	dec a
	bit 0, b
	jr nz, .fourthDigitFromRightNotLeadingDigit
	or a
	jr z, .fourthDigitFromRightIsZeroSkip

.fourthDigitFromRightNotLeadingDigit
	add a, $BB
	ld [de], a
	inc de
	ld b, 1

.fourthDigitFromRightIsZeroSkip
	push de
	ld c, 0
	ld de, -100

.thirdDigitFromRightCalcLoop
	inc c
	add hl, de
	jr c, .thirdDigitFromRightCalcLoop
	ld de, 100
	add hl, de
	pop de
	ld a, c
	dec a
	bit 0, b
	jr nz, .thirdDigitFromRightNotLeadingDigit
	or a
	jr z, .thirdDigitFromRightIsZeroSkip

.thirdDigitFromRightNotLeadingDigit
	add a, $BB
	ld [de], a
	inc de
	ld b, 1

.thirdDigitFromRightIsZeroSkip
	push de
	ld c, 0
	ld de, -10

.secondDigitFromRightCalcLoop
	inc c
	add hl, de
	jr c, .secondDigitFromRightCalcLoop
	ld de, 10
	add hl, de
	pop de
	ld a, c
	dec a
	bit 0, b
	jr nz, .secondDigitFromRightNotLeadingDigit
	or a
	jr z, .secondDigitFromRightIsZeroSkip

.secondDigitFromRightNotLeadingDigit
	add a, $BB
	ld [de], a
	inc de
	ld b, 1

.secondDigitFromRightIsZeroSkip
	ld a, l
	add a, $BB
	ld [de], a
	inc de
	ld a, $E0
	ld [de], a
	ret

SECTION "Event Action - Standard End", ROMX[$4263], BANK[$F]
; I may rename this later if I find other endcodes.
EventScript_StandardEnd::
	ld a, 0
	ld [$C950], a
	ld [$C951], a
	ld a, 3
	ld [$C918], a
	
; This function call seems to reset button inputs.
	
	call $225B
	ld a, 8
	ld [W_EventScript_WaitFrames], a
	ld a, [$C940]
	or a
	jr nz, .jpA
	inc a
	ld [$C940], a

.jpA
	ld a, [W_MetaSpriteConfigPlayer + $19]
	and a, $FD
	ld [W_MetaSpriteConfigPlayer + $19], a
	xor a
	ld [$CD00], a
	ret
