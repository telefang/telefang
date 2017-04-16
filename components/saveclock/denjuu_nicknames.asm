INCLUDE "registers.inc"
INCLUDE "components/saveclock/save_format.inc"

SECTION "Save/Clock Nickname Staging Area", WRAM0[$C9E1]
W_SaveClock_NicknameStaging:: ds M_SaveClock_DenjuuNicknameStagingSize

SECTION "Save/Clock Load Denjuu Nickname", ROMX[$4E02], BANK[$29]
;Alternate LoadDenjuuNickname head.
SaveClock_LoadDenjuuNicknameByIndex::
	ld h, 0
	ld l, c
	sla l
	rl h
	
	ld b, h
	ld c, l
	sla l
	rl h
	
	add hl, bc
	jr SaveClock_LoadDenjuuNicknameByStatPtr.indexNicknameArray
	
SaveClock_LoadDenjuuNicknameByStatPtr::
	ld hl, -S_SaveClock_StatisticsArray & $FFFF
	add hl, de
	srl h
	rr l
	srl h
	rr l
	ld b, h
	ld c, l
	srl h
	rr l
	add hl, bc ;HL = the original denjuu index * 6
   
.indexNicknameArray
	ld de, S_SaveClock_NicknameArray
	add hl, de
	
	;Manual SRAM unlock
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, BANK(S_SaveClock_NicknameArray)
	ld [REG_MBC3_SRAMBANK], a
	
	ld de, W_SaveClock_NicknameStaging
	ld c, M_SaveClock_DenjuuNicknameSize
	
.stageLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .stageLoop
	
	;Add null terminator
	ld a, $E0
	ld [de], a
	
	;Manual SRAM lock
	ld a, 0
	ld [REG_MBC3_SRAMENABLE], a
	
	ret