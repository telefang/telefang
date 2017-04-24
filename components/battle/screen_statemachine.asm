SECTION "Battle Screen State Machine", ROMX[$4460], BANK[$5]
Battle_ScreenStateMachine::
    ld a, [W_SerIO_ConnectionState]
    or a
    jr z, .executeSubSubState
    
    ld a, [W_Battle_SubSubState]
    cp $37
    jr z, .executeSubSubState
    cp $38
    jr z, .executeSubSubState
    cp $39
    jr z, .executeSubSubState
    call $06B4
    
    ld a, [Malias_CmpSrcBank]
    or a
    jr z, .executeSubSubState
    
    ld a, $37
    ld [W_Battle_SubSubState], a
    
.executeSubSubState
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]

.stateTable
    dw $457D,$45A9,$45F5,$463E,$4681,$4B07,$4BC6,$4C34 ;00-07
    dw $4D1F,$4DDD,$4F81,$510A,$545C,$545F,$57FB,$59BC ;08-0F
    dw $5F2D,$5F57,$62CD,$6348,$6360,$63FE,$6416,$46E2 ;10-17
    dw $46F2,$4707,$48E9,$48FC,$4911,$464B,$6099,$6289 ;18-1F
    dw $5FD6,$6318,$61FB,$50F5,$53EF,$5F3D,$4721,$48AD ;20-27
    dw $492F,$4AAD,$4F12,$5F79,$5428,$5489,$4AF8,$63EF ;28-2F
    dw $63E0,$5F66,$5FA1,$5FB4,$5661,$5292,$5683,$452D ;30-37
    dw $454A,$4566,$561E,$5051,$50E0,$5416,$4F32,$5810 ;38-3F

Battle_ScreenUIStrings::
    INCBIN "script/battle/ui_strings.stringtbl"