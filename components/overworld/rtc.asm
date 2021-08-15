INCLUDE "telefang.inc"

SECTION "Overworld RTC Memory", WRAM0[$C939]
W_Overworld_CurrentTimeSeconds:: ds 1
W_Overworld_CurrentTimeMinutes:: ds 1
W_Overworld_CurrentTimeHours:: ds 1
W_Overworld_CurrentTimeDays:: ds 2
W_Overworld_ClockDisplay:: ds 1

SECTION "Overworld RTC", ROMX[$5060], BANK[$29]
Overworld_ReadRTCTime::
    ld a, [W_FrameCounter]
    and 3
    ret nz
	; Continues into Overworld_ReadRTCTime_Unconditional
    
Overworld_ReadRTCTime_Unconditional::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, 0
    ld [REG_MBC3_RTCLATCH], a
    ld a, 1
    ld [REG_MBC3_RTCLATCH], a
    
    ld a, 8
    ld [REG_MBC3_SRAMBANK], a
    nop
    nop
    ld a, [$A000]
    ld [W_Overworld_CurrentTimeSeconds], a
    
    ld a, 9
    ld [REG_MBC3_SRAMBANK], a
    nop
    nop
    ld a, [$A000]
    ld [W_Overworld_CurrentTimeMinutes], a
    
    ld a, $A
    ld [REG_MBC3_SRAMBANK], a
    nop
    nop
    ld a, [$A000]
    ld [W_Overworld_CurrentTimeHours], a
    
    ld a, $B
    ld [REG_MBC3_SRAMBANK], a
    nop
    nop
    ld a, [$A000]
    ld [W_Overworld_CurrentTimeDays], a
    
    ld a, $C
    ld [REG_MBC3_SRAMBANK], a
    nop
    nop
    ld a, [$A000]
    and 1
    ld [W_Overworld_CurrentTimeDays + 1], a
    
    ld a, 0
    ld [REG_MBC3_SRAMENABLE], a
    ret

SECTION "Calculate New Messages Via RTC", ROMX[$53AE], BANK[$29]
Overworld_CalculateNumNewMessages::
    ld a, [W_Overworld_CurrentTimeDays + 1]
    ld b, a
    ld a, [W_Overworld_CurrentTimeDays]
    ld c, a
    ld de, 24
    call System_Multiply16
    ld a, [W_Overworld_CurrentTimeHours]
    ld l, a
    ld h, 0
    add hl, de
    push hl
    call Overworld_ReadRTCTime_Unconditional
    ld a, [W_Overworld_CurrentTimeDays + 1]
    ld b, a
    ld a, [W_Overworld_CurrentTimeDays]
    ld c, a
    ld de, 24
    call System_Multiply16
    ld a, [W_Overworld_CurrentTimeHours]
    ld l, a
    ld h, 0
    add hl, de
    pop bc
    ld a, b
    cpl
    ld b, a
    ld a, c
    cpl
    ld c, a
    inc bc
    add hl, bc
    ld b, h
    ld c, l
    ld de, 6
    ld a, $29
    ld [W_PreviousBank], a
    call $0628
    ld a, b
    or a
    jr z, .bSevenBitLimitNotExceeded
    ld c, $7F

.bSevenBitLimitNotExceeded
    ld a, c
    cp $80
    jr c, .cSevenBitLimitNotExceeded
    ld a, $7F

.cSevenBitLimitNotExceeded
    ld c, a
    call $30A7
    ld e, a
    call System_Multiply8
    ld a, $80
    add e
    ld e, a
    ld a, 0
    adc d
    ld d, a
    inc de
    ld a, d
    cp 5
    jr c, .limitNotExceeded
    ld a, 4

.limitNotExceeded
    ret
