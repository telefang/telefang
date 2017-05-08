INCLUDE "telefang.inc"

SECTION "Encounter Selected-Indicator Code", ROMX[$438C], BANK[$1C]
Encounter_LoadSelectedIndicatorResources::
    ld a, 0
    call Banked_Status_LoadUIGraphics
    jp Encounter_StageSelectedIndicatorPalette

Encounter_StageSelectedIndicatorPalette::
    ld a, 0
    ld bc, 4
    call CGBLoadObjectPaletteBanked
    
    ld a, 1
    ld [W_CGBPaletteStagedOBP], a
    
    ret

Encounter_PlaceSelectIndicator::
    ld a, [$D40D]
    cp 1
    jr z, .selectFurtherRight
    
.selectFurtherLeft
    ld a, $18
    jr .setupAnimation
    
.selectFurtherRight
    ld a, $48

.setupAnimation
    ld [W_LCDC_MetaspriteAnimationXOffsets], a
    ld a, $80
    ld [W_LCDC_MetaspriteAnimationYOffsets], a
    ld a, 0
    ld [W_LCDC_NextMetaspriteSlot], a
    ld a, $D0
    ld [W_LCDC_MetaspriteAnimationIndex], a
    jp LCDC_BeginMetaspriteAnimation