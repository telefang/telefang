INCLUDE "telefang.inc"

SECTION "CGB Palette Management Vars", WRAM0[$CA61]
W_CGBPaletteScheduled: ds 8

SECTION "CGB Palette Management Staging", WRAM0[$CAC8]
W_CGBPaletteStaging: ds 1

SECTION "CGB Palette Management Second Vars", WRAMX[$DD00], BANK[$1]
W_CGBPaletteStagedBGP:: ds 1
W_CGBPaletteBackgroundIndex: ds 2
W_CGBPaletteStagedOBP:: ds 1
W_CGBPaletteObjectIndex: ds 2

SECTION "CGB Palette Management Second Staging", WRAMX[$DD10], BANK[$1]
W_LCDC_CGBStagingBGPaletteArea:: ds M_LCDC_CGBStagingAreaSize
W_LCDC_CGBStagingOBPaletteArea:: ds M_LCDC_CGBStagingAreaSize

SECTION "LCDC Palette Fade Staging WRAM", WRAMX[$DE00], BANK[1]
; Palette fades and other color maths are calculated with each color component
; unpacked.
W_LCDC_CGBScratchBGPaletteArea:: ds M_LCDC_CGBScratchAreaSize
W_LCDC_CGBScratchOBPaletteArea:: ds M_LCDC_CGBScratchAreaSize

; Once faded the palettes are packed and written here for final staging.
W_LCDC_FadeStagingArea:: ds M_LCDC_CGBStagingAreaSize

;This is a system that loads entire palette sets from ROM.
;There's another system for loading a single palette further down.
SECTION "CGB Palette Management 2", ROM0[$106A]
CGBCommitPalettes::
	ld a, [W_GameboyType]
	cp $11
	ret nz
	ld a, [W_CGBPaletteStagedBGP]
	or a
	jr z, .noCommitPalette
	call CGBCommitPalettesBGP
.noCommitPalette
	ld a, [W_CGBPaletteStagedOBP]
	or a
	ret z
	jp CGBCommitPalettesOBP

CGBCommitPalettesBGP:
	ld a, $D
	rst $10
	ld hl, W_LCDC_CGBStagingBGPaletteArea
	ld b, M_LCDC_CGBStagingAreaSize
	ld a, $80
	ld [REG_BGPI], a
	
.loop
	ld a, [hli]
	di
	call YetAnotherWFB
	ld [REG_BGPD], a
	ei
	dec b
	jr nz, .loop
	xor a
	ld [W_CGBPaletteStagedBGP], a
	ret
	
;Load a set of eight background palettes into the staging area from ROM.
;This function uses a metatable at 7:4000. Each entry indexes eight individual
;palettes from the individual palette table at D:4000.
CGBLoadBackgroundPalette::
	push hl
	push bc
	push de
	ld a, b
	ld [W_CGBPaletteBackgroundIndex], a
	ld a, c
	ld [W_CGBPaletteBackgroundIndex + 1], a
	ld hl, $4000
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld b, 8
	ld de, W_LCDC_CGBStagingBGPaletteArea
	
.paletteLoop
	push bc
	ld a, 7
	rst $10
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld a, $D
	rst $10
	ld hl, $4000
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld b, 8
	
.colorLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .colorLoop
	pop hl
	pop bc
	dec b
	jr nz, .paletteLoop
	pop de
	pop bc
	pop hl
	ret
	
CGBLoadBackgroundPaletteBanked::
	push hl
	push bc
	push de
	ld e, a
	ld d, 0
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	ld hl, W_LCDC_CGBStagingBGPaletteArea
	add hl, de
	push hl
	pop de
	ld a, $D
	rst $10
	ld hl, $4000
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld b, 8
	
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	pop de
	pop bc
	pop hl
	ld a, [W_PreviousBank]
	rst $10
	ret

;Load a set of eight object palettes into the staging area from ROM.
;This function uses a metatable at E:4000. Each entry indexes eight individual
;palettes from the individual palette table at D:5D80.
CGBCommitPalettesOBP::
	ld a, $D
	rst $10
	ld hl, W_LCDC_CGBStagingOBPaletteArea
	ld b, M_LCDC_CGBStagingAreaSize
	ld a, $80
	ld [REG_OBPI], a
	
.oloop
	ld a, [hli]
	di
	call YetAnotherWFB
	ld [REG_OBPD], a
	ei
	dec b
	jr nz, .oloop
	xor a
	ld [W_CGBPaletteStagedOBP], a
	ret
	
CGBLoadObjectPalette::
	push hl
	push bc
	push de
	ld a, b
	ld [W_CGBPaletteObjectIndex], a
	ld a, c
	ld [W_CGBPaletteObjectIndex + 1], a
	ld hl, $4000
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld b, 8
	ld de, W_LCDC_CGBStagingOBPaletteArea
	
.paletteLoop
	push bc
	ld a, $E
	rst $10
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld a, $D
	rst $10
	ld hl, $5D80
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld b, 8
	
.colorLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .colorLoop
	pop hl
	pop bc
	dec b
	jr nz, .paletteLoop
	pop de
	pop bc
	pop hl
	ret
	
CGBLoadObjectPaletteBanked::
	push hl
	push bc
	push de
	ld e, a
	ld d, 0
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	ld hl, W_LCDC_CGBStagingOBPaletteArea
	add hl, de
	push hl
	pop de
	ld a, $D
	rst $10
	ld hl, $5D80
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld b, 8
	
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	pop de
	pop bc
	pop hl
	ld a, [W_PreviousBank]
	rst $10
	ret

LCDC_UnpackStagedPalettes::
    ld hl, W_LCDC_CGBScratchBGPaletteArea
    ld de, W_LCDC_CGBStagingBGPaletteArea
    call LCDC_UnpackStagedBGPalettes
    ld hl, W_LCDC_CGBScratchOBPaletteArea
    ld de, W_LCDC_CGBStagingOBPaletteArea
    jp LCDC_UnpackStagedOBPalettes

LCDC_UnpackStagedBGPalettes::
    ld b, M_LCDC_CGBPaletteCount
    
.paletteUnpack
    push bc
    ld b, M_LCDC_CGBColorCount
    
.colorUnpack
    push bc
    call LCDC_CGBColorUnPack15to24
    pop bc
    dec b
    jp nz, .colorUnpack
    
    pop bc
    dec b
    jp nz, .paletteUnpack
    
    ret

;Literally a cut-and-paste of the BGP version... why?
LCDC_UnpackStagedOBPalettes::
    ld b, M_LCDC_CGBPaletteCount
    
.paletteUnpack
    push bc
    ld b, M_LCDC_CGBColorCount
    
.colorUnpack
    push bc
    call LCDC_CGBColorUnPack15to24
    pop bc
    dec b
    jp nz, .colorUnpack
    
    pop bc
    dec b
    jp nz, .paletteUnpack
    
    ret

LCDC_CGBColorUnPack15to24::
    ld a, [de]
    ld c, a
    and $1F
    ld [hli], a
    
    inc de
    ld a, [de]
    ld b, a
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    ld a, b
    and $1F
    ld [hli], a
    
    ld a, [de]
    srl a
    srl a
    and $1F
    ld [hli], a
    inc de
    
    ret

SECTION "CGB Palette Management", ROM0[$382E]
CGBCommitObjectPalette:
	push af
	ld de, REG_OBPI
	call CGBSetPaletteIndex
	ld de, REG_OBPD
	jr copyCGBPalette
	
CGBCommitBackgroundPalette:
	push af
	ld de, REG_BGPI
	call CGBSetPaletteIndex
	ld de, REG_BGPD

copyCGBPalette:
	di

.vramUnlock
	ld a, [REG_STAT]
	and 2
	jr nz, .vramUnlock
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	ei
	pop af
	inc a
	ret
	
CGBSetPaletteIndex:
	sla a
	sla a
	sla a
	or $80
	ld [de], a
	ret

CGBCommitScheduledPalette::
	ld a, [W_CGBPaletteScheduled]
	or a
	ret z
	ld b, a
	xor a
	ld [W_CGBPaletteScheduled], a
	ld hl, W_CGBPaletteStaging
	ld a, b
	dec a
	cp 8
	jr c, CGBCommitBackgroundPalette
	sub 8
	jr CGBCommitObjectPalette