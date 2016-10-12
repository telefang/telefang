;One-off graphics not mentioned in the compressed graphics metatable over
;in the other graphics file.

SECTION "gfx/diploma.2bpp", ROMX[$44e9], BANK[$3f]
DiplomaGfx:
	INCBIN "gfx/diploma.2bpp"
	
SECTION "gfx/menu/script_window.2bpp", ROMX[$719C], BANK[$38]
ScriptWindow::
	INCBIN "gfx/menu/script_window.2bpp"
ScriptWindow_END::
	
SECTION "gfx/menu/signal_levels.2bpp", ROMX[$44D8], BANK[$38]
Menu_SignalLevelsGfx::
	INCBIN "gfx/menu/signal_levels.2bpp"
Menu_SignalLevelsGfx_END::