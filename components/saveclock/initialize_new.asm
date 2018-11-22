INCLUDE "telefang.inc"

SECTION "Save Clock Denjuu Initialization Utils", ROMX[$40EF], BANK[$29]
SaveClock_InitializeNewDenjuu::
    call sub_A412E
    call SaveClock_MarkSlotInUse47
    
    ld b, 0
    sla c
    rl b
    
    ld hl, S_SaveClock_NicknameArray
    add hl, bc
    add hl, bc
    add hl, bc
    
    push hl
    
    ld hl, StringTable_denjuu_species
    ld a, [Malias_CmpSrcBank]
    ld c, a
    ld b, 0
    
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    
    call SaveClock_ADVICE_RelocateCopyBank
    nop
    pop de
    call SaveClock_ADVICE_TerminateDenjuuNickname
    ret
    
SaveClock_MarkSlotInUse47::
    ld a, c
    ld hl, $B800 ;TODO: What function does this array serve?
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld [hl], $47
    ret
    
;TODO: What does this function do?
;The functions it calls do some really weird address maths
sub_A412E::
    push bc
    push hl
    
    ld b, 0
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    
    ld hl, S_SaveClock_StatisticsArray
    add hl, bc
    
    ld c, [hl]
    ld a, c
    ld [Malias_CmpSrcBank], a
    
    ld b, 0
    ld hl, $F00
    add hl, bc
    ld b, h
    ld c, l
    call Overworld_SetFlag ;TODO: WTF does this DO!?
    
    ld bc, $FF00
    add hl, bc
    ld b, h
    ld c, l
    call Overworld_SetFlag
    
    pop hl
    pop bc
    
    ret
    
SECTION "Save Clock Denjuu Initialization Utils ADVICE", ROMX[$79A0], BANK[$29]
SaveClock_ADVICE_TerminateDenjuuNickname::
    push af
    
    ld a, $E6
    ld [de], a
    inc de
    dec b
    
.terminateLoop
    ld a, $E0
    ld [de], a
    inc de
    dec b
    
    jp nz, .terminateLoop
    
    pop af
    
    ret
    
    nop
    nop
    nop
    
SaveClock_ADVICE_RelocateCopyBank::
    push af
    
    ld a, $40
    cp h
    jp z, .bank34
    jp nc, $7F38 ;TODO: This is a nop slide to nowhere! I think they meant .bank75
    
    ld a, $45
    cp h
    jp c, .bank75
    jp nz, .bank34
    
    ld a, $78
    cp l
    jp nc, .bank34
    
.bank75
    ld c, $75
    pop af
    ld b, M_SaveClock_DenjuuNicknameSize
    ret
    
.bank34
    ld c, $34
    add hl, hl
    
    ld b, $40
    
    ld a, h
    sub b
    ld h, a
    
    pop af
    
    ld b, M_SaveClock_DenjuuNicknameSize
    ret
    
SaveClock_ADVICE_RelocateCopyBank_END::