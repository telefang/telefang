INCLUDE "telefang.inc"

; Not sure where to put these two vars yet, so they can stay here for now.

SECTION "Shop Item Price Staging", WRAM0[$CADC]
; This is the price of the shop item you are holding as a negative number.
W_Shop_ItemPriceStaging:: ds 2

SECTION "Shop Player Total Chiru", WRAM0[$C910]
; This is the price of the shop item you are holding as a negative number.
W_Shop_PlayerTotalChiru:: ds 2

SECTION "Event Action - Display Map Location and Continue", ROMX[$4E34], BANK[$F]
EventScript_DisplayMapLocationAndContinue::
	ld a, $2A
	ld hl, $4576
	call CallBankedFunction_int
	ld a, BANK(Map_LoadLocationName)
	ld hl, Map_LoadLocationName
	call CallBankedFunction_int
	ld b, 0
	ld c, $A6
	ld a, $B
	ld hl, $47CE
	call CallBankedFunction_int
	ld a, [W_MainScript_WindowLocation]
	dec a
	ld [W_MainScript_WindowLocation], a
	ld a, [W_MainScript_WindowLocation]
	dec a
	ld [W_MainScript_WindowLocation], a
	ld b, 1
	call EventScript_CalculateNextOffset
	ld a, [W_EventScript_WaitFrames]
	or a
	jr nz, .jpA
	ld a, 8
	ld [W_EventScript_WaitFrames], a

.jpA
	xor a
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

SECTION "Event Action - Clear Message Window and Continue", ROMX[$423D], BANK[$F]
EventScript_ClearMessageWindowAndContinue::
; Utterly useless because the message windows called by EventScript_OutputMessageAndContinue clear automatically after the message is finished.
	call $2BA9
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
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
