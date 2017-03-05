SECTION "Status Shift Background Tiles Stuff", WRAM0[$CB80]
W_Status_ShiftedTileStaging: ds $48

SECTION "Status Shift Background Tiles", ROM0[$17EF]
Status_ShiftBackgroundTiles::
    push hl
    ld de, W_Status_ShiftedTileStaging
    ld bc, $40
    call LCDC_SaveGraphicsFromVRAM
    
    ;Shift the tile right by one pixel.
    ld de, W_Status_ShiftedTileStaging
    ld hl, W_Status_ShiftedTileStaging + $10
    ld b, 2
    
.shiftRightLoop
    push bc
    push hl
    push de
    ld b, $10
    
.shiftTileRightLoop
    call Status_ShiftTileRight
    dec b
    jp nz, .shiftTileRightLoop
    
    ;Move the tile pointers down by two tiles.
    ld bc, $20
    pop hl
    add hl, bc
    push hl
    pop de
    pop hl
    add hl, bc
    pop bc
    
    dec b
    jp nz, .shiftRightLoop
    
    ;Copy the tops of each tile onto the end of the staging area.
    ld de, W_Status_ShiftedTileStaging
    ld hl, W_Status_ShiftedTileStaging + $40
    call Status_CopyTileLine
    
    ld de, W_Status_ShiftedTileStaging + $10
    call Status_CopyTileLine
    
    ld de, W_Status_ShiftedTileStaging + $20
    call Status_CopyTileLine
    
    ld de, W_Status_ShiftedTileStaging + $30
    call Status_CopyTileLine
    
    ;Shift the tiles up by one pixel - overwriting those first lines we already
    ;copied elsewhere.
    ld hl, W_Status_ShiftedTileStaging + $2
    ld de, W_Status_ShiftedTileStaging
    ld b, 4
    
.shiftUpLoop
    push bc
    ld b, $E
    
.shiftUpTileLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jp nz, .shiftUpTileLoop
    
    ;Align our pointers onto the next tile in the loop.
    inc hl
    inc hl
    inc de
    inc de
    
    pop bc
    dec b
    jp nz, .shiftUpLoop
    
    ;Put those lines we copied earlier back onto the bottom of the tileset
    ld de, W_Status_ShiftedTileStaging + $40
    ld hl, W_Status_ShiftedTileStaging + $2E
    call Status_CopyTileLine
    ld hl, W_Status_ShiftedTileStaging + $3E
    call Status_CopyTileLine
    ld hl, W_Status_ShiftedTileStaging + $0E
    call Status_CopyTileLine
    ld hl, W_Status_ShiftedTileStaging + $1E
    call Status_CopyTileLine
    
    pop de
    ld hl, W_Status_ShiftedTileStaging
    ld bc, $40
    call LCDC_LoadGraphicIntoVRAM
    ret

SECTION "Status Shift Utilities", ROM0[$18CC]
Status_CopyTileLine::
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ret
    
Status_ShiftTileRight::
    push de
    ld a, [de]
    srl a
    ld [de], a
    ld a, [hl]
    rr a
    ld [hli], a
    pop de
    jp nc, .noBitCarry
    
    ;Wrap that bit we shifted off back on
    ld a, [de]
    or $80
    ld [de], a
    
.noBitCarry
    inc de
    ret