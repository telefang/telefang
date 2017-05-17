INCLUDE "telefang.inc"

SECTION "Victory Contact Utils - Deletion", ROMX[$58F8], BANK[$1D]
Victory_DeleteContact::
    ld b, M_SaveClock_MaxDenjuuContacts
    ld hl, W_PauseMenu_ContactsArray
    
;Compact the contact array by erasing it entirely, and then filling it with
;contact IDs until we hit the erased one.
.eraseLoop
    ld a, 0
    ld [hli], a
    dec b
    jr nz, .eraseLoop
    
    ld b, 0
    ld hl, W_PauseMenu_ContactsArray
    
.reindexLoop
    ld a, [W_PauseMenu_DeletedContact]
    cp b
    jr z, .reindexNextSlot
    
    push hl
    push bc
    
    call SaveClock_EnterSRAM2
    
    ld hl, $A000 + M_SaveClock_DenjuuLevel
    ld a, b
    call Battle_IndexStatisticsArray
    
    ld a, [hl]
    
    pop bc
    pop hl
    
    cp 0
    jr z, .reindexNextSlot
    
    ld a, b
    ld [hli], a
    
.reindexNextSlot
    inc b
    ld a, M_SaveClock_MaxDenjuuContacts
    cp b
    jr nz, .reindexLoop
    
    ld c, 0
    ld a, 0
    ld [W_Victory_DefectedContact], a

    ld a, [W_Victory_ContactsPresent]
    cp 2
    jp z, .simpleEraseExit
    
    dec a
    ld [W_Victory_LeveledUpParticipant], a
    
.compareFriendshipLoop
    push bc
    
    ld hl, W_PauseMenu_ContactsArray
    ld d, 0
    ld a, [W_Victory_DefectedContact]
    ld e, a
    add hl, de
    ld a, [hl]
    
    ld hl, $A000 + M_SaveClock_DenjuuFriendship
    call Battle_IndexStatisticsArray
    
    ld a, [hl]
    ld [$D40B], a
    
    pop bc
    push bc
    
    ld a, c
    ld hl, W_PauseMenu_ContactsArray
    
.indexLoopLate
    inc hl
    dec a
    jr nz, .indexLoopLate
    
    ld a, [hl]
    ld hl, $A000 + M_SaveClock_DenjuuFriendship
    call Battle_IndexStatisticsArray
    pop bc
    
    ld a, [$D40B]
    ld b, a
    ld a, [hl]
    cp b
    jr c, .markSelectedContactAsDefecting
    jr .dontMarkSelectedContactAsDefecting
    
.markSelectedContactAsDefecting
    ld a, c
    ld [W_Victory_DefectedContact], a
    
.dontMarkSelectedContactAsDefecting
    inc c
    ld a, [W_Victory_LeveledUpParticipant]
    ld b, a
    ld a, c
    cp b
    jr nz, .compareFriendshipLoop
    
.simpleEraseExit
    ld hl, W_PauseMenu_ContactsArray
    ld d, 0
    
    ld a, [W_Victory_DefectedContact]
    ld e, a
    add hl, de
    ld a, [hl]
    ld [W_Victory_DefectedContact], a
    
    ret