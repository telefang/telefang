INCLUDE "registers.inc"
INCLUDE "components/LCDC/oam_dma.inc"
INCLUDE "components/LCDC/vblank_irq.inc"

;The "LCDC" component consists of parts of the game that manage the LCD
;Controller and it's associated registers.

SECTION "LCDC VBlank_IRQ_WRAM1", WRAM0[$C437]
W_OAMDMAReady: ds 1

SECTION "LCDC VBlank_IRQ again", ROM0[$02E7]
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
