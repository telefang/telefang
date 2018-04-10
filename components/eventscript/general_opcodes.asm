INCLUDE "telefang.inc"

SECTION "Event Action - Warp Player and Continue", ROMX[$428F], BANK[$F]
EventScript_WarpPlayerAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_Overworld_AcreType], a
	ld a, [W_EventScript_ParameterB]
	ld [$C906], a
	ld a, [W_EventScript_ParameterC]
	ld b, a
	inc a
	ld c, a
	and a, $F0
	add a, 8
	ld [$C901], a
	ld a, c
	swap a
	and a, $F0
	ld [$C902], a
	ld a, [W_SystemSubState]
	cp a, 1
	jr z, .jpA
	ld a, 7
	ld [W_SystemSubState], a
	ld a, $F
	ld [W_PreviousBank], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld b, 4
	call EventScript_CalculateNextOffset
	xor a
	ret

.jpA
	ld a, 0
	ld [W_SystemSubState], a
	ld b, 4
	call EventScript_CalculateNextOffset
	xor a
	ret

SECTION "Event Action - Wait X Frames and Continue", ROMX[$4247], BANK[$F]
EventScript_WaitXFramesAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_EventScript_WaitFrames], a
	ld b, 2
	call EventScript_CalculateNextOffset
	
; It should be noted that if the carry flag is set at the end of an action then it will immediately continue to the next action in the sequence without waiting a frame.
; Generally "xor a" is used to reset the carry flag, and "scf" is used to set it.
	
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

SECTION "Event Action - Standard End", ROMX[$4263], BANK[$F]
; I may rename this later if I find other endcodes.
EventScript_StandardEnd::
	ld a, 0
	ld [$C950], a
	ld [$C951], a
	ld a, 3
	ld [$C918], a
	
; This function call seems to reset button inputs.
	
	call $225B
	ld a, 8
	ld [W_EventScript_WaitFrames], a
	ld a, [$C940]
	or a
	jr nz, .jpA
	inc a
	ld [$C940], a

.jpA
	ld a, [W_MetaSpriteConfigPlayer + $19]
	and a, $FD
	ld [W_MetaSpriteConfigPlayer + $19], a
	xor a
	ld [$CD00], a
	ret
