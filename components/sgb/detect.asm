INCLUDE "telefang.inc"

SECTION "SGB ICD Detect Memory", WRAM0[$C40A]
W_SGB_DetectSuccess:: ds 1

SECTION "SGB ICD Detect", ROMX[$41AF], BANK[$3]
SGB_DetectICDPresence::
    ld hl, SGB_PacketEnableMultiplayer
    call SGB_SendPackets
    call SGB_FrameWait
    
    ldh a, [REG_JOYP]
    and 3
    cp 3
    jr nz, .sgbNotDetected
    
.secondarySgbCheck
    ld a, $20
    ldh [REG_JOYP], a
    
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    
    ld a, $30
    ldh [REG_JOYP], a
    ld a, $10
    ldh [REG_JOYP], a
    
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    
    ld a, $30
    ldh [REG_JOYP], a
    
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    ldh a, [REG_JOYP]
    
    and 3
    cp 3
    jr nz, .sgbNotDetected
    
.sgbDetected
    ld hl, SGB_PacketDisableMultiplayer
    call SGB_SendPackets
    call SGB_FrameWait
    sub a
    ret
    
.sgbNotDetected
    ld hl, SGB_PacketDisableMultiplayer
    call SGB_SendPackets
    call SGB_FrameWait
    scf
    ret
    
SGB_PacketDisableMultiplayer::
    db $89
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    
SGB_PacketEnableMultiplayer::
    db $89
    db 1
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    
SGB_FrameWait::
    ld de, $1B58
    
.wasteCycles
    nop
    nop
    nop
    
    dec de
    ld a, d
    or e
    jr nz, .wasteCycles
    
    ret