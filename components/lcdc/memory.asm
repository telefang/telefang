INCLUDE "telefang.inc"

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

LCDC_ClearMetasprites::
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld bc, M_MetaSpriteConfig_Size * (M_MetaSpriteConfig1_Count + M_MetaSpriteConfig2_Count + M_MetaSpriteConfig3_Count)
    ld hl, W_MetaSpriteConfig1
    call memclr
    
    ld bc, $40
    ld hl, $C480
    jp memclr
	
SECTION "LCDC Memory Utility 2", ROM0[$09AA]
;Yet another wait-for-blank, because I assume there's more in the code.
YetAnotherWFB::
	push af
	
.loop
	ld a, [REG_STAT]
	and 2
	jr nz, .loop
	pop af
	ret
	
vmempoke::
	di
	push af
	
.wfb
	ld a, [REG_STAT]
	and 2
	jr nz, .wfb
	pop af
	ld [hli], a
	ei
	ret
	
ClearGBCTileMap0::
	ld bc, M_VRAM_TMAPSIZE
	ld hl, VRAM_TMAP0
	
.bank0
	xor a
	call vmempoke
	dec bc
	ld a, b
	or c
	jr nz, .bank0
	ld bc, M_VRAM_TMAPSIZE
	ld hl, VRAM_TMAP0
	ld a, 1
	ld [REG_VBK], a
	
.bank1
	xor a
	call vmempoke
	dec bc
	ld a, b
	or c
	jr nz, .bank1
	xor a
	ld [REG_VBK], a
	ret
	
ClearGBCTileMap1::
	ld bc, M_VRAM_TMAPSIZE
	ld hl, VRAM_TMAP1
	
.bank0
	xor a
	call vmempoke
	dec bc
	ld a, b
	or c
	jr nz, .bank0
	ld bc, M_VRAM_TMAPSIZE
	ld hl, VRAM_TMAP1
	ld a, 1
	ld [REG_VBK], a
	
.bank1
	xor a
	call vmempoke
	dec bc
	ld a, b
	or c
	jr nz, .bank1
	xor a
	ld [REG_VBK], a
	ret
