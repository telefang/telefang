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
    jp MainScript_ADVICE_ClearWindowTiles_DrawColorOneMaybe
    nop
    
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

SECTION "Main Script Clear Window Tiles Text Style 3 Fix", ROMX[$4E44], BANK[$B]
; This fixes it so that MainScript_ClearWindowTiles works for text style 3.
MainScript_ADVICE_ClearWindowTiles_DrawColorOneMaybe::
    cp 2
    jp z, MainScript_ClearWindowTiles.drawColorThree
    cp 3
    jp nz, MainScript_ClearWindowTiles.drawColorZero

.drawColorOne
    di
    
.dct_blanking
    ld a, [REG_STAT]
    and 2
    jr nz, .dct_blanking
    
    ld a, $FF
    ld [hli], a
    xor a
    ld [hli], a
    
    ei
    dec b
    jr nz, .drawColorOne
    
    ret
	
	;Note: Free Space
	ds $36

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

SECTION "MainScript Clear Secondary Shop Window", ROMX[$4EBB], BANK[$32]
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
    call MainScript_ADVICE_ClearSecondaryShopWindow
    ret

MainScript_ClearBothShopWindows::
    ld a, 2
    call MainScript_ADVICE_ClearBothShopWindows
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
    jp MainScript_ADVICE_ClearOverworldWindow

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
    jp MainScript_ADVICE_DrawTwoThirdsOverworldWindow

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
    jp MainScript_ADVICE_DrawOverworldWindow

.waitUntilNextFrame
    ret

SECTION "MainScript Clear Overworld Hud", ROMX[$48B1], BANK[$B]
MainScript_ClearOverworldHud::
    ld a, [$CD29]
    or a
    jr nz, .hudAtBottomOfScreen

.hudAtTopOfScreen
    call MainScript_ADVICE_TopHudSGBClear
    ld h, a
    ld a, [W_MainScript_TilePtr]
    ld l, a
    ld de, $CA70
    call .mapAcreRow
    ret

.hudAtBottomOfScreen
    call MainScript_ADVICE_BottomHudSGBClear
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
    M_AuxJmp Banked_MainScript_ADVICE_SGBRedrawOverworldLocationWindow

.extEntry
    ld a, [W_MainScript_WindowLocation]
    ld c, 1
    call MainScript_ADVICE_MapLocationWindow
    ld a, [W_MainScript_WindowLocation]
    dec a
    ld [W_MainScript_WindowLocation], a
    ret

MainScript_OverworldWindowThirdOpen::
    call MainScript_LoadWindowBorderTileset
    call $4CE5
    M_AuxJmp Banked_MainScript_ADVICE_SGBRedrawOverworldWindow
    ld a, [W_MainScript_WindowLocation]
    ld c, 1
    call MainScript_ADVICE_DrawOneThirdOverworldWindow
    ret

SECTION "MainScript Map Hud Window", ROMX[$49FB], BANK[$B]
MainScript_MapOverworldHudWindow::
    call MainScript_LoadWindowTiles
    call $4D63
    M_AuxJmp Banked_MainScript_ADVICE_SGBRedrawHud
    ld a, [W_MainScript_WindowLocation]
    ld c, 0
    call MainScript_ADVICE_MapOverworldHudWindow
    ret

SECTION "MainScript Map Secondary Shop Window", ROMX[$4A48], BANK[$B]
MainScript_MapSecondaryShopWindow::
    call MainScript_LoadWindowBorderTileset
    call MainScript_ClearWindowTilesNext
    M_AuxJmp Banked_MainScript_ADVICE_SGBRedrawSecondaryShopWindow
    ld a, [W_MainScript_WindowLocation]
    ld c, $C
    call MainScript_ADVICE_MapSecondaryShopWindow
    ret

SECTION "MainScript Overworld SGB Window Advice", ROMX[$7FAC], BANK[$B]
MainScript_ADVICE_DrawOverworldWindow::
    call MainScript_DrawWindowBorder
    ld h, 4

.extEntry
    jp Banked_SGB_ConstructATTRBLKPacket

MainScript_ADVICE_DrawTwoThirdsOverworldWindow::
    call MainScript_DrawWindowBorder
    ld h, 5
    jr MainScript_ADVICE_DrawOverworldWindow.extEntry

MainScript_ADVICE_DrawOneThirdOverworldWindow::
    call MainScript_DrawWindowBorder
    ld h, 6
    jr MainScript_ADVICE_DrawOverworldWindow.extEntry

MainScript_ADVICE_MapOverworldHudWindow::
    call MainScript_DrawWindowBorder
    ld h, 8
    jr MainScript_ADVICE_DrawOverworldWindow.extEntry

MainScript_ADVICE_MapLocationWindow::
    call MainScript_DrawWindowBorder
    ld h, $C
    jr MainScript_ADVICE_DrawOverworldWindow.extEntry

MainScript_ADVICE_DrawEmptyShopWindow::
    call MainScript_DrawWindowBorder
    ld h, $D
    jr MainScript_ADVICE_DrawOverworldWindow.extEntry

MainScript_ADVICE_MapSecondaryShopWindow::
    call MainScript_DrawWindowBorder
    ld h, $E
    jr MainScript_ADVICE_DrawOverworldWindow.extEntry

MainScript_ADVICE_TopHudSGBClear::
    ld h, 9

.extEntry
    call Banked_SGB_ConstructATTRBLKPacket
    ld a, [$C9FD]
    ret

MainScript_ADVICE_BottomHudSGBClear::
    ld h, $B
    jr MainScript_ADVICE_TopHudSGBClear.extEntry

MainScript_ADVICE_MapLocationWindowForMap::
    call MainScript_LoadWindowBorderTileset
    call MainScript_ClearWindowTilesNext
    ld de, $5127
    ld b, 3
    jp MainScript_MapLocationWindow.extEntry

SECTION "MainScript Clear Shop Window Advice", ROMX[$70E0], BANK[$32]
MainScript_ADVICE_ClearSecondaryShopWindow::
    call $328D
    ld h, $F
    jp Banked_SGB_ConstructATTRBLKPacket

MainScript_ADVICE_ClearBothShopWindows::
    ld [$C9D8], a
    ld h, $A
    jp Banked_SGB_ConstructATTRBLKPacket

SECTION "Overworld Message Box Clear Advice", ROM0[$3EA5]
MainScript_ADVICE_ClearOverworldWindow::
    call MainScript_ClearOverworldWindowTiles
    ld a, [W_CurrentBank]
    push af
    ld a, BANK(Overworld_ADVICE_SGBShopTextStyle)
    rst $10
    call Overworld_ADVICE_SGBShopTextStyle
    pop af
    rst $10
    ld h, 7
    jp Banked_SGB_ConstructATTRBLKPacket

SECTION "MainScript Window Redraw Advice", ROMX[$6470], BANK[$1]
MainScript_ADVICE_SGBRedrawOverworldLocationWindow::
    M_AdviceSetup
    call MainScript_ADVICE_SGBRedrawOverworldWindow_Common
    ld de, $5127
    ld b, 3
    M_AdviceTeardown
    ret

MainScript_ADVICE_SGBRedrawOverworldWindow::
    M_AdviceSetup
    call MainScript_ADVICE_SGBRedrawOverworldWindow_Common
    ld de, $50C3
    ld b, 2
    M_AdviceTeardown
    ret

MainScript_ADVICE_SGBRedrawOverworldWindow_Common::
    call PauseMenu_ADVICE_CheckSGB
    ret z

MainScript_ADVICE_SGBRedrawOverworldWindow_Common_skipSGBCheck::
    ld a, 3
    ld [W_MainScript_TextStyle], a
    ld hl, $8C00
    ld b, $C0
    call Zukan_ADVICE_TileLowByteBlanketFill
    ld b, $50
    call Zukan_ADVICE_TileLightColourReverse
    ld b, $14
    call Zukan_ADVICE_TileLowByteBlanketFill
    ret

MainScript_ADVICE_SGBRedrawHud::
    M_AdviceSetup

    call PauseMenu_ADVICE_CheckSGB
    jr z, .exit

    ; Check if tiles already redrawn.
    di
    call WaitForBlanking
    ld a, [$8C00]
    ei
    cp $1F
    jr z, .exit

    ld hl, $8C00
    ld b, $B0
    call Zukan_ADVICE_TileLightColourReverse
    ld b, $B0
    call Zukan_ADVICE_TileLightColourReverse

.exit
    ld de, $CA08
    ld b, 2
    M_AdviceTeardown
    ret

SECTION "MainScript Shop Window Redraw Advice", ROMX[$5F20], BANK[$1]
MainScript_ADVICE_SGBRedrawShopWindow::
    M_AdviceSetup
    call MainScript_ADVICE_SGBRedrawSecondaryShopWindow_Common
    ld de, MainScript_ShopWindowBorder
    ld b, 4
    M_AdviceTeardown
    ret

MainScript_ADVICE_SGBRedrawSecondaryShopWindow::
    M_AdviceSetup
    call MainScript_ADVICE_SGBRedrawSecondaryShopWindow_Common
    ld de, $5185
    ld b, 3
    M_AdviceTeardown
    ret

MainScript_ADVICE_SGBRedrawSecondaryShopWindow_Common::
    call PauseMenu_ADVICE_CheckSGB
    ret z
    ld hl, $8EF0
    ld b, 4
	call Zukan_ADVICE_TileLowByteBlanketFill
    ld b, $50
    call Zukan_ADVICE_TileLightColourReverse
    ret
