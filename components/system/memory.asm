;Utilities that seem to be ASM analogs of common C Runtime mem* functions.

;Project won't link unless I declare it in a banked WRAM section
SECTION "System_Memory Stack", WRAMX[$DF00], BANK[1]
W_Stack:: ds $FF

SECTION "System_Memory", ROM0[$159F]
;Clear memory (set it to $00).
;HL is the target and BC is the size/count.
memclr::
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, memclr
	ret

;Like memclr, but with $FF instead of $00
;HL is the target and BC is the size/count.
memset_ff::
	ld a, $FF
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, memset_ff
	ret

;Calculate the index of an array (SIZE * INDEX).
;D is the index, HL the size. Returns HL as offset address.
memoffset::
	ld a, d
	or a
	jr z, .mulZero
	dec d
	ret z
	ld b, h
	ld c, l
	
.mulLoop
	add hl, bc
	dec d
	jr nz, .mulLoop
	ret
	
.mulZero
	ld hl, 0
	ret

;Copy bc bytes from [hl] to [de].
memcpy::
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, memcpy
	ret