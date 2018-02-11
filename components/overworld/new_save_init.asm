INCLUDE "telefang.inc"

SECTION "Overworld New Save Init Mem", WRAM0[$C900]
W_Overworld_State:: ds 1

;Actual init code is version specific.
;Go check versions/**/components/overworld/new_save_init.asm

SECTION "Overworld New Save Init Advice", ROMX[$70C9], BANK[$32]
Overworld_ADVICE_PropagateSavedRTC::
    ld a, [W_SaveClock_RealTimeSeconds]
    ld [W_Overworld_CurrentTimeSeconds], a
    
    ld a, [W_SaveClock_RealTimeMinutes]
    ld [W_Overworld_CurrentTimeMinutes], a
    
    ld a, [W_SaveClock_RealTimeHours]
    ld [W_Overworld_CurrentTimeHours], a
    
    call $30A7
    
    ret

Overworld_ADVICE_PropagateSavedRTC_END::