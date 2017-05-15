INCLUDE "telefang.inc"

SECTION "Victory UI Util Memory", WRAMX[$D40D], BANK[$1]
W_Victory_UserSelection:: ds 1

SECTION "Victory UI Utils", ROMX[$546D], BANK[$1D]
Victory_PlaceChoiceCursor::
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .secondOptionSelected
    
.firstOptionSelected
    ld a, $17
    jr .writeXOffset
    
.secondOptionSelected
    ld a, $36
    
.writeXOffset
    ld [W_LCDC_MetaspriteAnimationXOffsets], a
    ld a, $80
    ld [W_LCDC_MetaspriteAnimationYOffsets], a
    ld a, 0
    ld [W_LCDC_NextMetaspriteSlot], a
    ld a, $D0
    ld [W_LCDC_MetaspriteAnimationIndex], a
    jp LCDC_BeginMetaspriteAnimation