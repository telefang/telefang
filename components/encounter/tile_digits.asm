INCLUDE "telefang.inc"

SECTION "Encounter Tile Digits", ROM0[$1430]
Encounter_DrawTileDigits::
    push hl
    push de
    push bc
    push bc
    push hl
    
    call Status_DecimalizeStatValue
    
    pop hl
    xor a
    ld [Malias_DeCmpDst], a
    
    pop bc
    ld a, c
    cp 1
    jp nz, .checkHundredsDigit
    
.one
    ld a, 1
    ld [Malias_DeCmpDst], a
    jp .checkTensDigit
    
.checkHundredsDigit
    ld a, [Malias_CmpSrcBank]
    and $F
    or a
    jr nz, .pokeHundredsDigit
    
    ld b, a
    ld a, [Malias_DeCmpDst]
    or a
    jr z, .drawSpace
    ld a, b
    
.pokeHundredsDigit
    add a, $F0
    call vmempoke
    
    ld a, 1
    ld [Malias_DeCmpDst], a
    jr .checkTensDigit
    
.drawSpace
    ld a, $FF
    call vmempoke
    
.checkTensDigit
    ld a, [W_GenericRegPreserve]
    and $F0
    or a
    jr nz, .drawTensDigit
    
    ld b, a
    ld a, [Malias_DeCmpDst]
    or a
    jr z, .drawTensSpace
    ld a, b
    
.drawTensDigit
    swap a
    add a, $F0
    call vmempoke
    jr .drawOnesDigit
    
.drawTensSpace
    ld a, $FF
    call vmempoke
    
.drawOnesDigit
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $F0
    
    call vmempoke
    
    pop bc
    pop de
    pop hl
    
    ret