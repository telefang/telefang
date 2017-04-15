INCLUDE "telefang.inc"

SECTION "Title Menu Specific SRAM Enter/Exit functions", ROMX[$7EE7], BANK[$4]
TitleMenu_EnterSRAM::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, b
    ld [REG_MBC3_SRAMBANK], a
    ret
    
TitleMenu_ExitSRAM::
    xor a
    ld [REG_MBC3_SRAMENABLE], a
    ret