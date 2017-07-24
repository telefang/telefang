INCLUDE "telefang.inc"

SECTION "VS Battle Copied Functions 1", ROMX[$60A7], BANK[$1F]
SerIO_LoadDenjuuSpeciesAsMessageArg1::
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    ld bc, W_StringTable_StagingLoc
    call SerIO_BattleCopyTableString
    jp SerIO_CopyIntoArg1
    
SerIO_BattleCopyTableString::
    ld hl, W_Battle_TableStringStaging
    ld a, M_StringTable_Load8AreaSize
    ld [W_Battle_LoopIndex], a
    
.loop
    ld a, [bc]
    cp $C0
    jr z, .terminate
    
    ld [hl], a
    inc hl
    inc bc
    
    ld a, [W_Battle_LoopIndex]
    dec a
    ld [W_Battle_LoopIndex], a
    
    jr nz, .loop
    
.terminate
    ld a, $E0
    ld [hl], a
    
    ld hl, W_Battle_TableStringStaging
    ret
    
SerIO_CopyIntoArg1::
    ld de, W_MainScript_MessageArg1
    ld b, M_MainScript_MessageArg1Size
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop
    
    ret
    
SECTION "VS Battle Copied Functions 2", ROMX[$60F9], BANK[$1F]
SerIO_PlaceChoiceCursor::
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .secondOptionSelected
    
.firstOptionSelected
    ld a, $18
    jr .writeXOffset
    
.secondOptionSelected
    ld a, $48
    
.writeXOffset
    ld [W_LCDC_MetaspriteAnimationXOffsets], a
    ld a, $80
    ld [W_LCDC_MetaspriteAnimationYOffsets], a
    xor a
    ld [W_LCDC_NextMetaspriteSlot], a
    ld a, $D0
    ld [W_LCDC_MetaspriteAnimationIndex], a
    jp LCDC_BeginMetaspriteAnimation
    
SECTION "VS Battle Copied Functions 3", ROMX[$5C41], BANK[$1F]
SerIO_Increment4thOrderSubState::
    ld hl, W_Battle_4thOrderSubState
    inc [hl]
    ret