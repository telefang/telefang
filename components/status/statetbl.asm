SECTION "Status Screen State Machine Vars", WRAMX[$D41F], BANK[1]
W_Status_SubState: ds 1

SECTION "Status Screen State Machine Vars 2", WRAMX[$D456], BANK[1]
W_Status_UseDenjuuNickname: ds 1

SECTION "Status Screen Home Utils", ROM0[$3CFD]
Status_IncrementSubState::
    ld hl, W_Status_SubState
    inc [hl]
    ret

SECTION "Status Screen State Machine", ROMX[$4B8B], BANK[$02]
Status_GameStateMachine::
    ld a, [W_Status_SubState]
    ld hl, Status_GameStateTable
    call System_IndexWordList
    jp [hl]

Status_GameStateTable:
    dw Status_State0,Status_State1,Status_State2,$4D7A
    dw $4DBB,$4F2D,$4F96,$4E98
    dw $4F1D

Status_TextTable: ;4BA7
    INCBIN "script/status/ui_strings_1.stringtbl"
    INCBIN "script/status/ui_strings_2.stringtbl" ;4BB1

SECTION "Status Screen State Implementations", ROMX[$4C81], BANK[$02]
Status_State0:
    ld bc, $E
    call Banked_LoadMaliasGraphics
    ld a, $F0
    ld [$C91E], a
    call $3566
    ld bc, $16
    call Banked_CGBLoadBackgroundPalette
    ld a, 0
    call $3EB9
    ld a, 0
    call $543
    ld a, [$CB2B]
    cp 0
    jp z, .loc_8CAC
    call Status_LoadContactInfo
    jr .infoLoaded

.loc_8CAC
    ld a, [W_Status_UseDenjuuNickname]
    cp 0
    jr z, .loc_8CB8
    call Status_LoadContactInfo
    jr .infoLoaded

.loc_8CB8
    ld a, [W_SystemSubState]
    cp 1
    jr nz, .loc_8CC4
    call Status_LoadSpecialInfo ;Like LoadContactInfo but it loads from $D5B6
    jr .infoLoaded

.loc_8CC4:
    call Status_LoadContactInfo

.infoLoaded:
    ld a, [W_Status_SelectedDenjuuByte0]
    push af
    ld c, 1
    ld de, $8800
    call $516
    pop af
    call $175F
    xor a
    ld [$CB30], a
    jp Status_IncrementSubState

Status_State1:
    ld bc, 0
    ld e, 1
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, 0
    ld e, 1
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    jp Status_IncrementSubState

Status_State2:
    ld a, [W_Status_SelectedDenjuuByte0]
    ld de, $9200
    call $3D95 ;Some weird-ass jump/lookup table
    ld a, [W_Status_SelectedDenjuuByte3]
    call $5AC
    ld a, [W_Status_SelectedDenjuuByte3]
    call $5B1
    ld hl, $9300
    ld a, 8
    call MainScript_DrawEmptySpaces
    ld a, [W_Status_UseDenjuuNickname]
    cp 1
    jr z, .isNicknamedDenjuu
    ld a, [W_SystemSubState]
    cp 1
    jr z, .loc_8D2B
    
.isNicknamedDenjuu:
    ld a, [W_Status_SelectedDenjuuIndex]
    ld hl, $9300
    call Status_DrawDenjuuNickname
    jr .loc_8D37

.loc_8D2B:
    ld a, [W_Status_SelectedDenjuuByte0]
    ld de, $4000
    ld bc, $9300
    call MainScript_DrawCenteredDenjuuName
    
.loc_8D37:
    ld a, [W_Status_SelectedDenjuuByte3]
    ld bc, $8D80
    ld de, $7928
    call MainScript_DrawCenteredDenjuuName
    call $597
    call $50C2
    ld de, Status_TextTable
    ld hl, $8E00
    ld b, 8
    call Banked_MainScript_DrawStatusText
    ld a, [$CB30]
    cp 0
    jr nz, .loc_8D64
    call $502E
    call $523B
    call $504A

.loc_8D64:
    ld a, [$CB30]
    add a, 2
    ld e, a
    ld bc, 9
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    ld a, 4
    call $050A ;Banked_SetupPalswapAnimation
    jp Status_IncrementSubState