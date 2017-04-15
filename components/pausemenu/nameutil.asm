INCLUDE "telefang.inc"

SECTION "Pause Menu Names Util", ROMX[$5A35], BANK[$4]
PauseMenu_ContactPrepName::
    ld [W_StringTable_ROMTblIndex], a
    ld hl, $9780
    ld b, 8
    call PauseMenu_ClearScreenTiles
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    xor a
    ld [$CA65], a
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    ld d, $C
    jp PauseMenu_CenterPreppedName
    
PauseMenu_ItemPrepName::
    ld [W_StringTable_ROMTblIndex], a
    ld hl, $9780
    ld b, 8
    call PauseMenu_ClearScreenTiles
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    xor a
    ld [$CA65], a
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    ld hl, StringTable_battle_items
    call StringTable_LoadNameB
    ld d, $B
    jp PauseMenu_CenterPreppedName
    
PauseMenu_CenterPreppedName::
    push de
    ld hl, W_MainScript_CenteredNameBuffer
    ld b, M_StringTable_Load8AreaSize + 1
    
.nullTermLoop
    ld a, $E0
    ld [hli], a
    dec b
    jr nz, .nullTermLoop
    
    ld hl, W_StringTable_StagingLoc
    ld de, W_MainScript_CenteredNameBuffer
    call Banked_StringTable_PadCopyBuffer
    pop de
    jp PauseMenu_DrawCenteredNameBuffer