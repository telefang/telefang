INCLUDE "registers.inc"
INCLUDE "components/LCDC/oam_dma.inc"

SECTION "LCDC OAM DMA Shadow", WRAM0[$C000]
W_ShadowOAM:: ds M_OAMShadowLength

;The OAM DMA driver is a small bit of code which executes in high memory to
;keep the CPU off the main memory bus as DMA does it's thing.

SECTION "LCDC yetagain", ROM0[$079A]
InstallODMADriver:: ld c, $80
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