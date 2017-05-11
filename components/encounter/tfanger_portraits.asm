SECTION "Encounter Tfanger Portraits", ROM0[$16C2]
Encounter_LoadTFangerPortrait::
    push de
    cp $12
    jp nc, .middleBank

.lowBank
    ld [W_Encounter_PortraitOffset], a
    ld a, $7E
    jp .loadGraphic
    
.middleBank
    cp $24
    jp nc, .highBank
    
    sub $12
    ld [W_Encounter_PortraitOffset], a
    ld a, $7F
    jp .loadGraphic
    
.highBank
    sub $24
    ld [W_Encounter_PortraitOffset], a
    ld a, $7D
    
.loadGraphic
    ld [W_Encounter_PortraitBank], a
    ld a, [W_Encounter_PortraitOffset]
    
    ld hl, Battle_DenjuuPortraitLookupTable
    ld d, 0
    ld e, a
    sla e
    rl d
    add hl, de
    
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    ld a, [W_Encounter_PortraitBank]
    rst $10
    pop de
    ld bc, $380
    
    jp LCDC_LoadGraphicIntoVRAM