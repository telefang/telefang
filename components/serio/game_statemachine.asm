INCLUDE "telefang.inc"

SECTION "Link Communications Game State Machine", ROMX[$4000], BANK[$1F]
SerIO_GameStateMachine::
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    
    ld a, [W_SystemSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl
    
.stateTable
    dw $4019, $401C, $401F, $4022
    dw $4025