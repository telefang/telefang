INCLUDE "macros.asm"

SECTION "vblank interrupt", ROM0[$40]
    jp VBlankingIRQ

SECTION "lcd interrupt", ROM0[$48]
    jp LCDCIRQ

SECTION "timer interrupt", ROM0[$50]
    reti

SECTION "serial interrupt", ROM0[$58]
    jp $1cb4

SECTION "joypad interrupt", ROM0[$60]
    reti

SECTION "bank 1", ROMX[$4000], BANK[$1]
    ds $4000 ; bank 1 is empty

SECTION "RomHeader", ROM0[$0100]
__start: nop
    jp Main

SECTION "gfx/diploma.2bpp", ROMX[$44eb], BANK[$3f]
DiplomaGfx:
	INCBIN "gfx/diploma.2bpp"

SECTION "gfx/denjuu_stages.2bpp", ROMX[$5180], BANK[$7d]
DenjuuStageGfx:
	INCBIN "gfx/denjuu_stages.2bpp"

SECTION "Phone keypad graphics", ROMX[$4000], BANK[$79]
; XXX no rgbdep yet...
;phone_keypad_gfx: MACRO
;	INCBIN "gfx/phones/\1/numbers.2bpp"
;	INCBIN "gfx/phones/\1/menus.2bpp"
;	INCBIN "gfx/phones/\1/letters1.2bpp"
;	INCBIN "gfx/phones/\1/menus.2bpp"
;	INCBIN "gfx/phones/\1/letters2.2bpp"
;	INCBIN "gfx/phones/\1/menus.2bpp"
;	INCBIN "gfx/phones/\1/solfege.2bpp"
;	INCBIN "gfx/phones/\1/menus.2bpp"
;ENDM


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
