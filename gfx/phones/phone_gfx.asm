SECTION "Phone border graphics", ROMX[$5D5F], BANK[$7a]
PhoneGfx::
	INCBIN "build/gfx/phones/0/phone.2bpp"
	INCBIN "build/gfx/phones/1/phone.2bpp"
	INCBIN "build/gfx/phones/2/phone.2bpp"

SECTION "Phone model number graphics", ROMX[$6E5F], BANK[$7a]
PhoneModelNumbersGfx::
	INCBIN "build/gfx/phones/0/model_numbers.2bpp"
	INCBIN "build/gfx/phones/1/model_numbers.2bpp"
	INCBIN "build/gfx/phones/2/model_numbers.2bpp"
