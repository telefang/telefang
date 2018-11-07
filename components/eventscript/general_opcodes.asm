INCLUDE "telefang.inc"

SECTION "Event Action - Change Phone State and Continue", ROMX[$4FA6], BANK[$F]
EventScript_ChangePhoneStateAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_PauseMenu_PhoneState], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Play Credits and Continue", ROMX[$4F93], BANK[$F]
EventScript_PlayCreditsAndContinue::
	call $2411
	ld a, $30
	ld [W_SystemSubState], a
	ld a, 4
	call LCDC_SetupPalswapAnimation
	ld b, 1
	call EventScript_CalculateNextOffset
	ret

SECTION "Event Action - Ring Ring and Continue", ROMX[$4E70], BANK[$F]
EventScript_RingRingAndContinue::
	ld a, [W_Overworld_MannerMode]
	or a
	jr nz, .onSilent
	ld a, 2
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, $54
	ld [W_Sound_NextSFXSelect], a

.onSilent
	ld a, 4
	ld [$C940], a
	ld a, 1
	ld [W_Overworld_PowerAntennaPattern], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Stop Ringing and Continue", ROMX[$4E97], BANK[$F]
EventScript_StopRingingAndContinue::
	ld a, [W_Overworld_MannerMode]
	or a
	jr nz, .phoneWasOnSilent
	ld a, 1
	ld [W_Sound_NextSFXSelect], a
	ld a, $FF
	ld [$C917], a
	call $3435

.phoneWasOnSilent
	ld a, 0
	ld [W_Overworld_PowerAntennaPattern], a
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret

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

SECTION "Event Action - Mode7 Warp Player and Continue", ROMX[$42D9], BANK[$F]
EventScript_Mode7WarpPlayerAndContinue::
; Yes I know it isn't actually Mode 7. I couldn't think of a better name.
	ld a, [W_Overworld_AcreType]
	ld [$CA69], a
	ld a, 0
	ld [$C958], a
	ld a, $32
	ld hl, $59AC
	call CallBankedFunction_int
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

SECTION "Event Action - Wait For Button Press and Continue", ROMX[$4254], BANK[$F]
EventScript_WaitForButtonPressAndContinue::
; Waits for buttons A or B to be pressed before continuing.
	ldh a, [H_JPInput_Changed]
	and a, 3
	jr nz, .buttonPressed
	xor a
	ret

.buttonPressed
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret
	
SECTION "Event Action - Set Reception and Continue", ROMX[$4EB6], BANK[$F]
EventScript_SetReceptionAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_Overworld_SignalStrength], a
	ld b, 0
	ld a, $29
	ld hl, $503B
	call CallBankedFunction_int
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Schedule SFX and Continue", ROMX[$4802], BANK[$F]
EventScript_ScheduleSFXAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_Sound_NextSFXSelect], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
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

SECTION "Event Action - Initiate Battle and Continue", ROMX[$476A], BANK[$F]
EventScript_InitiateBattleAndContinue::
	ld a, [W_EventScript_ParameterB] ; Completely redundant line.
	ld a, 1
	ld [$C91D], a
	ld a, [W_EventScript_ParameterA]
	ld [$D402], a
	ld a, [W_EventScript_ParameterB]
	ld [W_Encounter_TFangerClass], a
	ld a, [W_EventScript_ParameterC]
	ld [W_Encounter_BattleType], a
	ld b, 4
	call EventScript_CalculateNextOffset
	xor a
	ret

SECTION "Event Action - Manipulate Inventory and Continue", ROMX[$478B], BANK[$F]
; Yet to verify, but it seems obvious at a glance.
EventScript_IncreaseInventoryAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld hl, W_PauseMenu_InventoryQuantities
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [W_EventScript_ParameterB]
	ld b, a
	ld a, [hl]
	add b
	ld [hl], a
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_DecreaseInventoryAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld hl, W_PauseMenu_InventoryQuantities
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [W_EventScript_ParameterB]
	ld b, a
	ld a, [hl]
	sub b
	ld [hl], a
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Manipulate Chiru and Continue", ROMX[$47BF], BANK[$F]
EventScript_AddChiruAndContinue::
	ld a, [W_EventScript_ParameterB]
	ld b, a
	ld a, [W_EventScript_ParameterA]
	ld c, a
	ld a, $B
	ld hl, $5ED9
	call CallBankedFunction_int
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

EventScript_SubtractChiruAndContinue::
	ld a, [W_EventScript_ParameterA]
	cpl
	ld c, a
	ld a, [W_EventScript_ParameterB]
	cpl
	ld b, a
	inc bc
	ld a, $B
	ld hl, $5ED9
	call CallBankedFunction_int
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Reset Overworld Interation and Continue", ROMX[$4F44], BANK[$F]
EventScript_ResetOverworldInterationAndContinue::
	call $2928
	ldh a, [H_JPInput_Changed]
	and a, $FE
	ldh [H_JPInput_Changed], a
	ld b, 1
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Standard End", ROMX[$4263], BANK[$F]
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

SECTION "Event Action - Basic End", ROMX[$4972], BANK[$F]
EventScript_BasicEnd::
	xor a
	ld [$CD00], a
	ret
