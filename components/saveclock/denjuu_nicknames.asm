INCLUDE "telefang.inc"

SECTION "Save/Clock Nickname Staging Area Extended", WRAM0[$CCA3]
W_SaveClock_NicknameStaging:: ds M_SaveClock_DenjuuNicknameStagingSize

SECTION "Save/Clock Load Denjuu Nickname", ROMX[$4E12], BANK[$29]
SaveClock_LoadDenjuuNickname::
	ld a, BANK(SaveClock_ADVICE_LoadDenjuuNickname)
	call Banked_SaveClock_ADVICE_LoadDenjuuNickname
	ret

SECTION "Save/Clock ADVICE'd Load Denjuu Nickname", ROMX[$7EAD], BANK[$34]
SaveClock_ADVICE_LoadDenjuuNickname::
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
   push hl
	ld de, S_SaveClock_NicknameArray
	add hl, de
	
	;Manual SRAM unlock
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, BANK(S_SaveClock_NicknameArray)
	ld [REG_MBC3_SRAMBANK], a
	
	ld a, [hl]
	cp $E6
	jp nz, .hasCustomNickname
	
	;Since nicknames were not widened, species names can exceed nickname
	;length. Therefore they have to be loaded differently
	pop hl
	push bc
	pop hl
	sla l
	rl h
	sla l
	rl h
	push hl
	ld a, $A0
	add a, h
	ld h, a
	call Battle_ADVICE_GetDenjuuSpeciesFromStatistics
	call PatchUtils_LimitBreak
	call PatchUtils_LimitBreak
	ld hl, $4000
	add hl, de
	ld de, W_SaveClock_NicknameStaging
	ld c, M_SaveClock_DenjuuNicknameStagingSize - 1
	jr .stageLoop
	
.hasCustomNickname
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
	
	pop af
	ld a, BANK(SaveClock_LoadDenjuuNickname)
	
	ret