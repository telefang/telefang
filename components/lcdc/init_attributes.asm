INCLUDE "telefang.inc"

SECTION "LCDC Init Attributes", ROM0[$377B]
LCDC_InitAttributesSquare::
    push af
    call LCDC_InitAttributesLine
    ld a, $20
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    pop af
    dec d
    jr nz, LCDC_InitAttributesSquare
    ret
    
LCDC_InitAttributesLine::
    push af
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr nz, .noColorPresent
    
.hasColor
    pop af
    push de
    push hl
    push bc
    
    ld d, a
    ld a, 1
    ldh [REG_VBK], a
    call .setAttrs
    
    ld a, 0
    ldh [REG_VBK], a
    
    pop bc
    pop hl
    pop de
    ld a, d
    ret
    
.setAttrs
    bit 0, c
    jr z, .canDoubleByteCopy
    
.singleByteLoop
    di
    
.singleByteWait
    ldh a, [REG_STAT]
    and 2
    jr nz, .singleByteWait
    
    ld a, d
    ld [hli], a
    
    ei
    
    dec bc
    ld a, b
    or c
    jr nz, .singleByteLoop
    
    ret
    
.canDoubleByteCopy
    srl b
    rr c
    
.doubleByteLoop
    di
    
.doubleByteWait
    ldh a, [REG_STAT]
    and 2
    jr nz, .doubleByteWait
    
    ld a, d
    ld [hli], a
    ld [hli], a
    
    ei
    
    dec bc
    ld a, b
    or c
    jr nz, .doubleByteLoop
    
    ret
    
;WARNING: Assumes was called from the Square function above.
;WILL CRASH OTHERWISE
.noColorPresent
    add sp, 2
    ret