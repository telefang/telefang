INCLUDE "registers.inc"

SECTION "LCDC HBlank_IRQ_WRAM2", WRAM0[$C467]
W_HBlank_Scanline24Pos:: ds 1

SECTION "LCDC HBlank_IRQ_WRAM3", WRAM0[$C469]
W_HBlank_SecondaryMode:: ds 1

SECTION "LCDC HBlank_IRQ_WRAM4", WRAM0[$C46D]
W_HBlank_SCYIndexAndMode:: ds 1

SECTION "LCDC HBlank_IRQ_WRAM5", WRAM0[$C957]
W_HBlank_SCYTableID:: ds 1

SECTION "LCDC HBlank_IRQ_WRAM6", WRAM0[$CAC1]
W_HBlank_State:: ds 1

SECTION "LCDC HBlank_IRQ again", ROM0[$0324]
LCDCIRQ::
	push af
	ld a, [W_HBlank_SCYIndexAndMode]
	cp 2
	jp nc, .doHblankSCY
	push bc ; HBL either mode 0 or 1
	push hl
	ld a, [W_HBlank_SecondaryMode]
	or a
	jp nz, .doOtherHblEffect
	call ClearHBlankState
	jr .ret_pop3

.doOtherHblEffect
	ld a, [W_HBlank_SCYIndexAndMode]
	or a
	jr nz, .doHblEffect1
	ld hl, $C464 ; HBL Effect 0
	; Used for moving the window around.
	ld a, [hli]
	sub 4
	ld b, a
	ld a, [REG_LY]
	cp b
	jr nc, .notAtDesiredLine
	ld a, [W_HBlank_State]
	or a
	jr nz, .ret_pop3
	ld a, [hli]
	ld [REG_WX], a
	ld a, [hl]
	ld [REG_WY], a
	ld a, b
	ld [REG_LYC], a
	ld a, 1
	ld [W_HBlank_State], a
	jr .ret_pop3

.notAtDesiredLine
	ld a, b
	add a, 4
	ld b, a

.waitUntilLineReady
	ld a, [REG_LY]
	cp b
	jr c, .waitUntilLineReady

.clearScroll
	xor a
	ld [REG_SCX], a
	ld [REG_SCY], a

.setupScreen
	ld [W_HBlank_State], a
	ld a, 0
	ld [REG_LYC], a
	ld [W_ShadowREG_LYC], a
	ld a, %10000011 ; Enable LCD, BG, and OBJ (and no others)
	ld [REG_LCDC], a

.ret_pop3
	pop hl
	pop bc
	pop af
	reti

.doHblEffect1
	ld a, [W_SystemState]
	cp 4
	jr z, .letterboxEffect
	ld hl, $C467
	ld a, [REG_LY]
	cp $5F ; '_'
	jr nc, .clearScroll
	ld a, [W_HBlank_State]
	cp 1
	jr z, .loc_3AE
	cp 0
	jr nz, .ret_pop3
	xor a
	ld [REG_SCX], a
	ld [REG_SCY], a
	ld a, $27 ; '''
	ld [REG_LYC], a
	ld a, 1
	ld [W_HBlank_State], a
	jr .ret_pop3

.loc_3AE
	ld a, [hl]
	ld [REG_SCX], a
	ld a, $5F ; '_'
	ld [REG_LYC], a
	ld a, 2
	ld [W_HBlank_State], a
	jr .ret_pop3

.letterboxEffect
	ld a, [REG_LY]
	cp $6C ; 'l'
	jr nc, .insertBottomLetterbox
	ld a, [W_HBlank_State]
	cp 1
	jr z, .insertMiddleSection
	cp 0
	jr nz, .ret_pop3
	ld a, $7F ; ''
	ld [REG_SCY], a
	ld a, $14
	ld [REG_LYC], a
	ld a, 1
	ld [W_HBlank_State], a
	jr .ret_pop3

.insertMiddleSection
	ld a, [REG_LY]
	cp $18
	jr c, .insertMiddleSection
	ld a, [W_HBlank_Scanline24Pos]
	ld [REG_SCY], a
	ld a, $6C ; 'l'
	ld [REG_LYC], a
	ld a, 2
	ld [W_HBlank_State], a
	jr .ret_pop3

.insertBottomLetterbox
	ld a, [REG_LY]
	cp $70 ; 'p'
	jr c, .insertBottomLetterbox
	ld a, $10
	ld [REG_SCY], a
	xor a
	ld [REG_SCX], a
	jp .setupScreen

.doHblankSCY
	push hl
	ld hl, $C140
	ld a, [W_HBlank_SCYTableID]
	or a
	jr nz, .copyToSCY
	ld hl, $C0A0

.copyToSCY
	ld a, [W_HBlank_SCYIndexAndMode]
	add a, l
	ld l, a
	ld a, 0
	adc a, h
	ld h, a
	ld a, [hl]
	ld [REG_SCY], a
	ld a, [W_HBlank_SCYIndexAndMode]
	inc a
	ld [W_HBlank_SCYIndexAndMode], a
	pop hl
	pop af
	reti

ClearHBlankState:
	xor a
	ld [W_HBlank_State], a
	ld hl, $C460
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret