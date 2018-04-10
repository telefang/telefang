INCLUDE "telefang.inc"

SECTION "Event Action - Fucking Weird Sequence Jump and Continue", ROMX[$44B7], BANK[$F]
EventScript_FuckingWeirdSequenceJumpAndContinue::
	ld a, 0
	ld [W_EventScript_EventChainingOffset + 1], a
	ld a, 0
	ld [W_EventScript_EventChainingOffset], a
	ld a, [W_EventScript_ParameterA]
	ld [W_EventScript_EventSequencePointerIndex + 1], a
	ld a, [W_EventScript_ParameterB]
	ld [W_EventScript_EventSequencePointerIndex], a
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret
	
SECTION "Event Action - Relative Long Jump and Continue", ROMX[$474E], BANK[$F]
EventScript_RelativeLongJumpAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld d, a
	ld a, [W_EventScript_ParameterB]
	ld e, a
	inc de
	ld a, [W_EventScript_EventChainingOffset]
	ld l, a
	ld a, [W_EventScript_EventChainingOffset + 1]
	ld h, a
	add hl, de
	ld a, l
	ld [W_EventScript_EventChainingOffset], a
	ld a, h
	ld [W_EventScript_EventChainingOffset + 1], a
	scf
	ret


SECTION "Event Action - Flag Jump Actions", ROMX[$4843], BANK[$F]
EventScript_JumpOnPlayerWinAndContinue::
	ld a, [W_Victory_PlayerWon]
	or a
	jr nz, .playerWon
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret
	
.playerWon
	ld a, [W_EventScript_ParameterA]
	inc a
	ld b, a
	call EventScript_CalculateNextOffset
	scf
	ret


SECTION "Event Action - Flag Jump Actions", ROMX[$4A8A], BANK[$F]
EventScript_JumpIfFlagSetAndContinue::
	ld a, [W_EventScript_ParameterB]
	ld c, a
	ld a, [W_EventScript_ParameterA]
	ld b, a
	call Overworld_CheckFlagValue
	jr nz, EventScript_FlagJumpHandler
	ld  b, 4
	call EventScript_CalculateNextOffset
	scf  
	ret

EventScript_FlagJumpHandler::
	ld a, [W_EventScript_ParameterC]
	inc a
	ld b, a
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_JumpIfFlagUnsetAndContinue::
	ld a, [W_EventScript_ParameterB]
	ld c, a
	ld a, [W_EventScript_ParameterA]
	ld b, a
	call Overworld_CheckFlagValue
	jr z, EventScript_FlagJumpHandler
	ld b, 4
	call EventScript_CalculateNextOffset
	scf
	ret
