SECTION "Tilemap Maths", ROM0[$EB3]
TMAPWrapToLine::
	push af
	push bc
	push de
	call TMAPWrapToTilemap
	ld d, h
	ld e, l
	ld bc, $6800
	or a
	jr z, .isTmap1
	ld bc, $6400
	
.isTmap1
	add hl, bc
	srl l
	jr c, .addressNotAtStartOfRow
	srl l
	jr c, .addressNotAtStartOfRow
	srl l
	jr c, .addressNotAtStartOfRow
	srl l
	jr c, .addressNotAtStartOfRow
	srl l
	jr c, .addressNotAtStartOfRow
	jr .backupLineAndExit
	
.addressNotAtStartOfRow
	ld h, d
	ld l, e
	pop de
	pop bc
	pop af
	ret
	
.backupLineAndExit
	ld h, d
	ld l, e
	ld bc, $FFE0
	add hl, bc
	call TMAPWrapToTilemap
	pop de
	pop bc
	pop af
	ret

;Used if we moved back one tile instead of forwards.
TMAPWrapToLine_Backwards::
	push af
	push bc
	push de
	call TMAPWrapToTilemap
	ld d, h
	ld e, l
	ld bc, $6800
	or a
	jr z, .isTmap1
	ld bc, $6400
	
.isTmap1
	add hl, bc
	srl l
	jr nc, .addressNotAtEndOfRow
	srl l
	jr nc, .addressNotAtEndOfRow
	srl l
	jr nc, .addressNotAtEndOfRow
	srl l
	jr nc, .addressNotAtEndOfRow
	srl l
	jr nc, .addressNotAtEndOfRow
	jr .forwardLineAndExit
	
.addressNotAtEndOfRow
	ld h, d
	ld l, e
	pop de
	pop bc
	pop af
	ret
	
.forwardLineAndExit
	ld h, d
	ld l, e
	ld bc, $20
	add hl, bc
	call TMAPWrapToTilemap
	pop de
	pop bc
	pop af
	ret
	
;Wrap HL within the tilemap specified in A.
TMAPWrapToTilemap::
	push af
	or a
	jr nz, .isTmap2
	ld a, h
	and 3
	ld h, $98
	or h
	ld h, a
	pop af
	ret
	
.isTmap2
	ld a, h
	and $F
	ld h, $9C
	or h
	ld h, a
	pop af
	ret