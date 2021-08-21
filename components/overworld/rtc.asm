INCLUDE "telefang.inc"

SECTION "RTC Time On Save Load Tracking", WRAM0[$C7D0]
W_Overworld_HoursOnLoad:: ds 2
W_Overworld_MinutesOnLoad:: ds 1

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

SECTION "Calculate New Messages Via RTC", ROMX[$53AE], BANK[$29]
Overworld_CalculateNumNewMessages::
    call Overworld_ADVICE_GetRTCHoursForNewMessages
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

; Note: Free space.
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    
SECTION "Overworld RTC-Free IRQ Memory", WRAM0[$C7CB]
W_Overworld_ADVICE_CurrentTimeFrames:: ds 1

SECTION "Overworld RTC Advice", ROMX[$78FB], BANK[$29]
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
    jp c, Overworld_ReadRTCTime_Unconditional.comefromAdvice
    sub 24
    jp .hoursBound
Overworld_ADVICE_ReadRTCTime_paletteFix_END::

Overworld_ADVICE_PowerAntennaIRQTask::
    call Overworld_DrivePowerAntennaPattern
    
    ;Emulate RTC operation.
    ld a, [W_SaveClock_ADVICE_RTCCheckStatus]
    dec a
    ret nz

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

SECTION "Overworld RTC Advice 2", ROMX[$7C13], BANK[$29]
Overworld_ADVICE_GetRTCHoursForNewMessages::
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
    ld de, W_Overworld_HoursOnLoad

    ld a, [W_SaveClock_ADVICE_RTCCheckStatus]
    dec a
    jr z, .nortc

.rtc
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ld a, [W_Overworld_CurrentTimeMinutes]
    ld [de], a
    pop bc
    ret

.nortc
    ; Instead of measuring hours since the game was last saved we will measure the number of minutes of the last play session divided by approximately 4.

    ld a, [de]
    ld c, a
    ld a, l
    ld [de], a
    inc de
    ld a, [de]
    ld b, a
    ld a, h
    ld [de], a
    inc de
    ld a, [de]
    ld h, a
    ld a, [W_Overworld_CurrentTimeMinutes]
    ld [de], a
    ld d, 0
    ld e, h
    srl e
    srl e
    ld h, b
    ld l, c
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, de
    ld b, h
    ld c, l
    pop hl
    ld a, [W_Overworld_CurrentTimeMinutes]
    ld d, 0
    ld e, a
    srl e
    srl e
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, de
    ret
