INCLUDE "telefang.inc"

SECTION "Single/Plural Character Tables", ROMX[$74F0], BANK[$1]
; Temporary tables for now.
Battle_SingularCharacterTable::
	db $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
	
Battle_PluralCharacterTable::
	db "s", "e", $E0, $E0, $E0, $E0, $E0, $E0
	
SECTION "Battle Single/Plural Check", ROMX[$74A0], BANK[$1]
Battle_ADVICE_ParsePluralState::
	M_AdviceSetup
	push bc
	push hl
	ld b, 8
	ld de, W_Map_LocationStaging
	ld a, h
	cp 0
	jr nz, .isPlural
	ld a, l
	cp 1
	jr nz, .isPlural
	push de
	pop hl
	ld de, Battle_SingularCharacterTable
	jr .loadTableLoop
	
.isPlural
	push de
	pop hl
	ld de, Battle_PluralCharacterTable
	
.loadTableLoop
	ld a, [de]
	ld [hli], a
	ld a, $E0
	ld [hli], a
	inc de
	dec b
	jr nz, .loadTableLoop
	pop hl
	pop bc
	ld de, W_Battle_MessageNumbers_StagingLoc
	ld b, 0
	M_AdviceTeardown
	ret
