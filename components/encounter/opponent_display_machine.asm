INCLUDE "telefang.inc"

SECTION "Encounter Memory 6", WRAM0[$C9DA]
W_Encounter_SceneryType:: ds 1

SECTION "Encounter Memory 5", WRAM0[$CB2D]
W_Encounter_PortraitOffset:: ds 1
W_Encounter_PortraitBank:: ds 1

SECTION "Encounter Memory 2", WRAMX[$D403], BANK[$1]
W_Encounter_BattleType:: ds 1

SECTION "Encounter Memory 3", WRAMX[$D406], BANK[$1]
W_Encounter_TFangerClass:: ds 1

SECTION "Encounter Vertical Selection", WRAMX[$D40E], BANK[$1]
W_Encounter_UserVerticalSelection:: ds 1

SECTION "Encounter Memory 1", WRAMX[$D43A], BANK[$1]
W_Encounter_AlreadyInitialized:: ds 1

SECTION "Encounter Opponent Display Machine", ROMX[$44AF], BANK[$1C]
Encounter_OpponentDisplayStateMachine::
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp hl
    
.stateTable
    dw Encounter_SubStateNull ; 00
    dw Encounter_SubStateSetupThemeGraphics ; 01
    dw Encounter_SubStateDrawEncounterScreen ; 02
    dw Encounter_SubStateFadeIn ; 03
    dw Encounter_SubStateDenjuuOrTFangerAppearedMessage ; 04
    dw Encounter_SubStateGoDenjuuMessage ; 05
    dw Encounter_SubStateFightFleeStatus ; 06
    dw Encounter_SubStateInputHandler ; 07
    dw Encounter_SubStateEnterOpponentStatusScreen ; 08
    dw Encounter_SubStateFuckThisImOuttaHere ; 09
    dw Encounter_SubStateButYouCouldntEscapeMessage ; 0A
    dw Encounter_SubStateAccessingPhoneMemory ; 0B
    dw Encounter_SubStateEnterSummonScreen ; 0C
    dw Encounter_SuccessfulFleeFade ; 0D
    dw Encounter_SuccessfulFleeExitToOverworld ; 0E

; State 06 01 00
Encounter_SubStateNull::
    jp Battle_IncrementSubSubState

; State 06 01 01
Encounter_SubStateSetupThemeGraphics::
    call ClearGBCTileMap0
    call ClearGBCTileMap1
    call LCDC_ClearMetasprites
    
    ld bc, $12
    call Banked_CGBLoadBackgroundPalette
    
    ld bc, $4
    call Banked_CGBLoadObjectPalette
    
    ld bc, M_Malias_menu_encounter
    call Banked_LoadMaliasGraphics
    
    ld a, $28
    call PauseMenu_CGBStageFlavorPalette
    
    call Encounter_DrawScenery
    jp Battle_IncrementSubSubState
    
Encounter_DrawScenery::
    ld a, [W_Encounter_SceneryType]
    call Banked_Encounter_LoadSceneryTiles
    
    ld a, [W_Encounter_SceneryType]
    ld e, a
    ld d, 0
    sla e
    rl d
    ld hl, $60
    ld a, [W_Overworld_CurrentTimeHours]
    cp 20
    jr nc, .nightPalettes
    cp 4
    jr nc, .offsetByScenery
    
.nightPalettes
    ld hl, $380
    
.offsetByScenery
    ld a, [W_Encounter_SceneryType]
    ld e, a
    ld d, 0
    sla e
    rl d
    add hl, de
    
    push hl
    pop bc
    push bc
    
    ld a, 3
    call CGBLoadBackgroundPaletteBanked
    
    pop bc
    inc bc
    ld a, 4
    call CGBLoadBackgroundPaletteBanked
    
    ld a, 1
    ld [W_RLEAttribMapsEnabled], a
    
    ret

; State 06 01 02
Encounter_SubStateDrawEncounterScreen::
    ld a, $20
    ld [W_LCDC_MetaspriteAnimationBank], a
    
    ld bc, 0
    ld e, $B
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, 0
    ld e, $B
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld e, $40
    ld a, [W_Encounter_SceneryType]
    add a, e
    ld e, a
    ld bc, 4
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld e, $40
    ld a, [W_Encounter_SceneryType]
    add a, e
    ld e, a
    ld bc, 4
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld bc, $201
    ld e, $84
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld hl, $9850
    ld a, [W_Overworld_SignalStrength]
    call Encounter_DrawSignalIndicator
    
    ld a, 5
    ld [W_MainScript_WindowBorderAttribs], a
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, [W_Encounter_AlreadyInitialized]
    cp 0
    jr z, .startMusic
    
.alreadyPlaying
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    push af
    ld c, 0
    ld de, $8800
    call Banked_Battle_LoadDenjuuPortrait
    
    pop af
    call Battle_LoadDenjuuPaletteOpponent
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    ld de, StringTable_denjuu_species
    ld bc, $9500
    call MainScript_DrawCenteredName75
    
    ld bc, $B01
    ld e, $97
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLevel]
    ld hl, $984B
    ld c, 1
    call Encounter_DrawTileDigits
    jp .fadeAndNextState
    
.startMusic
    xor a
    ld [$D40E], a
    ld [$D40D], a
    
    ld a, $12
    call Sound_IndexMusicSetBySong
    
    ld [W_Sound_NextBGMSelect], a
    
    ld a, [W_Encounter_BattleType]
    cp M_Encounter_BattleTypeRandom
    jr z, .drawDenjuu
    cp M_Encounter_BattleTypeStory
    jr z, .drawDenjuu
    
.drawTfanger
    ld a, [W_Encounter_TFangerClass]
    dec a
    push af
    
    ld de, $8800
    call Banked_Encounter_LoadTFangerPortrait
    
    pop af
    call Battle_LoadExtraPalette
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    ld c, 0
    ld de, $8B80
    call Banked_Battle_LoadDenjuuPortrait
    
    ld a, [W_Encounter_TFangerClass]
    dec a
    ld de, StringTable_battle_tfangers
    ld bc, $9500
    call MainScript_DrawCenteredName75
    
    ld a, [W_Encounter_TFangerClass]
    dec a
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_battle_tfangers
    call StringTable_LoadName75
    call Encounter_CopyStagedStringToArg2
    
    ld c, $71
    call Battle_QueueMessage
    jp .fadeAndNextState

.drawDenjuu
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    push af
    ld c, 0
    ld de, $8800
    call Banked_Battle_LoadDenjuuPortrait
    
    pop af
    call Battle_LoadDenjuuPaletteOpponent
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    ld de, StringTable_denjuu_species
    ld bc, $9500
    call MainScript_DrawCenteredName75
    
    ld bc, $B01
    ld e, $97
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLevel]
    ld hl, $984B
    ld c, 1
    call Encounter_DrawTileDigits
    
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    ld hl, StringTable_denjuu_species
    call StringTable_LoadName75
    call Encounter_CopyStagedStringToArg2
    
    ld a, [W_Encounter_BattleType]
    cp M_Encounter_BattleTypeStory
    jr z, .storyDenjuuMessage
    
.randomEncounterMessage
    ld c, M_Battle_MessageRandomEncounter
    call Battle_QueueMessage
    jp .fadeAndNextState
    
.storyDenjuuMessage
    ld c, M_Battle_MessageStoryEncounter
    call Battle_QueueMessage
    jp .fadeAndNextState
    
.unk
    ld a, 0
    ld [$D45D], a
    ld [$D45E], a
    
.fadeAndNextState
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp Battle_IncrementSubSubState

Encounter_SubStateFadeIn::
; This is designed to progress to the next substate (substate 4) after the fade in when first displaying the encounter screen,
; however it is also designed to skip to substate 6 when returning from the status screen.
; This is because we only want to display encounter messages once.

    ld a, [W_Encounter_AlreadyInitialized]
    cp 0
    jr z, .initialFadeIn
    ld a, 0
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, 0
    ld [W_Encounter_AlreadyInitialized], a
    ld a, 6
    ld [W_Battle_SubSubState], a
    ret

.initialFadeIn
    ld a, 2
    call Banked_LCDC_PaletteFade
    or a
    ret z
    jp Battle_IncrementSubSubState

Encounter_SubStateDenjuuOrTFangerAppearedMessage::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    ld a, [W_Encounter_BattleType]
    cp 0
    jp z, .notTFanger
    cp 2
    jp z, .notTFanger

; If it is a TFanger then we need to load the Denjuu to the screen and queue the relevant message.

    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    call Battle_LoadDenjuuPaletteOpponent
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld bc, $605
    ld e, $96
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    ld de, Encounter_GameStateMachine
    ld bc, $9500
    call MainScript_DrawCenteredName75
    ld bc, $B01
    ld e, $97
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLevel]
    ld hl, $984B
    ld c, 1
    call Encounter_DrawTileDigits
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    ld [W_StringTable_ROMTblIndex], a
    ld hl, Encounter_GameStateMachine
    call StringTable_LoadName75
    call Encounter_CopyStagedStringToArg2
    ld c, $23
    call Battle_QueueMessage
    ld a, $52
    ld [W_Sound_NextSFXSelect], a
    jp Battle_IncrementSubSubState

.notTFanger
    ld a, 6
    ld [W_Battle_SubSubState], a
    ret

Encounter_SubStateGoDenjuuMessage::
; This is skipped if the opponent isn't a TFanger.

    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp a, 9
    ret nz
    jp Battle_IncrementSubSubState

Encounter_SubStateFightFleeStatus::
    ld c, $26
    call Battle_QueueMessage
    ld a, 0
    call Banked_Status_LoadUIGraphics
    ld a, 0
    ld bc, 4
    call CGBLoadObjectPaletteBanked
    ld a, 1
    ld [W_CGBPaletteStagedOBP], a
    call $4ACA
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    jp Battle_IncrementSubSubState

Encounter_SubStateInputHandler::
    call LCDC_IterateAnimationComplex
    call Banked_MainScriptMachine
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Up
    jr z, .upNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Encounter_UserVerticalSelection]
    cp 0
    jr z, .moveCursorToStatus
    ld a, 0
    ld [W_Encounter_UserVerticalSelection], a
    jp $4ACA

.moveCursorToStatus
    ld a, [W_Victory_UserSelection]
    cp a, 1

; Do nothing if cursor is next to "Flee".

    jr z, .upNotPressed
    ld a, 1
    ld [W_Encounter_UserVerticalSelection], a
    jp $4ACA

.upNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Down
    jr z, .downNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Encounter_UserVerticalSelection]
    cp a, 1
    jr z, .moveCursorUpToFight
    ld a, [W_Victory_UserSelection]
    cp a, 1
    jr nz, .cursorPositionNotFlee
    ld a, 0
    ld [W_Victory_UserSelection], a

.cursorPositionNotFlee
    ld a, 1
    ld [W_Encounter_UserVerticalSelection], a
    jp $4ACA

.moveCursorUpToFight
    ld a, 0
    ld [W_Encounter_UserVerticalSelection], a
    jp $4ACA

.downNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Left
    jr z, .leftNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_UserSelection]
    cp a, 0
    jr z, .moveCursorRightToFlee
    ld a, 0
    ld [W_Victory_UserSelection], a
    jp $4ACA

.moveCursorRightToFlee
    ld a, [W_Encounter_UserVerticalSelection]
    cp 1

; Do nothing if cursor is next to "Status".

    jr z, .leftNotPressed
    ld a, 1
    ld [W_Victory_UserSelection], a
    jp $4ACA

.leftNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Right
    jr z, .rightNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .moveCursorLeftToFight
    ld a, 1
    ld [W_Victory_UserSelection], a
    ld a, 0
    ld [W_Encounter_UserVerticalSelection], a
    jp $4ACA

.moveCursorLeftToFight
    ld a, 0
    ld [W_Victory_UserSelection], a
    jp $4ACA

.rightNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    jr z, .aNotPressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    xor a
    ld [W_MetaSpriteConfig1], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld a, [W_Encounter_UserVerticalSelection]
    cp 1
    jr z, .statusSelected
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .fleeSelected
    ld a, $B
    ld [W_Battle_SubSubState], a
    ret

.statusSelected
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp Battle_IncrementSubSubState

.aNotPressed
    ldh a,[H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed

.fleeSelected
    ld a, $57
    ld [W_Sound_NextSFXSelect], a
    xor a
    ld [W_MetaSpriteConfig1], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld a, $1E
    ld [W_Battle_LoopIndex], a
    ld c, $11
    call Battle_QueueMessage
    ld a, 9
    ld [W_Battle_SubSubState], a
    ret

.bNotPressed
    ret

Encounter_SubStateEnterOpponentStatusScreen::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantSpecies]
    ld [$D5B6], a
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLevel]
    ld [$D5B7], a
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantPersonality]
    ld [$D5B8], a
    ld a, 1
    ld [W_Status_NumDuplicateDenjuu], a
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLevel]
    cp 0
    jr z, .noMoreDenjuu
    ld  a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantSpecies]
    ld [$D5B9], a
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLevel]
    ld [$D5BA], a
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantPersonality]
    ld [$D5BB],a
    ld a, [W_Status_NumDuplicateDenjuu]
    inc a
    ld [W_Status_NumDuplicateDenjuu], a
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLevel]
    cp 0
    jr z, .noMoreDenjuu
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantSpecies]
    ld [$D5BC], a
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLevel]
    ld [$D5BD], a
    ld a, [W_Battle_OpponentParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantPersonality]
    ld [$D5BE], a
    ld a, [W_Status_NumDuplicateDenjuu]
    inc a
    ld [W_Status_NumDuplicateDenjuu], a

.noMoreDenjuu
    xor a
    ld [W_Status_SubState], a
    ld [W_Status_SelectedContactIndex], a
    ld a, 9
    ld [W_SystemState], a
    ret

Encounter_SubStateFuckThisImOuttaHere::
    xor a
    ld [W_MetaSpriteConfig1], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld a,[W_Battle_LoopIndex]
    dec a
    ld [W_Battle_LoopIndex], a
    cp 0
    jr z, .finishedPrintingMessage
    jp Banked_MainScriptMachine

.finishedPrintingMessage
    ld a, [W_SerIO_ConnectionState]
    cp 1
    jr z, .couldntEscape
    ld a, [W_Encounter_BattleType]
    cp 0
    jr nz, .couldntEscape
    call $4A99
    cp 0
    jr z, .couldntEscape
    call SaveClock_EnterSRAM2
    ld hl, $A002
    ld a, [W_PauseMenu_DeletedContact]
    call Battle_IndexStatisticsArray
    ld a, [hl]
    cp 1
    jr c, .fdIsRockBottom
    sub 1
    ld [hl], a

.fdIsRockBottom
    call SaveClock_ExitSRAM
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $10
    ld [$CF96], a
    ld a, $D
    ld [W_Battle_SubSubState], a
    ret

.couldntEscape
    ld c, $12
    call Battle_QueueMessage
    jp Battle_IncrementSubSubState

Encounter_SubStateButYouCouldntEscapeMessage::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    jp Battle_IncrementSubSubState

Encounter_SubStateAccessingPhoneMemory::
; If the player's contact list contains 80 or more Denjuu, then the game displays the "Accessing phone memory!".
; The game does this because more contacts means more delay before the summon screen can be shown.
    ld a, [W_Victory_ContactsPresent]
    cp 80
    jr c, .smallContactList
    ld a, 1
    ld [W_Battle_LoopIndex], a
    ld c, $96
    call Battle_QueueMessage
    jp Battle_IncrementSubSubState
.smallContactList
    ld a, 1
    ld [W_Battle_LoopIndex], a
    jp Battle_IncrementSubSubState

Encounter_SubStateEnterSummonScreen::
; If the "Accessing phone memory!" message is queued then this displays it.
; However if no mesage was queued then this exploits a behavioural trait of MainScriptMachine to display no message.
; The W_MainScript_TextPtr and W_MainScript_TextBank left over from printing the last message will always contain the address of the E1 code used to end the message.
    call Banked_MainScriptMachine
    ld a, [W_Battle_LoopIndex]
    dec a
    ld [W_Battle_LoopIndex], a
    ret nz
    xor a
    ld [W_Battle_SubSubState], a
    jp System_ScheduleNextSubState

Encounter_SuccessfulFleeFade::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    jp Battle_IncrementSubSubState

Encounter_SuccessfulFleeExitToOverworld::
    xor a
    ld [W_Battle_SubSubState], a
    ld a, 4
    ld [W_SystemSubState], a
    ret
