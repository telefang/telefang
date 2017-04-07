SECTION "Pause Menu Utilities 1", ROMX[$6270], BANK[$4]
PauseMenu_IndexPtrTable::
    ld d, 0
    ld e, a
    sla e
    rl d
    add hl, de
    ret