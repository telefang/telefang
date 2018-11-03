INCLUDE "telefang.inc"

SECTION "Pause Menu WRAM", WRAM0[$CB38]
W_PauseMenu_SelectedMenuItem:: ds 1
W_PauseMenu_ScrollAnimationTimer:: ds 1

SECTION "Pause Menu WRAM 2", WRAM0[$CD22]
W_PauseMenu_SelectedMenuTilemap:: ds 1

SECTION "Pause Menu Animation Utils", ROMX[$59B9], BANK[$4]
PauseMenu_ManageScrollAnimation::
    ld a, [W_JPInput_TypematicBtns]
    and $C0 ; Up / Down
    jr nz, PauseMenu_ResetAnimation
    
    ld a, [W_PauseMenu_ScrollAnimationTimer]
    cp $10
    ret z
    
    inc a
    ld [W_PauseMenu_ScrollAnimationTimer], a
    
    cp $10
    ret nz
    
PauseMenu_DrawMenuItemsAndFrame::
    ld bc, $109
    ld e, $13
    call PauseMenu_LoadMap0
    jp PauseMenu_DrawMenuItemsFromTop
    
PauseMenu_ResetAnimation::
    xor a
    ld [W_PauseMenu_ScrollAnimationTimer], a
    
PauseMenu_DrawMenuItemsFromTop::
    ld bc, $307
    
PauseMenu_DrawMenuItems::
    ld a, [W_PauseMenu_SelectedMenuTilemap]
    add a, $24
    call TitleMenu_LoadItemTilemapSequence
    
    ld a, [W_PauseMenu_SelectedMenuTilemap]
    inc a
    cp 9
    jr c, .no_wrap_item_2

.wrap_item_2
    sub 9
    
.no_wrap_item_2
    add a, $24
    call TitleMenu_LoadItemTilemapSequence
    
    ld a, [W_PauseMenu_SelectedMenuTilemap]
    inc a
    inc a
    cp 9
    jr c, .no_wrap_item_3
    
.wrap_item_3
    sub 9
    
.no_wrap_item_3
    add a, $24
    jp TitleMenu_LoadItemTilemapSequence