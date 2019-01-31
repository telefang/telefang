INCLUDE "telefang.inc"

SECTION "Contact Menu SGB Recolour Overview Advice", ROMX[$5630], BANK[$1]
ContactMenu_ADVICE_LoadSGBFilesOverview_Common::
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld c, 9
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 2
    call PatchUtils_CommitStagedCGBToSGB

.return
    ret

ContactMenu_ADVICE_LoadSGBFilesOverview::
    M_AdviceSetup

    call ContactMenu_ADVICE_LoadSGBFilesOverview_Common

    ld bc, $12

    M_AdviceTeardown
    ret

SECTION "Contact Menu SGB Recolour Overview Advice 2", ROMX[$58A0], BANK[$1]
ContactMenu_ADVICE_LoadSGBFilesActionScreen::
    M_AdviceSetup
	
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return
	
    ld c, 7
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
	ld bc, $1A
	
    M_AdviceTeardown
    ret

ContactMenu_ADVICE_LoadSGBFilesRingtone::
    M_AdviceSetup
	
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, b
    call PatchUtils_CommitStagedCGBToSGB
    
.return
	ld bc, $13
	
    M_AdviceTeardown
    ret

ContactMenu_ADVICE_LoadSGBFilesOverview_RingtoneExit::
    M_AdviceSetup

    push de
    ld bc, $106
    xor a
    call Banked_RLEDecompressTMAP0
    pop de
    ld bc, $106
    xor a
    call Banked_RLEDecompressAttribsTMAP0

    call ContactMenu_ADVICE_LoadSGBFilesOverview_Common

    M_AdviceTeardown
    ret
