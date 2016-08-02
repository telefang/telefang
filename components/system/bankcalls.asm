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
    ld [$CA52], a
    ld a, $B
    rst $10
    pop af
    call MainScript_DrawLetter
    ld a, [$CA52]
    rst $10
    ret