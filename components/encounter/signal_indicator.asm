SECTION "Encounter Signal Indicator", ROMX[$430C], BANK[$1C]
Encounter_DrawSignalIndicator::
    cp 1
    jr z, .oneBar
    
    cp 2
    jr z, .twoBars
    
    cp 3
    jr z, .threeBars
    
    cp 4
    jr z, .fourBars
    
    ret
    
.oneBar
    ld c, $32
    jp Encounter_WriteTileToVRAM
    
.twoBars
    ld c, $33
    jp Encounter_WriteTileToVRAM
    
.threeBars
    ld c, $33
    call Encounter_WriteTileToVRAM
    
    ld a, $1F
    ld b, a
    ld a, l
    sub b
    ld l, a
    
    ld c, $34
    call Encounter_WriteTileToVRAM
    
    ld de, $20
    add hl, de
    
    ld c, $35
    jp Encounter_WriteTileToVRAM
    
.fourBars
    ld c, $33
    call Encounter_WriteTileToVRAM
    
    inc l
    ld c, $36
    call Encounter_WriteTileToVRAM
    
    dec l
    ld a, $1F
    ld b, a
    ld a, l
    sub b
    ld l, a
    
    ld c, $37
    jp Encounter_WriteTileToVRAM