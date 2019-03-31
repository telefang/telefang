INCLUDE "telefang.inc"

SECTION "Save Clock Denjuu Initialization Utils", ROMX[$40EF], BANK[$29]
SaveClock_InitializeNewDenjuu::
    call sub_A412E
    call SaveClock_MarkSlotInUse47

    ld h, S_SaveClock_NicknameExtensionIndicatorArray >> 8
    ld l, c
    ld [hl], 1

    ld h, 0
    add hl, hl
	push hl
    add hl, hl
    ld a, h
    add S_SaveClock_NicknameExtensionArray >> 8
    ld h, a

    ld d, M_SaveClock_DenjuuNicknameExtensionSize
    call SaveClock_ADVICE_InitializeNewDenjuuCopyLoop

	pop hl
    ld d, h
    ld e, l
    add hl, hl
    add hl, de
    ld a, h
    add S_SaveClock_NicknameArray >> 8
    ld h, a
    ld a, $E6
    ld [hli], a
    ld d, M_SaveClock_DenjuuNicknameSize - 1
    ; Continue into SaveClock_ADVICE_InitializeNewDenjuuCopyLoop

SaveClock_ADVICE_InitializeNewDenjuuCopyLoop::
    ld a, $E0

.loop
    ld [hli], a
    dec d
    jr nz, .loop
    ret
    nop

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
    
