;One-off graphics not mentioned in the compressed graphics metatable over
;in the other graphics file.

SECTION "gfx/diploma.2bpp", ROMX[$44eb], BANK[$3f]
DiplomaGfx:
	INCBIN "gfx/diploma.2bpp"
	
SECTION "gfx/menu/script_window.2bpp", ROMX[$719C], BANK[$38]
ScriptWindow::
	INCBIN "gfx/menu/script_window.2bpp"
ScriptWindow_END::

SECTION "gfx/menu/battle_contact_select.2bpp", ROMX[$5A00], BANK[$42]
BattleContactSelect::
	INCBIN "gfx/menu/battle_contact_select.2bpp"
BattleContactSelect_END::
	REPT $83
	db 0
	ENDR
	
	;TODO: Remove these trashbytes
	db 1, 0, 7, 0, $E, $F, $10, $10, $2F, $20, $1F, $46, $39