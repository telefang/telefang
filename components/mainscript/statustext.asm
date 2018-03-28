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
	
MainScript_DrawStatusText_loop::
	push bc
	push de
	push hl
	ld a, [de]
	cp $E0
	jp z, MainScript_DrawStatusText_ret
	pop hl
	push hl
	call Banked_MainScript_DrawLetter
	pop hl
	jp MainScript_ADVICE_DrawStatusText
	
MainScript_DrawStatusText_secondCompositeTile::
	add hl, bc
	
MainScript_DrawStatusText_firstCompositeTile::
	pop de
	inc de
	ld a, [W_MainScript_StatusLettersDrawn]
	inc a
	ld [W_MainScript_StatusLettersDrawn], a
	pop bc
	dec b
	jp MainScript_ADVICE_DrawStatusText_enterSecondHalf
	
MainScript_DrawStatusText_ret::
	pop hl
	pop de
	jp MainScript_ADVICE_DrawStatusText_exitFromSecondHalf

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
	ld a, Banked_MainScript_ADVICE_CondenseTableStringLong & $FF
	call PatchUtils_AuxCodeJmp
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
   
	ld a, Banked_MainScript_ADVICE_CondenseStagedTableStringLong & $FF
	call PatchUtils_AuxCodeJmp
   
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
    ld a, Banked_MainScript_ADVICE_CondenseTableStringShort & $FF
    call PatchUtils_AuxCodeJmp
    pop hl
    ld de, W_StringTable_StagingLocDbl
    ld b, M_StringTable_Load4AreaSize
    jp Banked_MainScript_DrawStatusText
    
;3B22
MainScript_DrawHabitatString::
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, $D
    call Banked_Battle_LoadSpeciesData
    
    ld a, BANK(MainScript_ADVICE_DrawHabitatString)
    rst $10
    jp MainScript_ADVICE_DrawHabitatString
    
    nop
    nop
    nop
    nop
    nop
    nop
    
;3B36
MainScript_DrawStatusEffectString::
    push hl
    ld a, b
    ld de, StringTable_denjuu_statuses
    pop bc
    jp MainScript_DrawShortName

SECTION "Main Script Status Text Drawing Advice 2", ROMX[$7EC0], BANK[$B]
;BC = text string (presumed WRAM, not bankable)
;D = string length (bytes)
;Returns E = string length (pixels)
;Clobbers a, hl, flags; arguments not preserved
MainScript_ADVICE_CountTextWidth::
	 ld e, 0
    
.sizingLoop
    ld a, [bc]
    cp $E0
    jr z, .finishedMeasuring
    
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

.finishedMeasuring
    ; Remove the last post-letter 1-pixel space if there was any text.
    ld a, e
    cp 0
    ret z
    dec e

    ret

;BC = Argument for Draw Empty Spaces
;DE = Argument for Load Denjuu Name
;ROMTblIndex = Index of string to draw - THIS IS DIFFERENT FROM DrawCenteredName
;              SO THAT YOU CAN USE RST $20. ORIGINAL FUNCTION USES A REGISTER
;Draws the habitat name, but right-aligned. assumes habitat sized win
MainScript_ADVICE_DrawRightAlignedHabitatName::
    push bc
    push de
    ld hl, W_MainScript_CenteredNameBuffer
    ld b, M_StringTable_Load4AreaSize + 1
	
.clearLoop
    ld a, $E0
    ld [hli], a
    dec b
    jr nz, .clearLoop

    pop hl
    call StringTable_LoadShortName
    pop hl

    ld d, M_StringTable_Load4AreaSize
    ld bc, W_StringTable_StagingLocDbl
   
MainScript_ADVICE_DrawRightAlignedStagedString::
    push bc
    push de
    push hl

    ld a, 7
    call MainScript_DrawEmptySpaces

    pop hl ;tileptr
    pop de ;text string
    pop bc ;string size (bytes)
    push bc
    push hl
    
    ld a, [W_MainScript_ADVICE_FontToggle]
    and a
    jr z, .useRegularFont
    
.useNarrowFont
    ld a, [W_PreviousBank]
    push af
    
    ld a, BANK(MainScript_ADVICE_CountNarrowTextWidth)
    ld hl, MainScript_ADVICE_CountNarrowTextWidth
    call CallBankedFunction_int
    
    di
    pop af
    ld [W_PreviousBank], a
    ei
    
    jr .moveupTilePtr
    
.useRegularFont
    call MainScript_ADVICE_CountTextWidth
    
    ;At this point, e contains the total size of text we need to deal with.
.moveupTilePtr
    ld a, [W_MainScript_VWFNewlineWidth]
    and a
    jr z, .useFallbackWidth
    
.useSpecifiedWidth
    sla a
    sla a
    sla a
    jr .checkStringOverflow
    
.useFallbackWidth
    ld a, $40
    
.checkStringOverflow
    sub e
    jr c, .overwideStringFailsafe
    jr MainScript_ADVICE_DrawCenteredName75.setupVwfOffset
    
    ;Used if the string being drawn is too wide, since we can't draw strings
    ;before the selected tile
.overwideStringFailsafe
    pop hl
    jr MainScript_ADVICE_DrawCenteredName75.drawString

;HL = Tile ptr
;BC = Text string to draw
;D = Text drawing limit (terminators also respected)
;Centers the drawn text.
MainScript_ADVICE_DrawCenteredName75::
    push bc
    push hl
    
    ld a, [W_MainScript_ADVICE_FontToggle]
    and a
    jr z, .useRegularFont
    
.useNarrowFont
    ld a, [W_PreviousBank]
    push af
    
    ld a, BANK(MainScript_ADVICE_CountNarrowTextWidth)
    ld hl, MainScript_ADVICE_CountNarrowTextWidth
    call CallBankedFunction_int
    
    di
    pop af
    ld [W_PreviousBank], a
    ei
    
    jr .moveupTilePtr
    
.useRegularFont
    call MainScript_ADVICE_CountTextWidth
    
    ;At this point, e contains the total size of text we need to deal with.
    ;NOTE: This logic WILL NOT WORK with a wider than 8 tile window!
    ;TODO: Use VWFNewlineWidth to determine window size.
.moveupTilePtr
    ld a, [W_MainScript_VWFNewlineWidth]
    and a
    jr z, .useFallbackWidth
    
.useSpecifiedWidth
    sla a
    sla a
    sla a
    jr .checkStringOverflow
    
.useFallbackWidth
    ld a, $40
    
.checkStringOverflow
    sub e
    jr c, .overwideStringFailsafe
    
    sra a
    
.setupVwfOffset
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

MainScript_ADVICE_DrawHabitatString::
    ld hl, $9380
    ld a, 6
    
.loopSpaces
    push af
    ld de, MainScript_DrawEmptySpaces_Space
    ld b, 1
    call MainScript_DrawStatusText
    pop af
    dec a
    jr nz, .loopSpaces
    
    ld a, [$D45F]
    ld de, StringTable_denjuu_habitats
    ld bc, $9380
    jp MainScript_DrawShortName

;MainScript_ADVICE_DrawStatusText has been moved to components/system/patch_utils.asm

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

SECTION "Main Script Status Text AuxCode Advice", ROMX[$4640], BANK[$1]
MainScript_ADVICE_CondenseTableStringShort::
    M_AdviceSetup
    
    ;This is what the pointcut replaces in all table draw functions.
    ;Do NOT replace any other code with your pointcut!
    ld a, 3
    call MainScript_DrawEmptySpaces
    
    ;Try and determine window width
    ld a, [W_MainScript_VWFNewlineWidth]
    and a
    jr nz, .scaleWidth
    
.defaultWidth
    ld a, 64
	 jr .countWidth
	 
.scaleWidth
    sla a
    sla a
    sla a
    
.countWidth
    push af
    
    ld a, BANK(MainScript_ADVICE_CountTextWidth)
    ld hl, MainScript_ADVICE_CountTextWidth
    ld bc, W_StringTable_StagingLocDbl
    ld d, M_StringTable_Load4AreaSize
    call CallBankedFunction_int
    
    pop af
    cp e
    jr nc, .noTextOverflow
    
.textOverflow
    ld a, 1
    jr .exit
    
.noTextOverflow
    ld a, 0
    
.exit
    ld [W_MainScript_ADVICE_FontToggle], a
    
    M_AdviceTeardown
    ret
    
MainScript_ADVICE_CondenseTableStringLong::
    M_AdviceSetup
    
    ;This is what the pointcut replaces in all table draw functions.
    ;Do NOT replace any other code with your pointcut!
    ld a, 8
    call MainScript_DrawEmptySpaces
    
    ;Try and determine window width
    ld a, [W_MainScript_VWFNewlineWidth]
    and a
    jr nz, .scaleWidth
    
.defaultWidth
    ld a, 64
	 jr .countWidth
	 
.scaleWidth
    sla a
    sla a
    sla a
    
.countWidth
    push af
    
    ld a, BANK(MainScript_ADVICE_CountTextWidth)
    ld hl, MainScript_ADVICE_CountTextWidth
    ld bc, W_StringTable_StagingLocDbl
    ld d, M_StringTable_Load8AreaSize
    call CallBankedFunction_int
    
    pop af
    cp e
    jr nc, .noTextOverflow
    
.textOverflow
    ld a, 1
    jr .exit
    
.noTextOverflow
    ld a, 0
    
.exit
    ld [W_MainScript_ADVICE_FontToggle], a
    
    M_AdviceTeardown
    ret
    
MainScript_ADVICE_CondenseStagedTableStringLong::
    M_AdviceSetup
    
    push bc
    
    ;This is what the pointcut replaces in all table draw functions.
    ;Do NOT replace any other code with your pointcut!
    ld a, 8
    call MainScript_DrawEmptySpaces
    
    ;Try and determine window width
    ld a, [W_MainScript_VWFNewlineWidth]
    and a
    jr nz, .scaleWidth
    
.defaultWidth
    ld a, 64
	 jr .countWidth
	 
.scaleWidth
    sla a
    sla a
    sla a
    
.countWidth
    pop bc
    push af
    
    ld a, BANK(MainScript_ADVICE_CountTextWidth)
    ld hl, MainScript_ADVICE_CountTextWidth
    ld d, M_StringTable_Load8AreaSize
    call CallBankedFunction_int
    
    pop af
    cp e
    jr nc, .noTextOverflow
    
.textOverflow
    ld a, 1
    jr .exit
    
.noTextOverflow
    ld a, 0
    
.exit
    ld [W_MainScript_ADVICE_FontToggle], a
    
    M_AdviceTeardown
    ret
MainScript_ADVICE_CondenseStagedTableStringLong_END::