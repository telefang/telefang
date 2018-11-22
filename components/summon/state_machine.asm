SECTION "Summon Memory 1", WRAMX[$D413], BANK[1]
W_Summon_SelectedPageCount:: ds 1
W_Summon_SelectedPageContact:: ds 1

SECTION "Summon Memory 2", WRAMX[$D4A0], BANK[1]
W_Summon_CurrentPage:: ds 1
W_Summon_MaxPages:: ds 1

SECTION "Summon Screen State Machine", ROMX[$4AFD], BANK[$1C]
Summon_StateMachine::
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]
    
.stateTable
    dw $4B53
    dw Summon_StateFadeOutIntoSummonScreen
    dw Summon_StateEnter
    dw $4D22
    dw $4D39
    dw $4D63
    dw $4D81
    dw $4FFD
    dw $5033
    dw $506C
    dw $5097
    dw $50AE
    dw $51CF
    dw $51D9
    dw $7F5C

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
    
;$4B43
.noDenjuu
    db "-", 0, "None", 0, "-"
    
;$4B4B
.page
    db "Pg.", 0, 0
    
;$4B50
.outOf
    db 0, " /"

Section "Summon Screen State 1 and Forward", ROMX[$4BB6], BANK[$1C]
; This state is used when fading out from the encounter screen and
; the check-your-own-Denjuu status screen into the summon screen.
Summon_StateFadeOutIntoSummonScreen::
    ld a, 1
    call Banked_LCDC_PaletteFade
    ; Apparently this is a "JoJoke", if kmeist's comment in the
    ; status screen state machine code is to be believed.
    or a
    ret z

    ld a, Banked_Summon_ADVICE_ExitIntoSummonScreen & $FF
    call PatchUtils_AuxCodeJmp

    call $52C9 ; Initializes the encounter, I presume.

.encounterInitialized::
    jp Battle_IncrementSubSubState

Summon_StateEnter::
    ld bc, $12
    call Banked_CGBLoadBackgroundPalette
    ld a, $28
    call PauseMenu_CGBStageFlavorPalette
    ld bc, $15
    call Banked_LoadMaliasGraphics
    ld hl, $8800
    call $57C8 ; Loads the phone border tiles to [hl].

    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    ld hl, $0390
    add hl, de
    push hl
    
    pop bc
    xor a
    call CGBLoadBackgroundPaletteBanked

    ld hl, $9400
    ld a, 32
    call MainScript_DrawEmptySpaces

    ld bc, 0
    ld e, $0D
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, 0
    ld e, $0D
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0

    ld bc, 0
    ld e, $B7
    ld a, 0
    call Banked_RLEDecompressTMAP0

    ld hl, $9882
    ld a, [W_Overworld_SignalStrength]
    call Encounter_DrawSignalIndicator

    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles

    ; There's a *lot* still left of this state. Hoo boy.
    ; ...
