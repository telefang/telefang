INCLUDE "telefang.inc"

SECTION "Event Flag Utils Memory", WRAM0[$C500]
W_Overworld_EventFlagBitfield:: ds 1 ;TODO: How large is the Zukan?

SECTION "Event Flag Utils", ROM0[$2C4D]
Overworld_CheckFlagValue::
    push bc
    push hl
    call Overworld_GenerateFlagAddressAndMask
    ld a, [hl]
    and c
    pop hl
    pop bc
    ret
    
Overworld_SetFlag::
    push bc
    push hl
    call Overworld_GenerateFlagAddressAndMask
    ld a, [hl]
    or c
    
.store
    ld [hl], a
    pop hl
    pop bc
    ret
    
Overworld_ToggleFlag::
    push bc
    push hl
    call Overworld_GenerateFlagAddressAndMask
    ld a, [hl]
    xor c
    jr Overworld_SetFlag.store
    
Overworld_ResetFlag::
    push bc
    push hl
    call Overworld_GenerateFlagAddressAndMask
    ld a, c
    cpl
    ld c, a
    ld a, [hl]
    and c
    jr Overworld_SetFlag.store

Overworld_GenerateFlagAddressAndMask::
    ld a, c
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    ld hl, W_Overworld_EventFlagBitfield
    add hl, bc
    ld c, 1
    and 7
    jr z, .ret
    
.maskgenloop
    sla c
    dec a
    jr nz, .maskgenloop
    
.ret
    ret