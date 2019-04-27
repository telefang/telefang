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

;   LATIN-1 notes: We use the following diacritic order.
;       a -> à -> á -> â -> ä -> ç -> ñ -> a
;   Missing diacritic forms for specific letters will be skipped in the cycle.
;   Other languages feel free to alter this order.
;   English doesn't really use diacritics anyway, it's mostly for completeness
;   sake.
.searchTable
    db $41, $85, $80, $8F, $97, $8A, $98 ; AÀÁÂÅÄÆA
    db $45, $86, $81, $90, $8B           ; EÈÉÊËE
    db $49, $87, $82, $91, $8C           ; IÌÍÎÏI
    db $4F, $88, $83, $92, $8D, $99, $9A ; OÒÓÔÖŒØO
    db $55, $89, $84, $93, $8E           ; UÙÚÛÜU
    db $61, $A5, $A0, $AF, $9D, $AA, $9E ; aàáâåäæa
    db $65, $A6, $A1, $B0, $AB, $1E      ; eèéêëěe
    db $69, $A7, $A2, $B1, $AC           ; iìíîïi
    db $6F, $A8, $A3, $B2, $AD, $9F, $9C ; oòóôöœøo
    db $75, $A9, $A4, $B3, $AE, $9B      ; uùúûüůu
    db $59, $94      ; YŸY
    db $43, $09, $95 ; CČÇC
    db $4E, $96      ; NÑN
    db $5A, $0A      ; ZŽZ
    db $52, $0B      ; RŘR
    db $53, $0C      ; SŠS
    db $79, $1F, $B4 ; yýÿy
    db $63, $19, $B5 ; cčçc
    db $6E, $B6      ; nñn
    db $7A, $1A      ; zžz
    db $72, $1B      ; rřr
    db $73, $1C      ; sšs
    db $00, $00, $00
.replacementTable
    db $85, $80, $8F, $97, $8A, $98, $41 ; AÀÁÂÅÄÆA
    db $86, $81, $90, $8B, $45           ; EÈÉÊËE
    db $87, $82, $91, $8C, $49           ; IÌÍÎÏI
    db $88, $83, $92, $8D, $99, $9A, $4F ; OÒÓÔÖŒØO
    db $89, $84, $93, $8E, $55           ; UÙÚÛÜU
    db $A5, $A0, $AF, $9D, $AA, $9E, $61 ; aàáâåäæa
    db $A6, $A1, $B0, $AB, $1E, $65      ; eèéêëěe
    db $A7, $A2, $B1, $AC, $69           ; iìíîïi
    db $A8, $A3, $B2, $AD, $9F, $9C, $6F ; oòóôöœo
    db $A9, $A4, $B3, $AE, $9B, $75      ; uùúûüůu
    db $94, $59      ; YŸY
    db $09, $95, $43 ; CČÇC
    db $96, $4E      ; NÑN
    db $0A, $5A      ; ZŽZ
    db $0B, $52      ; RŘR
    db $0C, $53      ; SŠS
    db $1F, $B4, $79 ; yýÿy
    db $19, $B5, $63 ; cčçc
    db $B6, $6E      ; nñn
    db $1A, $7A      ; zžz
    db $1B, $72      ; rřr
    db $1C, $73      ; sšs
    db $00, $00, $00
