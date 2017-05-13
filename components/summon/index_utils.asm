SECTION "Summon Index Utils", ROMX[$5704], BANK[$1C]
Summon_IndexCursorToContactSlotID::
    ld a, [W_Summon_CurrentPage]
    cp 0
    jr z, .returnAnswer
    
    ld b, a
    ld a, d
    
.mulLoop
    add a, 3
    dec b
    jr nz, .mulLoop
    
    ld d, a
    
.returnAnswer
    ld a, d
    ret
    
SECTION "Summon Index Utils 2", ROMX[$5738], BANK[$1C]
Summon_GetContactIDForCurrentPage::
    call Summon_IndexCursorToContactSlotID
    
    ld d, 0
    ld e, a
    ld hl, W_PauseMenu_ContactsArray
    add hl, de
    ld a, [hl]
    
    ret