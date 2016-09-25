INCLUDE "components/saveclock/save_format.inc"

SECTION "Battle Index Statistics Func", ROM0[$3D0E]
Battle_IndexStatisticsArray::
	push hl
	ld c, a
	ld e, M_SaveClock_DenjuuStatSize
	call System_Multiply8
	pop hl
	add hl, de
	ret