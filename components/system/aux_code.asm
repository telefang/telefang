SECTION "Patch Utilities - Auxiliary Code Trampolines", ROMX[$4000], BANK[$1]
Banked_PatchUtils_StoreDefaultCharaName:
	call PatchUtils_StoreDefaultCharaName
	ret
	
Banked_PatchUtils_InitializeRelocatedCharaName:
	call PatchUtils_InitializeRelocatedCharaName
	ret

SECTION "Patch Utilities - Auxiliary Code", ROMX[$4100], BANK[$1]
PatchUtils_StoreDefaultCharaName:
	ld a, "S"
	ld [$C3A9], a
	ld a, "h"
	ld [$C3AA], a
	ld a, "i"
	ld [$C3AB], a
	ld a, "g"
	ld [$C3AC], a
	ld a, "e"
	ld [$C3AD], a
	ld a, "k"
	ld [$C3AE], a
	ld a, "i"
	ld [$C3AF], a
	ret

PatchUtils_InitializeRelocatedCharaName:
	ld hl, $C3A9
	ld de, $CC90
	ld b, $11
	
.eraseLoop
	ld a, $E0
	ld [de], a
	inc de
	dec b
	jr nz, .eraseLoop
	
	ld b, 9
.secondEraseLoop
	xor a
	ld [hli], a
	dec b
	jr nz, .secondEraseLoop
	ret
   
PatchUtils_InitializeRelocatedCharaName_END::