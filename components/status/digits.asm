SECTION "Status Screen Int to Digits Draw Func", ROM0[$12FB]
Status_DecimalizeStatValue::
    push de
    push bc
    push hl
    push af
    
    xor a
    ld [Malias_CmpSrcBank], a
    ld [W_GenericRegPreserve], a
    ld de, 0
    pop af
    
.checkHundredsDigit
    ld b, 100
    
.hundredsLoop
    ld c, a
    sub b
    jr z, .checkTensDigit
    inc d
    jr .hundredsLoop
    
.checkTensDigit
    ld a, c
    ld b, 10
    
.tensLoop
    ld c, a
    sub b
    jr c, .checkOnesDigit
    
    push af
    ld a, e
    add a, $10
    ld e, a
    pop af
    
    jr .tensLoop
    
.checkOnesDigit
    ld a, c
    ld b, 1
    
.onesLoop
    ld c, a
    sub b
    jr c, .return
    inc e
    jr .onesLoop
    
.return
    ld a, d
    ld [Malias_CmpSrcBank], a
    ld a, e
    ld [W_GenericRegPreserve], a
    
    pop hl
    pop bc
    pop de
    ret

Status_ModuloDivide::
    xor a
    ld [Malias_CmpSrcBank], a
    ld [W_GenericRegPreserve], a
    ld a, b
    or a
    jr nz, .divideLoop
    ld a, c
    or a
    ret z
    
.divideLoop
    ld a, h
    ld [W_LCDC_CGBFadeFactor], a
    ld a, l
    ld [W_LCDC_CGBFadeFactor + 1], a ; some good ol fashioned global aliasing
    
    ld d, b
    ld a, h
    sub d
    ret c
    jr nz, .subtractDivisor
    
    ld d, c
    ld a, l
    sub d
    ret c
    
.subtractDivisor
    ld a, [W_LCDC_CGBFadeFactor + 1]
    sub c
    ld l, a
    ld a, [W_LCDC_CGBFadeFactor]
    sbc a, b
    
    ld h, a
    ld a, [Malias_CmpSrcBank]
    add a, 1
    ld [Malias_CmpSrcBank], a
    
    ld a, 0
    adc a, 0
    ld d, a
    ld a, [W_GenericRegPreserve]
    add a, d
    ld [W_GenericRegPreserve], a
    
    jr .divideLoop
    
Status_DrawStatValue::
    push hl
    push de
    push bc
    push bc
    
    push hl
    call Status_DecimalizeStatValue
    pop hl
    
    xor a
    ld [W_Malias_DeCmpDst], a
    
    pop bc
    ld a, c
    cp 1
    jp nz, .hundredsDigitRangeCheck
    
    ld a, 1
    ld [Malias_DeCmpDst], a
    jp .tensDigit
    
;Partial check for hundreds digits outside of the normal digit range.
;Note that this check is actually very faulty 
.hundredsDigitRangeCheck
    ld a, [Malias_CmpSrcBank] ;hundreds digit
    and $F
    or a
    jr nz, .drawHundredsDigit
    xor a
    
.drawHundredsDigit
    add a, $F0
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    ld a, 1
    ld [Malias_DeCmpDst], a
    
.tensDigit
    inc hl
    ld a, [W_GenericRegPreserve]
    and $F0
    or a
    jr nz, .drawTensDigit
    
    ld b, a
    ld a, [Malias_DeCmpDst]
    or a
    jr z, .onesDigit
    ld a, b
    
.drawTensDigit
    swap a
    add a, $F0
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    
.onesDigit
    inc hl
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $F0
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    
    pop bc
    pop de
    pop hl
    ret

SECTION "Status Screen Int to Digits Draw Func 2", ROM0[$14B1]
Status_DrawStatValuePad3::
    push hl
    push de
    push bc
    xor a
    ld [Malias_DeCmpDst], a
    ld a, b
    ld [W_Status_DrawStatValuePad3Target], a
    ld a, c
    ld [W_Status_DrawStatValuePad3Target + 1], a
    
    ld bc, 1000
    call Status_ModuloDivide
    
    ld a, [Malias_CmpSrcBank]
    or a
    jr nz, .drawThousandsDigit
    ld b, a
    ld a, [W_Malias_DeCmpDst]
    or a
    jr z, .checkHundredsDigit
    ld a, b
    
.drawThousandsDigit
    add a, $F0
    push af
    ld a, [W_Status_DrawStatValuePad3Target]
    ld h, a
    ld a, [W_Status_DrawStatValuePad3Target + 1]
    ld l, a
    pop af
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    ld a, 1
    ld [Malias_DeCmpDst], a
    
.checkHundredsDigit
    ld a, [W_LCDC_CGBFadeFactor]
    ld h, a
    ld a, [W_LCDC_CGBFadeFactor + 1] ;boy I love pointer aliasing...
    ld l, a
    ld bc, 100
    call Status_ModuloDivide
    
    ld a, [Malias_CmpSrcBank]
    or a
    jr nz, .drawHundredsDigit
    ld b, a
    ld a, [Malias_DeCmpDst]
    or a
    ld a, b
    
.drawHundredsDigit
    add a, $F0
    push af
    ld a, [W_Status_DrawStatValuePad3Target]
    ld h, a
    ld a, [W_Status_DrawStatValuePad3Target + 1]
    ld l, a
    ld bc, 1
    add hl, bc
    xor a
    call TMAPWrapToLine
    pop af
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    ld a, 1
    ld [Malias_DeCmpDst], a
    
.checkTensDigit
    ld a, [W_LCDC_CGBFadeFactor]
    ld h, a
    ld a, [W_LCDC_CGBFadeFactor + 1]
    ld l, a
    ld bc, 10
    call Status_ModuloDivide
    
    ld a, [Malias_CmpSrcBank]
    or a
    jr nz, .drawTensDigit
    ld b, a
    ld a, [Malias_DeCmpDst]
    or a
    ld a, b
    
.drawTensDigit
    add a, $F0
    push af
    ld a, [W_Status_DrawStatValuePad3Target]
    ld h, a
    ld a, [W_Status_DrawStatValuePad3Target + 1]
    ld l, a
    ld bc, 1
    add hl, bc
    xor a
    call TMAPWrapToLine
    ld bc, 1
    add hl, bc
    xor a
    call TMAPWrapToLine
    pop af
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    
.checkOnesDigit
    ld a, [W_LCDC_CGBFadeFactor]
    ld h, a
    ld a, [W_LCDC_CGBFadeFactor + 1]
    ld l, a
    ld bc, 1
    call Status_ModuloDivide
    
.drawOnesDigit
    ld a, [Malias_CmpSrcBank]
    add a, $F0
    push af
    ld a, [W_Status_DrawStatValuePad3Target]
    ld h, a
    ld a, [W_Status_DrawStatValuePad3Target + 1]
    ld l, a
    ld bc, 1
    add hl, bc
    xor a
    call TMAPWrapToLine
    ld bc, 1
    add hl, bc
    xor a
    call TMAPWrapToLine
    ld bc, 1
    add hl, bc
    xor a
    call TMAPWrapToLine ;uh, copy-paste much?
    pop af
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    
    pop bc
    pop de
    pop hl
    ret