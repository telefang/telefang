INCLUDE "telefang.inc"

SECTION "Phone Convo Outbound RAM", WRAM0[$CB04]
W_PhoneConversation_CalledDenjuu:: ds 1

SECTION "Phone Convo Outbound States", ROMX[$4C47], BANK[$4]
PhoneConversation_SubStateDialNumber::
    jp sub_12B2B

PhoneConversation_SubStateCallOutDrawScreen:: ;State 0C 10 0C
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    
    call PhoneConversation_OutboundConfigureScreen
    
    xor a
    ld [W_MainScript_TextStyle], a
    
    ld a, 1
    ld [W_Status_CalledFromContactScreen], a
    
    call LCDC_ClearMetasprites
    call PauseMenu_IndexContactArray
    
    ld [W_PhoneConversation_CalledDenjuu], a
    call PhoneConversation_GetCalledDenjuuSpecies
    call PhoneConversation_DrawOutboundCallScreen
    call PauseMenu_ContactsMenuDrawDenjuuNickname
    
    ld e, $1C
    ld bc, $603
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    xor a
    ld [W_CGBPaletteStagedBGP], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    ld a, 2
    ld [W_Overworld_PowerAntennaPattern], a
    ld a, [W_PhoneConversation_CalledDenjuu]
    call PhoneConversation_OutboundIncrementFD
    jp System_ScheduleNextSubSubState
    
PhoneConversation_SubStateCallOutFadeScreenIn:: ;State 0C 10 0D
    ld a, 0
    call Banked_LCDC_PaletteFade
    or a
    ret z
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, $85
    ld [W_MainScript_WindowBorderAttribs], a
    
    ld a, $A0
    ld [W_MainScript_TileBaseIdx], a
    
    call $70C
    
    ld d, $C
    call $520
    
    jp System_ScheduleNextSubSubState

PhoneConversation_SubStateCallOutConvoScriptProcessing:: ;State 0C 10 0E
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    
    ld c, $FE
    ld b, 1
    ld d, $C
    call $520
    
    jp System_ScheduleNextSubSubState

PhoneConversation_SubStateCallOutSwitchScriptProcessing:: ;State 0C 10 0F
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp a, 9
    ret nz
    ld bc, $C3E
    call Overworld_CheckFlagValue
    jr nz, .yesSelected
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp System_ScheduleNextSubSubState

.yesSelected
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    call $06D4
    ld a, [$C955]
    cp c
    jr nz, .hpIsntFull
    call PauseMenu_IndexContactArray
    ld b, a
    ld a, [W_PauseMenu_DeletedContact]
    cp b
    jr z, .alreadyFollowing
    ld a, b
    ld [W_PauseMenu_DeletedContact], a
    call PhoneConversation_GetCalledDenjuuSpecies
    ld [W_Overworld_PartnerSpecies], a
    ld a, 8
    ld [W_Overworld_State], a
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $17
    ld [W_SystemSubState], a
    xor a
    ld [W_SystemSubSubState], a
    ret

.alreadyFollowing
    ld c, $F0
    jr .queueMessage

.hpIsntFull
    ld c, $F1

.queueMessage
    ld b, 1
    ld d, $C
    call $0520
    ld a, $15
    ld [W_SystemSubSubState], a
    ret

PhoneConversation_SubStateCallOutFadeToContactMenu::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    xor a
    ld [W_Overworld_PowerAntennaPattern], a
    call LCDC_ClearMetasprites
    call PauseMenu_LoadMenuResources
    ld bc, $12
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .use_cgb_graphic

.use_dmg_graphic
    ld bc, $57

.use_cgb_graphic
    call Banked_LoadMaliasGraphics
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
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    xor a
    ld [W_Status_CalledFromContactScreen], a
    ld a, 1
    ld [W_SystemSubSubState], a
    jp $636B

SECTION "Phone Convo Outbound States 2", ROMX[$4E45], BANK[$4]
PhoneConversation_SubStateCallOutNoSwitchMessage::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $10
    ld [W_SystemSubSubState], a
    ret

PhoneConversation_SubStateCallOutForeveeeeerrrr::
    ret

PhoneConversation_SubStateCallOutForeveeeeerrrrB::
    ret

SECTION "Phone Conversation Outbound 2", ROMX[$771C], BANK[$4]
PhoneConversation_DrawOutboundCallScreen::
    push af
    call Banked_PhoneConversation_LoadPhoneFrameTiles
    
    ld a, [W_Encounter_SceneryType]
    call Banked_PhoneConversation_LoadSceneryTiles
    
    pop af
    push af
    ld c, 0
    ld de, $9400
    call Banked_Battle_LoadDenjuuPortrait
    
    ld hl, $695F
    ld de, $8800
    ld bc, $100
    ld a, $37
    call Banked_LCDC_LoadGraphicIntoVRAM
    
    ld a, [W_Encounter_SceneryType]
    add a, $50
    ld e, a
    ld bc, 0
    call PauseMenu_LoadMap0
    
    ld bc, $C
    ld e, $1A
    call PauseMenu_LoadMap0
    
    pop af
    call Battle_LoadDenjuuPalettePartner
    
    ld hl, $60
    ld a, [W_SaveClock_RealTimeHours]
    cp $14
    jr nc, .selectDifferentBase
    cp 4
    jr nc, .selectFirstBase
    
.selectDifferentBase
    ld hl, $380
    
.selectFirstBase
    ld a, [W_Encounter_SceneryType]
    call PauseMenu_IndexPtrTable
    
    push hl
    pop bc
    push bc
    ld a, 3
    call CGBLoadBackgroundPaletteBanked
    
    pop bc
    inc bc
    ld a, 4
    call CGBLoadBackgroundPaletteBanked
    
    ld bc, $36
    ld a, 1
    call CGBLoadBackgroundPaletteBanked
    
    ld a, [W_PauseMenu_WindowFlavor]
    ld c, a
    ld b, 0
    ld hl, $324
    add hl, bc
    push hl
    pop bc
    ld a, 5
    call CGBLoadBackgroundPaletteBanked
    
    jp PauseMenu_CGBLoadPhonePalette
    
SECTION "Phone Conversation Outbound 3", ROMX[$7E6E], BANK[$4]
PhoneConversation_OutboundConfigureScreen::
    ld a, $C3
    ld [W_ShadowREG_LCDC], a
    xor a
    ld [W_ShadowREG_SCX], a
    ld [W_ShadowREG_SCY], a
    ld [W_ShadowREG_WX], a
    ld [W_ShadowREG_WY], a
    ret