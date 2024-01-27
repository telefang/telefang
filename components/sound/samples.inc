DEF HM_Sound_SampleSelect EQU $FFA9

MACRO dsample
    db BANK(\1) ;Fragment bank
    dw \2 ;Sample count?
ENDM