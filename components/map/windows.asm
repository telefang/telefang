INCLUDE "telefang.inc"

SECTION "Map Location Window", ROMX[$47B9], BANK[$B]
Map_StateDrawScreen::
	ld a, $D0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $F0
	ld [W_Status_NumericalTileIndex], a
	call MainScript_QueueCustomWindowMessage
	ld a, 7
	ld [$CA65], a
	jp MainScript_MapLocationWindow
