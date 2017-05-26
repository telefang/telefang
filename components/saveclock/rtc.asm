INCLUDE "telefang.inc"

SECTION "SaveClock RTC Shadow", WRAM0[$C3CD]
W_SaveClock_RealTimeSeconds:: ds 1
W_SaveClock_RealTimeMinutes:: ds 1
W_SaveClock_RealTimeHours:: ds 1
W_SaveClock_RealTimeDays:: ds 2