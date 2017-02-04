INCLUDE "components/stringtable/load.inc"

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
    call Banked_PauseMenu_ADVICE_LoadDenjuuName
    ld d, $C
    jp $5A80
    
SECTION "Pause Menu Names Util ADVICE", ROMX[$7F10], BANK[$34]
PauseMenu_ADVICE_LoadDenjuuName::
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