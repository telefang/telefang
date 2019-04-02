INCLUDE "telefang.inc"

SECTION "Battle Misc Draw Utils 1", ROMX[$43F9], BANK[$5]
Battle_ExpandNumericalTiles::
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    jp Status_ExpandNumericalTiles
