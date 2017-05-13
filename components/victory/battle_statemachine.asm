SECTION "Victory On Battle Screen State Machine", ROMX[$4243], BANK[$1D]
Victory_BattleScreenStateMachine::
    ld a, [W_Battle_4thOrderSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]
    
.stateTable
    dw $4291,$42C4,$42F6,$47D7,$4827,$4957,$4F3D,$4F80
    dw $4FC2,$4FD4,$4FE8,$449F,$4B86,$497D,$4942,$4BDC
    dw $4C2B,$47E6,$4813,$4D96,$4E64,$4E89,$4F27,$4C3A

Victory_BattleScreenPrivateStrings::

;Spd - $427D
.speed
    db "Spd "
    
;Atk - $4281
.attack
    db "Atk "
    
;Def - $4285
.defense
    db "Def "
    
;D.Atk - $4289
.denmaAtk
    db $F, "Atk"
    
;D.Def - $428D
.denmaDef
    db $F, "Def"