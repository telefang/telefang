INCLUDE "telefang.inc"

SECTION " Pause Menu Screen Utils", ROMX[$5A06], BANK[4]
PauseMenu_ClearScreenTiles::
    push bc
    ld c, $10
    
.loop1
    xor a
    call YetAnotherWFB
    ld [hli], a
    dec c
    jr nz, .loop1
    
    pop bc
    dec b
    jr nz, PauseMenu_ClearScreenTiles
    
    ret
    
PauseMenu_DMGClearInputTiles::
    ld d, $FF
    ld e, 0
    jr PauseMenu_CGBClearInputTiles.clearLoop
    
PauseMenu_CGBClearInputTiles::
    ld d, 0
    ld e, $FF
    
.clearLoop
    push bc
    ld c, 8
    
.innerLoop
    call YetAnotherWFB
    ld a, d
    ld [hli], a
    ld a, e
    call YetAnotherWFB
    ld [hli], a
    dec c
    jr nz, .innerLoop
    
    pop bc
    dec b
    jr nz, .clearLoop
    
    ret

SECTION "Pause Menu Tilemap Loading", ROMX[$7931], BANK[$4]

; All of these are thunks/frontends into the tilemap decompressor.
; Yes, they are intended to fallthrough into each other.
; The LoadMenu* variants specify a particular coordinate; the functions they
; fallthrough into let you specify your own.

PauseMenu_LoadMenuTilemap0::
    ld bc, $106
    
PauseMenu_LoadTilemap0::
    ld a, 0
    jp Banked_RLEDecompressTMAP0

PauseMenu_LoadMenuAttribmap0::
    ld bc, $106
    
PauseMenu_LoadAttribmap0::
    ld a, 0
    jp Banked_RLEDecompressAttribsTMAP0

PauseMenu_LoadMenuTilemap1::
    ld bc, $106
    
PauseMenu_LoadTilemap1::
    ld a, 0
    jp Banked_RLEDecompressTMAP1

PauseMenu_LoadMenuAttribmap1::
    ld bc, $106
    
PauseMenu_LoadAttribmap1::
    ld a, 0
    jp Banked_RLEDecompressAttribsTMAP1

; These are frontends for loading both tilemaps and attribs.
; LoadMenu* / Load* distinction still exists

PauseMenu_LoadMenuMap0::
    push de
    call PauseMenu_LoadMenuTilemap0
    pop de
    jp PauseMenu_LoadMenuAttribmap0

PauseMenu_LoadMap0::
    push bc
    push de
    call PauseMenu_LoadTilemap0
    pop de
    pop bc
    jp PauseMenu_LoadAttribmap0

;Yes I know, LoadMenuMap0 is missing. They never wrote one.

PauseMenu_LoadMap1::
    push bc
    push de
    call PauseMenu_LoadTilemap1
    pop de
    pop bc
    jp PauseMenu_LoadAttribmap1
    
SECTION "Pause Menu Tilemap Loading 2", ROMX[$7F38], BANK[$4]
;Another round of tilemap decompressor frontends
PauseMenu_LoadScrollAnimationFrameD2::
    ld e, $1E
    jp PauseMenu_LoadScrollAnimationFrame
    
PauseMenu_LoadScrollAnimationFrameD1::
    ld e, $1F
    
PauseMenu_LoadScrollAnimationFrame::
    call PauseMenu_LoadMenuTilemap0
    ld e, $12
    jp PauseMenu_LoadMenuAttribmap0

SECTION "Pause Menu Tile Utils", ROMX[$7FC6], BANK[$4]
PauseMenu_ClearArrowMetasprites::
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call LCDC_ClearSingleMetasprite
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    jp LCDC_ClearSingleMetasprite
    
PauseMenu_ClearInputTiles::
    nop
    nop
    call TitleMenu_ADVICE_CanUseCGBTiles
    jr nz, .dmgClear
    jp PauseMenu_CGBClearInputTiles
    
.dmgClear
    jp PauseMenu_DMGClearInputTiles
    
PauseMenu_SelectTextStyle::
    nop
    nop
    call TitleMenu_ADVICE_CanUseCGBTiles
    jr nz, .selectDMGStyle
    ld a, 1
    jr .setTextStyle
    
.selectDMGStyle
    ld a, 3
    
.setTextStyle
    ld [W_MainScript_TextStyle], a
    ret