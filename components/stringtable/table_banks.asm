;Ugh. Why do I gotta do this??
IMPORT MainScript_denjuu_species

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
    
StringTable_LoadShortName::
    ld a, BANK(MainScript_denjuu_species)
    rst $10
    call StringTable_LoadFromROMTbl4
    rst $18
    ret