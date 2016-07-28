SECTION "String Table Bank Functions", ROM0[$0548]
StringTable_LoadDenjuuName:
    ld a, $75
    rst $10
    call StringTable_LoadFromROMTbl8
    rst $18
    ret
    
;Mystery table
    ld a, $B
    rst $10
    call StringTable_LoadFromROMTbl8
    rst $18
    ret
    
;Mystery table
    ld a, $75
    rst $10
    call StringTable_LoadFromROMTbl4
    rst $18
    ret