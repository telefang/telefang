DEF M_LCDC_CGBMathArenaSize EQU 3
DEF M_LCDC_CGBColorSize EQU 2
DEF M_LCDC_CGBColorCount EQU 4
DEF M_LCDC_CGBPaletteCount EQU 8

DEF M_LCDC_CGBStagingAreaStride EQU M_LCDC_CGBColorSize * M_LCDC_CGBColorCount
DEF M_LCDC_CGBStagingAreaSize EQU M_LCDC_CGBStagingAreaStride * M_LCDC_CGBPaletteCount

DEF M_LCDC_CGBScratchAreaStride EQU M_LCDC_CGBMathArenaSize * M_LCDC_CGBColorCount
DEF M_LCDC_CGBScratchAreaSize EQU M_LCDC_CGBScratchAreaStride * M_LCDC_CGBPaletteCount

MACRO dcolor
    dw ((\3) << 10) + ((\2) << 5) + (\1)
    ENDM
    
;CGB palette color indexes are stored as big-endian words for some reason
MACRO dpalette
    dw (\1 >> 8) | ((\1 & $FF) << 8)
    dw (\2 >> 8) | ((\2 & $FF) << 8)
    dw (\3 >> 8) | ((\3 & $FF) << 8)
    dw (\4 >> 8) | ((\4 & $FF) << 8)
    dw (\5 >> 8) | ((\5 & $FF) << 8)
    dw (\6 >> 8) | ((\6 & $FF) << 8)
    dw (\7 >> 8) | ((\7 & $FF) << 8)
    dw (\8 >> 8) | ((\8 & $FF) << 8)
    ENDM