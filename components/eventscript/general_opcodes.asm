INCLUDE "telefang.inc"

SECTION "Event Action - Wait X Frames and Continue", ROMX[$4247], BANK[$F]
EventScript_WaitXFramesAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_EventScript_WaitFrames], a
	ld b, 2
	call EventScript_CalculateNextOffset
	xor a
	ret

SECTION "Event Action - Set Music and Continue", ROMX[$480F], BANK[$F]
EventScript_SetMusicAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret
	
SECTION "Event Action - Output Message and Continue", ROMX[$4222], BANK[$F]
EventScript_OutputMessageAndContinue::
	ld hl, W_EventScript_ParameterA
	ld a, [hli]
	ld b, a
	ld c, [hl]
	call $33C9
	ld b, 3
	call EventScript_CalculateNextOffset
	ld a, [W_EventScript_WaitFrames]
	or a
	jr nz, .weAreWaitingAlready
	ld a, 8
	ld [W_EventScript_WaitFrames], a
	
.weAreWaitingAlready
	xor a
	ret
