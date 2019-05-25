INCLUDE "telefang.inc"

SECTION "Link Victory On Battle Screen State Machine", ROMX[$5B03], BANK[$1F]
LinkVictory_BattleScreenStateMachine::
    ld a, [W_Battle_4thOrderSubState]
    cp 5
    jr z, .dontFireConnectionErrorState
    cp 6
    jr z, .dontFireConnectionErrorState
    cp 7
    jr z, .dontFireConnectionErrorState
    call $461B
    ld a, [Malias_CmpSrcBank]
    or a
    jr z, .dontFireConnectionErrorState
    ld a, 5
    ld [W_Battle_4thOrderSubState], a

.dontFireConnectionErrorState
    ld a, [W_Battle_4thOrderSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl

.stateTable
    dw LinkVictory_SubStateInit
    dw $5B91
    dw $5BBE
    dw $5BE1
    dw $5C22
    dw $5B3A
    dw $5B42
    dw $5B59

SECTION "Link Victory On Battle Screen State Machine 2", ROMX[$5B70], BANK[$1F]
LinkVictory_SubStateInit::
    ld a, $20
    ld [W_LCDC_MetaspriteAnimationBank], a
    ld bc, 1
    call Banked_LoadMaliasGraphics
    ld bc, $14
    call Banked_LoadMaliasGraphics
    ld a, [W_Victory_PlayerWon]
    cp 0
    jr z, .playerLost
    jp SerIO_Increment4thOrderSubState

.playerLost
    ld a, 3
    ld [W_Battle_4thOrderSubState], a
    ret
