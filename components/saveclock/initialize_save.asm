INCLUDE "telefang.inc"

SECTION "Save Clock Save Data Initialization/Erase Utils", ROM0[$FF6]
SaveClock_EraseLoadedSave::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    xor a
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, $A000
    ld bc, $1FFF
    
.eraseLoop
    xor a
    ld [hli], a
    
    dec bc
    ld a, c
    or b
    jr nz, .eraseLoop
    
    xor a
    ld [$BFFD], a
    jp $F3F
    
SaveClock_EraseSaveData::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    ld a, 1
    ld [REG_MBC3_SRAMBANK], a
    
    call SaveClock_EraseSRAMBank
    
    ld a, 2
    ld [REG_MBC3_SRAMBANK], a
    
    call SaveClock_EraseSRAMBank
    
    ld a, 3
    ld [REG_MBC3_SRAMBANK], a
    
    call SaveClock_EraseSRAMBank
    
    xor a
    ld [REG_MBC3_SRAMENABLE], a
    
    ret

SaveClock_EraseSRAMBank::
    ld hl, $A000
    ld bc, $2000
    
.eraseLoop
    xor a
    ld [hli], a
    
    dec bc
    ld a, b
    or c
    jr nz, .eraseLoop
    
    ret

SECTION "Save Clock Save Data Initialization/Erase Utils 2", ROM0[$1A09]
SaveClock_WriteDefaultSaveFile::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    ld a, 1
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, $A000
    ld bc, $1000
    
.eraseLoop
    ld a, $FE
    ld [hli], a
    
    dec bc
    ld a, b
    or c
    jr nz, .eraseLoop
    
    ld de, $A000
    ld hl, .fileDefaults
    ld bc, 8
    call memcpy
    
    ld de, $A200
    ld hl, .fileDefaults
    ld bc, 8
    call memcpy
    
    ld de, $A400
    ld hl, .fileDefaults
    ld bc, 8
    call memcpy
    
    ld de, $A600
    ld hl, .fileDefaults
    ld bc, 8
    call memcpy
    
    ld de, $A800
    ld hl, .fileDefaults
    ld bc, 8
    call memcpy
    
    ld de, $AA00
    ld hl, .fileDefaults
    ld bc, 8
    call memcpy
    
    ld de, $AC00
    ld hl, .fileDefaults
    ld bc, 8
    call memcpy
    
    ld de, $AE00
    ld hl, .fileDefaults
    ld bc, 8
    call memcpy
    
    xor a
    ld [REG_MBC3_SRAMENABLE], a
    ret
    
.fileDefaults
    dw 1, $201, $221, $241