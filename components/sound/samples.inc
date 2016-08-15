H_Sound_SampleSelect EQU $FFA9

dsample: MACRO
    db BANK(\1) ;Fragment bank
    dw \2 ;Sample count?
    db \3 ;Unknown
    db \4 ;Unknown
ENDM