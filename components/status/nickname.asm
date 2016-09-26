INCLUDE "telefang.inc"

M_Status_StringStaging_Size EQU $11

SECTION "Status String Staging Area", WRAMX[$D6A0], BANK[1]
;Also used by a lot of battle messages
W_Status_StringStaging:: ds M_Status_StringStaging_Size

SECTION "Status Screen Nickname Drawing 2", ROM0[$3D7F]
;TODO: Is this only for denjuu nicknames?
Status_CopyLoadedDenjuuNickname::
	ld hl, W_Status_StringStaging
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
	ld hl, SaveClock_StatisticsArray
   call Battle_IndexStatisticsArray
   push hl
   pop de
   call Banked_SaveClock_LoadDenjuuNickname
   call SaveClock_EnterSRAM2
   call Status_CopyLoadedDenjuuNickname
   call SaveClock_ExitSRAM
   ld hl, W_Status_StringStaging
   ld de, W_MainScript_CenteredNameBuffer
   call Banked_StringTable_ADVICE_PadCopyBuffer
   ld de, W_MainScript_CenteredNameBuffer
   ld b, M_StringTable_Load8AreaSize
   pop hl
   jp Banked_MainScript_DrawStatusText