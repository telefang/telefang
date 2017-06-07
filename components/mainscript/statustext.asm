INCLUDE "telefang.inc"

;"Status text" is text that we want to draw using the script system's text
;renderer, but isn't going to be interpreted by the script interpreter.

SECTION "Main Script Status Text Drawing WRAM", WRAM0[$CB2F]
W_MainScript_StatusLettersDrawn: ds 1

SECTION "Main Script Status Text Drawing WRAM 2", WRAM0[$CC90]
W_MainScript_CenteredNameBuffer:: ds M_StringTable_Load8AreaSize + 1

SECTION "Main Script Status Text Drawing WRAM 3", WRAM0[$C92C]
W_MainScript_PlayerName:: ds M_MainScript_PlayerNameSize + 1

SECTION "Main Script Status Text Drawing", ROM0[$3A91]
MainScript_DrawStatusText::
	xor a
	ld [W_MainScript_StatusLettersDrawn], a
	
.loop
	push bc
	push de
	push hl
	ld a, [de]
	cp $E0
	jp z, .ret
	pop hl
	push hl
	call Banked_MainScript_DrawLetter
	pop hl
	jp MainScript_ADVICE_DrawStatusText
	
.secondCompositeTile
	add hl, bc
	
.firstCompositeTile
	pop de
	inc de
	ld a, [W_MainScript_StatusLettersDrawn]
	inc a
	ld [W_MainScript_StatusLettersDrawn], a
	pop bc
	dec b
	jp MainScript_ADVICE_DrawStatusText.enterSecondHalf
	
.ret
	pop hl
	pop de
	jp MainScript_ADVICE_DrawStatusText.exitFromSecondHalf

Encounter_WriteTileToVRAM::
	di
	call YetAnotherWFB
	ld [hl], c
	ei
	ret
	
MainScript_DrawEmptySpaces_Space: db 0

;3AC3
MainScript_DrawName75::
	ld [W_StringTable_ROMTblIndex], a
	push bc
	push de
	pop hl
	call StringTable_LoadName75
	pop hl
	push hl
	ld a, 8
	call MainScript_DrawEmptySpaces
	pop hl
	ld de, W_StringTable_StagingLocDbl
	ld b, $16 ;likely incorrect.
	jp Banked_MainScript_DrawStatusText
	
;BC = Argument for Draw Empty Spaces
;DE = Argument for Load Denjuu Name
;Draws the Denjuu name, but centered...
MainScript_DrawCenteredName75::
	ld [W_StringTable_ROMTblIndex], a
	push bc
	push de
	ld hl, W_MainScript_CenteredNameBuffer
	ld b, M_StringTable_Load8AreaSize + 1
	
.clearLoop
	ld a, $E0
	ld [hli], a
	dec b
	jr nz, .clearLoop
	
	pop hl
	call StringTable_LoadName75
	pop hl
	
	ld d, M_StringTable_Load8AreaSize + 1
	ld bc, W_StringTable_StagingLocDbl
   
MainScript_DrawCenteredStagedString::
	push bc
	push de
	push hl
   
	ld a, 8
	call MainScript_DrawEmptySpaces
   
   pop hl
	pop de
	pop bc
	ld a, BANK(MainScript_ADVICE_DrawCenteredName75)
   rst $10
	call MainScript_ADVICE_DrawCenteredName75
   rst $18
   ret
   
;3B09
MainScript_DrawShortName::
    ld [W_StringTable_ROMTblIndex], a
    push bc
    push de
    pop hl
    call StringTable_LoadShortName
    pop hl
    push hl
    ld a, 3
    call MainScript_DrawEmptySpaces
    pop hl
    ld de, W_StringTable_StagingLocDbl
    ld b, M_StringTable_Load4AreaSize
    jp Banked_MainScript_DrawStatusText
    
;3B22
MainScript_DrawHabitatString::
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, $D
    call Banked_Battle_LoadSpeciesData
    ld a, [$D45F]
    ld de, StringTable_denjuu_habitats
    ld bc, $9380
    jp MainScript_DrawShortName
    
;3B36
MainScript_DrawStatusEffectString::
    push hl
    ld a, b
    ld de, StringTable_denjuu_statuses
    pop bc
    jp MainScript_DrawShortName

SECTION "Main Script Status Text Drawing Advice 2", ROMX[$7D00], BANK[$B]
;HL = Tile ptr
;BC = Text string to draw
;D = Text drawing limit (terminators also respected)
;Centers the drawn text.
MainScript_ADVICE_DrawCenteredName75::
    push bc
    push hl
	 
	 ld e, 0
    
.sizingLoop
    ld a, [bc]
    cp $E0
    jr z, .moveupTilePtr
    
    ;Index the font sizing array
    ld h, MainScript_ADVICE_DrawLetterTable >> 8
    ld l, a
    ld a, [hl]
    
    inc a ;Widths are stored with implicit 1px between characters for... some reason
    add e
    ld e, a
    
    inc bc
    dec d
    jr nz, .sizingLoop
    
    ;At this point, e contains the total size of text we need to deal with.
    ;NOTE: This logic WILL NOT WORK with a wider than 8 tile window!
.moveupTilePtr
    ld a, $40
    sub e
    jr c, .overwideStringFailsafe
    sra a
    push af
    and $7 ; Number of pixels to push the compositing area forward by
    ld [W_MainScript_VWFLetterShift], a
    
    pop af
    and $F8 ; Number of tiles to push compositing area forward by, x8
    sla a ;now a proper tile offset
    
    pop hl
    add l
    ld l, a
    ld a, h
    adc 0
    ld h, a
    
    jr .drawString
    
    ;Used if the string being drawn is too wide, since we can't draw strings
    ;before the selected tile
.overwideStringFailsafe
    pop hl
    
.drawString
    ;Tile ptr has been moved up and our letters shifted.
    ;Time to draw.
    pop de
    ld b, $16 ;Incorrect. TODO: Switch back to symbolic representation
    jp MainScript_DrawStatusText

SECTION "Main Script Status Text Drawing Advice", ROM0[$0077]
;Part of a function that replaces status text drawing with the VWF.
MainScript_ADVICE_DrawStatusText::
	ld bc, $10
	ld a, [W_MainScript_VWFOldTileMode]
	cp 1
	jp z, MainScript_DrawStatusText.secondCompositeTile
	jp MainScript_DrawStatusText.firstCompositeTile
	
.enterSecondHalf
	jp nz, MainScript_DrawStatusText.loop
	
.resetVWFAndExit
	ld a, 2
	ld [W_MainScript_VWFOldTileMode], a
	ld a, 0
	ld [W_MainScript_VWFLetterShift], a
	ret
	
.exitFromSecondHalf
	pop bc
	jr .resetVWFAndExit

SECTION "Main Script Status Text Drawing 2", ROM0[$3D5C]
MainScript_DrawEmptySpaces::
	push af
	ld de, MainScript_DrawEmptySpaces_Space
	ld b, 1
	call Banked_MainScript_DrawStatusText
	pop af
	dec a
	jr nz, MainScript_DrawEmptySpaces
	ret
