INCLUDE "telefang.inc"

SECTION "SGB Packet Functions", ROMX[$4122], BANK[$3]
SGB_AdjustableWait::
    ld de, $6D6
    
.wasteCycles
    nop
    nop
    nop
    dec de
    
    ld a, d
    or e
    jr nz, .wasteCycles
    
    dec bc
    ld a, b
    or c
    jr nz, SGB_AdjustableWait
    ret
    
;Sends a completed SGB packet set via joypad bitbanging (aka "register file")
;
;The first byte's length parameter is used to determine the length of the packet
;buffer in [hl]. So you can't, say, send one of a multi-packet set this way.
;Also, packets with a zero length won't be sent at all.
SGB_SendPackets::
    ld a, [hl]
    and 7
    ret z
    
    ld b, a
    ld c, 0
    
.beginPacket
    push bc
    
    ld a, 0
    ld [c], a
    ld a, $30
    ld [c], a
    
    ld b, $10
    
.beginByte
    ld e, 8
    
    ld a, [hli]
    ld d, a
    
.beginBit
    bit 0, d
    ld a, $10
    jr nz, .sendOneBit
    
.sendZeroBit
    ld a, $20
    
.sendOneBit
    ld [c], a
    
    ld a, $30
    ld [c], a
    
    rr d
    dec e
    jr nz, .beginBit
    
    dec b
    jr nz, .beginByte
    
    ld a, $20
    ld [c], a
    ld a, $30
    ld [c], a
    
    pop bc
    dec b
    ret z
    
.nextPacket
    call SGB_FrameWait
    jr .beginPacket
    
SGB_SendPacketsWithVRAM::
    di
    
    push de
    call LCDC_DisableLCD
    ld a, $E4
    ld [REG_BGP], a
    
    ld de, $8800
    ld bc, $1000
    call SGB_CopyVRAMPacketData
    
SGB_SendPacketsWithVRAM_externalEntry::
    ld hl, $9800
    ld de, $C
    ld a, $80
    ld c, $D
    
.drawLine
    ld b, $14
    
.drawTile
    ld [hli], a
    inc a
    dec b
    jr nz, .drawTile
    
    add hl, de
    dec c
    jr nz, .drawLine
    
    ld a, $81
    ld [REG_LCDC], a
    
    ld bc, 5
    call SGB_AdjustableWait
    
    pop hl
    call SGB_SendPackets
    ld bc, 6
    call SGB_AdjustableWait
    
    ei
    
    ret
    
SGB_CopyVRAMPacketData::
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, SGB_CopyVRAMPacketData
    ret