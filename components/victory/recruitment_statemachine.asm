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
    dw $51DC
    dw $5202
    dw $5297
    dw $52D3
    dw $52E7
    dw Victory_SubStateRecruitmentWowYoureStrongMessage
    dw Victory_SubStateRecruitmentPhoneMemoryFullMessage
    dw $52F1
    dw $538E

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
