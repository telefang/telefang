INCLUDE "registers.inc"

;The name of this location is a slight misnomer: It is not the last value of
;W_CurrentBank, so much as it is a place to hold a bank we want to return to.
SECTION "RST WRAM", WRAM0[$C423]
W_PreviousBank:: ds 1

SECTION "RST WRAM2", WRAM0[$C425]
W_CurrentBank:: ds 1

SECTION "rst $0", ROM0[$0]
JumpAAtHL:
	pop hl
	add a
	rst $28
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

SECTION "rst $8", ROM0[$8]
ReturnFromInterrupt:
	reti

SECTION "rst $10", ROM0[$10]
BankSwitch:
	jp BankSwitch_int

SECTION "rst $18", ROM0[$18]
RestoreBank:
	ld a, [W_PreviousBank]
	rst $10
	ret

;Call the function in bank A with address HL.
;Clobbers W_PreviousBank.
SECTION "rst $20", ROM0[$20]
CallBankedFunction:
	jp CallBankedFunction_int

SECTION "rst $28", ROM0[$28]

SECTION "rst $30", ROM0[$30]
	add a
	rst $28
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

SECTION "rst $38", ROM0[$38]
SnapHL: ; http://www.catb.org/jargon/html/S/snap.html
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ret

SECTION "rst call banked function", ROM0[$0476]
CallBankedFunction_int::
	di
	ld [W_PreviousBank], a
	ld a, [W_CurrentBank]
	push af
	ld a, [W_PreviousBank]
	ld [REG_MBC3_ROMBANK], a
	ld [W_CurrentBank], a
	ei
	call IndirectFunctionCall
	di
	pop af
	ld [REG_MBC3_ROMBANK], a
	ld [W_CurrentBank], a
	ei
	ret
	
;TODO: Is there another entrypoint?
	di
	ld [REG_MBC3_ROMBANK], a
	ld [W_CurrentBank], a
	ei

IndirectFunctionCall:
	jp hl

BankSwitch_int:
	di
	ld [REG_MBC3_ROMBANK], a
	ld [W_CurrentBank], a
	ei
	ret