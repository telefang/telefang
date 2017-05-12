INCLUDE "telefang.inc"

SECTION "Overworld RTC Memory", WRAM0[$C939]
W_Overworld_CurrentTimeSeconds:: ds 1
W_Overworld_CurrentTimeMinutes:: ds 1
W_Overworld_CurrentTimeHours:: ds 1
W_Overworld_CurrentTimeDays:: ds 2

SECTION "Overworld RTC", ROMX[$5060], BANK[$29]
Overworld_ReadRTCTime::
    ld a, [W_FrameCounter]
    and 3
    ret nz
    
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
    ld [W_Overworld_CurrentTimeDays + 1], a
    
    ld a, 0
    ld [REG_MBC3_SRAMENABLE], a
    ret