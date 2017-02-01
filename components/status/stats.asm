SECTION "Status Screen Stat Stuff", WRAMX[$D415], BANK[1]
W_Status_SelectedContactIndex:: ds 1

SECTION "Status Screen Stat Stuff2", WRAMX[$D496], BANK[1]
W_Status_SelectedDenjuuIndex:: ds 1
W_Status_SelectedDenjuuByte0:: ds 1
W_Status_SelectedDenjuuByte1:: ds 1
W_Status_SelectedDenjuuByte3:: ds 1

SECTION "Status Screen Stat Loader", ROMX[$4FE8], BANK[$02]
Status_LoadContactInfo::
    ld hl, $D000 ;Contacts array (maps contact index to denjuu instance index)
    ld d, 0
    ld a, [W_Status_SelectedContactIndex]
    ld e, a
    add hl, de
    ld a, [hl]
    ld [W_Status_SelectedDenjuuIndex], a
    call SaveClock_EnterSRAM2
    ld a, [W_Status_SelectedDenjuuIndex]
    ld hl, $A000 ;Denjuu array (stores stats for each captured denjuu)
    call Battle_IndexStatisticsArray
    ld a, [hli]
    ld [W_Status_SelectedDenjuuByte0], a
    ld a, [hli]
    ld [W_Status_SelectedDenjuuByte1], a
    inc hl
    ld a, [hl]
    ld [W_Status_SelectedDenjuuByte3], a
    call SaveClock_ExitSRAM
    ret

Status_LoadSpecialInfo::
    ld hl, $D5B6
    ld d, 0
    ld a, [W_Status_SelectedContactIndex]
    ld b, a
    sla a
    add a, b
    ld e, a
    add hl, de
    ld a, [hli]
    ld [W_Status_SelectedDenjuuByte0], a
    ld a, [hli]
    ld [W_Status_SelectedDenjuuByte1], a
    ld a, [hl]
    ld [W_Status_SelectedDenjuuByte3], a
    ret