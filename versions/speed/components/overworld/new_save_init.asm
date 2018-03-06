INCLUDE "telefang.inc"

SECTION "Overworld New Save Init", ROMX[$5538], BANK[$32]
Overworld_InitializeNewSaveFile::
    ld a, [W_Overworld_State]
    or a
    jp nz, .noInitNeeded
 
.initNeeded
    ld a, [$C922]
    ld c, a
    ld a, [$C923]
    ld b, a
    ld a, [$C92A]
    ld d, a
    ld a, [$C92B]
    ld e, a
    push de
    push bc
    xor a
    ld hl, $C500
    ld b, 0
    call memfill  ; A = fill value, B = length to fill, HL = fill start
    call memfill  ; A = fill value, B = length to fill, HL = fill start
    
    ld hl, $C92C
    ld de, $CD00
    ld b, 9
    call Banked_Memcpy_INTERNAL
    
    xor a
    ld hl, W_Overworld_State
    ld b, $80 ; 'Ç'
    call memfill  ; A = fill value, B = length to fill, HL = fill start
    
    ld hl, $CD00
    ld de, $C92C
    ld b, 9
    call Banked_Memcpy_INTERNAL
    
    ld a, [W_PauseMenu_PhoneState]
    push af
    xor a
    ld hl, $CD00
    ld b, 0
    call memfill  ; A = fill value, B = length to fill, HL = fill start
    
    pop af
    ld [W_PauseMenu_PhoneState], a
    
    pop bc
    pop de
    ld a, b
    add a, d
    ld [$C922], a
    
    ld a, c
    add a, e
    ld a, a
    ld [$C923], a
    
    ld a, 1
    ld [W_Overworld_State], a
    ld a, $40 ; '@'
    ld [$C901], a
    ld a, $40 ; '@'
    ld [$C928], a
    ld a, $70 ; 'p'
    ld [$C902], a
    ld a, $70 ; 'p'
    ld [$C929], a
    ld a, $2B ; '+'
    ld [W_Overworld_AcreType], a
    ld a, $2B ; '+'
    ld [$C926], a
    ld a, 9
    ld [$C906], a
    ld a, 9
    ld [$C927], a
    ld a, 0
    ld [$C917], a
    
    ld a, [$C922]
    ld c, a
    ld a, [W_FrameCounter]
    add a, c
    ld [$C922], a
    
    ld a, [$C923]
    ld c, a
    ld a, [W_FrameCounter]
    add a, c
    ld [$C923], a
    call $30A7
    ld [$C920], a
    call $30A7
    ld [$C921], a
    
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, 2
    ld [REG_MBC3_SRAMBANK], a
    ld a, 0
    ld [W_PauseMenu_DeletedContact], a
    ld a, 5
    ld [$A001], a
    ld a, $32 ; '2'
    ld [$A002], a
    ld a, 0
    ld [$A008], a
    
    ld a, [$C906]
    push af
    call $30A7
    ld [$C906], a
    ld [$A009], a
    
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, 2
    ld [REG_MBC3_SRAMBANK], a
    ld a, 6 ; SPEED Version specific!!!
    ld [$A000], a
    ld a, $A ; SPEED Version specific!!!
    ld [$A003], a
    ld a, 6 ; SPEED Version specific!!!
    ld [$C912], a
    
    ld hl, $A006
    ld a, 1 ; SPEED Version specific!!!
    ld [hli], a
    ld a, 4
    ld [hl], a
    
    ld de, $401 ; SPEED Version specific!!!
    ld c, 1 ; SPEED Version specific!!!
    push de
    ld a, $29 ; ')'
    ld hl, $4162
    call CallBankedFunction_int
    
    ld hl, $A00A
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, [$CA69]
    ld [hl], a
    
    pop de
    ld c, 0
    ld a, $29 ; ')'
    ld hl, SaveClock_InitializeNewDenjuu
    call CallBankedFunction_int
    
    ld a, 0
    ld [REG_MBC3_SRAMENABLE], a
    
    pop af
    ld [$C906], a
    
    ld a, $29 ; ')'
    ld hl, $5525
    call CallBankedFunction_int
    
    ld a, c
    ld [$C955], a
    
    ld bc, $C00
    call $2C57
    
    ld bc, $1DD
    call $2C57
    
    ld a, 1
    ld [$C93E], a
    
    ld hl, $C910
    ld a, $F4 ; '('
    ld [hli], a
    ld a, 1
    ld [hl], a
    ld a, 0
    ld [$C90A], a
    ld a, 1
    ld [$CD27], a
    ld a, $E
    ld [W_PreviousBank], a
    ld a, 4
    ld [$C940], a
    call $30A7
    
    ld e, a
    ld c, $C7 ; '¦'
    call System_Multiply8
    
    ld a, d
    ld [$C943], a

.noInitNeeded
    ld a, [$C912]
    ld [$CDB9], a
    ret