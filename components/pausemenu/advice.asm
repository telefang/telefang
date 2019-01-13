INCLUDE "telefang.inc"

SECTION "Pause Menu Load SGB Files", ROMX[$5540], BANK[$1]
Banked_PauseMenu_ADVICE_LoadSGBFiles::
    M_AdviceSetup
    ld a, 5
    ld [W_SystemSubState], a
    jp TitleMenu_ADVICE_LoadSGBFiles_externalEntry

SECTION "Pause Menu Load SGB Files 2", ROMX[$5580], BANK[$1]
PauseMenu_ADVICE_LoadSGBFilesMelody::
    M_AdviceSetup

    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a

    ld c, 7
    call Banked_SGB_ConstructATFSetPacket

    M_AdviceTeardown
    ret

PauseMenu_ADVICE_LoadSGBFilesInventory::
    M_AdviceSetup

    xor a
    ld [W_PauseMenu_CurrentInventorySlot], a

    ;Do nothing if no SGB detected.
    ld a, [W_SGB_DetectSuccess]
    or a
    jr z, .return

    ;Do nothing if CGB hardware detected.
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .return

    ld c, 8
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 5
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

PauseMenu_ADVICE_LoadSGBPalettesInventory::
    M_AdviceSetup

    ld hl, $9400
    call Banked_PauseMenu_LoadItemGraphic

    ;Do nothing if no SGB detected.
    ld a, [W_SGB_DetectSuccess]
    or a
    jr z, .return

    ;Do nothing if CGB hardware detected.
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .return

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 6
    ld c, 7
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret
