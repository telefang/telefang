INCLUDE "registers.inc"
INCLUDE "components/sound/samples.inc"

SECTION "Sound Sample Data WRAM", WRAM0[$CF8A]
W_Sound_SampleFragmentCount: ds 1

SECTION "Sound Sample Data Functions", ROM0[$3882]
Sound_PlaySample:
    push af
    push bc
    push de
    push hl
    xor a
    ld [REG_NR52], a ;Disable sound hardware, resetting all state
    call Sound_OpenSampleData
    
.fragmentLoop
    call Sound_PrepareSampleFragment
    call Sound_PlaySampleFragment
    ld a, [W_Sound_SampleFragmentCount]
    dec a
    ld [W_Sound_SampleFragmentCount], a
    jr nz, .fragmentLoop
    
    call Sound_ExitSampleMode
    pop hl
    pop de
    pop bc
    pop af
    ret

Sound_OpenSampleData:
    ld hl, Sound_SampleMetatable
    ld d, 0
    ld a, [H_Sound_SampleSelect]
    dec a
    ld e, a
    add hl, de
    add hl, de
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld h, a
    ld l, d
    ld a, [hl+]
    ld [W_Sound_SampleFragmentCount], a
    ret

;Assumes that your sample occupies the start of it's bank.
Sound_PrepareSampleFragment:
    ld a, [hl+]
    rst $10
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld de, $4000
    ld a, l
    ld [$CF8B], a
    ld a, h
    ld [$CF8C], a ;Not sure what this does, doesn't seem to do anything
    ret

;Play a sample through CH1 and 2.
;Sample data exists at [DE] for BC samples as 4-bit packed data.
Sound_PlaySampleFragment:
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

Sound_ExitSampleMode:
    xor a
    ld [REG_NR12], a
    ld [REG_NR22], a
    ld [H_Sound_SampleSelect], a
    ld a, $FF
    ld [REG_NR13], a
    ld [REG_NR23], a
    ld a, $87
    ld [REG_NR14], a
    ld [REG_NR24], a
    ret

Sound_SampleMetatable:
    dw Sound_SampleMetatable_TitleScreenSample
    
Sound_SampleMetatable_TitleScreenSample:
    db 1     ;Number of fragments.
    db $7C   ;Bank where fragment exists. Addr assumed to be $4000
    dw $789F ;Sample count (also double the byte count)
    db 6
    db 6     ;Unknown.