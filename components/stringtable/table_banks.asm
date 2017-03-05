;Ugh. Why do I gotta do this??
IMPORT StringTable_battle_tfangers

SECTION "String Table Bank Functions", ROM0[$0548]
StringTable_LoadName75::
    call PatchUtils_LoadDenjuuName_Bankswitch
    call StringTable_LoadFromROMTbl8
    rst $18
    ret
    
;This got relocated so the name is wrong but w/e
StringTable_LoadNameB::
    ld a, $78
    rst $10
    call StringTable_LoadFromROMTbl8
    rst $18
    ret
    
StringTable_LoadShortName::
    ld a, BANK(StringTable_battle_tfangers)
    rst $10
    call StringTable_LoadFromROMTbl4
    rst $18
    ret