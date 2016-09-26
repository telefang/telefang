SECTION "System multiplication bits", ROM0[$2B44]

;Multiply BC * DE, result is returned in DE.
System_Multiply16::
	ld hl, 0
	ld a, $F
	
.bitCountLoop
	sla e
	rl d
	jr nc, .noBit
	add hl, bc
	
.noBit
	add hl, hl
	dec a
	jr nz, .bitCountLoop
	bit 7, d
	jr z, .stillNoBit
	add hl, bc
	
.stillNoBit
	ld d, h
	ld e, l
	ret
	
;Multiply C * E, result is returned in DE.
System_Multiply8::
	ld b, 0
	ld d, 0
	jp System_Multiply16