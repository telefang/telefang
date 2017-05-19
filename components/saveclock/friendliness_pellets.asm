INCLUDE "telefang.inc"

W_SaveClock_SelectedDenjuu EQU $CAFD

SECTION "SaveClock FD Manip", ROMX[$4DBB], BANK[$29]
SaveClock_IncrementFD::
    push bc
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, 2
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuFriendship
    ld a, [W_SaveClock_SelectedDenjuu]
    ld c, a
    ld b, 0
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    
    ld a, [hl]
    bit 7, e
    jr nz, .subtractFd
    
.addFd
    add a, e
    db $30, $30 ;jr nc, SaveClock_ADVICE_FDRollover
    
.saturateFdPos
    ld a, $64
    jr SaveClock_IncrementFD_storeFd
    
.subtractFd
    add a, e
    jr c, SaveClock_IncrementFD_storeFd
    
.saturateFdNeg
    xor a
    
SaveClock_IncrementFD_storeFd::
    ld [hl], a
    ld c, a
    ld a, [$C20B]
    ld b, a
    ld a, c
    sub b
    ld [$C20E], a
    
    ld a, 0
    ld [REG_MBC3_SRAMENABLE], a
    
    pop bc
    
    ret