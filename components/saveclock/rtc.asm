INCLUDE "telefang.inc"

SECTION "SaveClock RTC Shadow", WRAM0[$C3CD]
W_SaveClock_RealTimeSeconds:: ds 1
W_SaveClock_RealTimeMinutes:: ds 1
W_SaveClock_RealTimeHours:: ds 1
W_SaveClock_RealTimeDays:: ds 2

SECTION "SaveClock RTC ADVICE Memory", WRAM0[$C3D2]
W_SaveClock_ADVICE_RTCCheckStatus:: ds 1

SECTION "SaveClock ADVICE - RTC Functional Validation", ROMX[$70A0], BANK[$1]
;This exists 'cause the function right below it was originally being called
;directly, despite not being banksafe.
SaveClock_ADVICE_ValidateRTCFunction::
    M_AdviceSetup
    
    call SaveClock_ADVICE_ValidateRTCFunctionInternal
    
    ld b, a
    M_AdviceTeardown
    ld a, b
    ret

;This code is called to check if a functional RTC circuit is installed.
;It checks for the presence of the save header in bank 8.
;If it's not present, we assume the RTC is active.
;Sets a = 0 if RTC functionality failed to validate.
;Sets a = 1 if RTC functionality does validate.

;W_Overworld_RTCDebug = 0 if sram bank 8 is unavailable.
;W_Overworld_RTCDebug = 1 if the first two bytes of the day register don't match.
;W_Overworld_RTCDebug = 2 if the day writing test resulted in mismatched bytes.
;W_Overworld_RTCDebug = 3 if the day writing test was successful and the rtc was confirmed.
;W_Overworld_RTCDebug = 4 if the day writing test failed and the 1 second waiting test timed out.
;W_Overworld_RTCDebug = 6 if the 1 second waiting test was successful and the rtc was confirmed.

SaveClock_ADVICE_ValidateRTCFunctionInternal::
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
    xor a
    ld [W_Overworld_RTCDebug], a
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
    call SaveClock_ADVICE_RTCValidation_LatchSeconds
    
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

SaveClock_ADVICE_RTCValidation_LatchDays::
    xor a
    ld [REG_MBC3_RTCLATCH], a
    inc a
    ld [REG_MBC3_RTCLATCH], a
    ld a, $B
    ld [REG_MBC3_SRAMBANK], a
    ret

SaveClock_ADVICE_RTCValidation_LatchSeconds::
    xor a
    ld [REG_MBC3_RTCLATCH], a
    inc a
    ld [REG_MBC3_RTCLATCH], a
    ld a, 8
    ld [REG_MBC3_SRAMBANK], a
    ret

;CAUTION: This increments the day counter and then later decrements it after the check. There is an infinitesimally small risk that the day might tick over during the check, leading to a lost day.
SaveClock_ADVICE_RTCExtendedValidation::
    ld hl, W_Overworld_RTCDebug
    inc [hl] ; 1
    push de
    call SaveClock_ADVICE_RTCValidation_LatchDays
    ld a, [$A000]
    ld e, a
    ld d, a
    ld a, [$A001]
    cp e
    jr nz, .checkrtcfail
    
    inc [hl] ; 2
    inc a
    ld [$A000], a
    call SaveClock_ADVICE_RTCValidation_LatchDays
    ld a, [$A001]
    ld b, a
    ld a, [$A000]
    cp b
    jr nz, .checkrtcfail
    
    inc [hl] ; 3
    cp e
    jr nz, .fixdays
    
    inc [hl] ; 4
    ld bc, $6700
    call SaveClock_ADVICE_RTCValidation_LatchSeconds
    ld a, [$A000]
    ld e, a

.loop
    call SaveClock_ADVICE_RTCValidation_LatchSeconds
    ld a, [$A000]
    cp e
    jr nz, .exitloop
    dec bc
    ld a, b
    or c
    jr nz, .loop
    jr .checkrtcfail

.exitloop
    inc [hl]
    inc [hl] ; 6

.fixdays
    call SaveClock_ADVICE_RTCValidation_LatchDays
    ld a, d
    ld [$A000], a
    ld a, M_SaveClock_ADVICE_RTCPresent
    pop de
    ret

.checkrtcfail
    ld a, M_SaveClock_ADVICE_RTCNotPresent
    pop de
    ret
