INCLUDE "telefang.inc"

SECTION "Temporary Article String Table", ROMX[$5B00], BANK[$1C]
Encounter_ADVICE_ArticleTable::
; Temporary setup to be later replaced with a spreadsheet fed table.
	dw .a, .a, .an, .a, .a, .a, .a, .a     ; 07
	dw .a, .a, .a, .a, .a, .a, .a, .an     ; 0F
	dw .a, .a, .a, .a, .an, .a, .a, .a     ; 17
	dw .a, .an, .a, .a, .a, .a, .a, .a     ; 1F
	dw .a, .a, .an, .a, .a, .a, .a, .a     ; 27
	dw .a, .a, .a, .a, .a, .a, .a, .a      ; 2F
	dw .a, .a, .a, .a, .a, .a, .a, .a      ; 37
	dw .a, .an, .a, .a, .a, .a, .a, .a     ; 3F
	dw .a, .a, .a, .a, .a, .an, .a, .a     ; 47
	dw .a, .a, .an, .an, .a, .a, .a, .a    ; 4F
	dw .an, .a, .a, .a, .a, .a, .a, .a     ; 57
	dw .an, .an, .a, .a, .a, .a, .a, .an   ; 5F
	dw .a, .a, .a, .a, .a, .a, .a, .a      ; 67
	dw .a, .a, .a, .a, .a, .an, .an, .a    ; 6F
	dw .a, .a, .a, .a, .an, .an, .an, .a   ; 77
	dw .a, .a, .a, .a, .a, .a, .a, .an     ; 7F
	dw .a, .a, .a, .a, .an, .a, .a, .an    ; 87
	dw .a, .a, .a, .a, .an, .a, .a, .a     ; 8F
	dw .a, .a, .a, .a, .a, .a, .an, .a     ; 97
	dw .a, .a, .a, .a, .a, .a, .a, .a      ; 9F
	dw .an, .a, .a, .an, .a, .a, .an, .a   ; A7
	dw .a, .an, .a, .a, .a, .a, .nil, .nil ; AF
	
.a
	db "A "
	db $E0
	
.an
	db "An "
	db $E0
	
.nil
	db $E0

; To replace "call StringTable_LoadName75" at 1C:4666

SECTION "Encounter Screen Article Table Advice", ROMX[$5AB0], BANK[$1C]
Encounter_ADVICE_OpponentNameAndArticleLoader::
	call StringTable_LoadName75
	push af
	push bc
	push de
	push hl
	ld a, [W_StringTable_ROMTblIndex]
	ld e, a
	ld d, 0
	sla e
	rl d
	ld hl, Encounter_ADVICE_ArticleTable
	add hl, de
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	push bc
	pop hl
	ld de, W_Map_LocationStaging
	ld b, $10
	
.copyLoop
	ld a, [hli]
	cp $E0
	jr z, .abandonLoop
	ld [de], a
	inc de
	dec b
	jr nz, .copyLoop
	
.abandonLoop

	ld a, $E0
	ld [de], a
	pop hl
	pop de
	pop bc
	pop af
	ret