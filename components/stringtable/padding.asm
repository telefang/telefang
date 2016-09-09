SECTION "String Table Pad-to-center-string function Bankcall", ROM0[$33E3]
Banked_StringTable_PadCopyBuffer::
	ld a, [W_CurrentBank]
	push af
	ld a, BANK(StringTable_PadCopyBuffer)
	rst $10
	call StringTable_PadCopyBuffer
	pop af
	rst $10
	ret
	
SECTION "String Table Pad-to-center-string function", ROMX[$45AE], BANK[$2A]
StringTable_PadCopyBuffer::
	push hl
	push de
	ld c, 8
	ld a, 0
	
	;Fill the target buffer with spaces
.firstEraseLoop
	ld [de], a
	inc de
	dec c
	jr nz, .firstEraseLoop
	
	pop de
	ld c, 9
	
	;Now, count how many unused bytes are in the source buffer...
.sourceTrashCountLoop
	dec c
	jr z, .noMoreTrashBytes
	ld a, [hli]
	cp $E0
	jr nz, .sourceTrashCountLoop
	
	;Now half (round down) the count of trash bytes
	srl c
	ld a, c
	or a
	jr z, .noMoreTrashBytes
	
	ld a, 0
	
	;Add spaces to match the trash bytes at the end
.firstAddSpacesLoop
	ld [de], a
	inc de
	dec c
	jr nz, .firstAddSpacesLoop
	
.noMoreTrashBytes
	pop hl
	ld c, 8
	
	;Actually copy our string.
	;We should note that we already check for terminators here anyway, so there's
	;no reason to clear trash bytes
.actualCopyLoop
	ld a, [hli]
	ld [de], a
	dec c
	ret z
	inc de
	cp $E0
	jr nz, .actualCopyLoop
	
	ld a, 0
	
	;Add spaces at the other end to balance this all out
.lastAddSpacesLoop
	ld [de], a
	inc de
	dec c
	jr nz, .lastAddSpacesLoop
	ret