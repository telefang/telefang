INCLUDE "telefang.inc"

SECTION "Certificate States", ROMX[$5EFD], BANK[$29]
Certificate_StateFadeOutFromOverworld::
	ld a, $2A
	ld hl, $4000
	call CallBankedFunction_int
	ret

; Certificate_StateDrawScreen is version-specific.

SECTION "Certificate States 2", ROMX[$5F78], BANK[$29]
Certificate_StateFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	jp System_ScheduleNextSubState

Certificate_StateDelayAndWaitForInput::
	ld a, [W_Cutscene_WaitTimer]
	cp $3C
	jr nc, .finishedWaiting
	inc a
	ld [W_Cutscene_WaitTimer], a
	ret

.finishedWaiting
	ldh a, [H_JPInput_HeldDown]
	and M_JPInput_A + M_JPInput_B
	ret z
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState

Certificate_StateFadeOutAndExitToOverworld::
	call PhoneConversation_StateIncomingCallFadeOutAndExitToOverworld
	ret
