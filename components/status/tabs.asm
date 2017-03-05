SECTION "Status Screen Tabs Memory", WRAM0[$CB30]
W_Status_CurrentTab:: ds 1

SECTION "Status Screen Tabs Functions", ROMX[$502E], BANK[2]
Status_LoadCurrentTabTMAP::
    ld a, [W_Status_CurrentTab]
    add a, 2
    ld e, a
    ld bc, 9
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ret

Status_EnterTab1::
    jp Status_DrawDenjuuBattleStats

Status_EnterTab2::
    jp Status_ValidateMoves ; Does nothing.

Status_EnterTab0::
    call Status_DrawDenjuuPhoneNumber
    call Status_DrawDenjuuProgressionStats
    ret