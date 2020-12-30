INCLUDE "telefang.inc"

SECTION "Summon Contact Parser", ROMX[$522C], BANK[$1C]
Summon_ParseContacts::
	call $0671
	ld a, c
	ld [$D5A8], a
	xor a
	ld [W_Status_NumDuplicateDenjuu], a
	ld a, M_SaveClock_MaxDenjuuContacts
	ld b, a
	ld hl, W_PauseMenu_ContactsArray

.loop
	ld a, [W_PauseMenu_DeletedContact]
	cp b
	jr z, .skipContact

	push hl
	push bc
	call SaveClock_EnterSRAM2
	ld hl, $A001
	ld a, b
	call Battle_IndexStatisticsArray
	ld a, [hl]
	ld [W_Status_SelectedDenjuuLevel], a
	pop bc
	pop hl
	ld a, [W_Status_SelectedDenjuuLevel]
	cp 0
	jr z, .skipContact

	push hl
	push bc
	ld a, b
	ld hl, $A008
	call Battle_IndexStatisticsArray
	ld a, [hl]
	ld b, a
	ld a, [$D5A8]
	call $05E3
	ld a, [$D4EC]
	pop bc
	pop hl
	cp 8
	jr nc, .skipContact

	push hl
	ld hl, W_PhoneIME_DisplayedNumber
	ld d, 0
	ld a, [W_Status_NumDuplicateDenjuu]
	ld e, a
	add hl, de
	ld a, [$D4EC]
	ld [hl], a
	pop hl
	push hl
	ld hl, $D100
	ld d, 0
	ld a, [W_Status_NumDuplicateDenjuu]
	ld e, a
	add hl, de
	ld a, [W_Status_SelectedDenjuuLevel]
	ld [hl], a
	pop hl
	ld a, b
	ld [hli], a
	ld a, [W_Status_NumDuplicateDenjuu]
	inc a
	ld [W_Status_NumDuplicateDenjuu], a

.skipContact
	ld a, 0
	cp b
	jr z, .exit
	dec b
	jr .loop

.exit
	jp $3F12
