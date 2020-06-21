SECTION "String Table Bank Functions", ROM0[$0548]
StringTable_LoadName75::
    call StringTable_ADVICE_LoadName75
    jp StringTable_LoadNameB.rst10
    
    nop
    nop
    
;This got relocated so the name is wrong but w/e
StringTable_LoadNameB::
    ld a, $78
    
.rst10
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

SECTION "StringTable ADVICE Functions", ROM0[$3FF1]
StringTable_ADVICE_LoadName75::
	ld a, h
	cp $40
	jr nz, .aboveHL
	ld a, l
	or a
	jr nz, .aboveHL
	ld a, $34
	ret
	
.aboveHL
	ld a, $75 ;Original Denjuu bank
	ret