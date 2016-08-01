SECTION "Banked Call Helpers", ROM0[$0620]
Banked_LoadBattlePhrase:
    ld a, $75 ;Symbolic representation of bank suspended until disassembly
              ;of battle system
    rst $10
    call StringTable_LoadBattlePhrase
    rst $18
    ret