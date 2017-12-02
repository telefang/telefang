INCLUDE "telefang.inc"

SECTION "Title Screen State Machine (Speed)", ROMX[$499E], BANK[$2]
; State 01 01
TitleScreen_StateLoadTilemapsAndSprites::
    ld bc, 0
    ld e, $C
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, 0
    ld e, 9
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld a, 6
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_Index], a
    
    ld bc, $4C60
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call TitleScreen_PositionSpriteNoAttribs
    
    ld a, $1C
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 4 + M_LCDC_MetaSpriteConfig_Index], a
    
    ld bc, $4840
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 4
    call TitleScreen_PositionSprite
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    ld bc, $280C
    call TitleScreen_PositionSprite
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3
    ld bc, $780C
    call TitleScreen_PositionSprite
    
    ld a, 9
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_InitializeCursor
    
    ld a, $A
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3
    call Banked_PauseMenu_InitializeCursor
    
    ;These, of course, are the overhang sprites on the Telefang logo used to get
    ;around the attribute clash. You can tell that's the case because this code
    ;was hurriedly added in after the fact using a completely different style
    ;from the other bits of sprite init.
    ld a, $1D
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 5 + M_LCDC_MetaSpriteConfig_Index], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 5
    ld bc, $2038
    call TitleScreen_PositionSprite
    
    ld a, $1E
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 6 + M_LCDC_MetaSpriteConfig_Index], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 6
    ld bc, $8838
    call TitleScreen_PositionSprite
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    jp System_ScheduleNextSubState