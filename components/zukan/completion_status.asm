INCLUDE "telefang.inc"

SECTION "Zukan Completion Status Utils Memory", WRAM0[$C500]
W_Zukan_CompletionBitfield:: ds 1 ;TODO: How large is the Zukan?

SECTION "Zukan Completion Status Utils", ROM0[$2C4D]
Zukan_CheckEntryObtained::
    push bc
    push hl
    call Zukan_GenerateCompletionAddressMask
    ld a, [hl]
    and c
    pop hl
    pop bc
    ret
    
Zukan_MarkEntryObtained::
    push bc
    push hl
    call Zukan_GenerateCompletionAddressMask
    ld a, [hl]
    or c
    
.store
    ld [hl], a
    pop hl
    pop bc
    ret
    
Zukan_InvertEntryObtainedStatus::
    push bc
    push hl
    call Zukan_GenerateCompletionAddressMask
    ld a, [hl]
    xor c
    jr Zukan_MarkEntryObtained.store
    
Zukan_MarkEntryNotObtained::
    push bc
    push hl
    call Zukan_GenerateCompletionAddressMask
    ld a, c
    cpl
    ld c, a
    ld a, [hl]
    and c
    jr Zukan_MarkEntryObtained.store

Zukan_GenerateCompletionAddressMask::
    ld a, c
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    ld hl, W_Zukan_CompletionBitfield
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