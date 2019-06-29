INCLUDE "telefang.inc"

SECTION "Certificate States", ROMX[$5EFD], BANK[$29]
Certificate_StateFadeOutFromOverworld::
	ld a, $2A
	ld hl, $4000
	call CallBankedFunction_int
	ret

Certificate_StateDrawScreen::
	ld a, $2B
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	xor a
	ld [W_Cutscene_WaitTimer], a
	ld a, BANK(Certificate_StateDrawScreen)
	ld [W_PreviousBank], a
	ld bc, $34
	call Banked_CGBLoadBackgroundPalette
	ld de, DiplomaGfx + $800
	ld a, BANK(DiplomaGfx)
	ld hl, $8800
	ld bc, $6E0
	call Banked_LCDC_LoadTiles
	ld de, DiplomaGfx
	ld a, BANK(DiplomaGfx)
	ld hl, $9000
	ld bc, $800
	call Banked_LCDC_LoadTiles
	ld a, BANK(Certificate_StateDrawScreen)
	ld [W_PreviousBank], a

	xor a
	ldh [REG_VBK], a
	ld de, Zukan_CompletionCertificateTmap
	ld hl, $9800
	ld bc, $1214
	call $3410

	call Cutscene_ADVICE_CheckGBC
	jr nz, .notGBC
	ld a, 1
	ldh [REG_VBK], a
	ld de, $78EC
	ld hl, $9800
	ld bc, $1214
	call $3410

.notGBC
	xor a
	ldh [REG_VBK], a
	ld a, BANK(Certificate_StateDrawScreen)
	ld [W_PreviousBank], a
	ld bc, 0
	M_AuxJmp Banked_Certificate_ADVICE_LoadSGBFiles
	jp System_ScheduleNextSubState

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
