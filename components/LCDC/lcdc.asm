INCLUDE "registers.inc"

;The "LCDC" component consists of parts of the game that manage the LCD
;Controller and it's associated registers.

;So-called "shadow" registers are temporary WRAM locations for storing what we
;want the contents of timing-specific registers to be. An interrupt or timed
;loop will later copy them into the appropriate registers.
SECTION "LCDC_WRAM0", WRAM0[$C3C2]
W_ShadowREG_SCX: ds 1
W_ShadowREG_SCY: ds 1
W_ShadowREG_WX: ds 1
W_ShadowREG_WY: ds 1
W_ShadowREG_BGP: ds 1
W_ShadowREG_OGP0: ds 1
W_ShadowREG_OGP1: ds 1
W_ShadowREG_LCDC: ds 1
W_ShadowREG_LYC: ds 1

SECTION "LCDC_WRAM1", WRAM0[$C437]
W_OAMDMAReady: ds 1

SECTION "LCDC_WRAM2", WRAM0[$C467]
W_HBlank_Scanline24Pos: ds 1

SECTION "LCDC_WRAM3", WRAM0[$C46D]
W_HBlank_SCYIndexAndMode: ds 1

SECTION "LCDC_WRAM4", WRAM0[$C957]
W_HBlank_SCYTableID: ds 1

SECTION "LCDC_WRAM5", WRAM0[$CAC1]
W_HBlank_State: ds 1

SECTION "LCDC_HRAM", HRAM[$FF80]
H_ExecuteOAMDMA: ds $A

SECTION "LCDC_HRAM2", HRAM[$FF92]
H_VBlankCompleted: ds 1

SECTION "LCDC", ROM0[$0266]
SyncShadowRegs:
	ld a, [$C46C]
	or a
	jr nz, .uselessJmp
	jr .uselessJmp

.uselessJmp
	ld a, [W_ShadowREG_SCX]
	ld [REG_SCX], a
	ld a, [W_ShadowREG_SCY]
	ld [REG_SCY], a
	ld a, [W_ShadowREG_WX]
	ld [REG_WX], a
	ld a, [W_ShadowREG_WY]
	ld [REG_WY], a
	ld a, [W_ShadowREG_BGP]
	ld [REG_BGP], a
	ld a, [W_ShadowREG_OGP0]
	ld [REG_OBP0], a
	ld a, [W_ShadowREG_OGP1]
	ld [REG_OBP1], a
	ld a, [W_ShadowREG_LCDC]
	ld [REG_LCDC], a
	ld a, [W_ShadowREG_LYC]
	ld [REG_LYC], a
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
	ld a, [$C46C]
	ld [$C469], a
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

SECTION "LCDC again", ROM0[$02E7]
VBlankingIRQ::
	push af
	push bc
	push de
	push hl
	call SyncShadowRegs
	ld a, [H_VBlankCompleted]
	or a
	jr nz, .setCompletedFlag
	ld a, [W_OAMDMAReady]
	or a
	jr z, .setCompletedFlag
	call H_ExecuteOAMDMA ; In-memory code: OAM DMA
	call $3171 ; Looks like a crappy hack.
	xor a
	ld [$C430], a
	ld [W_OAMDMAReady], a

.setCompletedFlag:
	ld a, 1
	ld [H_VBlankCompleted], a
	ei
	call $464
	call $3442
	ld a, [$CB3F]
	or a
	jr nz, .loc_31C
	call $1F08
	jr .loc_31F

.loc_31C
	call $1C9B
.loc_31F
	pop hl
	pop de
	pop bc
	pop af
	reti
 
LCDCIRQ::
	push af
	ld a, [W_HBlank_SCYIndexAndMode]
	cp 2
	jp nc, .doHblankSCY
	push bc ; HBL either mode 0 or 1
	push hl
	ld a, [$C469]
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

SECTION "LCDC yetagain", ROM0[$079A]
InstallODMADriver: ld c, $80
	ld b, $A ;Length value.
	;I'm sure there's a way to calculate it with the
	;macrolanguage but I can't be arsed
	ld hl, ODMADriver
.copyLoop ld a, [hli]
	ld [c], a
	inc c
	dec b
	jr nz, .copyLoop
	ret

;Not executed in place.
;Is instead copied into HRAM where it is safe to run.
ODMADriver:
	ld a, $C0
	ld [REG_DMA], a
	ld a, $28
.spinLock
	dec a
	jr nz, .spinLock
	ret