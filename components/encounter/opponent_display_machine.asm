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

SECTION "Encounter Memory 1", WRAMX[$D43A], BANK[$1]
W_Encounter_AlreadyInitialized:: ds 1

SECTION "Encounter Opponent Display Machine", ROMX[$44AF], BANK[$1C]
Encounter_OpponentDisplayStateMachine::
    ld a, [W_Battle_SubSubState]
    ld hl, .stateTable
    call System_IndexWordList
    jp [hl]
    
.stateTable
    dw Encounter_SubStateNull,Encounter_SubStateSetupThemeGraphics,Encounter_SubStateDrawEncounterScreen,$4693,$46B6,$4724,$4730,$4755
    dw $4857,$48C2,$491D,$4929,$4945,$4957,$4961

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
    call Encounter_ADVICE_OpponentNameAndArticleLoader
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
    call Encounter_ADVICE_ScriptedDenjuuQueueMessage
    jp .fadeAndNextState
    
.unk
    ld a, 0
    ld [$D45D], a
    ld [$D45E], a
    
.fadeAndNextState
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    jp Battle_IncrementSubSubState
	
SECTION "Battle Arrival Nickname Table", ROMX[$5D00], BANK[$1C]
Encounter_ADVICE_ScriptedDenjuuNicknameTable::
; A temporary table for nicknames in battle.
	db "Noisy", $E0, $E0, $E0, $E0, $E0, $E0, $E0
	db "Ganbanno", $E0, $E0, $E0, $E0
	
SECTION "Battle Arrival Text Preparation 1", ROMX[$5E00], BANK[$1C]
Encounter_ADVICE_ScriptedDenjuuQueueMessage::
	push bc ; C5
	push de ; D5
	push hl ; E5
	push af ; F5
	
; Load nicknames in the X has challenged you message, because why not?
	
	ld a, [$D402] ; FA 02 D4
	cp 4 ; FE 04
	jr nz, .notGanbanno ; 20 08
	ld hl, Encounter_ADVICE_ScriptedDenjuuNicknameTable + $C ; 21 0C 5D
	call Encounter_ADVICE_ScriptedDenjuuLoadNickname ; CD 2A 5E
	jr .notNoisy ; 18 0A
	
.notGanbanno
	cp 6 ; FE 06
	jr nz, .notNoisy ; 20 06
	ld hl, Encounter_ADVICE_ScriptedDenjuuNicknameTable ; 21 00 5D
	call Encounter_ADVICE_ScriptedDenjuuLoadNickname ; CD 2A 5E
	
.notNoisy
	
; Don't use articles here.
	
	ld a, $E0 ; 3E E0
	ld [W_Map_LocationStaging], a ; EA C0 CC
	pop af ; F1
	pop hl ; E1
	pop de ; D1
	pop bc ; C1
	call Battle_QueueMessage ; CD 02 3D
	ret ; C9

Encounter_ADVICE_ScriptedDenjuuLoadNickname::
	ld de, W_MainScript_MessageArg2 ; 11 58 D6
	ld b, $C ; 06 0C
	
.copyLoop
	ld a, [hli] ; 2A
	cp $E0 ; FE E0
	jr z, .abandonLoop ; 28 05
	ld [de], a ; 12
	inc de ; 13
	dec b ; 05
	jr nz, .copyLoop ; 20 F6
	
.abandonLoop

	ld a, $E0 ; 3E E0
	ld [de], a ; 12
	ret ; C9
	
