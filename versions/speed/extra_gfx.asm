;One-off graphics not mentioned in the compressed graphics metatable over
;in the other graphics file.

SECTION "gfx/diploma.2bpp", ROMX[$44e9], BANK[$3f]
DiplomaGfx::
	INCBIN "build/gfx/diploma.2bpp"
	
SECTION "gfx/menu/script_window.2bpp", ROMX[$719C], BANK[$38]
ScriptWindow::
	INCBIN "build/gfx/menu/script_window.2bpp"
ScriptWindow_END::

SECTION "gfx/menu/battle_contact_select.2bpp", ROMX[$5A00], BANK[$42]
BattleContactSelect::
	INCBIN "build/gfx/menu/battle_contact_select.2bpp"
BattleContactSelect_END::