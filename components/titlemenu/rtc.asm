INCLUDE "telefang.inc"

SECTION "Title Menu RTC Handlers", ROMX[$6A4E], BANK[$4]
TitleMenu_ResetRTC::
    ld de, W_SaveClock_RealTimeSeconds
    
.rtcClearLoop
    xor a
    ld [de], a
    
    inc e
    ld a, e
    cp a, $D2
    jr nz,.rtcClearLoop
    ret
    
    nop
    nop
    nop
    nop
    nop

TitleMenu_StoreRTCValues::
    M_AuxJmp Banked_SaveClock_ADVICE_ValidateRTCFunction
    
    or a
    jr z, .exitSram
    
.writeRTC
    ld b, $C
    ld a, $40 ; Halt flag.
    call .writeToRTCCommon

    ld b, 8
    xor a
    call .writeToRTCCommon
    
    inc b
    ld a, [W_SaveClock_RealTimeMinutes]
    call .writeToRTCCommon
    
    inc b
    ld a, [W_SaveClock_RealTimeHours]
    call .writeToRTCCommon
    
    inc b
    xor a
    call .writeToRTCCommon
    
    inc b
    call .writeToRTCCommon
    
    ld b, 0
    call .writeToRTCCommon
    
    inc b
    call .writeToRTCCommon
    
    inc b
    call .writeToRTCCommon
    
    inc b
    call .writeToRTCCommon
    
.exitSram
    jr TitleMenu_ADVICE_CopyNewlySetTime

.writeToRTCCommon
    nop
    ld c, a
    ld a, b
    ld [REG_MBC3_SRAMBANK], a
    nop
    nop
    nop
    nop
    ld a, c
    ld [$B000], a
    ret

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
    
TitleMenu_LoadRTCValues::
    M_AuxJmp Banked_TitleMenu_ADVICE_LoadRTCValues
    jp TitleMenu_ExitSRAM
    
TitleMenu_ADVICE_CopyNewlySetTime::
    xor a
    ld [W_Overworld_CurrentTimeSeconds], a
    ld [W_Overworld_CurrentTimeDays], a
    ld [W_Overworld_CurrentTimeDays + 1], a
    ld a, [W_SaveClock_RealTimeMinutes]
    ld [W_Overworld_MinutesOnLoad], a
    ld [W_Overworld_CurrentTimeMinutes], a
    ld a, [W_SaveClock_RealTimeHours]
    ld [W_Overworld_HoursOnLoad], a
    ld [W_Overworld_CurrentTimeHours], a
    jp TitleMenu_ExitSRAM

    ;Note: Free space.
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

SECTION "Title Menu Advice Block", ROMX[$4290], BANK[$1]
TitleMenu_ADVICE_LoadRTCValues::
    M_AdviceSetup
    
;This function opens SRAM, and latches RTC for us.
    call SaveClock_ADVICE_ValidateRTCFunctionInternal
    
    or a
    jr z, .rtcNotPresent
    
.rtcPresent
    ld a, 8
    ld [REG_MBC3_SRAMBANK], a
    ld a, [$A000]
    ld [W_SaveClock_RealTimeSeconds], a
    
    ld a, 9
    ld [REG_MBC3_SRAMBANK], a
    ld a, [$A000]
    ld [W_SaveClock_RealTimeMinutes], a
    
    ld a, $A
    ld [REG_MBC3_SRAMBANK], a
    ld a, [$A000]
    ld [W_SaveClock_RealTimeHours], a
    jp .ret
    
;If there's no RTC we need to load the emulated RTC values.
.rtcNotPresent
    ld a, [W_Overworld_CurrentTimeSeconds]
    ld [W_SaveClock_RealTimeSeconds], a
    
    ld a, [W_Overworld_CurrentTimeMinutes]
    ld [W_SaveClock_RealTimeMinutes], a
    
    ld a, [W_Overworld_CurrentTimeHours]
    ld [W_SaveClock_RealTimeHours], a
    
.ret
    M_AdviceTeardown
    ret
TitleMenu_ADVICE_LoadRTCValues_END::