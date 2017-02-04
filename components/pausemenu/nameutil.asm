SECTION "Pause Menu Names Util", ROMX[$5A35], BANK[$4]
PauseMenu_ContactPrepName::
    ld [W_StringTable_ROMTblIndex], a
    ld hl, $9780
    ld b, 8
    call PauseMenu_ClearScreenTiles
    ld a, $F0
    ld [$C91E], a
    xor a
    ld [$CA65], a
    ld a, $78
    ld [W_MainScript_TileBaseIdx], a
    ld hl, $4000
    call StringTable_LoadDenjuuName
    ld d, $C
    jp $5A80