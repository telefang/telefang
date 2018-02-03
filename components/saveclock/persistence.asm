INCLUDE "telefang.inc"

SECTION "Save Clock Store/Retrieve Code", ROMX[$7B3E], BANK[$3]
SaveClock_StoreWorkingStateToSaveData::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    xor a
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, $C900
    ld de, $A010
    ld bc, $80
    call memcpy
    
    ld hl, $CD00
    ld de, $A110
    ld bc, $100
    call memcpy
    
    ld hl, $C500
    ld de, $A210
    ld bc, $200
    call memcpy
    
    ld hl, $A000
    ld de, $A410
    ld bc, $1900
    ld a, 2
    ld [Malias_CmpSrcBank], a
    
    xor a
    ld [Malias_DeCmpDst], a
    call SaveClock_SRAMCopy
    call SaveClock_SignSaveDataAsValid
    
    ld a, 1
    ld [$BFFD], a
    
    xor a
    ld [REG_MBC3_SRAMENABLE], a
    ret
    
SaveClock_RetrieveWorkingStateFromSaveData::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    xor a
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, $A010
    ld de, $C900
    ld bc, $80
    call memcpy
    
    ld hl, $A110
    ld de, $CD00
    ld bc, $100
    call memcpy
    
    ld hl, $A210
    ld de, $C500
    ld bc, $200
    call memcpy
    
    ld hl, $A410
    ld de, $A000
    ld bc, $1900
    xor a
    ld [Malias_CmpSrcBank], a
    
    ld a, 2
    ld [Malias_DeCmpDst], a
    call SaveClock_SRAMCopy
    
    xor a
    ld [REG_MBC3_SRAMENABLE], a
    
    ld a, [$C926]
    ld [W_Overworld_AcreType], a
    
    ld a, [$C927]
    ld [$C906], a
    
    ld a, [$C928]
    ld [$C901], a
    
    ld a, [$C929]
    ld [$C902], a
    ret
    
SaveClock_SRAMCopy::
    ld a, [Malias_CmpSrcBank]
    ld [REG_MBC3_SRAMBANK], a
    
    ld a, [hli]
    push af
    
    ld a, [Malias_DeCmpDst]
    ld [REG_MBC3_SRAMBANK], a
    
    pop af
    ld [de], a
    
    inc de
    dec bc
    ld a, c
    or b
    
    jr nz, SaveClock_SRAMCopy
    ret