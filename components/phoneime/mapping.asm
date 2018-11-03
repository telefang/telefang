SECTION "Phone IME button mapping data", ROMX[$680D], BANK[$4]
PhoneIME_Data::
    dw .hiraganaTable
    dw .katakanaTable
    dw .numeralsTable
    
.hiraganaTable
    dw .hiraganaButton1
    dw .hiraganaButton2
    dw .hiraganaButton3
    dw .hiraganaButton4
    dw .hiraganaButton5
    dw .hiraganaButton6
    dw .hiraganaButton7
    dw .hiraganaButton8
    dw .hiraganaButton9
    dw .hiraganaButtonStar
    dw .hiraganaButton0
    dw .hiraganaButtonPound
    
.hiraganaButton1
    db $A
    db $38, $39, $3A, $3B, $3C, $64, $65, $66, $67, $68

.hiraganaButton2
    db 5
    db $3D, $3E, $3F, $40, $41
    
.hiraganaButton3
    db 5
    db $42, $43, $44, $45, $46
    
.hiraganaButton4
    db 6
    db $47, $48, $49, $4A, $4B, $69
    
.hiraganaButton5
    db 5
    db $4C, $4D, $4E, $4F, $50
    
.hiraganaButton6
    db 5
    db $51, $52, $53, $1D, $54
    
.hiraganaButton7
    db 5
    db $55, $56, $57, $58, $59
    
.hiraganaButton8
    db 6
    db $5A, $5B, $5C, $6A, $6B, $6C
    
.hiraganaButton9
    db 5
    db $5D, $28, $5E, $5F, $60
    
.hiraganaButtonStar
    db $FF
    
.hiraganaButton0
    db 7
    db $61, $62, $63, $CD, $C8, $B9, $B8
    
.hiraganaButtonPound
    db $FF
    
.katakanaTable
    dw .katakanaButton1
    dw .katakanaButton2
    dw .katakanaButton3
    dw .katakanaButton4
    dw .katakanaButton5
    dw .katakanaButton6
    dw .katakanaButton7
    dw .katakanaButton8
    dw .katakanaButton9
    dw .katakanaButtonStar
    dw .katakanaButton0
    dw .katakanaButtonPound
    
.katakanaButton1
    db $A
    db 1, 2, 3, 4, 5, $2F, $30, $31, $32, $33
.katakanaButton2
    db 5
    db 6, 7, 8, 9, $A
.katakanaButton3
    db 5
    db $B, $C, $D, $E, $F
.katakanaButton4
    db 6
    db $10, $11, $12, $13, $14, $34
.katakanaButton5
    db 5
    db $15, $16, $17, $18, $19
.katakanaButton6
    db 5
    db $1A, $1B, $1C, $1D, $1E
.katakanaButton7
    db 5
    db $1F, $20, $21, $22, $23
.katakanaButton8
    db 6
    db $24, $25, $26, $35, $36, $37
.katakanaButton9
    db 5
    db $27, $28, $29, $2A, $2B
.katakanaButtonStar
    db $FF
.katakanaButton0
    db 7
    db $2C, $2D, $2E, $CD, $C8, $B9, $B8
.katakanaButtonPound
    db $FF

.numeralsTable
    dw .numeralsButton1
    dw .numeralsButton2
    dw .numeralsButton3
    dw .numeralsButton4
    dw .numeralsButton5
    dw .numeralsButton6
    dw .numeralsButton7
    dw .numeralsButton8
    dw .numeralsButton9
    dw .numeralsButtonStar
    dw .numeralsButton0
    dw .numeralsButtonPound
    
.numeralsButton1
    db 1
    db $BC
.numeralsButton2
    db 1
    db $BD
.numeralsButton3
    db 1
    db $BE
.numeralsButton4
    db 1
    db $BF
.numeralsButton5
    db 1
    db $C0
.numeralsButton6
    db 1
    db $C1
.numeralsButton7
    db 1
    db $C2
.numeralsButton8
    db 1
    db $C3
.numeralsButton9
    db 1
    db $C4
.numeralsButtonStar
    db $FF
.numeralsButton0
    db 1
    db $BB
.numeralsButtonPound
    db $FF