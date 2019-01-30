INCLUDE "telefang.inc"

SECTION "Pause Menu Contacts", ROMX[$4A49], BANK[$4]
ContactMenu_StateMachine::
    call PauseMenu_DrawClockSprites
    ld a, [W_SystemSubSubState]
    ld hl, .state_table
    call System_IndexWordList
    jp [hl]

.state_table
    dw ContactMenu_StateInit ; 00
    dw ContactMenu_StateDrawContactDenjuu ; 01
    dw ContactMenu_StateMapSubscreen ; 02
    dw ContactMenu_StateInputHandler ; 03
    dw ContactMenu_StateEnterActionScreen ; 04
    dw ContactMenu_StateDoNothing ; 05
    dw ContactMenu_StateActionScreenInputHandler ; 06
    dw ContactMenu_StateEnterStatus ; 07
    dw ContactMenu_StateExitStatus ; 08
    dw PhoneConversation_SubStateDialNumber ; 09
    dw PauseMenu_SubStateSMSExit1 ; 0A
    dw PauseMenu_SubStateSMSExit2 ; 0B
    dw PhoneConversation_SubStateCallOutDrawScreen ; 0C
    dw PhoneConversation_SubStateCallOutFadeScreenIn ; 0D
    dw PhoneConversation_SubStateCallOutConvoScriptProcessing ; 0E
    dw PhoneConversation_SubStateCallOutSwitchScriptProcessing ; 0F
    dw PhoneConversation_SubStateCallOutFadeToContactMenu ; 10
    dw ContactMenu_StateInitRingtoneScreen ; 11
    dw ContactMenu_StateRingtoneScreenInputHandler ; 12
    dw ContactMenu_StateExitRingtoneScreen ; 13
    dw ContactMenu_StateDeleteScreen ; 14
    dw PhoneConversation_SubStateCallOutNoSwitchMessage ; 15
    dw PhoneConversation_SubStateCallOutForeveeeeerrrr ; 16
    dw PhoneConversation_SubStateCallOutForeveeeeerrrrB ; 17

ContactMenu_StateInit::
    call $636B
    ld bc, $12
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .use_cgb_graphic
    
.use_dmg_graphic
    ld bc, $57
    
.use_cgb_graphic
    call Banked_LoadMaliasGraphics
    jp System_ScheduleNextSubSubState

ContactMenu_StateDrawContactDenjuu::
    ld a, [W_PauseMenu_CurrentContact]
    ld b, a
    ld a, [W_Zukan_LastKnownSpecies]
    dec a
    cp b
    jr nc, .skipdecCD24
    ld a, [W_PauseMenu_CurrentContact]
    dec a
    ld [W_PauseMenu_CurrentContact], a
    
.skipdecCD24
    ld a, [W_PauseMenu_CurrentContact]
    call PauseMenu_IndexedContactArrayLoad
    ld c, 0
    ld de, $9400
    call Banked_Battle_LoadDenjuuPortrait
    ld a, [W_PauseMenu_CurrentContact]
    call PauseMenu_IndexedContactArrayLoad
    call Battle_LoadDenjuuPaletteOpponent
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld a, [W_PauseMenu_CurrentContact]
    call PauseMenu_IndexedContactArrayLoad
    call PauseMenu_ContactPrepName
    jp System_ScheduleNextSubSubState

ContactMenu_StateMapSubscreen::
    ld e, $2E
    call PauseMenu_LoadMenuMap0
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0C0
    call Banked_PauseMenu_InitializeCursor
    ld a, $B
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0E0
    call Banked_PauseMenu_InitializeCursor
    call $7124
    ld a, 1
    ld [W_OAM_SpritesReady], a
    jp System_ScheduleNextSubSubState

ContactMenu_StateInputHandler::
    call $72D9
    ld a, 1
    ld [W_OAM_SpritesReady],  a
    ld a, [W_Zukan_LastKnownSpecies]
    dec a
    cp 0
    jr z, .rightNotPressed
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Right
    jr z, .rightNotPressed
    ld a, [W_Zukan_LastKnownSpecies]
    dec a
    ld b, a
    ld a, [W_PauseMenu_CurrentContact]
    cp b
    jr nz, .notLastContact
    ld a, $FF

.notLastContact
    inc a
    ld [W_PauseMenu_CurrentContact], a
    ld a, 1
    ld [W_SystemSubSubState], a
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ret

.rightNotPressed
    ld a, [W_Zukan_LastKnownSpecies]
    dec a
    cp 0
    jr z, .leftNotPressed
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Left
    jr z, .leftNotPressed
    ld a, [W_PauseMenu_CurrentContact]
    cp 0
    jr nz, .notFirst
    ld a, [W_Zukan_LastKnownSpecies]

.notFirst
    dec a
    ld [W_PauseMenu_CurrentContact], a
    ld a, 1
    ld [W_SystemSubSubState], a
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ret

.leftNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    call PauseMenu_ClearArrowMetasprites
    ld a, $A
    ld [W_SystemSubSubState], a
    ret

.bNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    jr z, .aNotPressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    xor a
    ld [W_MelodyEdit_DataCurrent], a
    call PauseMenu_ClearArrowMetasprites
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, 7
    ld [W_SystemSubSubState], a

.aNotPressed
    ret

ContactMenu_StateEnterActionScreen::
    ld bc, $1A
    ld a, [W_GameboyType]
    cp $11
    jr z, .use_cgb_graphic
    
.use_dmg_graphic
    ld bc, $54

.use_cgb_graphic
    call Banked_LoadMaliasGraphics
    ld e, $3E
    call PauseMenu_LoadMenuMap0
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0C0
    call Banked_PauseMenu_InitializeCursor
    call $729A
    ld a, 1
    ld [W_OAM_SpritesReady], a
    jp System_ScheduleNextSubSubState

ContactMenu_StateDoNothing::
    jp System_ScheduleNextSubSubState

ContactMenu_StateActionScreenInputHandler::
    ld de, $C0C0
    call Banked_PauseMenu_IterateCursorAnimation
    ld a, 1
    ld [W_OAM_SpritesReady], a
    jp $71A0

ContactMenu_StateEnterStatus::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    call PhoneConversation_OutboundConfigureScreen
    call $76D2
    call LCDC_ClearMetasprites
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld [W_Status_CalledFromContactScreen], a
    ld a, 9
     ld [W_SystemState], a
    xor a
    ld [W_Status_SubState], a
    ld [W_MainScript_TextStyle], a
    ret

ContactMenu_StateExitStatus::
    call LCDC_ClearMetasprites
    call PauseMenu_LoadMenuResources
    ld bc, 0
    ld e, $10
    call PauseMenu_LoadMap0
    ld bc, 0
    ld e, $11
    call PauseMenu_LoadMap1
    call PauseMenu_CGBLoadPalettes
    call PauseMenu_ConfigureScreen
    call LCDC_DMGSetupDirectPalette
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld [W_CGBPaletteStagedOBP], a
    ld a, [W_Status_CalledFromContactScreen]
    cp 1
    jr nz, .jpA
    ld bc, $12
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .cgb_resource

.dmg_resource
    ld bc, $57

.cgb_resource
    call Banked_LoadMaliasGraphics
    ld a, 1
    ld [W_SystemSubSubState], a
    xor a
    ld [W_Status_CalledFromContactScreen], a
    jp $636B

.jpA
    xor a
    ld [W_Status_CalledFromContactScreen], a
    ld a, 4
    ld [W_SystemSubSubState], a
    ret

SECTION "Pause Menu Contacts 2", ROMX[$4D86], BANK[$4]
ContactMenu_StateInitRingtoneScreen::
    ld e, $58
    call PauseMenu_LoadMenuMap0
    call $7DEA
    call $7907
    sla a
    sla a
    sla a
    add $38
    ld [$C0E4], a
    ld a, $10
    ld [$C0E3], a
    ld a, 1
    ld [$C0E0], a
    ld a, 0
    ld [$C0E1], a
    ld a, $D
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0E0
    call Banked_PauseMenu_InitializeCursor
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0C0
    call Banked_PauseMenu_InitializeCursor
    xor a
    ld [W_MelodyEdit_DataCurrent], a
    call $78E2
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    jp System_ScheduleNextSubSubState

ContactMenu_StateRingtoneScreenInputHandler::
    ld de, $C0C0
    call Banked_PauseMenu_IterateCursorAnimation
    ld de, $C0E0
    call Banked_PauseMenu_IterateCursorAnimation
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld a, $C
    ld [W_System_CountdownTimer], a
    jp $7816

ContactMenu_StateExitRingtoneScreen::
    ld a, [W_System_CountdownTimer]
    dec a
    ld [W_System_CountdownTimer], a
    cp 1
    jr z, .oneSecondToMidnight
    cp 0
    ret nz
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .use_cgb_graphic

.use_dmg_graphic
    ld bc, $54
    call Banked_LoadMaliasGraphics
    ld bc, $57
    call Banked_LoadMaliasGraphics
    jr .setMusic

.use_cgb_graphic
    ld bc, $1A
    call Banked_LoadMaliasGraphics
    ld bc, $12
    call Banked_LoadMaliasGraphics

.setMusic
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    ld a, 1
    ld [W_SystemSubSubState], a
    ret

.oneSecondToMidnight
    call PauseMenu_ClearArrowMetasprites
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret

ContactMenu_StateDeleteScreen::
    ld de, $C0C0
    call Banked_PauseMenu_IterateCursorAnimation
    ld a, 1
    ld [W_OAM_SpritesReady], a
    jp ContactMenu_DeleteScreenInputHandler


SECTION "Pause Menu Contacts 3", ROMX[$796D], BANK[$4]
ContactMenu_DeleteScreenInputHandler::
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    jr z, .aNotPressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_MelodyEdit_DataCount]
    cp 0
    jr nz, .abortAbort
    call PauseMenu_IndexContactArray
    call $647C
    call $636B
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    ld a, 1
    ld [W_SystemSubSubState], a
    ld bc, $12
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .use_cgb_graphic

.use_dmg_graphic
    ld bc, $57

.use_cgb_graphic
    call Banked_LoadMaliasGraphics
    ld de, $C0C0
    jp LCDC_ClearSingleMetasprite

.aNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed
    ld a, 4
    ld [W_Sound_NextSFXSelect],a

.abortAbort
    ld de, $C0C0
    call LCDC_ClearSingleMetasprite
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld a, 4
    ld [W_SystemSubSubState], a
    ret

.bNotPressed
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Up
    jp z, .upNotPressed
    jr .upOrDownPressed

.upNotPressed
    ld a,[W_JPInput_TypematicBtns]
    and M_JPInput_Down
    jp z, .exitAndLoop

.upOrDownPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_MelodyEdit_DataCount]
    xor 1
    ld [W_MelodyEdit_DataCount], a
    jp .repositionArrow

.exitAndLoop
    ret

.repositionArrow
    ld b, $10
    ld a, [W_MelodyEdit_DataCount]
    sla a
    sla a
    sla a
    sla a
    add $68
    jp TitleMenu_PositionFirstCursor

SECTION "Action Screen Input Handler 1", ROMX[$71A0], BANK[$4]
ContactMenu_ActionScreenInputHandler::
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Up
    jp z, .upNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_MelodyEdit_DataCurrent]
    cp 0
    jr nz, .notFirst
    ld a, 3

.notFirst
    dec a
    ld [W_MelodyEdit_DataCurrent], a
    jp ContactMenu_ActionScreenInputHandler_PositionFirstCursor

.upNotPressed
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Down
    jp z, .downNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_MelodyEdit_DataCurrent]
    cp 2
    jr nz, .notLast
    ld a, $FF

.notLast
    inc a
    ld [W_MelodyEdit_DataCurrent], a
    jp ContactMenu_ActionScreenInputHandler_PositionFirstCursor

.downNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jp z, .bNotPressed
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    ld bc, $12
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .use_cgb_graphic
    ld bc, $57

.use_cgb_graphic
    call Banked_LoadMaliasGraphics
    ld de, $C0C0
    call LCDC_ClearSingleMetasprite
    ld a, 1
    ld [W_SystemSubSubState], a
    jp $636B

.bNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    jp z, .aNotPressed
    ld a, [W_MelodyEdit_DataCurrent]
    cp 0
    jp z, .callPlz
    cp 1
    jp z, .deletePlz

.meloDPlz
    ld de, $C0C0
    call LCDC_ClearSingleMetasprite
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    ld bc, $13
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .use_cgb_graphic
    ld bc, $5A

.use_cgb_graphic
    call Banked_LoadMaliasGraphics
    ld a, $11
    ld [W_SystemSubSubState], a
    ret

.callPlz
    call PauseMenu_IndexContactArray
    call CallsMenu_QueuePhoneNumberSFXForContact
    xor a
    ld [W_MelodyEdit_DataCurrent], a
    ld a, $10
    ld [W_System_CountdownTimer], a
    ld a, 1
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    ld a, 9
    ld [W_SystemSubSubState], a
    ret

.orphanedCode
    ld a, 5
    ld [W_Sound_NextSFXSelect], a
    ret

.aNotPressed
    ret

.deletePlz
    call $718A
    cp 0
    jr z, .canDelete
    ld a, 5
    ld [W_Sound_NextSFXSelect], a
    ret

.canDelete
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld bc, $109
    ld e, $59
    call PauseMenu_LoadMap0
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    ld de, $C0C0
    call Banked_PauseMenu_InitializeCursor
    ld a, 1
    ld [W_MelodyEdit_DataCount], a
    call ContactMenu_DeleteScreenInputHandler.repositionArrow
    ld a, $14
    ld [W_SystemSubSubState], a
    ret

SECTION "Action Screen Input Handler 2", ROMX[$729A], BANK[$4]
ContactMenu_ActionScreenInputHandler_PositionFirstCursor::
    ld b, $10
    ld a, [W_MelodyEdit_DataCurrent]
    sla a
    sla a
    sla a
    sla a
    add $58
; Continues into TitleMenu_PositionFirstCursor
; Make sure that any code modifications in patch keep the same byte length to prevent execution of junk bytes.