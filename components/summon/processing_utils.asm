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
	ld de, $A000 + (M_SaveClock_DenjuuStatSize * M_SaveClock_MaxDenjuuContacts) + M_SaveClock_DenjuuLevel
	ld c, M_SaveClock_DenjuuStatSize
	call SaveClock_EnterSRAM2

.loop
	ld a, [W_PauseMenu_DeletedContact]
	cp b
	jr z, .skipContact

	ld a, [de]
	or a
	jr z, .skipContact

	ld [W_Status_SelectedDenjuuLevel], a
	push hl
	push bc
	push de
	ld a, e
	add 7
	ld e, a
	ld a, [de]
	ld b, a
	ld a, [$D5A8]
	call $05E3
	pop de
	pop bc
	pop hl
	ld a, [$D4EC]
	cp 8
	jr nc, .skipContact

	push hl
	ld h, W_PhoneIME_DisplayedNumber >> 8 ; This assumes that W_PhoneIME_DisplayedNumber will always be at 1:D200.
	ld a, [W_Status_NumDuplicateDenjuu]
	ld l, a
	ld a, [$D4EC]
	ld [hl], a
	ld h, $D1
	ld a, [W_Status_SelectedDenjuuLevel]
	ld [hl], a
	ld a, l
	inc a
	ld [W_Status_NumDuplicateDenjuu], a
	pop hl
	ld a, b
	ld [hli], a

.skipContact
	ld a, e
	sub c
	ld e, a
	jr nc, .noDecD
	dec d

.noDecD
	ld a, b
	or a
	jr z, .exit
	dec b
	jr .loop

.exit
	jp $3F12

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
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
