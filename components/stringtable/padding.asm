SECTION "String Table Weird Paranoid Padding Nonsense Bankcalls", ROM0[$33E3]
Banked_StringTable_PadCopyBuffer::
	ld a, [W_CurrentBank]
	push af
	ld a, BANK(StringTable_PadCopyBuffer)
	rst $10
	call StringTable_PadCopyBuffer
	pop af
	rst $10
	ret
	
SECTION "String Table Weird Paranoid Padding Nonsense", ROMX[$45AE], BANK[$2A]
StringTable_PadCopyBuffer::
	push hl
	push de
	ld c, 8
	ld a, 0
	
	;Clear the target buffer a first time. Fair enough...
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
	
	;Now, clear the same loop we already cleared again for no reason
.secondEraseLoop
	ld [de], a
	inc de
	dec c
	jr nz, .secondEraseLoop
	
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
	
	;Now we're clearing the target buffer for like the third time wtf
	;Except we're just clearing the trash bytes now
.thirdEraseLoop
	ld [de], a
	inc de
	dec c
	jr nz, .thirdEraseLoop
	ret