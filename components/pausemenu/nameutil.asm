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
    ld [W_MainScript_WindowBorderAttribs], a
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    ld hl, StringTable_denjuu_species
    call Banked_PauseMenu_ADVICE_LoadName75
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
    ld [W_MainScript_WindowBorderAttribs], a
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    ld hl, StringTable_battle_items
    call StringTable_LoadNameB
    ld d, $B
    jp PauseMenu_CenterPreppedName
    
PauseMenu_CenterPreppedName::
    ld hl, $9780
    ld bc, W_StringTable_StagingLocDbl
    ld d, M_StringTable_Load8AreaSize
    jp MainScript_DrawCenteredStagedString
    
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

SECTION "Pause Menu Names Util ADVICE", ROMX[$7F10], BANK[$34]
PauseMenu_ADVICE_LoadName75::
    ld d, 0
    ld a, [W_StringTable_ROMTblIndex]
    ld e, a
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld bc, M_StringTable_Load8AreaSize
    ld de, W_StringTable_StagingLocDbl
    jp memcpy
