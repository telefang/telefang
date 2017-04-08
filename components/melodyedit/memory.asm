INCLUDE "telefang.inc"

SECTION "Melody Edit Variables", WRAM0[$CB65]
W_MelodyEdit_State:: ds 1
    ds 2 ;unknown
W_MelodyEdit_DataCount:: ds 1
W_MelodyEdit_CurrentPage:: ds 1

SECTION "Melody Edit Buffers", WRAMX[$D001], BANK[$1]
W_MelodyEdit_Tempo:: ds 1
W_MelodyEdit_CurrentData:: ds M_MelodyEdit_CurrentDataLen