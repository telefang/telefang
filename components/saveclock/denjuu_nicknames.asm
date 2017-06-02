INCLUDE "telefang.inc"

SECTION "Save/Clock Nickname Staging Area Extended", WRAM0[$CCA3]
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
	jr SaveClock_LoadDenjuuNicknameByStatPtr_indexNicknameArray
	
SaveClock_LoadDenjuuNicknameByStatPtr::
	ld a, BANK(SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr)
	call Banked_SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr
	ret
   
SaveClock_ADVICE_FDRollover::
   cp $65
   jp c, SaveClock_IncrementFD_storeFd
   ld a, $64
   jp SaveClock_IncrementFD_storeFd
   
   nop
   nop
   nop
   
SaveClock_LoadDenjuuNicknameByStatPtr_indexNicknameArray::
	ld a, BANK(SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr)
	call Banked_SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr_indexNicknameArrayFixed
	ret
   
   REPT $1C
   nop
   ENDR

SECTION "Save/Clock ADVICE'd Load Denjuu Nickname", ROMX[$7C00], BANK[$34]
SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr::
	ld hl, -(S_SaveClock_StatisticsArray + M_SaveClock_DenjuuNickname) & $FFFF
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
	
SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr_indexNicknameArray::
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
	ld a, BANK(SaveClock_LoadDenjuuNicknameByStatPtr)
	
	ret
   
SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr_indexNicknameArrayFixed::
    push bc
    push af
    push hl
    ld bc, $0000
    ld a, $00
    cp l
    jp nz, .divideBySix
    cp h
    jp z, .divideBySixPostLoop

.divideBySix
    inc bc
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    cp l
    jp nz, .divideBySix
    cp h
    jp nz, .divideBySix

.divideBySixPostLoop
    sla c
    rl b
    sla c
    rl b
    pop hl
    pop af
    call SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr_indexNicknameArray
    pop bc
    ret