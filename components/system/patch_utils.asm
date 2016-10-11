SECTION "Patch Utilities", ROM0[$0063]
PatchUtils_ResetVector: jp PatchUtils_ResetGame
	db "Denjuu" ;not sure what this is
	ld [$FF00], a
PatchUtils_LimitBreak:: sla e
	rl d
	sla e
	rl d
	ret
	
SECTION "Patch Utilities 2", ROM0[$0096]
;MYSTERY CODE WOO
;TODO: Disassemble
PatchUtils_MysteryBlock:
	ld a, $78
	rst $10
	call $6FD0
	rst $18
	ret
	
PatchUtils_LoadDenjuuName_Bankswitch::
	ld a, h
	cp $40
	jr nz, .aboveHL
	ld a, l
	or a
	jr nz, .aboveHL
	ld a, $34
	rst $10
	ret
	
.aboveHL
	ld a, $75 ;Original Denjuu bank
	rst $10
	ret
	
;YAY NOP SLIDE
	db 0,0,0,0
	db 0,0,0,0
	db 0,0,0,0
	db 0,0,0,0
	
;BF
	rst $10
	call $7EC0
	rst $10
	ret
	
;C5
	rst $10
	call $7DCB
	rst $18
	ret
	
;CB
	rst $10
	call $7E45
	rst $18
	ret
	
;D1
Banked_SaveClock_ADVICE_LoadDenjuuNickname::
	rst $10
	call SaveClock_ADVICE_LoadDenjuuNickname
	rst $10
	ret

;D7
Banked_StringTable_ADVICE_PadCopyBuffer::
	ld a, [W_CurrentBank]
	push af
	ld a, BANK(StringTable_ADVICE_PadCopyBuffer)
	rst $10
	call StringTable_ADVICE_PadCopyBuffer
	pop af
	rst $10
	ret
	
;E4
MainScript_ADVICE_DrawDenjuuName::
	push af
	push hl
	cp h
	jr z, .mystery2
	call $548
	jr .mystery3
	
.mystery2 ;EE
	call .mystery4

.mystery3 ;F1
	pop af
	pop hl
	ret

.mystery4 ;F4
	ld a, $34
	rst $10
	call $7F10
	rst $18
	ret
	
PatchUtils_ResetGame: nop
	nop
	nop
	nop ;Further execution hits the main vector of the rom header

SECTION "PatchUtils Auxiliary Code", ROM0[$3FF1]
PatchUtils_AuxCodeJmp:
	push af
	ld a, 1
	rst $10
	pop af
	ld hl, .returnVec
	push hl
	ld l, a
	ld h, $40
	jp [hl]

.returnVec
	rst $18
	ret