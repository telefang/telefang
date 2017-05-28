INCLUDE "telefang.inc"

SECTION "SaveClock RTC Shadow", WRAM0[$C3CD]
W_SaveClock_RealTimeSeconds:: ds 1
W_SaveClock_RealTimeMinutes:: ds 1
W_SaveClock_RealTimeHours:: ds 1
W_SaveClock_RealTimeDays:: ds 2

SECTION "SaveClock ADVICE - RTC Functional Validation", ROMX[$4140], BANK[$1]
;This code is called to check if a functional RTC circuit is installed.
;It checks for the presence of the save header in bank 8.
;If it's not present, we assume the RTC is active.
;Sets a = 0 if RTC functionality failed to validate.
;Sets a = 1 if RTC functionality does validate.
SaveClock_ADVICE_ValidateRTCFunction::
    push hl
    push de
    push bc
    
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
    
;Ensure at least part of the save header is present.
;We don't copy all of it because it's also used to check save validity.
;Eight bytes should be enough to check.
    ld a, 0
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, $0F61
    ld de, $A000
    ld b, $8
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jp nz, .copyLoop
    
;Check for presence of the save header in RAM bank 8.
;I don't believe there's a cart with more than 8 RAM banks.
;If there is, this check won't work.
    ld a, 8
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, $0F61
    ld de, $A000
    ld b, $8
    
.cmpLoop
    ld a, [de]
    ld c, [hl]
    
    cp c
    jr nz, .ramBanksDifferent
    
    inc hl
    inc de
    dec b
    jr nz, .cmpLoop
    
.ramBanksSame
    ld a, 0
    jr .cleanup

.ramBanksDifferent
    ld a, 1
    
.cleanup
    pop bc
    pop de
    pop hl
    
    ret

SaveClock_ADVICE_ValidateRTCFunction_END::