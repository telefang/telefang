INCLUDE "telefang.inc"

SECTION "Phone Convo Outgoing FD Manip", ROMX[$7FB5], BANK[$4]
PhoneConversation_OutboundIncrementFD::
    call PhoneConversation_IndexDenjuuSRAM
    ld de, M_SaveClock_DenjuuFriendship
    add hl, de
    ld a, [hl]
    cp 100
    jr nc, .noInc
    
.inc
    inc a
    ld [hl], a
    
.noInc
    jp TitleMenu_ExitSRAM
    
SECTION "Phone Convo Outgoing FD Manip 2", ROMX[$7E08], BANK[$4]
PhoneConversation_IndexDenjuuSRAM::
    push af
    
    ld b, BANK(S_SaveClock_StatisticsArray)
    call TitleMenu_EnterSRAM
    
    pop af
    
    ld e, a
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, S_SaveClock_StatisticsArray
    add hl, de
    
    ret

SECTION "Phone Convo Outgoing Species Inquiry", ROMX[$7A30], BANK[$4]
PhoneConversation_GetCalledDenjuuSpecies::
    call PhoneConversation_IndexDenjuuSRAM
    ld a, [hl]
    push af
    call TitleMenu_ExitSRAM
    pop af
    ret