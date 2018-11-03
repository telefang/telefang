SECTION "Contact Enlist 32-bit Maths RAM", WRAM0[$CA6A]
W_ContactEnlist_Carry:: ds 1

SECTION "Contact Enlist 32-bit Maths", ROMX[$44E5], BANK[$29]
; Add the 32-bit value in bcde to the 32-bit value in [hl].
; 
; HL = Pointer to 32-bit value to add
; BCDE = 32-bit value literal
; 
; Returns
; BCDE = 32-bit result
; [W_ContactEnlist_Carry] = Carry bit result
ContactEnlist_32ConstantBy32Add::
    ldi a, [hl]
    add a, e
    ld e, a
    ld a, 0
    adc a, d
    ld d, a
    ld a, 0
    adc a, c
    ld c, a
    ld a, 0
    adc a, b
    ld b, a
    ld a, 0
    adc a, 0
    ld [W_ContactEnlist_Carry], a
    
    ldi a, [hl]
    add a, d
    ld d, a
    ld a, 0
    adc a, c
    ld c, a
    ld a, 0
    adc a, b
    ld b, a
    ld a, [W_ContactEnlist_Carry]
    adc a, 0
    ld [W_ContactEnlist_Carry], a
    
    ldi a, [hl]
    add a, c
    ld c, a
    ld a, 0
    adc a, b
    ld b, a
    ld a, [W_ContactEnlist_Carry]
    adc a, 0
    ld [W_ContactEnlist_Carry], a
    
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    add a, b
    ld b, a
    ld a, [W_ContactEnlist_Carry]
    adc a, 0
    ld [W_ContactEnlist_Carry], a
    ret
