StatusText_NumLettersDrawn EQU $CB2F

SECTION "Patch Utilities", ROM0[$0063]
PatchUtils_ResetVector: jp PatchUtils_ResetGame
	db "Denjuu" ;not sure what this is
	ld [$FF00], a
PatchUtils_LimitBreak: sla e
	rl d
	sla e
	rl d
	ret
	
;Part of a function that replaces status text drawing with the VWF.
PatchUtils_VWFStatusText:
	ld bc, $10
	ld a, [W_MainScript_VWFOldTileMode]
	cp 1
	jp z, PatchUtils_VWFStatusText2.secondCompositeTile
	jp PatchUtils_VWFStatusText2.firstCompositeTile
	
.enterSecondHalf
	jp nz, PatchUtils_VWFStatusText2
	
.resetVWFAndExit
	ld a, 2
	ld [W_MainScript_VWFOldTileMode], a
	ld a, 0
	ld [W_MainScript_VWFLetterShift], a
	ret
	
.exitFromSecondHalf
	pop bc
	jr .resetVWFAndExit
	
;MYSTERY CODE WOO
;TODO: Disassemble
PatchUtils_MysteryBlock
	ld a, $78
	rst $10
	call $6FD0
	rst $18
	ret
	
PatchUtils_LoadDenjuuName_Bankswitch:
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
	rst $10
	call $7EAD
	rst $10
	ret

;D7
	ld a, [W_CurrentBank]
	push af
	ld a, $34
	rst $10
	call $7F40
	pop af
	rst $10
	ret
	
;E4
	push af
	push hl
	cp h
	jr z, .mystery2
	call $548
	jr .mystery3
	
.mystery2 ;EE
	call $F4

.mystery3 ;F1
	pop af
	pop hl
	ret

;F4
	ld a, $34
	rst $10
	call $7F10
	rst $18
	ret
	
PatchUtils_ResetGame: nop
	nop
	nop
	nop ;Further execution hits the main vector of the rom header
	
SECTION "Patch Utilities VWF Status Text", ROM0[$3A95]
PatchUtils_VWFStatusText2:
	push bc
	push de
	push hl
	ld a, [de] ;Read next letter
	cp $E0
	jp z, .exit
	pop hl
	push hl
	call $2FC7 ;VWF Draw Letter, HOME bank edition
	pop hl
	jp PatchUtils_VWFStatusText
	
.secondCompositeTile
	add hl, bc
	
.firstCompositeTile
	pop de
	inc de
	ld a, [StatusText_NumLettersDrawn]
	inc a
	ld [StatusText_NumLettersDrawn], a
	pop bc
	dec b
	jp PatchUtils_VWFStatusText.enterSecondHalf
	
.exit
	pop hl
	pop de
	jp PatchUtils_VWFStatusText.exitFromSecondHalf