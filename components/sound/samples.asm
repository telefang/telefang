INCLUDE "registers.inc"

;Play a sample through CH1 and 2.
;Sample data exists at [DE] for BC samples as 4-bit packed data.

SECTION "Sound Sample Data Functions", ROM0[$38CA]
Sound_PlaySample:
    ld a, $80
    ld [REG_NR52], a ;Enable sound, disable all channels
    ld a, $77
    ld [REG_NR50], a ;Disable cart audio, full volume elsewhere
    ld a, $FF
    ld [REG_NR51], a ;Route both channels to left and right output
    ld a, 0
    ld [REG_NR10], a ;Disable CH1 sweep
    ld a, $80
    ld [REG_NR11], a
    ld [REG_NR21], a ;50% duty cycle, zero length
    ld a, $FF
    ld [REG_NR13], a
    ld [REG_NR23], a
    ld a, $78
    ld [REG_NR12], a
    ld [REG_NR22], a ;Envelope 0xFF, sweep disabled
    ld a, $87
    ld [REG_NR14], a
    ld [REG_NR24], a ;Frequency 0x2FF, consecutive mode
    
.pcmLoop:
    ld a, [de]
    and $F0
    or 8
    call Sound_CycleDelay
    ld [REG_NR12], a
    ld [REG_NR22], a
    ld a, 0
    ld [REG_NR13], a
    ld [REG_NR23], a
    ld a, $80
    ld [REG_NR14], a
    ld [REG_NR24], a
    dec bc
    ld a, c
    or b
    ret z
    ld a, [de]
    sla a
    sla a
    sla a
    sla a
    or 8
    nop
    nop
    nop
    call Sound_CycleDelay
    ld [REG_NR12], a
    ld [REG_NR22], a
    ld a, 0
    ld [REG_NR13], a
    ld [REG_NR23], a
    ld a, $80
    ld [REG_NR14], a
    ld [REG_NR24], a
    dec bc
    ld a, c
    or b
    ret z
    inc de
    jr .pcmLoop
    
Sound_CycleDelay:
    push hl
    pop hl
    nop
    nop
    nop
    nop
    ret