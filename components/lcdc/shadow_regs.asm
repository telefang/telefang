INCLUDE "registers.inc"

;So-called "shadow" registers are temporary WRAM locations for storing what we
;want the contents of timing-specific registers to be. An interrupt or timed
;loop will later copy them into the appropriate registers.

SECTION "LCDC_ShadowREGS_WRAM0", WRAM0[$C3C2]
W_ShadowREG_SCX:: ds 1
W_ShadowREG_SCY:: ds 1
W_ShadowREG_WX:: ds 1
W_ShadowREG_WY:: ds 1
W_ShadowREG_BGP:: ds 1
W_ShadowREG_OBP0:: ds 1
W_ShadowREG_OBP1:: ds 1
W_ShadowREG_LCDC:: ds 1
W_ShadowREG_LYC:: ds 1

;This byte controls a completely useless jump and then gets forwarded to Hblank
;vars
SECTION "LCDC_ShadowREGS_WRAM1", WRAM0[$C46C]
W_ShadowREG_HBlankSecondMode:: ds 1

;This is the aforementioned loop that synchronizes shadow registers to hardware
;ones. It also manages some things with HBlank effects that I haven't looked at
;yet.

SECTION "LCDC", ROM0[$0266]
SyncShadowRegs::
	ld a, [W_ShadowREG_HBlankSecondMode]
	or a
	jr nz, .uselessJmp
	jr .uselessJmp

.uselessJmp
	ld a, [W_ShadowREG_SCX]
	ldh [REG_SCX], a
	ld a, [W_ShadowREG_SCY]
	ldh [REG_SCY], a
	ld a, [W_ShadowREG_WX]
	ldh [REG_WX], a
	ld a, [W_ShadowREG_WY]
	ldh [REG_WY], a
	ld a, [W_ShadowREG_BGP]
	ldh [REG_BGP], a
	ld a, [W_ShadowREG_OBP0]
	ldh [REG_OBP0], a
	ld a, [W_ShadowREG_OBP1]
	ldh [REG_OBP1], a
	ld a, [W_ShadowREG_LCDC]
	ldh [REG_LCDC], a
	ld a, [W_ShadowREG_LYC]
	ldh [REG_LYC], a
	ld b, 0
	ld hl, $C464
	ld de, $C460
	ld a, [de]
	add a, b
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	ld a, [W_ShadowREG_HBlankSecondMode]
	ld [W_HBlank_SecondaryMode], a
	ld a, 0
	ld [W_HBlank_State], a
	ld a, [W_HBlank_SCYIndexAndMode]
	cp 2
	jr c, .return
	ld a, 2
	ld [W_HBlank_SCYIndexAndMode], a
	ld a, [W_HBlank_SCYTableID]
	xor 1
	ld [W_HBlank_SCYTableID], a
	ret

.return
	ret