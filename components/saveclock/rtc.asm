INCLUDE "telefang.inc"

SECTION "SaveClock RTC Shadow", WRAM0[$C3CD]
W_SaveClock_RealTimeSeconds:: ds 1
W_SaveClock_RealTimeMinutes:: ds 1
W_SaveClock_RealTimeHours:: ds 1
W_SaveClock_RealTimeDays:: ds 2

SECTION "SaveClock RTC ADVICE Memory", WRAM0[$C3D2]
W_SaveClock_ADVICE_RTCCheckStatus:: ds 1

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
    inc a
    ld [REG_MBC3_RTCLATCH], a
    
    nop
    nop
    nop
    nop
    
;If we've already checked the RTC, don't check it again.
    ld a, [W_SaveClock_ADVICE_RTCCheckStatus]
    and a ;equivalent to cp 0, but less clocks/faster
    jp nz, .returnRTCStatus

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
    jr nz, .copyLoop
    
;Check for presence of the save header in RAM bank 8.
;This check will fail on large-RAM carts, in which case run the extended check.
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
    ld a, M_SaveClock_ADVICE_RTCNotPresent
    jr .storeRTCStatus
    
.ramBanksDifferent
    call SaveClock_ADVICE_RTCExtendedValidation
    
.storeRTCStatus
    ld [W_SaveClock_ADVICE_RTCCheckStatus], a
    
.returnRTCStatus
    dec a
    
    pop bc
    pop de
    pop hl
    
    ret

SaveClock_ADVICE_ValidateRTCFunction_END::

;CAUTION: This increments the day counter.
SaveClock_ADVICE_RTCExtendedValidation::
    push de
    push af
    
    ld d, M_SaveClock_ADVICE_RTCPresent
    
    ld a, $B
    ld [REG_MBC3_SRAMBANK], a
    ld a, [$A000]
    ld e, a
    ld a, [$A001]
    
    cp e
    jp nz,.checkrtcdayfail
    
    inc a
    ld [$A000], a
    nop
    nop
    nop
    nop
    
    ld a, $B
    ld [REG_MBC3_SRAMBANK], a
    nop
    nop
    nop
    nop
    
    ld a, [$A000]
    ld e, a
    ld a, [$A001]
    cp e
    
    jp z, .checkrtcdaysuccess

.checkrtcdayfail
    ld d, M_SaveClock_ADVICE_RTCNotPresent

.checkrtcdaysuccess
    pop af
    ld a, d
    pop de
    ret

SaveClock_ADVICE_RTCExtendedValidation_END::
