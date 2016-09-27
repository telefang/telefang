;Ugh. Why do I gotta do this??
IMPORT StringTable_denjuu_species

SECTION "String Table Bank Functions", ROM0[$0548]
StringTable_LoadDenjuuName::
    ld a, BANK(StringTable_denjuu_species)
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
    
StringTable_LoadShortName::
    ld a, BANK(StringTable_denjuu_species)
    rst $10
    call StringTable_LoadFromROMTbl4
    rst $18
    ret