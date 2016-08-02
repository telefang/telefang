;"Status text" is text that we want to draw using the script system's text
;renderer, but isn't going to be interpreted by the script interpreter.

SECTION "Main Script Status Text Drawing WRAM", WRAM0[$CB2F]
W_MainScript_StatusLettersDrawn: ds 1

SECTION "Main Script Status Text Drawing", ROM0[$3A91]
MainScript_DrawStatusText::
    xor a
    ld [W_MainScript_StatusLettersDrawn], a
    
.loop
    push bc
    push de
    push hl
    ld a, [de]
    cp $E0
    jp z, .ret
    pop hl
    push hl
    call Banked_MainScript_DrawLetter
    pop hl
    ld bc, $10
    add hl, bc
    pop de
    inc de
    ld a, [W_MainScript_StatusLettersDrawn]
    inc a
    ld [W_MainScript_StatusLettersDrawn], a
    pop bc
    dec b
    jp nz, .loop
    ret
    
.ret
    pop hl
    pop de
    pop bc
    ret