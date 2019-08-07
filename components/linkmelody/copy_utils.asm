SECTION "Link Melody Copy From SRAM", ROMX[$77A7], BANK[$1F]
LinkMelody_ReadSelectedRingtone::
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, 1
	ld [SerIO_GameStateMachine], a
	ld hl, S_SaveClock_StatisticsArray
	ld bc, $200
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .skipMathLoop

.mathLoop
	add hl, bc
	dec a
	jr nz, .mathLoop

.skipMathLoop
	ld de, W_PauseMenu_ContactsArray
	call memcpy
	ld a, 0
	ld [REG_MBC3_SRAMENABLE], a
	ret

SECTION "Link Melody Copy To SRAM", ROMX[$79AC], BANK[$1F]
LinkMelody_StoreReceivedRingtone::
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, 1
	ld [SerIO_GameStateMachine], a
	ld hl, S_SaveClock_StatisticsArray
	ld bc, $200
	ld a, [W_Victory_UserSelection]
	cp 0
	jr z, .skipMathLoop

.mathLoop
	add hl, bc
	dec a
	jr nz, .mathLoop

.skipMathLoop
	push hl
	pop de
	ld hl, W_PauseMenu_ContactsArray
	call memcpy
	ld a, 0
	ld [REG_MBC3_SRAMENABLE], a
	ret
