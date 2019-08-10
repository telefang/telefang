SECTION "Link Melody Transfer Choice Cursor", ROMX[$777F], BANK[$1F]
LinkMelody_PlaceChoiceCursor::
    ld b, $17
    ld a, [W_Summon_SelectedPageContact]
    ld c, a
    cp 0
    jr z, .writeOutSprite
    
    ld a, b
.positionLoop
    add a, $1F
    ld b, a
    dec c
    jr nz, .positionLoop
    
.writeOutSprite
    ld a, b
    ld [W_LCDC_MetaspriteAnimationXOffsets + 1], a
    ld a, $80
    ld [W_LCDC_MetaspriteAnimationYOffsets + 1], a
    ld a, 1
    ld [W_LCDC_NextMetaspriteSlot], a
    ld a, $D0
    ld [W_LCDC_MetaspriteAnimationIndex], a
    call LCDC_BeginMetaspriteAnimation
    
    ret

SECTION "Link Melody Arrow Position Updater", ROMX[$7757], BANK[$1F]
LinkMelody_UpdateArrowPosition::
	ld b, $10
	ld a, [W_Victory_UserSelection]
	ld c, a
	cp 0
	jr z, .skipMathLoop
	ld a, b

.mathLoop
	add 8
	ld b, a
	dec c
	jr nz, .mathLoop

.skipMathLoop
	ld a, b
	ld [W_LCDC_MetaspriteAnimationYOffsets], a
	ld a, $28
	ld [W_LCDC_MetaspriteAnimationXOffsets], a
	ld a, 0
	ld [W_LCDC_NextMetaspriteSlot], a
	ld a, $D0
	ld [W_LCDC_MetaspriteAnimationIndex], a
	call LCDC_BeginMetaspriteAnimation
	ret
