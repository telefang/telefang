INCLUDE "telefang.inc"

SECTION "Title Menu RTC Handlers", ROMX[$6A4E], BANK[$4]
TitleMenu_ResetRTC::
    xor a
    ld [W_SaveClock_RealTimeSeconds], a
    ld [W_SaveClock_RealTimeMinutes], a
    ld [W_SaveClock_RealTimeHours], a
    ld [W_SaveClock_RealTimeDays], a
    ld [W_SaveClock_RealTimeDays + 1], a
    ret

TitleMenu_StoreRTCValues::
    ld a, Banked_TitleMenu_ADVICE_StoreRTCValues & $FF
    call TitleMenu_ADVICE_StoreRTCValues
    
    xor a
    ld [REG_MBC3_RTCLATCH], a
    ld a, 1
    ld [REG_MBC3_RTCLATCH], a
    
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
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    xor a
    ld [REG_MBC3_RTCLATCH], a
    ld a, 1
    ld [REG_MBC3_RTCLATCH], a
    
    nop
    nop
    nop
    nop
    
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
    
    jp TitleMenu_ExitSRAM

SECTION "Title Menu Advice Block", ROMX[$41A0], BANK[$1]
TitleMenu_ADVICE_StoreRTCValues::
    pop hl
    pop hl
    
;This function opens SRAM, and latches RTC for us.
    call SaveClock_ADVICE_ValidateRTCFunction
    
    cp 0
    jp z, .rtcNotPresent
    
;For both return paths we need to falsify stack values.
.rtcPresent
    ld hl, TitleMenu_StoreRTCValues.writeRTC
    push hl
    
    jp .ret
    
.rtcNotPresent
    ld hl, TitleMenu_StoreRTCValues.exitSram
    push hl
    
.ret
    ld hl, PatchUtils_AuxCodeJmp_returnVec
    push hl
    
    ret
    
TitleMenu_ADVICE_StoreRTCValues_END