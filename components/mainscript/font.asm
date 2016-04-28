INCLUDE "components/mainscript/font.inc"

SECTION "Main Script Font", ROMX[$5229], BANK[$B]
MainScript_Font::
    INCBIN "gfx/font.1bpp", 0, NUM_CHARACTERS * 8