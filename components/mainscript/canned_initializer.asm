SECTION "MainScript canned initializers", ROMX[$47ED], BANK[$B]
MainScript_InitializeMenuText::
    ;Point the MainScript text engine to draw at $9800... for some reason
    ld hl, W_MainScript_TilePtr
    ld a, 0
    ld [hli], a
    ld a, $98
    ld [hl], a
    
    ld a, d
    ld [W_MainScript_WindowLocation], a
    
    ld d, 0
    ld e, b
    ld hl, MainScript_table
    add hl, de
    add hl, de
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld [W_MainScript_TextBank], a
    
    ld l, c
    ld h, 0
    sla l
    rl h
    add hl, de
    call MainScript_Jump2Operand
    
    xor a
    call MainScript_ADVICE_RepositionCursor
    ld [W_MainScript_NumNewlines], a
    ld [W_MainScript_WaitFrames], a
    ld [W_MainScript_ContinueBtnPressed], a
    ld [W_MainScript_VWFMainScriptHack], a
    ld [W_MainScript_TextSpeed], a
    ld [$CADA], a
    inc a
    ld [W_MainScript_State], a
    ret