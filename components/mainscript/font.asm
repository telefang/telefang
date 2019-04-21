INCLUDE "components/mainscript/font.inc"

SECTION "Main Script Font", ROMX[$5228], BANK[$B]
;This is probably an image injection mistake, but include it anyway.
;TODO: What happens if we remove this byte?
    db 0
MainScript_Font::
    INCBIN "build/gfx/font.1bpp", 0, NUM_CHARACTERS * 8
	
SECTION "Main Script Extra Fonts", ROMX[$5000], BANK[$62]
MainScript_NarrowFont::
    INCBIN "build/gfx/narrow_font.1bpp", 0, NUM_CHARACTERS * 8

MainScript_BoldFont::
; The bold font excludes system characters (characters B8 to D2) to save space.
    INCBIN "build/gfx/bold_font.1bpp", 0, NUM_NON_SYSTEM_CHARACTERS * 8

MainScript_EntryFont::
; The entry font excludes system characters (characters B8 to D2) to save space.
    INCBIN "build/gfx/entry_font.1bpp", 0, NUM_NON_SYSTEM_CHARACTERS * 8
