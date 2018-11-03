INCLUDE "telefang.inc"

SECTION "Pause Menu Graphics WRAM", WRAM0[$CDB5]
W_PauseMenu_PhoneState:: ds 1

SECTION "Pause Menu Graphics Loaders", ROMX[$69C4], BANK[4]
PauseMenu_LoadPhoneGraphics::
    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    sla e
    rl d
    
    push de
    ld hl, PauseMenu_PhoneGraphicsTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, $9000
    ld bc, $400
    ld a, $37 ; '7'
    call Banked_LCDC_LoadGraphicIntoVRAM ; Phone
    
    pop de
    push de
    ld hl, PauseMenu_PhoneGraphicsTable.buttonsTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, $8800
    ld bc, $200
    ld a, $7A ; 'z'
    call Banked_LCDC_LoadGraphicIntoVRAM ; Buttons
    
    pop de
    ld hl, PauseMenu_PhoneGraphicsTable.modelNoTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, $9210
    ld bc, $30 ; '0'
    ld a, $37 ; '7'
    jp Banked_LCDC_LoadGraphicIntoVRAM ; Model no
    
;This should be in palette.asm, but it's not because it's sandwiched between these other two bits
PauseMenu_CGBLoadPhonePalette::
    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    
    ld hl, $390
    add hl, de
    
    push hl
    pop bc
    
    xor a
    jp CGBLoadBackgroundPaletteBanked
    
PauseMenu_PhoneGraphicsTable::
    dw $5D5F,$5D5F,$5D5F,$615F,$615F,$615F,$655F,$655F,$655F
.buttonsTable
    dw $4000,$4200,$4400,$4600,$4800,$4A00,$4C00,$4E00,$5000
.modelNoTable
    dw $6E5F,$6E8F,$6EBF,$6EEF,$6F1F,$6F4F,$6F7F,$6FAF,$6FDF