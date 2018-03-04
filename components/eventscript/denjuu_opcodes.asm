INCLUDE "telefang.inc"

SECTION "Event Action - Get Event Denjuu", ROMX[$4D38], BANK[$F]
EventScript_GetEventDenjuu::
    
; SRAM plz.
    
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, 2
    ld [REG_MBC3_SRAMBANK], a
    
; Check if an available slot exists for this Denjuu.
    
    ld bc, $C01
    call Overworld_ResetFlag
    call EventScript_FindEmptyDenjuuSlot
    jr z, .eventDenjuuEmptySlotFound
    ld bc, $C01
    call Overworld_SetFlag
    jp .eventDenjuuEmptySlotNotFound
    
.eventDenjuuEmptySlotFound

; Load Denjuu stats into SRAM.

    ld a, [W_EventScript_ParameterB]
    ldi [hl], a
    ld a, [W_EventScript_ParameterC]
    ldi [hl], a
    ld a, [W_EventScript_ParameterD]
    ldi [hl], a
    ld a, [W_EventScript_ParameterE]
    ldi [hl], a
    ld a, 0
    ldi [hl], a
    ldi [hl], a
    push hl
    ld hl, $400
    ld b, 0

; Parameter A is an identifier for the Event Denjuu.

    ld a, [W_EventScript_ParameterA]
    ld c, a
    add hl, bc
    ld d, h
    ld a, l
    pop hl
    ldi [hl], a
    ld e, a
    ld a, d
    ldi [hl], a
    push hl
    ld bc, -8
    add hl, bc
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    ld a, l
    and a, $FF
    ld c, a
    ld [$D4A7], a
    push bc
    ld a, BANK(SaveClock_InitializeNewDenjuu)
    ld hl, SaveClock_InitializeNewDenjuu
    call CallBankedFunction_int
    pop bc

; If the Event Denjuu in question is Noisy then read his name from the nickname table in the most untablelike way possible.

    ld a, [W_EventScript_ParameterA]
    cp a, $5
    jr nz, .notNoisy
    ld b, 0
    sla c
    rl b
    ld hl, S_SaveClock_NicknameArray
    add hl, bc
    add hl, bc
    add hl, bc
    ld d, h
    ld e, l
    ld hl, StringTable_denjuu_nicknames + $6 * $5
    ld c, BANK(StringTable_denjuu_nicknames)
    ld b, $06
    call Banked_Memcpy
    
.notNoisy
    pop hl
    push hl
    ld a, $2A
    ld hl, $4539
    call CallBankedFunction_int
    pop hl
    ld a, c
    ldi [hl], a
    ld a, [$C906]
    ldi [hl] ,a
    ld a, [W_EventScript_ParameterA]
    ld c, a
    push hl
    ld a, $29
    ld hl, $4162
    call CallBankedFunction_int
    pop hl
    ld a, e
    ldi [hl], a
    ld a, d
    ldi [hl], a
    ld a, c
    ldi [hl], a
    ld a, b
    ldi [hl], a
    ld a, [$CA69]
    ldi [hl],a
    ld a, $2
    ld [hl],a
    call $2411
    ld a,[$CD0A]
    ld [$D480],a
    ld a,[$CD0B]
    ld [$D481],a
    ld a,$34
    ld [W_SystemSubState],a
    
.eventDenjuuEmptySlotNotFound
    ld a, 0
    ld [REG_MBC3_SRAMENABLE], a
    ld b, $6
    call EventScript_CalculateNextOffset
    xor a
    ret

SECTION "Event Action - Get Event Denjuu - Find Empty Denjuu Slot", ROMX[$4FEF], BANK[$F]
EventScript_FindEmptyDenjuuSlot::
    ld hl,$A001
    ld c,$FE
    ld de,$0010
    
.emptySlotSearchLoop
    ld a, [hl]
    or a
    jr z, .emptySlotFound
    add hl,de
    dec c
    jr nz, .emptySlotSearchLoop
    or a, $01
    ret
    
.emptySlotFound
    dec  hl
    push hl
    ld b,$10
    xor  a
    
.emptySlotClear
    ldi [hl], a
    dec b
    jr nz, .emptySlotClear
    pop hl
    xor a
    ret