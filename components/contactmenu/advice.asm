INCLUDE "telefang.inc"

SECTION "Contact Menu SGB Recolour Overview Advice", ROMX[$5630], BANK[$1]
ContactMenu_ADVICE_LoadSGBFilesOverview_Common::
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld c, 9
    call Banked_SGB_ConstructATFSetPacket

    call PauseMenu_ADVICE_CGBToSGB02Shorthand

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

    call PauseMenu_ADVICE_CGBToSGB02Shorthand
    call PauseMenu_ADVICE_CGBToSGB56Shorthand
    
.return
	ld bc, $1A
	
    M_AdviceTeardown
    ret

ContactMenu_ADVICE_LoadSGBFilesRingtone::
    M_AdviceSetup
	
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    call PauseMenu_ADVICE_CGBToSGB55Shorthand
    
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
