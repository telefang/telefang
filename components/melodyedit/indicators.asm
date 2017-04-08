INCLUDE "telefang.inc"

SECTION "Melo-D Editor Indicator Code", ROMX[$61BF], BANK[$4]
MelodyEdit_DrawPageIndicator::
    ld a, $57
    ld hl, $99C2
    call vmempoke
    ld a, $58
    call vmempoke
    ld a, $59
    call vmempoke
    ld a, $55
    call vmempoke
    inc hl
    ld a, [W_MelodyEdit_CurrentPage]
    inc a
    
.decimalizeValue
    push hl
    call Status_DecimalizeStatValue
    pop hl
    
.drawDigits
    ld a, [W_GenericRegPreserve]
    and $F0
    swap a
    add a, $76
    di
    call YetAnotherWFB
    ld [hli], a
    ei
    
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $76
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    
    ret
    
MelodyEdit_DrawTempoIndicator::
    ld a, $53
    ld hl, $99E2
    call vmempoke
    ld a, $54
    call vmempoke
    ld a, $56
    call vmempoke
    ld a, $55
    call vmempoke
    inc hl
    ld a, [W_MelodyEdit_Tempo]
    inc a
    jp MelodyEdit_DrawPageIndicator.decimalizeValue
    
MelodyEdit_DrawDataIndicator::
    call MelodyEdit_CountData
    ld a, $71
    ld hl, $9A02
    call vmempoke
    ld a, $72
    call vmempoke
    ld a, $73
    call vmempoke
    ld a, $55
    call vmempoke
    
    ld a, [W_MelodyEdit_DataCount]
    push hl
    call Status_DecimalizeStatValue
    pop hl
    ld a, [Malias_CmpSrcBank]
    and $F
    add a, $76
    di
    call YetAnotherWFB
    ld [hli], a
    ei
    
    jp MelodyEdit_DrawPageIndicator.drawDigits
    
MelodyEdit_CountData::
    xor a
    ld [W_MelodyEdit_DataCount], a
    ld hl, W_MelodyEdit_CurrentData
    ld bc, M_MelodyEdit_CurrentDataMax
    
.countLoop
    ld a, [hli]
    cp M_MelodyEdit_NullNote
    jr nz, .countData
    
    ld a, [hl]
    cp M_MelodyEdit_NullNote
    jr z, .dontCountData
    
.countData
    ld a, [W_MelodyEdit_DataCount]
    inc a
    ld [W_MelodyEdit_DataCount], a
    
.dontCountData
    inc hl
    dec bc
    ld a, b
    or c
    jr nz, .countLoop
    
    ret