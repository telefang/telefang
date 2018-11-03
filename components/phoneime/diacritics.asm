SECTION "Phone IME Diacritics", ROMX[$73AB], BANK[$4]
PhoneIME_ApplyDiacritic::
    ld hl, .searchTable
    ld de, .replacementTable
    ld c, (.replacementTable - .searchTable)
    ld b, a
    
.searchLoop
    ld a, [hli]
    cp b
    jr z, .replacementFound
    
    inc de
    dec c
    jr nz, .searchLoop
    
.noReplacementFound
    ld a, b
    ret
    
.replacementFound
    ld a, [de]
    ret
    
;How this table works:
;   Any character match in searchTable corresponds to a replacement of the same
;   index in the replacement table. That's it.
;   To build chains of characters, just make a replacement for each character in
;   the chain.
.searchTable
    db $3D, $3E, $3F, $40, $41, $42, $43, $44
    db $45, $46, $47, $48, $49, $4A, $4B, $51
    db $52, $53, $1D, $54, $96, $97, $98, $7F
    db $99, $06, $07, $08, $09, $0A, $0B, $0C
    db $0D, $0E, $0F, $10, $11, $12, $13, $14
    db $1A, $1B, $1C, $1D, $1E, $7C, $7D, $7E
    db $7F, $80, $87, $88, $89, $8A, $8B, $8C
    db $8D, $8E, $8F, $90, $91, $92, $93, $94
    db $95, $9A, $9B, $9C, $84, $9D, $6D, $6E
    db $6F, $70, $71, $72, $73, $74, $75, $76
    db $77, $78, $79, $7A, $7B, $81, $82, $83
    db $84, $85
.replacementTable
    db $87, $88, $89, $8A, $8B, $8C, $8D, $8E
    db $8F, $90, $91, $92, $93, $94, $95, $96
    db $97, $98, $7F, $99, $9A, $9B, $9C, $84
    db $9D, $6D, $6E, $6F, $70, $71, $72, $73
    db $74, $75, $76, $77, $78, $79, $7A, $7B
    db $7C, $7D, $7E, $7F, $80, $81, $82, $83
    db $84, $85, $3D, $3E, $3F, $40, $41, $42
    db $43, $44, $45, $46, $47, $48, $49, $4A
    db $4B, $51, $52, $53, $1D, $54, $06, $07
    db $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
    db $10, $11, $12, $13, $14, $1A, $1B, $1C
    db $1D, $1E
