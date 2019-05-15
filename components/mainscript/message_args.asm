INCLUDE "telefang.inc"

SECTION "MainScript Message Argument Buffers", WRAMX[$D460], BANK[$1]
W_MainScript_MessageArg1:: ds M_MainScript_MessageArg1Size

SECTION "MainScript Message Argument Buffers 2", WRAMX[$D4B1], BANK[$1]
W_MainScript_MessageArg2:: ds 9 ; The size is actually M_MainScript_MessageArg2Size