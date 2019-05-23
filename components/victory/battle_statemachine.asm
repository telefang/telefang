INCLUDE "telefang.inc"

SECTION "Victory On Battle Screen State Machine", ROMX[$4243], BANK[$1D]
Victory_BattleScreenStateMachine::
    ld a, [W_Battle_4thOrderSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl
    
.stateTable
    dw Victory_SubStateInit,$42C4,$42F6,$47D7
    dw $4827,Victory_SubStateStatWindowPalette,$4F3D,$4F80
    dw $4FC2,$4FD4,$4FE8,$449F
    dw Victory_SubStateStatWindowIdle,Victory_SubStateDrawStatWindow,$4942,Victory_SubStateCheckMoveUnlocks
    dw Victory_SubStateNewMoveMessage,$47E6,$4813,$4D96
    dw Victory_SubStateNaturalEvoQuestion,Victory_SubStateNaturalEvoInput,Victory_SubStateNaturalEvoCancel,$4C3A

;すばやさ - $427D
Victory_BattleScreenPrivateStrings_speed::
    db $44, $96, $5A, $42
    
;こうげき - $4281
Victory_BattleScreenPrivateStrings_attack::
    db $41, $3A, $8A, $3E
    
;ぼうぎょ - $4285
Victory_BattleScreenPrivateStrings_defense::
    db $99, $3A, $88, $6C
    
;でんこう - $4289
Victory_BattleScreenPrivateStrings_denmaAtk::
    db $94, $63, $41, $3A
    
;でんぼう - $428D
Victory_BattleScreenPrivateStrings_denmaDef::
    db $94, $63, $99, $3A

Victory_SubStateInit::
    ld a, $20
    ld [W_LCDC_MetaspriteAnimationBank], a
    ld bc, 1
    call Banked_LoadMaliasGraphics
    ld bc, $14
    call Banked_LoadMaliasGraphics
    ld a, 0
    ld bc, 4
    call CGBLoadObjectPaletteBanked
    ld a, 1
    ld [W_CGBPaletteStagedOBP], a
    ld a, [W_Victory_PlayerWon]
    cp 0
    jr z, .playerLost
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

.playerLost
    ld a, 6
    ld [W_LateDenjuu_SubSubState], a
    ret
