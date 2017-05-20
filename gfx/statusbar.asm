INCLUDE "telefang.inc"

SECTION "Overworld Status Bar UI", ROMX[$4418], BANK[$38]
	INCBIN "gfx/statusbar/left_space.2bpp"
	INCBIN "gfx/statusbar/right_space.2bpp"
	INCBIN "gfx/statusbar/no_signal.2bpp"
	INCBIN "gfx/statusbar/signal_1.2bpp"
	INCBIN "gfx/statusbar/signal_2.2bpp"
	INCBIN "gfx/statusbar/signal_3.2bpp"
	INCBIN "gfx/statusbar/signal_4.2bpp"
	INCBIN "gfx/statusbar/startselect.2bpp"
	INCBIN "gfx/statusbar/blank_indicator.2bpp"
	INCBIN "gfx/statusbar/call_indicator.2bpp"
	INCBIN "gfx/statusbar/mail_indicator.2bpp"
	INCBIN "gfx/statusbar/blank_signal.2bpp"
	INCBIN "gfx/statusbar/silenced_call_signal.2bpp"
	INCBIN "gfx/statusbar/startselect_disabled.2bpp"
	INCBIN "gfx/statusbar/unk1.2bpp"
	INCBIN "gfx/statusbar/intro_statusbar.2bpp"

;TODO: Remove this trashbyte.
;Someone changed one pixel on a T-Fanger graphic
SECTION "Trash Bytes Endless", ROMX[$4E36], BANK[$7E]
	db $FE
