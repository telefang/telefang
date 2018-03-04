INCLUDE "telefang.inc"

SECTION "Main Script Message Arg 3 Extended", WRAMX[$D6B1], BANK[1]
W_MainScript_MessageArg3:: ds M_StringTable_Load8AreaSize

SECTION "Main Script Message Arg 3", WRAM0[$CA53]
W_MainScript_MessageArg3Old:: ds 8

SECTION "Main Script Shop Item Window", ROM0[$2CEB]
MainScript_DrawShopWindowForItem::
    ld a, [W_CurrentBank]
    push af
    ld a, BANK(MainScriptMachine)
    rst $10
    
    call MainScript_SetupShopWindowForItem
    call MainScriptMachine
    call MainScriptMachine
    
    pop af
    rst $10
    ld a, 0
    ld [$C9CF], a
    ret

SECTION "Main Script Shop Item Window 2", ROMX[$4711], BANK[$B]
MainScript_SetupShopWindowForItem::
    push bc
    call MainScript_LoadItemNameAsArg3
    
    xor a
    ld [$C9CF], a
    ld a, $C0
    ld [W_MainScript_TileBaseIdx], a
    ld a, $E0
    ld [W_Status_NumericalTileIndex], a
    
    ld b, 0
    ld c, $BA
    ld d, 0
    call MainScript_QueueCustomWindowMessage
    
    ld a, 1
    ld [$CADA], a
    ld a, 7
    ld [W_MainScript_WindowBorderAttribs], a
    
    call MainScript_DrawEmptyShopWindow
    
    pop bc
    call MainScript_DrawQuantity
    
    ret

MainScript_LoadItemNameAsArg3::
    call PatchUtils_MainScript_ADVICE_LoadItemNameAsArg3
    
    REPT $1E
    nop
    ENDR
    
    ret

SECTION "Main Script Shop Item Window ADVICE 3", ROMX[$6FD0], BANK[$78]
MainScript_ADVICE_LoadItemNameAsArg3::
    ld hl, StringTable_battle_items
    
    ld c, b
    ld b, 0
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    
    ld b, M_StringTable_Load8AreaSize
    ld de, W_MainScript_MessageArg3
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop
    
    ld a, $E0
    ld [de], a
    
    ;Cap off the old Arg3 area with a terminator
    ld de, W_MainScript_MessageArg3Old
    ld [de], a
    
    ;This is incorrect, but there's no "correct" way to do a second-level of
    ;banking safety. Telefang's bank-safe calls don't actually stack the current
    ;bank, making it sort of 
    ld a, BANK(MainScript_LoadItemNameAsArg3)
    ld [W_PreviousBank], a
    ret

SECTION "Main Script Shop Item Window 3", ROMX[$476C], BANK[$B]
MainScript_QueueCustomWindowMessage::
    ld hl, W_MainScript_TilePtr
    ld a, 0
    ld [hli], a
    ld a, $98
    ld [hl], a
    
    ld a, d
    ld [W_MainScript_WindowLocation], a
    
    ld d, 0
    ld e, b
    ld hl, MainScript_table
    add hl, de
    add hl, de
    add hl, de
    
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld [W_MainScript_TextBank], a
    
    ld l, c
    ld h, 0
    sla l
    rl h
    add hl, de
    call MainScript_Jump2Operand
    
    call Status_ExpandNumericalTiles
    
    xor a
    ld [W_MainScript_TilesDrawn], a
    ld [W_MainScript_NumNewlines], a
    ld [W_MainScript_WaitFrames], a
    ld [W_MainScript_ContinueBtnPressed], a
    ld [W_MainScript_VWFMainScriptHack], a
    inc a
    ld [W_MainScript_TextSpeed], a
    ld [W_MainScript_State], a
    inc a
    ld [$CADA], a
    
    nop
    nop
    nop
    nop
    nop
    
    ret

SECTION "Main Script Shop Item Window 4", ROMX[$49E6], BANK[$B]
MainScript_DrawEmptyShopWindow::
    call MainScript_LoadWindowBorderTileset
    call MainScript_ClearTilesShopWindow
    
    ld de, MainScript_ShopWindowBorder
    ld b, 4
    ld a, [W_MainScript_WindowLocation]
    ld c, 0
    call MainScript_DrawWindowBorder
    ret

.mystery
    ret

SECTION "Main Script Shop Item Window 5", ROMX[$4A0F], BANK[$B]
MainScript_DrawQuantity::
    ld a, b
    ld hl, $CDBC
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld a, [hl]
    cp 100
    jr c, .decimalize
.valueCap
    ld a, 99
    
.decimalize
    call MainScript_DrawQuantity_Prepare
    
    ld a, $C7
    ld hl, $8C80
    call MainScript_DrawLetter
    
    ld a, [W_GenericRegPreserve]
    swap a
    and $F
    add a, $BB
    ld hl, $8C90
    call MainScript_DrawLetter
    
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $BB
    ld hl, $8CA0
    call MainScript_DrawQuantity_Finalise
    
    ret
    
SECTION "Main Script Shop Item Window 5 Quantity Fix", ROMX[$7EA0], BANK[$B]
MainScript_DrawQuantity_Prepare::
    call Status_DecimalizeStatValue
    ld a,1
    ld [W_MainScript_VWFDisable],a
    ret
    
MainScript_DrawQuantity_Finalise::
    call MainScript_DrawLetter
    xor a
    ld [W_MainScript_VWFDisable],a
    ret