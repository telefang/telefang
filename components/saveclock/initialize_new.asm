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
    
    ld c, BANK(StringTable_denjuu_species)
    ld b, M_SaveClock_DenjuuNicknameSize
    pop de
    call Banked_Memcpy
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
    call $2C57 ;TODO: WTF does this DO!?
    
    ld bc, $FF00
    add hl, bc
    ld b, h
    ld c, l
    call $2C57
    
    pop hl
    pop bc
    
    ret