SECTION "ENDLESS TRASH", ROMX[$7FF0], BANK[$4]
;Trash bytes I found at the end of the ROM.
;Not sure why they're here.
ld [$C3AD], a
ld a, 'k'
ld [$C3AE], a
ld a, 'i'
ld [$C3AF], a
ret