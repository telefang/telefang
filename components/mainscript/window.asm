INCLUDE "telefang.inc"

SECTION "Main Script Window Vars", WRAM0[$C987]
W_MainScript_WindowTileWidth:: ds 1
W_MainScript_WindowHbyte:: ds 1

SECTION "Main Script Window Clear Vars", WRAM0[$C9D8]
W_MainScript_SecondaryWindowClearCondition:: ds 1
; This may possibly have other uses, but this is the only one I am aware of at the moment.

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
    ldh a, [REG_STAT]
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
    ldh a, [REG_STAT]
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
    ldh a, [REG_STAT]
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
    ldh a, [REG_STAT]
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
    ldh [REG_VBK], a
    
.loop
    di
    
.waitForBlanking
    ldh a, [REG_STAT]
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
    ldh [REG_VBK], a
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
    ldh a, [REG_STAT]
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
    ldh a, [REG_STAT]
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

SECTION "MainScript Clear Secondary Shop Window", ROMX[$4E9E], BANK[$32]
MainScript_ConditionallyClearSecondaryShopWindow::
    ; Check if we have talked to anyone on the top half of the screen. If so clear window.
    ld a, [W_MainScript_SecondaryWindowClearCondition]
    cp a, 2
    jr z, .clearWindow
    ; If we are in the top half of the screen then do nothing.
    ld a, [$C484]
    cp a, $48
    ret c
    ; If we have not talked to a bottom screen npc or opened a secondary window at some point since the last clear then do nothing.
    ld a, [W_MainScript_SecondaryWindowClearCondition]
    or a
    ret z

.clearWindow
    ; Reset conditional variable to 0 for next time.
    ld a, 0
    ld [W_MainScript_SecondaryWindowClearCondition], a
    call $2CD1
    jp MainScript_ClearSecondaryShopWindow

MainScript_ClearSecondaryShopWindow::
    ld hl, $980C
    ld a, [$CA76]
    call $328D
    ld hl, $980E
    ld a, [$CA77]
    call $328D
    ld hl, $9810
    ld a, [$CA78]
    call $328D
    ld hl, $9812
    ld a, [$CA79]
    call $328D
    ld hl, $984C
    ld a, [$CA80]
    call $328D
    ld hl, $984E
    ld a, [$CA81]
    call $328D
    ld hl, $9850
    ld a, [$CA82]
    call $328D
    ld hl, $9852
    ld a, [$CA83]
    call $328D
    ret

MainScript_ClearBothShopWindows::
    ld a, 2
    ld [$C9D8], a
    ld b, $A
    ld hl, $9800
    ld de, $CA70
    call .acreSquareMappingLoop
    ld b, $A
    ld hl, $9840
    ld de, $CA7A

.acreSquareMappingLoop
    push de
    push hl
    push bc
    ld a, [de]
    call $328D
    pop bc
    pop hl
    pop de
    inc de
    inc hl
    inc hl
    dec b
    jr nz, .acreSquareMappingLoop
    ret

SECTION "MainScript Clear Overworld Window", ROM0[$2BA9]
MainScript_ClearOverworldWindow::
    ld a, [W_MainScript_WindowLocation]
    srl a
    ld c, a
    ld e, $A
    call System_Multiply8
    ld hl, $CA70
    add hl, de
    ld d, h
    ld e, l
    ld a, [W_MainScript_WindowLocation]
    ld c, 0
    srl a
    srl a
    rr c
    srl a
    rr c
    ld b, a
    jp MainScript_ClearOverworldWindowTiles

.extEntryA
    ld bc, 0
    ld de, $CA70
    jp MainScript_ClearOverworldWindowTiles

.extEntryB
    ld bc, $100
    ld de, $CA98

MainScript_ClearOverworldWindowTiles::
    ld a, [W_MainScript_TilePtr]
    ld l, a
    ld a, [$C9FD]
    ld h, a
    add hl, bc
    call VRAMTileWraparound
    ld b, 4

.acreRowMappingLoop
    push bc
    push hl
    ld a, [W_CurrentBank]
    push af
    ld a, $32
    rst $10
    call $42A9
    pop af
    rst $10
    pop hl
    ld bc, $40
    add hl, bc
    call VRAMTileWraparound
    pop bc
    dec b
    jr nz, .acreRowMappingLoop
    ret

SECTION "MainScript Determine Overworld Window Position", ROMX[$46D2], BANK[$B]
MainScript_DetermineOverworldWindowPosition::
    ld d, $A
    ld a, [$C484]
    cp $48
    jr c, .placeWindowAtBottom

.placeWindowAtTop
    ld d, 1

.placeWindowAtBottom
    ld a, d
    ld [W_MainScript_WindowLocation], a
    ret

MainScript_FireXObtainedMessage::
    call MainScript_DetermineOverworldWindowPosition
    ld hl, StringTable_battle_items
    ld c, b
    ld b, 0
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    ld b, 8
    ld de, W_MainScript_MessageArg3

.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop

    ld a, $E0
    ld [de], a
    xor a
    ld [W_byte_C9CF], a
    ld b, 0
    ld c, $BF
    jp $464E

SECTION "MainScript Animate Overworld Window", ROMX[$457D], BANK[$B]
MainScript_AnimateOverworldWindow::
    ld a, [W_MainScript_WaitFrames]
    dec a
    ld [W_MainScript_WaitFrames], a
    jr nz, .waitUntilNextFrame

.twoThirdsOpen
    ld a, 4
    ld [W_MainScript_WaitFrames], a
    ld a, [W_MainScript_NumNewlines]
    inc a
    ld [W_MainScript_NumNewlines], a
    cp 1
    jr nz, .fullyOpen
    ld a, [W_MainScript_WindowLocation]
    dec a
    ld [W_MainScript_WindowLocation], a
    ld de, $507B
    ld b, 4
    ld c, 1
    jp MainScript_DrawWindowBorder

.fullyOpen
    ld a, 1
    ld [W_MainScript_State], a
    ld a, 0
    ld [W_MainScript_NumNewlines], a
    ld a, 8
    ld [W_MainScript_WaitFrames], a
    ld a, [W_MainScript_WindowLocation]
    dec a
    ld [W_MainScript_WindowLocation], a
    ld de, $500F
    ld b, 6
    ld c, 1
    jp MainScript_DrawWindowBorder

.waitUntilNextFrame
    ret

SECTION "MainScript Clear Overworld Hud", ROMX[$48B1], BANK[$B]
MainScript_ClearOverworldHud::
    ld a, [$CD29]
    or a
    jr nz, .hudAtBottomOfScreen

.hudAtTopOfScreen
    ld a, [$C9FD]
    ld h, a
    ld a, [W_MainScript_TilePtr]
    ld l, a
    ld de, $CA70
    call .mapAcreRow
    ret

.hudAtBottomOfScreen
    ld a, [$C9FD]
    ld h, a
    ld a, [W_MainScript_TilePtr]
    ld l, a
    ld bc, $1C0
    add hl, bc
    call VRAMTileWraparound
    ld de, $CAB6

.mapAcreRow
    call .mapAcreSquare
    call .mapAcreSquare
    call .mapAcreSquare
    call .mapAcreSquare
    call .mapAcreSquare
    call .mapAcreSquare
    call .mapAcreSquare
    call .mapAcreSquare
    call .mapAcreSquare
    jp .mapAcreSquare

.mapAcreSquare
    ld a, [de]
    push hl
    push de
    call $328D
    pop de
    inc de
    pop hl
    ld c, 2
    jp $4C32

SECTION "MainScript Map Location Window", ROMX[$49A2], BANK[$B]
MainScript_MapLocationWindow::
    call MainScript_LoadWindowBorderTileset
    call MainScript_ClearWindowTilesNext
    ld de, $5127
    ld b, 3
    ld a, [W_MainScript_WindowLocation]
    ld c, 1
    call MainScript_DrawWindowBorder
    ld a, [W_MainScript_WindowLocation]
    dec a
    ld [W_MainScript_WindowLocation], a
    ret

MainScript_OverworldWindowThirdOpen::
    call MainScript_LoadWindowBorderTileset
    call $4CE5
    ld de, $50C3
    ld b, 2
    ld a, [W_MainScript_WindowLocation]
    ld c, 1
    call MainScript_DrawWindowBorder
    ret

SECTION "MainScript Map Hud Window", ROMX[$49FB], BANK[$B]
MainScript_MapOverworldHudWindow::
    call MainScript_LoadWindowTiles
    call $4D63
    ld de, $CA08
    ld b, 2
    ld a, [W_MainScript_WindowLocation]
    ld c, 0
    call MainScript_DrawWindowBorder
    ret

SECTION "MainScript Map Secondary Shop Window", ROMX[$4A48], BANK[$B]
MainScript_MapSecondaryShopWindow::
    call MainScript_LoadWindowBorderTileset
    call MainScript_ClearWindowTilesNext
    ld de, $5185
    ld b, 3
    ld a, [W_MainScript_WindowLocation]
    ld c, $C
    call MainScript_DrawWindowBorder
    ret
