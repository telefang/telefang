INCLUDE "telefang.inc"

SECTION "Event Action - Jump on Silent Mode and Continue", ROMX[$4FB3], BANK[$F]
EventScript_JumpOnSilentModeAndContinue::
	ld a, [W_Phone_SilentMode]
	or a
	jr nz, .phoneIsOnSilent
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

.phoneIsOnSilent
	ld a, [W_EventScript_ParameterA]
	inc a
	ld b, a
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Comparative Jump and Continue", ROMX[$4CD9], BANK[$F]
EventScript_IncrementComparativeAndContinue::
	ld a, [W_EventScript_JumpComparative]
	inc a
	ld [W_EventScript_JumpComparative], a
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_DecrementComparativeAndContinue::
	ld a, [W_EventScript_JumpComparative]
	dec a
	ld [W_EventScript_JumpComparative], a
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_SetComparativeAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_EventScript_JumpComparative], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_JumpIfMatchComparativeAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld b, a
	ld a, [W_EventScript_JumpComparative]
	cp b
	jr nz, .noMatch
	ld a, [W_EventScript_ParameterB]
	inc a
	ld b, a
	call EventScript_CalculateNextOffset
	scf
	ret

.noMatch
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_JumpIfNotMatchComparativeAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld b, a
	ld a, [W_EventScript_JumpComparative]
	cp b
	jr z, .match
	ld a, [W_EventScript_ParameterB]
	inc a
	ld b, a
	call EventScript_CalculateNextOffset
	scf 
	ret

.match
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

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


SECTION "Event Action - Flag Jump Actions 2", ROMX[$4A8A], BANK[$F]
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

	
SECTION "Event Action - Set Multi Jump Conditional", ROMX[$449C], BANK[$F]
EventScript_SetMultiJumpConditionalAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_EventScript_MultiJumpConditional], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_IncrementMultiJumpConditionalAndContinue::
	ld a, [W_EventScript_MultiJumpConditional]
	inc a
	ld [W_EventScript_MultiJumpConditional], a
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret
	
SECTION "Event Action - Jump Using MultiJumpConditional and Continue", ROMX[$473A], BANK[$F]
EventScript_JumpUsingMultiJumpConditionalAndContinue::

; W_EventScript_MultiJumpConditional represents which parameter we are grabbing our relative jump offset from.
; Unfortunately this means that the length of this action can be anything from 2 bytes (1 parameter) to 8 bytes (7 parameters).
; When it comes to dumping event sequences this action will be a pain.

	ld a, [W_EventScript_MultiJumpConditional]
	ld hl, W_EventScript_ParameterA
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]
	inc a
	ld b, a
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Jump on Player Direction and Continue", ROMX[$4822], BANK[$F]
EventScript_JumpOnPlayerDirectionAndContinue::
; Parameter A is the direction we are comparing with. 0=Right, 1=Up/Down, 2=Left.
; Parameter B is the relative offset of where we are jumping to.
	ld a, [W_EventScript_ParameterA]
	ld b, a
	ld a, [W_MetaSpriteConfigPlayer + $17]
; Normally 3 represents down, but we want it to be the same value as up, which is 1.
	bit 0, a
	jr z, .isEven
	xor a, 2

.isEven
	cp b
	jr z, .makeTheJump
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

.makeTheJump
	ld a, [W_EventScript_ParameterB]
	inc a
	ld b, a
	call EventScript_CalculateNextOffset
	scf
	ret
