INCLUDE "telefang.inc"

SECTION "GBC Colour To SGB Colour Converter", ROMX[$7300], BANK[$1]
;Takes two given staged CGB palettes, converts them to SGB colorspace, and commits
;them in a given set of SGB palette slots.
; 
; A=SGB command to use (one of M_SGB_Pal01, Pal23, Pal03, Pal12)
; B=First CGB palette (in staging area)
; C=Second CGB palette (in staging area)
; 
; Returns nothing
; 
PatchUtils_CommitStagedCGBToSGB::
    ld [W_SGB_SpotPalette + M_SGB_Pal01Command], a
    
    ld a, W_LCDC_CGBStagingBGPaletteArea & $FF
    swap b
    srl b
    add a, b
    ld l, a
    ld a, W_LCDC_CGBStagingBGPaletteArea >> 8
    adc a, 0
    ld h, a
    
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    
    call PatchUtils_ColourToSGB
    
    ld a, d
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal0Color0 + 1], a
    ld a, e
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal0Color0 + 0], a
    
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    
    call PatchUtils_ColourToSGB
    
    ld a, d
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal0Color1 + 1], a
    ld a, e
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal0Color1 + 0], a
    
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    
    call PatchUtils_ColourToSGB
    
    ld a, d
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal0Color2 + 1], a
    ld a, e
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal0Color2 + 0], a
    
    ld a, [hli]
    ld d, [hl]
    ld e, a
    
    call PatchUtils_ColourToSGB
    
    ld a, d
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal0Color3 + 1], a
    ld a, e
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal0Color3 + 0], a
    
    ld a, c
    swap a
    srl a
    add a, 2
    add a, W_LCDC_CGBStagingBGPaletteArea & $FF
    ld l, a
    ld a, W_LCDC_CGBStagingBGPaletteArea >> 8
    adc a, 0
    ld h, a
    
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    
    call PatchUtils_ColourToSGB
    
    ld a, d
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal1Color1 + 1], a
    ld a, e
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal1Color1 + 0], a
    
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    
    call PatchUtils_ColourToSGB
    
    ld a, d
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal1Color2 + 1], a
    ld a, e
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal1Color2 + 0], a
    
    ld a, [hli]
    ld d, [hl]
    ld e, a
    
    call PatchUtils_ColourToSGB
    
    ld a, d
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal1Color3 + 1], a
    ld a, e
    ld [W_SGB_SpotPalette + M_SGB_Pal01Pal1Color3 + 0], a
    
    xor a
    ld [W_SGB_SpotPalette + $F], a
    
    ld a, BANK(SGB_SendConstructedPaletteSetPacket)
    ld hl, SGB_SendConstructedPaletteSetPacket
    call CallBankedFunction_int
    
    di
    ld a, BANK(PatchUtils_CommitStagedCGBToSGB)
    ld [W_PreviousBank], a
    ld [W_CurrentBank], a
    ei
    
    ret

PatchUtils_ColourToSGB::

	push af
	push bc
	push hl
	ld h, 0
	ld bc, PatchUtils_ColourToSGB_Table
	
; Red
	push bc
	ld a, e
	call PatchUtils_ColourToSGB_LookupTable
	ld l, c
	pop bc

; Green
	push de
	push bc
	call PatchUtils_LimitBreak
	sla e
	rl d
	ld a, d
	call PatchUtils_ColourToSGB_LookupTable
	ld d, c
	ld e, 0
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	add hl, de
	pop bc
	pop de
	
; Blue
	push bc
	srl d
	srl d
	ld a, d
	call PatchUtils_ColourToSGB_LookupTable
	sla c
	sla c
	ld a, c
	add a, h
	ld h, a
	pop bc
	
	push hl
	pop de
	
	pop hl
	pop bc
	pop af
	ret

PatchUtils_ColourToSGB_LookupTable::
	and $1F
	add a, c
	ld c, a
	ld a, [bc]
	ld c, a
	ret

SECTION "GBC Colour To SGB Colour Table", ROMX[$7480], BANK[$1]

PatchUtils_ColourToSGB_Table::

; IMPORTANT!
; The address for this table cannot be between XXE1 and XXFF or the lookup function would fail.

	db $00, $00, $02, $05, $07, $08, $0A, $0C
	db $0D, $0E, $0F, $11, $12, $13, $14, $15
	db $16, $17, $18, $19, $1A, $1B, $1B, $1C
	db $1C, $1D, $1D, $1E, $1E, $1F, $1F, $1F