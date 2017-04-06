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