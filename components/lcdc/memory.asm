INCLUDE "registers.inc"
INCLUDE "components/LCDC/oam_dma.inc"

;Contains utility functions for initializing or setting memory used by other
;parts of the game.
SECTION "LCDC Memory Utility", ROM0[$0968]
;Clear TPT 0 and 1.
;Unsafe to call when LCD is enabled.
ClearTilePatternTables::
	ld hl, VRAM_TPT0
	ld bc, VRAM_TMAP0 - VRAM_TPT0
	jp memclr

;Clear the "shadow OAM" area used for staging sprite data.
ClearShadowOAM::
	ld b, M_OAMShadowLength
	xor a
	ld hl, W_ShadowOAM
.clearLoop
	ld [hli], a
	dec b
	jr nz, .clearLoop
	ret

;Clear everything but the stack and OAM.
ClearWRAMVariables::
	ld bc, W_Stack - (W_ShadowOAM + M_OAMShadowLength)
	ld hl, W_ShadowOAM + M_OAMShadowLength
	jp memclr