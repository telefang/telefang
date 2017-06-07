INCLUDE "telefang.inc"

SECTION "Phone Conversation UI Tile Loader", ROM0[$1ACB]
PhoneConversation_LoadPhoneFrameTiles::
    ld de, $9000
    
    push de
    ld a, $37
    rst $10
    
    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    sla e
    rl d
    ld hl, .phoneTileLocators
    add hl, de
    
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    pop de
    ld bc, $200
    jp LCDC_LoadGraphicIntoVRAM
    
.phoneTileLocators
    dw $5D5F,$5D5F,$5D5F,$615F,$615F,$615F,$655F