INCLUDE "registers.inc"
INCLUDE "components/lcdc/oam_dma.inc"
INCLUDE "components/lcdc/vblank_irq.inc"

;The "LCDC" component consists of parts of the game that manage the LCD
;Controller and it's associated registers.

SECTION "LCDC VBlank_IRQ_WRAM1", WRAM0[$C437]
W_OAM_DMAReady:: ds 1

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
	ld a, [W_OAM_DMAReady]
	or a
	jr z, .setCompletedFlag
	call H_ExecuteOAMDMA ; In-memory code: OAM DMA
	call $3171 ; Looks like a crappy hack.
	xor a
	ld [$C430], a
	ld [W_OAM_DMAReady], a

.setCompletedFlag:
	ld a, 1
	ld [H_VBlankCompleted], a
	ei
	call $464
	call $3442
	ld a, [$CB3F]
	or a
	jr nz, .enableInternalSIOClock
	call $1F08
	jr .exit

.enableInternalSIOClock
	call SerIO_SwitchToInternalClock

.exit
	pop hl
	pop de
	pop bc
	pop af
	reti
