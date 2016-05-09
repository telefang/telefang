SECTION "vblank interrupt", ROM0[$40]
    jp VBlankingIRQ

SECTION "lcd interrupt", ROM0[$48]
    jp LCDCIRQ

SECTION "timer interrupt", ROM0[$50]
    reti

SECTION "serial interrupt", ROM0[$58]
    jp SerIO_IRQ

SECTION "joypad interrupt", ROM0[$60]
    reti

SECTION "RomHeader", ROM0[$0100]
__start: nop
    jp Main