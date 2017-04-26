H_Sound_SampleSelect EQU $FFA9

dsample: MACRO
    db BANK(\1) ;Fragment bank
    dw \2 ;Sample count?
ENDM