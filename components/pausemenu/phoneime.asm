INCLUDE "telefang.inc"

; BANK() is stupid
IMPORT PhoneKeypadGfx
IMPORT PhoneKeypadGfxDmg

SECTION "Pause Menu IME WRAM", WRAM0[$CDB5]
W_PauseMenu_PhoneState:: ds 1

SECTION "Pause Menu IME WRAM2", WRAM0[$CB3E]
W_PauseMenu_PhoneIMEPressCount:: ds 1

SECTION "Pause Menu IME WRAM3", WRAM0[$CB28]
W_PauseMenu_PhoneIME:: ds 1
    ds 1 ; ???
W_PauseMenu_NextPhoneIME:: ds 1

SECTION "Pause menu IME stuff", ROMX[$665A], BANK[$4]
PauseMenu_LoadPhoneIMETilemap::
    ld e, $15
    ld a, [W_PauseMenu_NextPhoneIME]
    cp 0
    jr z, .loadTmap
    ld e, $16
    cp 1
    jr z, .loadTmap
    ld e, $1B
    
.loadTmap
    ld bc, $111
    ld a, 0
    jp Banked_RLEDecompressTMAP0

SECTION "Pause Menu Phone Stuff", ROMX[$693B], BANK[$4]
PauseMenu_LoadPhoneIMEGraphics::
    ld hl, .imeGraphicsTableCGB
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .tableSelected
    ld hl, .imeGraphicsTableDMG
    
.tableSelected
    ld a, [W_PauseMenu_PhoneState]
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    ld a, [W_PauseMenu_PhoneIME]
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .selectCGBBank
    ld a, BANK(PhoneKeypadGfx)
    jr .bankSelected
    
.selectCGBBank
    ld a, BANK(PhoneKeypadGfxDmg) ;yeah IDK WTF, I think our PNGs are mislabeled
    
.bankSelected
    ld de, $8A00
    ld bc, $400
    jp Banked_LCDC_LoadGraphicIntoVRAM
    
;TODO: These are all offsets of PhoneKeypadGfx
.imeGraphicsTableCGB
    dw .imeGraphicsTableCGBPhone0, .imeGraphicsTableCGBPhone0, .imeGraphicsTableCGBPhone0
    dw .imeGraphicsTableCGBPhone1, .imeGraphicsTableCGBPhone1, .imeGraphicsTableCGBPhone1
    dw .imeGraphicsTableCGBPhone2, .imeGraphicsTableCGBPhone2, .imeGraphicsTableCGBPhone2
    
.imeGraphicsTableCGBPhone0
    dw $4000,$4400,$4800,$4C00
.imeGraphicsTableCGBPhone1
    dw $5000,$5400,$5800,$5C00
.imeGraphicsTableCGBPhone2
    dw $6000,$6400,$6800,$6C00

.imeGraphicsTableDMG
    dw .imeGraphicsTableDMGPhone0, .imeGraphicsTableDMGPhone0, .imeGraphicsTableDMGPhone0
    dw .imeGraphicsTableDMGPhone1, .imeGraphicsTableDMGPhone1, .imeGraphicsTableDMGPhone1
    dw .imeGraphicsTableDMGPhone2, .imeGraphicsTableDMGPhone2, .imeGraphicsTableDMGPhone2
    
.imeGraphicsTableDMGPhone0
    dw $4000,$4400,$4800,$4C00
.imeGraphicsTableDMGPhone1
    dw $5000,$5400,$5800,$5C00
.imeGraphicsTableDMGPhone2
    dw $6000,$6400,$6800,$6C00

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