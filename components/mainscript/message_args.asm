INCLUDE "telefang.inc"

SECTION "MainScript Message Argument Buffers", WRAMX[$D6A0], BANK[$1]
W_MainScript_MessageArg1:: ds M_MainScript_MessageArg1Size

SECTION "MainScript Message Argument Buffers 2", WRAMX[$D658], BANK[$1]
W_MainScript_MessageArg2:: ds M_MainScript_MessageArg2Size
