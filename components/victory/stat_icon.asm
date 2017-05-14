INCLUDE "telefang.inc"

SECTION "Victory Stat Improvement Icon Animation", ROM0[$1796]
Victory_UpdateStatIconAnimation::
    push hl
    pop de
    
    di
    call YetAnotherWFB
    ld a, [hli]
    ld [W_System_GenericCounter], a
    ei
    
    di
    call YetAnotherWFB
    ld a, [hli]
    ld [W_System_GenericCounter + 1], a
    ei
    
    ld b, 6
    
.scrollLoop
    di
    call YetAnotherWFB
    ld a, [hli]
    ld [de], a
    inc de
    
    call YetAnotherWFB
    ld a, [hli]
    ld [de], a
    inc de
    ei
    
    dec b
    jr nz, .scrollLoop
    
    di
    ld a, [W_System_GenericCounter]
    call YetAnotherWFB
    ld [de], a
    
    inc de
    ld a, [W_System_GenericCounter + 1]
    call YetAnotherWFB
    ld [de], a
    ei
    
    ret