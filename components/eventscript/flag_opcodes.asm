INCLUDE "telefang.inc"

SECTION "Event Action - Flag Actions 1", ROMX[$43EE], BANK[$F]
EventScript_EventFlag800SAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld h, a
	ld a, [W_EventScript_ParameterB]
	ld l, a
	ld bc, $800
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_EventFlag400S800RAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld h, a
	ld a, [W_EventScript_ParameterB]
	ld l, a
	ld bc, $800
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_ResetFlag
	ld a, [W_EventScript_ParameterA]
	ld h, a
	ld a, [W_EventScript_ParameterB]
	ld l, a
	ld bc, $400
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_EventFlag400R800RAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld h, a
	ld a, [W_EventScript_ParameterB]
	ld l, a
	ld bc, $800
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_ResetFlag
	ld a, [W_EventScript_ParameterA]
	ld h, a
	ld a, [W_EventScript_ParameterB]
	ld l, a
	ld bc, $400
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_ResetFlag
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_CurrentEventFlag400S800RAndContinue::
	ld a, [W_EventScript_EventSequencePointerIndex]
	ld l, a
	ld a, [W_EventScript_EventSequencePointerIndex + 1]
	ld h, a
	ld bc, $800
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_ResetFlag
	ld a, [W_EventScript_EventSequencePointerIndex]
	ld l, a
	ld a, [W_EventScript_EventSequencePointerIndex + 1]
	ld h, a
	ld bc, $400
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_SetFlag
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_CurrentEventFlag800RAndContinue::
	ld a, [W_EventScript_EventSequencePointerIndex]
	ld l, a
	ld a, [W_EventScript_EventSequencePointerIndex + 1]
	ld h, a
	ld bc, $800
	add hl, bc
	ld b, h
	ld c, l
	call Overworld_ResetFlag
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret
	
EventScript_EffectiveEventFlag400S800RAndContinue::
	jp EventScript_EventFlag400S800RAndContinue

SECTION "Event Action - Flag Actions 2", ROMX[$4A66], BANK[$F]
EventScript_SetFlagAndContinue::
	ld a, [W_EventScript_ParameterB]
	ld c, a
	ld a, [W_EventScript_ParameterA]
	ld b, a
	call Overworld_SetFlag
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_ResetFlagAndContinue::
	ld a, [W_EventScript_ParameterB]
	ld c, a
	ld a, [W_EventScript_ParameterA]
	ld b, a
	call Overworld_ResetFlag
	ld  b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

