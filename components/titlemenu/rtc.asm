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
    
    cp 0
    jr nz, .writeRTC
    
    jr .exitSram
	 
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    
.writeRTC
    ld a, 8
    ld [REG_MBC3_SRAMBANK], a
    xor a
    ld [$A000], a
    
    nop
    nop
    nop
    nop
    
    ld a, 9
    ld [REG_MBC3_SRAMBANK], a
    ld a, [W_SaveClock_RealTimeMinutes]
    ld [$A000], a
    
    nop
    nop
    nop
    nop
    
    ld a, $A
    ld [REG_MBC3_SRAMBANK], a
    ld a, [W_SaveClock_RealTimeHours]
    ld [$A000], a
    
    nop
    nop
    nop
    nop
    
    ld a, $B
    ld [REG_MBC3_SRAMBANK], a
    ld a, [W_SaveClock_RealTimeDays]
    ld [$A000], a
    
    nop
    nop
    nop
    nop
    
    ld a, $C
    ld [REG_MBC3_SRAMBANK], a
    ld a, [W_SaveClock_RealTimeDays + 1]
    ld [$A000], a
    
.exitSram
    jp TitleMenu_ExitSRAM
    
TitleMenu_LoadRTCValues::
    M_AuxJmp Banked_TitleMenu_ADVICE_LoadRTCValues
    jp TitleMenu_ExitSRAM
    
    ;TODO: Free space for the rest of this symbol!
    nop
    
    xor a
    ld [REG_MBC3_RTCLATCH], a
    ld a, 1
    ld [REG_MBC3_RTCLATCH], a
    
.readRTC
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
    
.exitSram
    jp TitleMenu_ExitSRAM

SECTION "Title Menu Advice Block", ROMX[$4280], BANK[$1]
TitleMenu_ADVICE_LoadRTCValues::
    M_AdviceSetup
    
;This function opens SRAM, and latches RTC for us.
    call SaveClock_ADVICE_ValidateRTCFunctionInternal
    
    cp 0
    jp z, .rtcNotPresent
    
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