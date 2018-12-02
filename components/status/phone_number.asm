INCLUDE "telefang.inc"

SECTION "Status Phone Numbers", ROMX[$504A], BANK[2]
Status_DrawDenjuuPhoneNumber::
    call SaveClock_EnterSRAM2
    ld a, [W_Status_CalledFromContactScreen]
    cp 1
    jr z, .drawPhoneNumber
    ld a, [W_Status_UseDenjuuNickname]
    cp 1
    jr z, .drawPhoneNumber
    ld a, [W_SystemSubState]
    cp 2
    jr nz, .specialUnknownNumber
    
.drawPhoneNumber
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuPhoneVals
    ld a, [W_Status_SelectedDenjuuIndex]
    call Battle_IndexStatisticsArray
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, [hl]
    ld hl, $9984
    call Banked_Status_DrawPhoneNumberForStatus
    jr .exitSRAM
    
.specialUnknownNumber
    ld bc, $80C
    ld e, $AC
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
.exitSRAM
    call SaveClock_ExitSRAM
    ret
    
SECTION "Status Draw Phone Number", ROMX[$42A3], BANK[$29]
Status_DrawPhoneNumber::
    push hl
    call $42E5 ;TODO: How are phone numbers calculated?
    push de
    call Status_LoadPhoneDigits
    pop de
    
.skipLoadDigits
    pop hl
    push hl
    push de
    call Status_DrawTopOfDigits
    pop de
    pop hl
    ld bc, $20
    add hl, bc
    jp Status_DrawBottomOfDigits

Status_DrawTopOfDigits::
    ld b, 7
    
.twoByteLoop
    di
    
.wfbLoop
    ld a, [REG_STAT]
    and 2
    jr nz, .wfbLoop
    
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    ld [hli], a
    
    ei
    inc de
    dec b
    jr nz, .twoByteLoop
    
    ret

Status_DrawBottomOfDigits::
    ld b, 7
    
.twoByteLoop
    di
    
.wfbLoop
    ld a, [REG_STAT]
    and 2
    jr nz, .wfbLoop
    
    ld a, [de]
    inc de
    inc a
    ld [hli], a
    ld a, [de]
    inc a
    ld [hli], a
    
    ei
    inc de
    dec b
    jr nz, .twoByteLoop
    
    ret
    
Status_CalculatePhoneNumber::

SECTION "Status Phone Number Graphic", ROMX[$49B8], BANK[$29]
Status_LoadPhoneDigits::
    ld hl, $9600
    ld de, Status_PhoneDigits
    ld bc, $200 ;This is a LIE. It's actually $1E0 bytes...
    jp LCDC_LoadTiles
    
Status_PhoneDigits::
    INCBIN "build/components/status/phone_digits.2bpp"