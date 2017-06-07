INCLUDE "telefang.inc"

SECTION "Phone Conversation Scenery Data Utils", ROMX[$4631], BANK[$2A]
PhoneConversation_ReadSceneryData::
    call PhoneConversation_BankedRead
    ld a, b
    bit 0, c
    jr nz, .noSwap
    
    swap a
.noSwap
    and $F
    ld b, a
    ret
    
PhoneConversation_IndexSceneryData::
    ld d, 0
    
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    
    ld a, [$C906]
    ld c, a
    
    srl a
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    
    ret
    
PhoneConversation_DetermineSceneryType::
    ld hl, $6417
    ld a, [W_Overworld_AcreType]
    cp 2
    jr c, .inBankData
    cp 6
    jr nc, .inBankData
    
.outOfBankData
    sub 2
    ld e, a
    call PhoneConversation_IndexSceneryData
    ld b, $2A
    call PhoneConversation_ReadSceneryData
    ret
    
.inBankData
    ld hl, $6497
    
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    
    ld b, [hl]
    ret
    
SECTION "Phone Conversation Scenery Tile Load Utils", ROM0[$1BB8]
PhoneConversation_LoadSceneryTiles::
    ld de, $9200
    push de
    ld d, a
    ld a, $76
    rst $10
    
    ld e, 0
    sla e
    rl d
    ld hl, $4E00
    
    add hl, de
    pop de
    ld bc, $200
    jp LCDC_LoadGraphicIntoVRAM
    
SECTION "Phone Conversation Scenery Tile Load Util Utils", ROM0[$2FDA]
PhoneConversation_BankedRead::
    ld a, [W_CurrentBank]
    push af
    ld a, b
    rst $10
    ld b, [hl]
    pop af
    rst $10
    ret