INCLUDE "telefang.inc"

SECTION "GBC Colour To SGB Colour Converter", ROMX[$7000], BANK[$1]
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
    call PatchUtils_CommitStagedCGBToSGBBuffer
    jr PatchUtils_CommitSGBBufferToSGB.dontSetCommand

PatchUtils_CommitSGBBufferToSGB::
    ld [W_SGB_PalCommandBuffer], a

.dontSetCommand
    ld a, [W_SGB_PalCommandBuffer]
    and $1F
    ld [W_SGB_SpotPalette + M_SGB_Pal01Command], a
    ld de, W_SGB_SpotPalette + M_SGB_Pal01Pal0Color0
    ld hl, W_SGB_Colour00Buffer

    ld a, [hli]
    ld [de], a
    inc de

    ld a, [hli]
    ld [de], a
    inc de

    call PatchUtils_GetSGBPalBufferAddressA
    call PatchUtils_CommitStagedCGBToSGBBuffer_CopyPalette

    call PatchUtils_GetSGBPalBufferAddressB
    call PatchUtils_CommitStagedCGBToSGBBuffer_CopyPalette

    xor a
    ld [de], a

    ld a, BANK(SGB_SendConstructedPaletteSetPacket)
    ld hl, SGB_SendConstructedPaletteSetPacket
    call CallBankedFunction_int

    di
    ld a, BANK(PatchUtils_CommitStagedCGBToSGB)
    ld [W_PreviousBank], a
    ld [W_CurrentBank], a
    ei
    ret

PatchUtils_CommitStagedCGBToSGBBuffer::
    ld [W_SGB_PalCommandBuffer], a

    ld a, $7F
    ld [W_SGB_Colour00Buffer + 1], a
    ld a, $FF
    ld [W_SGB_Colour00Buffer + 0], a

    push bc

    call PatchUtils_GetSGBPalBufferAddressA
    ld a, b
    ld b, h
    ld c, l
    call PatchUtils_CommitStagedCGBToSGBBuffer_GetCGBColourAddress
    call PatchUtils_CommitStagedCGBToSGBBuffer_ConvertAndBuffer
    call PatchUtils_CommitStagedCGBToSGBBuffer_ConvertAndBuffer
    call PatchUtils_CommitStagedCGBToSGBBuffer_ConvertAndBuffer

    pop bc

    call PatchUtils_GetSGBPalBufferAddressB
    ld a, c
    ld b, h
    ld c, l
    call PatchUtils_CommitStagedCGBToSGBBuffer_GetCGBColourAddress
    call PatchUtils_CommitStagedCGBToSGBBuffer_ConvertAndBuffer
    call PatchUtils_CommitStagedCGBToSGBBuffer_ConvertAndBuffer
    call PatchUtils_CommitStagedCGBToSGBBuffer_ConvertAndBuffer
    ret

PatchUtils_GetSGBPalCommandTableIndex::
    ld a, [W_SGB_PalCommandBuffer]
    and $78
    rra
    ret

PatchUtils_GetSGBPalBufferAddressA::
    call PatchUtils_GetSGBPalCommandTableIndex
    jr PatchUtils_GetSGBPalBufferAddressB.common

PatchUtils_GetSGBPalBufferAddressB::
    call PatchUtils_GetSGBPalCommandTableIndex
    add 2

.common
    ld hl, .table
    add l
    jr nc, .noIncHL
    inc h

.noIncHL
    ld l, a
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ret

.table
    dw W_SGB_Colour01Buffer, W_SGB_Colour11Buffer
    dw W_SGB_Colour21Buffer, W_SGB_Colour31Buffer
    dw W_SGB_Colour01Buffer, W_SGB_Colour31Buffer
    dw W_SGB_Colour11Buffer, W_SGB_Colour21Buffer
    dw W_SGB_Colour01Fade13Buffer, W_SGB_Colour11Fade13Buffer
    dw W_SGB_Colour21Fade13Buffer, W_SGB_Colour31Fade13Buffer
    dw W_SGB_Colour01Fade13Buffer, W_SGB_Colour31Fade13Buffer
    dw W_SGB_Colour11Fade13Buffer, W_SGB_Colour21Fade13Buffer
    dw W_SGB_Colour01Fade23Buffer, W_SGB_Colour11Fade23Buffer
    dw W_SGB_Colour21Fade23Buffer, W_SGB_Colour31Fade23Buffer
    dw W_SGB_Colour01Fade23Buffer, W_SGB_Colour31Fade23Buffer
    dw W_SGB_Colour11Fade23Buffer, W_SGB_Colour21Fade23Buffer

PatchUtils_CommitStagedCGBToSGBBuffer_GetCGBColourAddress::
    ld hl, W_LCDC_CGBStagingBGPaletteArea
    swap a
    rra
    add l
    add 2
    ld l, a
    ret

PatchUtils_CommitStagedCGBToSGBBuffer_ConvertAndBuffer::
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    call PatchUtils_ColourToSGB

    ld a, e
    ld [bc], a
    inc bc
    ld a, d
    ld [bc], a
    inc bc
    ret

PatchUtils_CommitStagedCGBToSGBBuffer_CopyPalette::
    ld a, [hli]
    ld [de], a
    inc de

    ld a, [hli]
    ld [de], a
    inc de

    ld a, [hli]
    ld [de], a
    inc de

    ld a, [hli]
    ld [de], a
    inc de

    ld a, [hli]
    ld [de], a
    inc de

    ld a, [hli]
    ld [de], a
    inc de
    ret

SECTION "GBC Colour To SGB Colour Converter 2", ROMX[$7C1A], BANK[$1]
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
	
PatchUtils_CommitStagedCGBToSGB_CBE::
	M_AdviceSetup
	ld a, d
	call PatchUtils_CommitStagedCGBToSGB
	jp Battle_ADVICE_BattleArticle_teardown

SECTION "GBC Colour To SGB Colour Table", ROMX[$7CD0], BANK[$1]

PatchUtils_ColourToSGB_Table::

; IMPORTANT!
; The address for this table cannot be between XXE1 and XXFF or the lookup function would fail.

	db $00, $00, $02, $05, $07, $08, $0A, $0C
	db $0D, $0E, $0F, $11, $12, $13, $14, $15
	db $16, $17, $18, $19, $1A, $1B, $1B, $1C
	db $1C, $1D, $1D, $1E, $1E, $1F, $1F, $1F