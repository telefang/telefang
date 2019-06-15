INCLUDE "telefang.inc"

SECTION "Certificate States Speed", ROMX[$5F06], BANK[$29]
Certificate_StateDrawScreen::
	ld a, $2B
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, 0
	ld [W_Cutscene_WaitTimer], a
	ld a, BANK(Certificate_StateDrawScreen)
	ld [W_PreviousBank], a
	ld bc, $34
	call Banked_CGBLoadBackgroundPalette
	ld de, $4CE9
	ld a, $3F
	ld hl, $8800
	ld bc, $6E0
	call Banked_LCDC_LoadTiles
	ld de, $44E9
	ld a, $3F
	ld hl, $9000
	ld bc, $800
	call Banked_LCDC_LoadTiles
	ld a, BANK(Certificate_StateDrawScreen)
	ld [W_PreviousBank], a

	ld a, 0
	ldh [REG_VBK], a
	ld de, Zukan_CompletionCertificateTmap
	ld hl, $9800
	ld b, $12
	ld c, $14
	call $3410

	ld a, 1
	ldh [REG_VBK], a
	ld de, $78EC
	ld hl, $9800
	ld b, $12
	ld c, $14
	call $3410

	ld a, 0
	ldh [REG_VBK], a
	ld a, BANK(Certificate_StateDrawScreen)
	ld [W_PreviousBank], a
	ld bc, 0
	ld a, 4
	call LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState
