SECTION "Phone keypad graphics", ROMX[$4000], BANK[$79]
PhoneKeypadGfx:
	INCBIN "gfx/phones/0/numbers.2bpp"
	INCBIN "gfx/phones/0/menus.2bpp"
	INCBIN "gfx/phones/0/letters1.2bpp"
	INCBIN "gfx/phones/0/menus.2bpp"
	INCBIN "gfx/phones/0/letters2.2bpp"
	INCBIN "gfx/phones/0/menus.2bpp"
	INCBIN "gfx/phones/0/solfege.2bpp"
	INCBIN "gfx/phones/0/menus.2bpp"
	
	INCBIN "gfx/phones/1/numbers.2bpp"
	INCBIN "gfx/phones/1/menus.2bpp"
	INCBIN "gfx/phones/1/letters1.2bpp"
	INCBIN "gfx/phones/1/menus.2bpp"
	INCBIN "gfx/phones/1/letters2.2bpp"
	INCBIN "gfx/phones/1/menus.2bpp"
	INCBIN "gfx/phones/1/solfege.2bpp"
	INCBIN "gfx/phones/1/menus.2bpp"
	
	INCBIN "gfx/phones/2/numbers.2bpp"
	INCBIN "gfx/phones/2/menus.2bpp"
	INCBIN "gfx/phones/2/letters1.2bpp"
	INCBIN "gfx/phones/2/menus.2bpp"
	INCBIN "gfx/phones/2/letters2.2bpp"
	INCBIN "gfx/phones/2/menus.2bpp"
	INCBIN "gfx/phones/2/solfege.2bpp"
	INCBIN "gfx/phones/2/menus.2bpp"

; rest of bank is blank

SECTION "Phone button graphics", ROMX[$4000], BANK[$7a]
PhoneButtonGfx:
rept 3
	INCBIN "gfx/phones/0/buttons.2bpp"
	INCBIN "gfx/phones/1/buttons.2bpp"
	INCBIN "gfx/phones/2/buttons.2bpp"
endr

; rest of bank is blank

SECTION "Phone keypad graphics DMG", ROMX[$4000], BANK[$7b]
PhoneKeypadGfxDmg:
	INCBIN "gfx/phones/0/numbers.2bpp"
	INCBIN "gfx/phones/0/menus_dmg.2bpp"
	INCBIN "gfx/phones/0/letters1.2bpp"
	INCBIN "gfx/phones/0/menus_dmg.2bpp"
	INCBIN "gfx/phones/0/letters2.2bpp"
	INCBIN "gfx/phones/0/menus_dmg.2bpp"
	INCBIN "gfx/phones/0/solfege.2bpp"
	INCBIN "gfx/phones/0/menus_dmg.2bpp"
	
	; one tile row has some extra shading against the cgb version
	; natsume probably messed up there
	INCBIN "gfx/phones/1/numbers_dmg.2bpp"
	
	INCBIN "gfx/phones/1/menus_dmg.2bpp"
	INCBIN "gfx/phones/1/letters1.2bpp"
	INCBIN "gfx/phones/1/menus_dmg.2bpp"
	INCBIN "gfx/phones/1/letters2.2bpp"
	INCBIN "gfx/phones/1/menus_dmg.2bpp"
	INCBIN "gfx/phones/1/solfege.2bpp"
	INCBIN "gfx/phones/1/menus_dmg.2bpp"
	
	; one single tile has some extra shading against the cgb version
	; natsume probably messed up again
	INCBIN "gfx/phones/1/numbers_dmg.2bpp"
	INCBIN "gfx/phones/2/menus_dmg.2bpp"
	INCBIN "gfx/phones/2/letters1.2bpp"
	INCBIN "gfx/phones/2/menus_dmg.2bpp"
	INCBIN "gfx/phones/2/letters2.2bpp"
	INCBIN "gfx/phones/2/menus_dmg.2bpp"
	INCBIN "gfx/phones/2/solfege.2bpp"
	INCBIN "gfx/phones/2/menus_dmg.2bpp"
	
; rest of bank is blank

SECTION "Phone Screen Graphics", ROMX[$6A5F], BANK[$37]
PhoneScreenNewTextsGfx
	INCBIN "gfx/phones/new_texts.2bpp"