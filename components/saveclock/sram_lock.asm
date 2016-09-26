INCLUDE "registers.inc"

SECTION "Save/Clock Services Safety Switch", ROM0[$3D6A]
SaveClock_EnterSRAM2::
	push af
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, 2
	ld [REG_MBC3_SRAMBANK], a
	pop af
	ret
	
SaveClock_ExitSRAM::
	push af
	ld a, 0
	ld [REG_MBC3_SRAMENABLE], a
	pop af
	ret

