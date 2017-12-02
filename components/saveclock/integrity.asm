INCLUDE "telefang.inc"

SECTION "Save Data Integrity Vars", WRAM0[$C434]
W_SaveClock_SaveCheckPassed:: ds 1

SECTION "Save Data Integrity", ROM0[$F71]
SaveClock_SignSaveDataAsValid::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    xor a
    ld [REG_MBC3_SRAMBANK], a
    
    xor a
    ld [S_SaveClock_ClaimedChecksum], a
    ld [S_SaveClock_ClaimedChecksum + 1], a
    
    ld de, $A000
    ld bc, $1FF0
    ld hl, 0
    
.sumLoop
    push bc
    
    ld a, [de]
    ld c, a
    ld b, 0
    add hl, bc
    inc de
    
    pop bc
    
    dec bc
    ld a, b
    or c
    jr nz, .sumLoop
    
    ld a, l
    ld [S_SaveClock_ClaimedChecksum + 1], a
    ld a, h
    ld [S_SaveClock_ClaimedChecksum], a
    ret
    
SaveClock_CheckSaveIntegrity::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    xor a
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, SaveClock_IntegrityMagicValue
    ld de, $A000
    ld bc, $10
    
.saveMagicCheck
    push bc
    
    ld a, [hli]
    ld b, a
    ld a, [de]
    cp b
    jr nz, .saveNotInitialized
    
    inc de
    
    pop bc
    
    dec bc
    ld a, b
    or c
    jr nz, .saveMagicCheck
    
    xor a
    ld [$C433], a
    ld [W_SaveClock_SaveCheckPassed], a
    
    ld hl, 0
    ld de, $A000
    ld bc, $1FF0
    
.saveChecksumCheck
    push bc
    
    ld a, [de]
    ld c, a
    ld b, 0
    add hl, bc
    inc de
    
    pop bc
    
    dec bc
    
    ld a, b
    or c
    jr nz, .saveChecksumCheck
    
    ld a, l
    ld b, a
    ld a, h
    ld c, a
    ld a, [S_SaveClock_ClaimedChecksum + 1]
    cp b
    jr nz, .saveDamaged
    
    ld a, [S_SaveClock_ClaimedChecksum]
    cp c
    jr nz, .saveDamaged
    
    xor a
    ret
    
.saveNotInitialized
    pop bc
    ld a, 1
    ret
    
.saveDamaged
    ld a, 2
    ret