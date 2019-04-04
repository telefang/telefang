INCLUDE "telefang.inc"

SECTION "Recruitment State Machine", ROMX[$5040], BANK[$1D]
Victory_RecruitmentStateMachine::
    ld a, [W_LateDenjuu_SubSubState]
    ld hl, .table
    call System_IndexWordList
    jp hl

.table
    dw Victory_SubStateDrawRecruitmentScreen
    dw Victory_SubStateRecruitmentFadeInAndMemoryMarker
    dw Victory_SubStateRecruitmentGotNumberMessage
    dw Victory_SubStateRecruitmentCheckCapacityAndDrawNumber
    dw Victory_SubStateRecruitmentHideNumberOnInput
    dw Victory_SubStateRecruitmentSaveNumberMessageAndInputHandler
    dw Victory_SubStateRecruitmentSaveNumberParseResponse
    dw Victory_SubStateRecruitmentFadeOutForExit
    dw Victory_SubStateRecruitmentExit
    dw Victory_SubStateRecruitmentWowYoureStrongMessage
    dw Victory_SubStateRecruitmentPhoneMemoryFullMessage
    dw Victory_SubStateRecruitmentGiveNicknameMessageAndInputHandler
    dw Victory_SubStateRecruitmentOpenNicknameScreen

Victory_RecruitmentPhoneMemoryTable::
    db $46, $8C, $F0
    db $46, $8C, $F0
    db $46, $8C, $F0

Victory_SubStateDrawRecruitmentScreen::
    ld bc, $16
    call Banked_LoadMaliasGraphics
    ld bc, 9
    call Banked_LoadMaliasGraphics
    ld bc, $E
    call Banked_CGBLoadBackgroundPalette
    ld a, $28
    call PauseMenu_CGBStageFlavorPalette
    ld bc, 0
    ld e, $70
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, 0
    ld e, $70
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    ld bc, 4
    ld e, $AD
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, $605
    ld e, $91
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, $605
    ld e, $8B
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    ld a, [$D480]
    ld de, $9100
    call Status_LoadEvolutionIndicatorBySpecies
    ld a, [$D480]
    push af
    ld c, 0
    ld de, $8800
    call Banked_Battle_LoadDenjuuPortrait
    pop af
    call Battle_LoadDenjuuPaletteOpponent
    ld hl, $9580
    ld a, 8
    call MainScript_DrawEmptySpaces
    ld a, [$D480]
    ld de, Victory_ExternalStateMachine
    ld bc, $9580
    call MainScript_DrawCenteredName75
    ld a, [$D480]
    call Victory_LoadSpeciesNameAsArg1
    ld c, $6C
    call Battle_QueueMessage
    ld a, $28
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    ld a, [$D481]
    ld hl, $984A
    ld c, 1
    call Encounter_DrawTileDigits
    ld a, 0
    call $5456
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentFadeInAndMemoryMarker::
    ld a, 0
    call Banked_LCDC_PaletteFade
    or a
    ret z
    call $53F8
    cp 0
    jr z, .speciesNotInMemory
    ld bc, $201
    ld e, $A3
    ld a, 0
    call Banked_RLEDecompressTMAP0

.speciesNotInMemory
    ld a, [W_Encounter_BattleType]
    cp M_Encounter_BattleTypeTfanger
    jp z, .tfangerDefection
    ld a, 9
    ld [W_LateDenjuu_SubSubState], a
    ret

.tfangerDefection
    ld c, 3
    call Battle_QueueMessage
    ld a, 2
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentWowYoureStrongMessage::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    ld c, 3
    call Battle_QueueMessage
    ld a, 2
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentGotNumberMessage::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentCheckCapacityAndDrawNumber::
    ld bc, $20E
    ld e, $AB
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld hl, Victory_RecruitmentPhoneMemoryTable
    ld a, [W_PauseMenu_PhoneState]
    cp 0
    jr z, .skipLoop

.phoneCapacityTableOffsetLoop
    inc hl
    dec a
    jr nz, .phoneCapacityTableOffsetLoop

.skipLoop
    ld a, [hl]
    ld b, a
    ld a, [W_Victory_ContactsPresent]
    cp b
    jr nc, .insufficientMemoryAtThisTime
    ld bc, $18
    call Banked_LoadMaliasGraphics
    call $53AD
    ld a, 0
    ld [W_PauseMenu_CurrentContact], a
    call SaveClock_EnterSRAM2
    ld hl, $A00A
    ld a, [$D4A7]
    call Battle_IndexStatisticsArray
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, [hl]
    ld hl, $99C3
    call Banked_Status_DrawPhoneNumber
    call SaveClock_ExitSRAM
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

.insufficientMemoryAtThisTime
    ld c, $6E
    call Battle_QueueMessage
    ld a, $A
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentPhoneMemoryFullMessage::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    ld a, 1
    ld [W_Victory_UserSelection], a
    ld a, 6
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentHideNumberOnInput::
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A + M_JPInput_B
    ret z
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld c, $63
    call Battle_QueueMessage
    xor a
    ld [W_Victory_UserSelection], a
    call Victory_PlaceChoiceCursor
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentSaveNumberMessageAndInputHandler::
    call LCDC_IterateAnimationComplex
    call Banked_MainScriptMachine
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Left
    jr z, .leftNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_UserSelection]
    cp 0
    jr z, .moveCursorRightOnLeft
    xor a
    ld [W_Victory_UserSelection], a
    jp Victory_PlaceChoiceCursor

.moveCursorRightOnLeft
    ld a, 1
    ld [W_Victory_UserSelection], a
    jp Victory_PlaceChoiceCursor

.leftNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Right
    jr z, .rightNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .moveCursorLeftOnRight
    ld a, 1
    ld [W_Victory_UserSelection], a
    jp Victory_PlaceChoiceCursor

.moveCursorLeftOnRight
    xor a
    ld [W_Victory_UserSelection], a
    jp Victory_PlaceChoiceCursor

.rightNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    jr .noSelected

.bNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    ret z
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .noSelected
    ld c, $64
    jr .yesSelected

.noSelected
    ld a, 1
    ld [W_Victory_UserSelection], a
    call SaveClock_EnterSRAM2
    ld hl, $A001
    ld a, [$D4A7]
    call Battle_IndexStatisticsArray
    ld a, 0
    ld [hl], a
    ld c, $65

.yesSelected
    call Battle_QueueMessage
    ld a, 0
    ld [W_MetaSpriteConfig1], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentSaveNumberParseResponse::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp 9
    ret nz
    ld a, [W_Victory_UserSelection]
    cp 0
    jr nz, .noSelected
    ld c, $8F
    call Battle_QueueMessage
    xor a
    ld [W_Victory_UserSelection], a
    call Victory_PlaceChoiceCursor
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    ld a, $B
    ld [W_LateDenjuu_SubSubState], a
    ret

.noSelected
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $10
    ld [$CF96], a
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentFadeOutForExit::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, 0
    ld [W_ShadowREG_HBlankSecondMode], a
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentExit::
    xor a
    ld [W_LateDenjuu_SubSubState], a
    ld a, 8
    ld [W_Battle_SubSubState], a
    ret

Victory_SubStateRecruitmentGiveNicknameMessageAndInputHandler::
    call LCDC_IterateAnimationComplex
    call Banked_MainScriptMachine
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Left
    jr z, .leftNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_UserSelection]
    cp 0
    jr z, .moveCursorRightOnLeft
    xor a
    ld [W_Victory_UserSelection], a
    jp Victory_PlaceChoiceCursor

.moveCursorRightOnLeft
    ld a, 1
    ld [W_Victory_UserSelection], a
    jp Victory_PlaceChoiceCursor

.leftNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_Right
    jr z, .rightNotPressed
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .moveCursorLeftOnRight
    ld a, 1
    ld [W_Victory_UserSelection], a
    jp Victory_PlaceChoiceCursor

.moveCursorLeftOnRight
    xor a
    ld [W_Victory_UserSelection], a
    jp Victory_PlaceChoiceCursor

.rightNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .bNotPressed
    ld a, 0
    ld [W_MetaSpriteConfig1], a
    ld [$C0C0], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    jr .noSelected

.bNotPressed
    ldh a, [H_JPInput_Changed]
    and M_JPInput_A
    ret z
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    ld a, 0
    ld [W_MetaSpriteConfig1], a
    ld [$C0C0], a
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .noSelected
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, [W_LateDenjuu_SubSubState]
    inc a
    ld [W_LateDenjuu_SubSubState], a
    ret

.noSelected
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    ld a, $10
    ld [$CF96], a
    ld a, 7
    ld [W_LateDenjuu_SubSubState], a
    ret

Victory_SubStateRecruitmentOpenNicknameScreen::
    ld a, 1
    call Banked_LCDC_PaletteFade
    or a
    ret z
    ld a, [$D502]
    ld [$C955], a
    xor a
    ld [W_LateDenjuu_SubSubState], a
    ld [W_Battle_SubSubState], a
    ld a, $1F
    ld [W_SystemSubState], a
    ld a, 3
    ld [W_SystemState], a
    ret
