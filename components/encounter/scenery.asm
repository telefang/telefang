SECTION "Encounter Scenery Loader", ROM0[$1B9C]
Encounter_LoadSceneryTiles::
    ld d, a
    ld a, $76
    rst $10
    
    ld e, 0
    sla e
    rl d
    ld hl, $4000
    add hl, de
    ld de, $90E0
    ld bc, $200
    
    jp LCDC_LoadGraphicIntoVRAM