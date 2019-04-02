INCLUDE "telefang.inc"

SECTION "Battle State Machine", ROMX[$441B], BANK[$5]
Battle_StateMachine::
	ld a, [W_SystemSubState]
	ld hl, .table
	call System_IndexWordList
	jp hl

.table
	dw Battle_StateScreenSubMachine
	dw Battle_StateExitOnCompletion
	dw Battle_StateExitOnFlee
	dw Battle_StateLinkExitOnCompletion

Battle_StateScreenSubMachine::
	jp Battle_ScreenStateMachine

Battle_StateExitOnCompletion::
	ld a, 0
	ld [W_SystemSubState], a
	ld a, 8
	ld [W_SystemState], a
	ret

Battle_StateExitOnFlee::
	ld a, [$D502]
	ld [$C955], a
	ld a, $A
	ld [W_SystemSubState], a
	ld a, 5
	ld [W_SystemState], a
	ret

Battle_StateLinkExitOnCompletion::
	xor a
	ld [W_LateDenjuu_SubSubState], a
	ld a, 2
	ld [W_Battle_SubSubState], a
	ld a, 1
	ld [W_SystemSubState], a
	ld a, $F
	ld [W_SystemState], a
	ret