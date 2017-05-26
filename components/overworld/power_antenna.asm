INCLUDE "telefang.inc"

SECTION "Overworld Power Antenna Memory", WRAM0[$CAD0]
W_Overworld_PowerAntennaPattern:: ds 1

SECTION "Overworld Power Antenna Memory 2", WRAM0[$C936]
W_Overworld_PowerAntennaEnable:: ds 1
    ds 1
W_Overworld_PowerAntennaFrameCounter:: ds 1

;Telefang Limited Edition came with a link port peripheral LED thing.
;It was called 'Power Antenna'. This code drives it.
SECTION "Overworld Power Antenna LED Manager", ROMX[$4FCD], BANK[$29]
Overworld_ResetPowerAntenna::
    ld a, [W_Overworld_PowerAntennaPattern]
    or a
    ret nz
    
    ld a, M_Overworld_PowerAntennaInactive
    ld [W_Overworld_PowerAntennaPattern], a
    
    ld a, [W_Overworld_PowerAntennaEnable]
    or a
    ret z
    
    ld a, 0
    ld [REG_SB], a
    ld a, $81
    ld [REG_SC], a
    ret
    
Overworld_DrivePowerAntennaPattern::
    ld a, [W_Overworld_PowerAntennaEnable]
    or a
    ret z
    
    ld a, [W_Overworld_PowerAntennaPattern]
    or a
    ret z
    
    cp M_Overworld_PowerAntennaInactive
    ret z
    
    cp M_Overworld_PowerAntennaBlink
    jr nz, .ringingPattern
    
.blinkingPattern
    ld b, 0
    ld a, [W_Overworld_PowerAntennaFrameCounter]
    
    and 1
    jr z, .setLedState
    dec b
    jr .setLedState
    
.ringingPattern
    ld b, 0
    ld a, [W_Overworld_PowerAntennaFrameCounter]
    inc a
    and M_Overworld_PowerAntennaRingOffTime
    jr z, .setLedState
    
    ld a, [W_Overworld_PowerAntennaFrameCounter]
    inc a
    bit 1, a
    jr z, .setLedState
    ld b, $FF
    
.setLedState
    ld a, b
    ld [REG_SB], a
    ld a, $81
    ld [REG_SC], a
    ret

SECTION "Overworld Power Antenna IRQ Task", ROM0[$1F08]
Overworld_PowerAntennaIRQTask::
    ld a, [W_CurrentBank]
    push af
    
    ld a, BANK(Overworld_ResetPowerAntenna)
    rst $10
    
    ld a, 1
    ld [W_Overworld_PowerAntennaEnable], a
    
    ld a, [W_Overworld_PowerAntennaFrameCounter]
    inc a
    ld [W_Overworld_PowerAntennaFrameCounter], a
    
    call Overworld_ResetPowerAntenna
    call Overworld_DrivePowerAntennaPattern
    
    pop af
    rst $10
    ret