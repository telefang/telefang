SECTION "Title Menu Scroll", ROMX[$5913], BANK[$4]
TitleMenu_ScrollMenu::
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Up + M_JPInput_Down
    jr nz, TitleMenu_ScrollMenu_noChange
    
TitleMenu_ScrollMenu_change::
    ld a, [$CB39]
    cp $10
    ret z
    
    inc a
    ld [$CB39], a
    cp $10
    ret nz
    
TitleMenu_ScrollMenu_refresh::
    ld bc, $109
    ld e, $13
    call PauseMenu_LoadMap0
    jp TitleMenu_DrawMenuItems
    
TitleMenu_ScrollMenu_noChange::
    xor a
    ld [$CB39], a
    
TitleMenu_DrawMenuItems::
    ld bc, $307
    
TitleMenu_DrawMenuItems_custCoords::
    ld a, [W_PauseMenu_SelectedMenuItem]
    add a, $36
    call TitleMenu_LoadItemTilemapSequence
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    inc a
    cp 4
    jr c, .noOverflow
    
.capOverflow
    sub 4
    
.noOverflow
    add a, $36
    call TitleMenu_LoadItemTilemapSequence
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    inc a
    inc a
    cp 4
    jr c, .noOverflow2
    
.capOverflow2
    sub 4
    
.noOverflow2
    add a, $36
    jp TitleMenu_LoadItemTilemapSequence
    
SECTION "Title Menu Scroll 2", ROMX[$59AC], BANK[$4]
TitleMenu_LoadItemTilemapSequence::
    push bc
    
    ld e, a
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    pop bc
    
    ld a, c
    add a, 3
    ld c, a
    
    ret

SECTION "Title Menu Scroll 3", ROMX[$5799], BANK[$4]
TitleMenu_DrawUpScrollMenuItems::
    ld a, [$CB3C]
    cp 0
    jr nz, .alternateDrawPath
    
    ld bc, $306
    call TitleMenu_DrawMenuItems_custCoords
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 3
    jr nz, .noWraparound
    
.wraparound
    ld a, $FF
    
.noWraparound
    inc a
    ld [W_PauseMenu_SelectedMenuItem], a
    ret
    
    ;Not sure what any of this does...
.alternateDrawPath
    ld bc, $306
    call $5985
    
    ld a, [$CB3A]
    inc a
    and 3
    ld [$CB3A], a
    ret
    
TitleMenu_DrawDownScrollMenuItems::
    ld a, [$CB3C]
    cp 0
    jr nz, .alternateDrawPath
    
    ld bc, $308
    call TitleMenu_DrawMenuItems_custCoords
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    jr nz, .noWraparound
    
.wraparound
    ld a, 4
    
.noWraparound
    dec a
    ld [W_PauseMenu_SelectedMenuItem], a
    ret
    
    ;Not sure what any of this does...
.alternateDrawPath
    ld bc, $308
    call $5985
    
    ld a, [$CB3A]
    dec a
    and 3
    ld [$CB3A], a
    ret