SECTION "Banked Call Helper WRAM", WRAM0[$CB26]
W_System_BankedArg: ds 1

SECTION "Banked Call Helpers 0", ROM0[$04B1]
Banked_LoadMaliasGraphics::
    call LoadMaliasGraphics
    rst $18
    ret

Banked_CGBLoadBackgroundPalette::
    call CGBLoadBackgroundPalette
    rst $18
    ret

Banked_CGBLoadObjectPalette::
    call CGBLoadObjectPalette
    rst $18
    ret

Banked_SGBLoadPalette::
    push af
    ld a, 3
    rst $10
    pop af
    call $4320
    rst $18
    ret

Banked_RLEDecompressTMAP0::
    ld [W_System_BankedArg], a
    ld a, [W_CurrentBank]
    push af
    ld a, [W_System_BankedArg]
    call RLEDecompressTMAP0
    pop af
    rst $10
    ret

Banked_RLEDecompressAttribsTMAP0::
    ld [W_System_BankedArg], a
    ld a, [W_CurrentBank]
    push af
    ld a, [W_System_BankedArg]
    call RLEDecompressAttribsTMAP0
    pop af
    rst $10
    ret

Banked_RLEDecompressAttribsTMAP1::
    ld [W_System_BankedArg], a
    ld a, [W_CurrentBank]
    push af
    ld a, [W_System_BankedArg]
    call RLEDecompressAttribsTMAP1
    pop af
    rst $10
    ret

Banked_RLEDecompressTMAP1::
    ld [W_System_BankedArg], a
    ld a, [W_CurrentBank]
    push af
    ld a, [W_System_BankedArg]
    call RLEDecompressTMAP1
    pop af
    rst $10
    ret

SECTION "Banked Call Helpers", ROM0[$0560]
Banked_MainScript_DrawStatusText::
    call MainScript_DrawStatusText
    rst $18
    ret

SECTION "Banked Call Helpers 2", ROM0[$0620]
Banked_LoadBattlePhrase:
    ld a, $75 ;Symbolic representation of bank suspended until disassembly
              ;of battle system
    rst $10
    call StringTable_LoadBattlePhrase
    rst $18
    ret
    
SECTION "Banked Call Helpers 3", ROM0[$2FC7]
Banked_MainScript_DrawLetter::
    push af
    ld a, [W_CurrentBank]
    ld [W_LCDC_LastBank], a
    ld a, $B
    rst $10
    pop af
    call MainScript_DrawLetter
    ld a, [W_LCDC_LastBank]
    rst $10
    ret