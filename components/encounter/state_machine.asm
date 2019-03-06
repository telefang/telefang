SECTION "Encounter State Machine", ROMX[$4000], BANK[$1C]
Encounter_GameStateMachine::
    ld a, [W_SystemSubState]
    ld hl, .table
    call System_IndexWordList
    jp hl
    
.table
    dw $4016,$4279,$427C,$427F,$428F,$429E