INCLUDE "macros.asm"

;Telefang uses a nested state machine to control code execution across multiple
;frames. There are 16 states in total, many of which are sub-state machines of
;variable cardinality. Some sub-state machines have a third level of execution
;in a sub-sub-state machine as well; as well as or alongside their own private
;state machines as well.

SECTION "SystemStateMachine WRAM", WRAM0[$C3E0]
W_SystemState:: ds 1
W_SystemSubState:: ds 1
W_SystemSubSubState:: ds 1

SECTION "StateMachine Tools", ROM0[$E97]
System_IndexWordList::
    ld b, 0
    ld c, a
    sla c
    rl b
    add hl, bc
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret
    
System_ScheduleNextSubState::
    ld a, [W_SystemSubState]
    inc a
    ld [W_SystemSubState], a
    ret
    
System_ScheduleNextSubSubState::
    ld a, [W_SystemSubSubState]
    inc a
    ld [W_SystemSubSubState], a
    ret

SECTION "StateMachine Execution", ROM0[$1BE2]
GameStateMachine::
	ld a, [W_SystemState]
	ld hl, GameStateMachineTable
	ld d, 0
	ld e, a
	sla e
	rl d
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp [hl]

GameStateMachineTable:
	dw GameState00, GameState01, GameState02, GameState03
	dw GameState04, GameState05, GameState06, GameState07
	dw GameState08, GameState09, GameState10, GameState11
	dw GameState11, GameState13, GameState14, GameState15

;Disassembly of individual substates follows.
;TODO: Name each state.

GameState00:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $5300

GameState01:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $493F

GameState02:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $4000

GameState03:
	ld a, 4
	ld [W_PreviousBank], a
	rst $10
	jp $4000

GameState04:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $40BF

GameState05:
	ld a, $B
	ld [W_PreviousBank], a
	rst $10
	jp $1EA1

GameState06:
	ld a, $1C
	ld [W_PreviousBank], a
	rst $10
	jp $4000

GameState07:
	ld a, 5
	ld [W_PreviousBank], a
	rst $10
	jp $441B

GameState08:
	ld a, $1D
	ld [W_PreviousBank], a
	rst $10
	jp $4000

GameState09:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $4B8B

GameState10:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $4824

GameState11: ;Repeated twice in original ROM.
	ld a, 4
	ld [W_PreviousBank], a
	rst $10
	jp $45C0

GameState13:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $44CF

GameState14:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $458E

GameState15:
	ld a, $1F
	ld [W_PreviousBank], a
	rst $10
	jp $4000