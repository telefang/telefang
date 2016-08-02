SECTION "String Table Bank Functions", ROM0[$0548]
StringTable_LoadDenjuuName::
    call PatchUtils_LoadDenjuuName_Bankswitch
    call StringTable_LoadFromROMTbl8
    rst $18
    ret
    
;Mystery table
    ld a, $78
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