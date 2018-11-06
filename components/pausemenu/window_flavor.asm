INCLUDE "telefang.inc"

SECTION "Pause Menu Window Flavor WRAM", WRAM0[$CDB3]
W_PauseMenu_WindowFlavor:: ds 1

SECTION "Pause Menu Window Flavor Palette", ROM0[$3EB9]
; Windows in the pause menu, status screen, and other places can be colored
; based on user preference. We call this "window flavor" in honor of Itoi.
PauseMenu_CGBStageFlavorPalette::
    ld hl, W_LCDC_CGBStagingBGPaletteArea
    ld b, 0
    ld c, a
    add hl, bc
    ld a, [W_PauseMenu_WindowFlavor]
    cp M_PauseMenu_WindowFlavorMint
    jr z, .mintFlavoredWindows
    cp M_PauseMenu_WindowFlavorStrawberry
    jr z, .strawberryFlavoredWindows
    cp M_PauseMenu_WindowFlavorMango
    jr z, .mangoFlavoredWindows
    
; Plain flavor
    ld a, $FF
    ld [hli], a
    ld a, 3
    ld [hl], a
    jr .return
    
.mintFlavoredWindows
    ld a, 0
    ld [hli], a
    ld a, $7F
    ld [hl], a
    jr .return
    
.strawberryFlavoredWindows
    ld a, $1F
    ld [hli], a
    ld a, $7E
    ld [hl], a
    jr .return
    
.mangoFlavoredWindows
    ld a, $E6
    ld [hli], a
    ld a, $1B
    ld [hl], a

.return
    ret