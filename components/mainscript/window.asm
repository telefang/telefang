INCLUDE "telefang.inc"

;because macros
IMPORT ScriptWindow
IMPORT ScriptWindow_END

SECTION "Main Script Window Vars", WRAM0[$C987]
W_MainScript_WindowTileWidth:: ds 1
W_MainScript_WindowHbyte:: ds 1

SECTION "Main Script Window Border Vars 2", WRAM0[$CA6D]
W_MainScript_WindowType:: ds 1

SECTION "MainScript Window Text Clear", ROMX[$4CEB], BANK[$B]
MainScript_ClearTilesShopWindow::
    ld a, [W_MainScript_TileBaseIdx]
    
.calcAddr
    call LCDC_TileIdx2Ptr
    
    ld b, $80
    jp MainScript_ClearWindowTiles

;TODO: What does this variant of the clear-tiles function do?
;Why does it add 16 to the tilebase?
MainScript_ClearWindowTilesNext::
    ld a, [W_MainScript_TileBaseIdx]
    add a, $10
    jr MainScript_ClearTilesShopWindow.calcAddr
    
MainScript_ClearWindowTiles::
    ld a, [W_MainScript_TextStyle]
    cp 0
    jr z, .drawColorZero
    cp 1
    jr z, .drawColorTwo
    cp 2
    jr z, .drawColorThree
    
.drawColorZero
    di

.dcz_blanking
    ld a, [REG_STAT]
    and 2
    jr nz, .dcz_blanking
    
    xor a
    ld [hli], a
    ld [hli], a
    
    ei
    dec b
    jr nz, .drawColorZero
    
    ret
    
.drawColorTwo
    di
    
.dct_blanking
    ld a, [REG_STAT]
    and 2
    jr nz, .dct_blanking
    
    xor a
    ld [hli], a
    cpl
    ld [hli], a
    
    ei
    dec b
    jr nz, .drawColorTwo
    
    ret
    
.drawColorThree
    di
    
.dcth_blanking
    ld a, [REG_STAT]
    and 2
    jr nz, .dcth_blanking
    
    ld a, $FF
    ld [hli], a
    ld [hli], a
    
    ei
    dec b
    jr nz, .drawColorThree
    
    ret

SECTION "Main Script Draw Window Tilemaps", ROMX[$4A5C], BANK[$B]
MainScript_DrawWindowBorder::
    push bc
    push de
    
    ld b, 0
    sla a
    rl b
    sla a
    rl b
    sla a
    rl b
    sla a
    rl b
    sla a
    rl b
    ld d, a
    ld a, [W_MainScript_TilePtr]
    add a, c
    ld l, a
    ld a, [W_MainScript_TilePtr + 1]
    ld h, a
    ld c, d
    add hl, bc
    call VRAMTileWraparound
    
    pop de
    pop bc
    
.drawLoop
    push bc
    push hl
    
    call MainScript_DrawWindowBorderLine
    
    pop hl
    pop bc
    push bc
    push hl
    
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr nz, .noAttribs
    
.attribs
    call MainScript_DrawWindowBorderAttribLine
    
.noAttribs
    pop hl
    ld bc, $20
    add hl, bc
    call VRAMTileWraparound
    
    pop bc
    dec b
    jr nz, .drawLoop
    
    ret
    
MainScript_DrawWindowBorderLine:
    ld a, c
    ld [W_MainScript_WindowType], a
    ld c, $12
    cp 1
    jr z, .drawLine
    ld c, $A
    cp 0
    jr nz, .thinWindow
    ld a, [W_Overworld_AcreType]
    cp $B ;Set to $B in shops, $A in dungeons, $4 and $2 outside
    jr z, .drawLine
    
    ld c, $14
    jr .drawLine
    
.thinWindow
    ld a, [W_MainScript_WindowType]
    ld c, 8
    cp $C
    jr z, .drawLine
    ld c, $10
    
.drawLine
    ld a, c
    ld [W_MainScript_WindowTileWidth], a
    
    ld a, l
    and $E0
    ld b, a
    ld c, l
    ld a, h
    ld [W_MainScript_WindowHbyte], a
    
.loop
    di
    
.waitForBlanking
    ld a, [REG_STAT]
    and 2
    jr nz, .waitForBlanking
    
    ld a, [de]
    ld [hli], a
    inc de
    
    ei
    
;This wraps the line drawing to the current line.
    ld a, [W_MainScript_WindowHbyte]
    ld h, a
    ld a, 1
    add a, c
    ld c, a
    and $1F
    or b
    ld l, a
    
    ld a, [W_MainScript_WindowTileWidth]
    dec a
    ld [W_MainScript_WindowTileWidth], a
    
    jr nz, .loop
    
    ret

MainScript_DrawWindowBorderAttribLine::
    push de
    ld a, c
    ld d, $12
    cp 1
    jr z, .drawLineAttribs
    ld d, $A
    cp 0
    jr nz, .wideWindow
    ld a, [W_Overworld_AcreType]
    cp $B
    jr z, .drawLineAttribs
    ld d, $14
    jr .drawLineAttribs
    
.wideWindow
    ld d, $10
    
.drawLineAttribs
    ld a, l
    and $E0
    ld b, a
    ld c, l
    ld a, h
    ld e, a
    ld a, 1
    ld [REG_VBK], a
    
.loop
    di
    
.waitForBlanking
    ld a, [REG_STAT]
    and 2
    jr nz, .waitForBlanking
    
    ld a, [W_MainScript_WindowBorderAttribs]
    ld [hli], a
    
    ei
    
    ld a, e
    ld h, a
    ld a, 1
    add a, c
    ld c, a
    and $1F
    or b
    ld l, a
    dec d
    jr nz, .loop
    
    xor a
    ld [REG_VBK], a
    pop de
    ret

SECTION "Main Script Load Window Tiles", ROMX[$4F28], BANK[$B]
MainScript_LoadWindowBorderTileset::
    ld hl, $8F00
    ld de, .windowBorderTiles
    ld bc, $A0
    call LCDC_LoadTiles
    
    ;Add a blank tile to correspond to the current text style.
    ld hl, $8EF0
    ld b, 8
    ld a, [W_MainScript_TextStyle]
    
    cp 2
    jr z, .color3Clear
    
.color0Clear
    di
    
.c0_blanking
    ld a, [REG_STAT]
    and 2
    jr nz, .c0_blanking
    
    xor a
    ld [hli], a
    ld [hli], a
    
    ei
    inc de
    dec b
    
    jr nz, .color0Clear
    
    ret

.color3Clear
    di
    
.c3_blanking
    ld a, [REG_STAT]
    and 2
    jr nz, .c3_blanking
    
    ld a, $FF
    ld [hli], a
    ld [hli], a
    
    ei
    inc de
    dec b
    
    jr nz, .color3Clear
    
    ret
    
.windowBorderTiles
    INCBIN "build/components/mainscript/window_border.2bpp"

MainScript_LoadWindowTiles::
    ld a, BANK(ScriptWindow)
    ld hl, $8C00
    ld de, ScriptWindow
    ld bc, ScriptWindow_END - ScriptWindow
    jp Banked_LCDC_LoadTiles

;There's a bunch more window tilemaps than this, but there's no table to dump
;all of them with. So add to this section as necessary.
SECTION "Main Script Window Data - Shop Window", ROMX[$515D], BANK[$B]

;This window tiledata is for the window that shows the name of an item in a shop
MainScript_ShopWindowBorder::
    db $F0, $F1, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F3
    db $F4, $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $F6
    db $F4, $EF, $EF, $EF, $EF, $EF, $C8, $C9, $CA, $F6
    db $F7, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F9