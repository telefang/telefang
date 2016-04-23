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
	dw $1C14, $1C1D, $1C26, $1C2F, $1C38, $1C41, $1C4A, $1C53
	dw $1C5C, $1C65, $1C6E, $1C77, $1C77, $1C80, $1C89, $1C92

;Disassembly of individual substates follows.