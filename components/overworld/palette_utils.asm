INCLUDE "telefang.inc"

SECTION "Overworld Palette Loader", ROMX[$6466], BANK[$B]
Overworld_PaletteLoader::
    ld hl, Overworld_PaletteIdentificationTable
    ld a, [$C905]
    add l
    ld l, a
    ld a, 0
    adc h
    ld h, a
    ld a, [hl]
    ld c, a
    cp $40
    jr nz, .weAreIndoors
    ld a, [W_Overworld_CurrentTimeHours]
    add $50
    ld c, a

.weAreIndoors
    ld a, BANK(Overworld_PaletteLoader)
    ld [W_PreviousBank], a
    ld b, 0
    call Banked_CGBLoadBackgroundPalette
    jp Overworld_ADVICE_PaletteLoader

Overworld_WindowFlavourPaletteLoader::
    ld b, 7
    push bc
    ld a, [W_PauseMenu_WindowFlavor]
    ld c, a
    ld b, 0
    ld hl, $328
    add hl, bc
    ld b, h
    ld c, l
    pop af
    jp CGBLoadBackgroundPaletteBanked

Overworld_PaletteIdentificationTable::
    db $40, $40, $40, $43
    db $40, $42, $47, $44
    db $45, $46, $48, $48
    db $49, $4A, $4B, $45
    db $43, $4D, $4E, $4F
