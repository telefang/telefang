SECTION "System Bit Manip Utils", ROM0[$1784]
System_BitReverse::
    push de
    push bc
    ld b, 8
    ld d, 0
    ld e, a
    
.loop
    srl e
    rl d
    dec b
    jr nz, .loop
    
    ld a, d
    pop bc
    pop de
    ret