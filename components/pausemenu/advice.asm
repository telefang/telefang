INCLUDE "telefang.inc"

SECTION "Pause Menu Load SGB Files", ROMX[$5540], BANK[$1]
PauseMenu_ADVICE_LoadSGBFiles::
    M_AdviceSetup
    ld a, M_PauseMenu_StateInputHandler
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

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld c, 8
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 6
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

PauseMenu_ADVICE_LoadSGBPalettesInventory::
    M_AdviceSetup

    ld hl, $9400
    call Banked_PauseMenu_LoadItemGraphic

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 7
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret
	
PauseMenu_ADVICE_CheckSGB::
    ;Do nothing if no SGB detected.
    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ;Do nothing if CGB hardware detected. This is possible if, say, we're in bgb
    ;or someone builds a Super Game Boy Color cart
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret

SECTION "Pause Menu Load SGB Files 3", ROMX[$5740], BANK[$1]
PauseMenu_ADVICE_LoadSGBFilesNumMessages::
    M_AdviceSetup

    ld e, 6
    push de
    ld bc, $106
    xor a
    call Banked_RLEDecompressTMAP0
    pop de
    ld bc, $106
    xor a
    call Banked_RLEDecompressAttribsTMAP0

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld c, $A
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 1
    call PatchUtils_CommitStagedCGBToSGB
    
.return
    M_AdviceTeardown
    ret

PauseMenu_ADVICE_LoadSGBFilesListMessages::
    M_AdviceSetup

    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld c, $B
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 2
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 6
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

PauseMenu_ADVICE_SMSMapTiles_LoadSGBFiles::
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld c, $A
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, b
    call PatchUtils_CommitStagedCGBToSGB

.return
    ld bc, $106
    ret

SECTION "Pause Menu Load SGB Files 4", ROMX[$5950], BANK[$1]
PauseMenu_ADVICE_LoadSGBFilesPhoneIME::
    M_AdviceSetup ; FA 23 C4 F5 FA 25 C4 F5 3E 01 EA 23 C4 EA 25 C4 FB F8 06 2A 66 6F

    ld a, 1 ; 3E 01
    ld [W_PhoneIME_CurrentNumberLength], a ; EA 29 CB

    call PauseMenu_ADVICE_CheckSGB ; CD 15 56
    jr z, .return ; 28 08

    ld a, M_SGB_Pal23 << 3 + 1 ; 3E 09
    ld b, 5 ; 06 05
    ld c, b ; 48
    call PatchUtils_CommitStagedCGBToSGB ; CD 00 72

.return
    M_AdviceTeardown ; F3 F1 EA 25 C4 F1 EA 23 C4
    ret ; C9
