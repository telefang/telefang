INCLUDE "telefang.inc"

SECTION "Status Screen Nickname Drawing 2", ROM0[$3D7F]
;TODO: Is this only for denjuu nicknames?
Status_CopyLoadedDenjuuNickname::
	ld hl, W_MainScript_MessageArg1
	ld a, 9 ;TODO: Clear entire staging area
	push hl
	
.eraseLoop
	ld [hl], 0
	inc hl
	dec a
	jr nz, .eraseLoop
	
	ld bc, M_SaveClock_DenjuuNicknameStagingSize
	pop de
	ld hl, W_SaveClock_NicknameStaging
	jp memcpy

SECTION "Status Screen Nickname Drawing", ROM0[$3E19]
Status_DrawDenjuuNickname::
	push hl
	push af
	call SaveClock_EnterSRAM2
	pop af
	ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuNickname
   call Battle_IndexStatisticsArray
   push hl
   pop de
   call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
   call SaveClock_EnterSRAM2
   call Status_CopyLoadedDenjuuNickname
   call SaveClock_ExitSRAM
   nop
   nop
   nop
   nop
   nop
   nop
   ld bc, W_MainScript_MessageArg1
   pop hl
	ld a, BANK(MainScript_ADVICE_DrawCenteredName75)
   rst $10
   call MainScript_ADVICE_DrawCenteredName75
   rst $18
   ret
   
Status_DrawDenjuuNickname_END::