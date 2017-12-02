INCLUDE "telefang.inc"

SECTION "Title Screen Position Sprites", ROMX[$4630], BANK[$2]
TitleScreen_PositionSpriteNoAttribs::
    ld hl, 0
    add hl, de
    inc hl
    jp TitleScreen_PositionSprite.afterAttribsSet
    
TitleScreen_PositionSprite::
    ld hl, 0
    add hl, de
    ld a, 1
    ld [hli], a
    
.afterAttribsSet
    ld a, 0
    ld [hli], a
    
    inc hl
    ld a, b
    ld [hli], a
    
    ld a, c
    ld [hli], a
    ret