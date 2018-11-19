SECTION "Victory On Battle Screen State Machine", ROMX[$4243], BANK[$1D]
Victory_BattleScreenStateMachine::
    ld a, [W_Battle_4thOrderSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]
    
.stateTable
    dw $4291,$42C4,$42F6,$47D7
    dw $4827,Victory_SubStateStatWindowPalette,$4F3D,$4F80
    dw $4FC2,$4FD4,$4FE8,$449F
    dw Victory_SubStateStatWindowIdle,Victory_SubStateDrawStatWindow,$4942,Victory_SubStateCheckMoveUnlocks
    dw Victory_SubStateNewMoveMessage,$47E6,$4813,$4D96
    dw Victory_SubStateNaturalEvoQuestion,Victory_SubStateNaturalEvoInput,Victory_SubStateNaturalEvoCancel,$4C3A

;Spd - $427D
Victory_BattleScreenPrivateStrings_speed::
    db "Spd "
    
;Atk - $4281
Victory_BattleScreenPrivateStrings_attack::
    db "Atk "
    
;Def - $4285
Victory_BattleScreenPrivateStrings_defense::
    db "Def "
    
;D.Atk - $4289
Victory_BattleScreenPrivateStrings_denmaAtk::
    db $F, "Atk"
    
;D.Def - $428D
Victory_BattleScreenPrivateStrings_denmaDef::
    db $F, "Def"

SECTION "Clear Status Effects Hack", ROMX[$4296], BANK[$1D]
    ; Part of a much larger battle system function.
    ; If we don't clear the status effect tilemaps, since they're extended by
    ; one tile each, the battle end graphics will be shown in their place.
    nop
    ld a, Banked_Battle_ADVICE_ClearStatusEffectTilemaps & $FF
    call PatchUtils_AuxCodeJmp

SECTION "Clear Status Effects Hack (Link Battles)", ROMX[$5B75], BANK[$1F]
    ; Part of a much larger battle system function.
    ; Same as the previous section, except... duplicated for link battles.
    nop
    ld a, Banked_Battle_ADVICE_ClearStatusEffectTilemaps & $FF
    call PatchUtils_AuxCodeJmp
