INCLUDE "telefang.inc"

SECTION "Link Victory Advice Code", ROMX[$79D5], BANK[$1F]
LinkVictory_ADVICE_SubStateDrawDefectionScreen::
	ld a, M_SaveClock_DenjuuStatSize
	
.eraseLoop
	ld [hl], 0
	inc hl
	dec a
	jr nz, .eraseLoop
	ret
