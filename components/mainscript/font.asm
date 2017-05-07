INCLUDE "components/mainscript/font.inc"

SECTION "Main Script Font", ROMX[$5228], BANK[$B]
;This is probably an image injection mistake, but include it anyway.
;TODO: What happens if we remove this byte?
    db 0
MainScript_Font::
    INCBIN "gfx/font.1bpp", 0, NUM_CHARACTERS * 8