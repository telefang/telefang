SECTION "Phone IME button mapping data", ROMX[$680D], BANK[$4]
PhoneIME_Data::
    dw .latinUpperTable
    dw .latinLowerTable
    dw .numeralsTable
    
.latinLowerTable
    dw .latinLowerButton1
    dw .latinLowerButton2
    dw .latinLowerButton3
    dw .latinLowerButton4
    dw .latinLowerButton5
    dw .latinLowerButton6
    dw .latinLowerButton7
    dw .latinLowerButton8
    dw .latinLowerButton9
    dw .latinLowerButtonStar
    dw .latinLowerButton0
    dw .latinLowerButtonPound
    
.latinLowerButton1
    db 9, ".,:;'", $22, "!?", "-"
.latinLowerButton2
    db 3, "abc"
.latinLowerButton3
    db 3, "def"
.latinLowerButton4
    db 3, "ghi"
.latinLowerButton5
    db 3, "jkl"
.latinLowerButton6
    db 3, "mno"
.latinLowerButton7
    db 4, "pqrs"
.latinLowerButton8
    db 3, "tuv"
.latinLowerButton9
    db 4, "wxyz"
.latinLowerButtonStar
    db $FF
.latinLowerButton0
    db 1, $20, $C5, $C6, $C7, $C9, $CA, $CC
.latinLowerButtonPound
    db 6, "<>()[]"
    
.latinUpperTable
    dw .latinUpperButton1
    dw .latinUpperButton2
    dw .latinUpperButton3
    dw .latinUpperButton4
    dw .latinUpperButton5
    dw .latinUpperButton6
    dw .latinUpperButton7
    dw .latinUpperButton8
    dw .latinUpperButton9
    dw .latinUpperButtonStar
    dw .latinUpperButton0
    dw .latinUpperButtonPound
    
.latinUpperButton1
    db 9, ".,:;'", $22, "!?", "-"
.latinUpperButton2
    db 3, "ABC"
.latinUpperButton3
    db 3, "DEF"
.latinUpperButton4
    db 3, "GHI"
.latinUpperButton5
    db 3, "JKL"
.latinUpperButton6
    db 3, "MNO"
.latinUpperButton7
    db 4, "PQRS"
.latinUpperButton8
    db 3, "TUV"
.latinUpperButton9
    db 4, "WXYZ"
.latinUpperButtonStar
    db $FF
.latinUpperButton0
    db 1, $20, $C5, $C6, $C7, $C9, $CA, $CC ;space, arrows, and 「」
.latinUpperButtonPound
    db 6, "<>()[]"

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
    db $6, "*+-%$="
.numeralsButton0
    db 1
    db $BB
.numeralsButtonPound
    db $5, "#_/|\\"