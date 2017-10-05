SECTION "Phone IME Diacritics", ROMX[$73AB], BANK[$4]
PauseMenu_PhoneIMEApplyDiacritic::
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
    db $41, $85, $80, $8F, $8A ; AÀÁÂÄA
    db $45, $86, $81, $90, $8B ; EÈÉÊËE
    db $49, $87, $82, $91, $8C ; IÌÍÎÏI
    db $4F, $88, $83, $92, $8D ; OÒÓÔÖO
    db $55, $89, $84, $93, $8E ; UÙÚÛÜU
    db $61, $A5, $A0, $AF, $AA ; aàáâäa
    db $65, $A6, $A1, $B0, $AB ; eèéêëe
    db $69, $A7, $A2, $B1, $AC ; iìíîïi
    db $6F, $A8, $A3, $B2, $AD ; oòóôöo
    db $75, $A9, $A4, $B3, $AE ; uùúûüu
    db $59, $94 ; YŸY
    db $43, $95 ; CÇC
    db $4E, $96 ; NÑN
    db $79, $B4 ; yÿy
    db $63, $B5 ; cçc
    db $6E, $B6 ; nñn
    db $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00
.replacementTable
    db $85, $80, $8F, $8A, $41 ; AÀÁÂÄA
    db $86, $81, $90, $8B, $45 ; EÈÉÊËE
    db $87, $82, $91, $8C, $49 ; IÌÍÎÏI
    db $88, $83, $92, $8D, $4F ; OÒÓÔÖO
    db $89, $84, $93, $8E, $55 ; UÙÚÛÜU
    db $A5, $A0, $AF, $AA, $61 ; aàáâäa
    db $A6, $A1, $B0, $AB, $65 ; eèéêëe
    db $A7, $A2, $B1, $AC, $69 ; iìíîïi
    db $A8, $A3, $B2, $AD, $6F ; oòóôöo
    db $A9, $A4, $B3, $AE, $75 ; uùúûüu
    db $94, $59 ; YŸY
    db $95, $43 ; CÇC
    db $96, $4E ; NÑN
    db $B4, $79 ; yÿy
    db $B5, $63 ; cçc
    db $B6, $6E ; nñn
    db $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00
