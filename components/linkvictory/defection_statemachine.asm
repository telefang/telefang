INCLUDE "telefang.inc"

SECTION "Link Battle Defection State Machine", ROMX[$611A], BANK[$1F]
LinkVictory_DefectionStateMachine::
	ld a, [W_LateDenjuu_SubSubState]
	cp a, 4
	jr z, .jumpToState
	cp a, 5
	jr z, .jumpToState
	cp a, 7
	jr z, .jumpToState
	cp a, 8
	jr z, .jumpToState
	cp a, $A
	jr z, .jumpToState
	cp a, $B
	jr z, .jumpToState
	ld a, [$D4AC]
	cp a, 1
	jr z, .jumpToState
	call $461B
	ld a, [Malias_CmpSrcBank]
	or a
	jr z, .jumpToState
	ld a, 7
	ld [W_LateDenjuu_SubSubState], a
	
.jumpToState
	ld a, [W_LateDenjuu_SubSubState]
	ld hl, .stateTable
	call System_IndexWordList
	jp [hl]
    
.stateTable
	dw $61A5, $62E9, $62FC, $6319
	dw $633E, $6348, $62C2, $616C
	dw $6174, LinkVictory_SubStateDrawDefectionScreen, $618B, $6195

SECTION "Link Battle Draw Defection Screen", ROMX[$61B0], BANK[$1F]
LinkVictory_SubStateDrawDefectionScreen::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z

    ld bc, $16
    call Banked_LoadMaliasGraphics
    
    ld bc, $9
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
    
    ld bc, $605
    ld e, $91
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, $605
    ld e, $8B
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld a, [W_Victory_ContactsPresent]
    cp 1
    jr z, .migrateContactId
    
.deindexLostContact
    call Victory_DeleteContact
    jr .processContactLoss
    
.migrateContactId
    ld a, [W_PauseMenu_DeletedContact]
    ld [W_Victory_DefectedContact], a

.processContactLoss
	call SaveClock_EnterSRAM2
	ld   hl, S_SaveClock_StatisticsArray
	ld   a, [W_Victory_DefectedContact]
	call Battle_IndexStatisticsArray
	ld de, $DC60
	ld bc, $10
	call memcpy
	call SaveClock_EnterSRAM2
	ld hl, S_SaveClock_NicknameArray
	ld a, [W_Victory_DefectedContact]
	ld de, 6
	cp a, 0
	jr z, .skipLoop

.nicknameAddressCalcLoop
	add hl, de
	dec a
	jr nz, .nicknameAddressCalcLoop

.skipLoop
	ld de, $DC70
	ld bc, 6
	call memcpy
	
    call SaveClock_EnterSRAM2
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuSpecies
    ld a, [W_Victory_DefectedContact]
    call Battle_IndexStatisticsArray
    
    push hl
    
    ld a, [hli]
    ld [W_Victory_DefectedContactSpecies], a
    ld a, [hl]
    ld [W_Victory_DefectedContactLevel], a
    
    pop hl
    
    ld a, M_SaveClock_DenjuuStatSize
    
.eraseLoop
    ld [hl], 0
    inc hl
    dec a
    jr nz, .eraseLoop
    
    call SaveClock_ExitSRAM
    
    ld a, [W_Victory_ContactsPresent]
    dec a
    ld [W_Victory_ContactsPresent], a
    
    ld a, [W_Victory_DefectedContact]
    ld c, a
    call $6A4
    
    ld a, 0
    ld [W_PauseMenu_CurrentContact], a
	
	call Banked_SaveClock_StoreWorkingStateToSaveData
    
    ld a, [W_Victory_DefectedContactSpecies]
    ld de, $9100
    call Status_LoadEvolutionIndicatorBySpecies
    
    ld a, [W_Victory_DefectedContactSpecies]
    push af
    ld c, 0
    ld de, $8800
    call Banked_Battle_LoadDenjuuPortrait
    
    pop af
    call Battle_LoadDenjuuPaletteOpponent
    
    ld hl, $9580
    ld a, 8
    call MainScript_DrawEmptySpaces
    
    ld hl, $9580
    ld a, [W_Victory_DefectedContact]
    call Status_DrawDenjuuNickname
    
    ld c, M_Battle_MessageDenjuuDefected
    call Battle_QueueMessage
    
    ld a, [W_Victory_DefectedContactLevel]
    ld hl, $984A
    ld c, 1
    call Encounter_DrawTileDigits
    
    ld a, $2E
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
	
	xor a
	ld [W_Battle_LoopIndex], a
	ld a, 6
	ld [W_LateDenjuu_SubSubState], a
	ret
