INCLUDE "telefang.inc"

;because macros
IMPORT ScriptWindow
IMPORT ScriptWindow_END

SECTION "Main Script Load Window Tiles", ROMX[$5001], BANK[$B]
MainScript_LoadWindowTiles::
	ld a, BANK(ScriptWindow)
	ld hl, $8C00
	ld de, ScriptWindow
	ld bc, ScriptWindow_END - ScriptWindow
	jp Banked_LCDC_LoadTiles