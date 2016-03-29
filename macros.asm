dbw: MACRO
    db \1
    dw \2
ENDM

dbwb: MACRO
    dbw \1, \2
    db \3
ENDM
