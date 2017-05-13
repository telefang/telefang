SECTION "Summon Screen State Machine", ROMX[$4AFD], BANK[$1C]
Summon_StateMachine::
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]
    
.stateTable
    dw $4B53, $4BB6, $4BCA, $4D22, $4D39, $4D63, $4D81, $4FFD
    dw $5033, $506C, $5097, $50AE, $51CF, $51D9, $7F5C

Summon_PrivateStrings::
;る - $4B25
    db $5E

;でんじゃうがいません! - $4B26
    db $94, $63, $8D, $6B, $3A, $87, $39, $55, $45, $63, $B9, 0, 0
    
;ひき - $4B33
    db $52, $3E, 0

;よべます - $4B36
    db $5C, $7F, $55, $44, 0, 0

;よべません! - $4B3C
    db $5C, $7F, $55, $45, $63, $B9, 0
    
;だれもよべません - $4B43
.noDenjuu
    db $91, $5F, $59, $5C, $7F, $55, $45, $63
    
;リスト - $4B4B
.page
    db $28, $0D, $14, 0, 0
    
;/ - $4B50
.outOf
    db $CB, 0, 0