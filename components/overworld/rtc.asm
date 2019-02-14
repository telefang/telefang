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
    
    M_AuxJmp Banked_SaveClock_ADVICE_ValidateRTCFunction

    cp 0
    jr z, .exitSram
    jr .readRTC
    nop
    nop
    nop
    
.readRTC
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
    
    push bc
    push af
    
    ld a, $A
    ld [REG_MBC3_SRAMBANK], a
    nop
    nop
    jp Overworld_ADVICE_ReadRTCTime_paletteFix
    
.comefromAdvice
    ld [W_Overworld_CurrentTimeHours], a
    
    pop bc ;Not unbalanced, advice code pops once.
    
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
    
.exitSram
    ld a, 0
    ld [REG_MBC3_SRAMENABLE], a
    ret
    
SECTION "Overworld RTC-Free IRQ Memory", WRAM0[$C7CB]
W_Overworld_ADVICE_CurrentTimeFrames:: ds 1

SECTION "Overworld RTC Advice", ROMX[$7900], BANK[$29]
;Emulator-compatibility fix for Visual Boy Advance, whose emulated RTC counts
;from 1-60 instead of 0-59. Notably this breaks palette loading, causing the
;entire game to white out at 2400-2460 hours (a nonexistent time)
Overworld_ADVICE_ReadRTCTime_paletteFix::
    ld a, [$A000] ;Expected pointcut is right after the hours have been latched
    ld b, a
    
    pop af ;These are minutes we pushed before the pointcut
    
.minutesBound
    cp 60
    jp c, .writeFixedMinutes
    sub 60
    inc b
    jp .minutesBound
    
.writeFixedMinutes
    ld [W_Overworld_CurrentTimeMinutes], a
    ld a, b
    
.hoursBound
    cp 24
    jp c, Overworld_ReadRTCTime.comefromAdvice
    sub 24
    jp .hoursBound
Overworld_ADVICE_ReadRTCTime_paletteFix_END::

Overworld_ADVICE_PowerAntennaIRQTask::
    call Overworld_DrivePowerAntennaPattern
    
    ;Emulate RTC operation.
    ;TODO: Is this code safe to run if an RTC is present?
    ld a, [W_Overworld_ADVICE_CurrentTimeFrames]
    inc a
    ld [W_Overworld_ADVICE_CurrentTimeFrames], a
    
    cp 60
    ret c
    
    xor a
    ld [W_Overworld_ADVICE_CurrentTimeFrames], a
    
    ld a, [W_Overworld_CurrentTimeSeconds]
    inc a
    ld [W_Overworld_CurrentTimeSeconds], a
    
    cp 60
    ret c
    
    xor a
    ld [W_Overworld_CurrentTimeSeconds], a
    
    ld a, [W_Overworld_CurrentTimeMinutes]
    inc a
    ld [W_Overworld_CurrentTimeMinutes], a
    
    cp 60
    ret c
    
    xor a
    ld [W_Overworld_CurrentTimeMinutes], a
    
    ld a, [W_Overworld_CurrentTimeHours]
    inc a
    ld [W_Overworld_CurrentTimeHours], a
    
    cp 24
    ret c
    
    xor a
    ld [W_Overworld_CurrentTimeHours], a
    
    ld a, [W_Overworld_CurrentTimeDays]
    inc a
    ld [W_Overworld_CurrentTimeDays], a
    ret nz
    
    ld a, [W_Overworld_CurrentTimeDays + 1]
    inc a
    and 1
    ld [W_Overworld_CurrentTimeDays + 1], a
    
    ret
Overworld_ADVICE_PowerAntennaIRQTask_END::