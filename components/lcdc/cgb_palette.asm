INCLUDE "registers.inc"

SECTION "CGB Palette Management Vars", WRAM0[$CA61]
CGBPaletteScheduled: ds 1

SECTION "CGB Palette Management Staging", WRAM0[$CAC8]
CGBPaletteStaging: ds 1

SECTION "CGB Palette Management", ROM0[$382E]
CGBLoadObjectPalette:
    push af
    ld de, REG_OBPI
    call CGBBeginPaletteLoad
    ld de, REG_OBPD
    jr copyCGBPalette
    
CGBLoadBackgroundPalette:
    push af
    ld de, REG_BGPI
    call CGBBeginPaletteLoad
    ld de, REG_BGPD

copyCGBPalette:
    di

.vramUnlock
    ld a, [REG_STAT]
    and 2
    jr nz, .vramUnlock
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ei
    pop af
    inc a
    ret
    
CGBBeginPaletteLoad:
    sla a
    sla a
    sla a
    or $80
    ld [de], a
    ret

CGBLoadScheduledPalette::
    ld a, [CGBPaletteScheduled]
    or a
    ret z
    ld b, a
    xor a
    ld [CGBPaletteScheduled], a
    ld hl, CGBPaletteStaging
    ld a, b
    dec a
    cp 8
    jr c, CGBLoadBackgroundPalette
    sub 8
    jr CGBLoadObjectPalette