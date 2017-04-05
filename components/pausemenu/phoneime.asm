INCLUDE "telefang.inc"

SECTION "Pause Menu IME Memory", WRAM0[$CB28]
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