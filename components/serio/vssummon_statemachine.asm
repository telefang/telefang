INCLUDE "telefang.inc"

SECTION "Link Comms Vs-Mode Summon Screen Machine", ROMX[$48F1], BANK[$1F]
SerIO_VsSummonStateMachine::
    ld a, [W_Battle_4thOrderSubState]
    cp $C
    jr z, .runSubstate
    cp $B
    jr z, .runSubstate
    
    call $461B
    
    ld a, [Malias_CmpSrcBank]
    or a
    jr z, .runSubstate
    
    ld c, M_Battle_MessageConnectionError
    call Battle_QueueMessage
    
    ld a, $C
    ld [W_Battle_4thOrderSubState], a
    
.runSubstate
    ld a, [W_Battle_4thOrderSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl
    
.stateTable
    dw $4947,$4B81,$4BBE,$4BD4
    dw $4BE4,$4E4E,$4E84,$4EA1
    dw $4EB5,$512F,$513C,$51D3
    dw $4FBD,$4FD9,$5085,$5066
    dw $51ED,$4F96,$4AAA

SerIO_VsSummonPrivateString_Page::
;"リスト" - $493F
    db $28, $0D, $14, 0, 0
    
SerIO_VsSummonPrivateString_Separator::
;"/" - $4944
    db $CB, 0, 0