INCLUDE "telefang.inc"

;NOTE: Anyone adding new advice.
;The order of these functions should represent the order of the actual advice
;sections in code. That way, we can relocate sections when they conflict.
;Convention is to increment conflicting sections to the next $40 byte area so
;that we have some slack space in each section to hold additional code. Bank 1
;is completely empty, so we aren't too worried about wasted space from
;fragmented code.
SECTION "Patch Utilities - Auxiliary Code Trampolines", ROMX[$4000], BANK[$1]
Banked_PatchUtils_AdviceTable::
Banked_PatchUtils_StoreDefaultCharaName::
	dw PatchUtils_StoreDefaultCharaName

Banked_PatchUtils_InitializeRelocatedCharaName::
	dw PatchUtils_InitializeRelocatedCharaName

;components/saveclock/rtc.asm - $4180
Banked_SaveClock_ADVICE_ValidateRTCFunction::
	dw SaveClock_ADVICE_ValidateRTCFunction

;components/titlemenu/rtc.asm - $4240
Banked_TitleMenu_ADVICE_LoadRTCValues::
	dw TitleMenu_ADVICE_LoadRTCValues

;components/pausemenu/sms_utils.asm - $4280
Banked_PauseMenu_ADVICE_DrawSMSFromMessages::
	dw PauseMenu_ADVICE_DrawSMSFromMessages

;components/titlemenu/advice.asm - $4340
Banked_TitleMenu_ADVICE_StateLoadGraphics::
	dw TitleMenu_ADVICE_StateLoadGraphics

Banked_TitleMenu_ADVICE_LoadSGBFiles::
	dw TitleMenu_ADVICE_LoadSGBFiles

Banked_TitleMenu_ADVICE_LoadSGBFilesSoundTest::
	dw TitleMenu_ADVICE_LoadSGBFilesSoundTest

Banked_TitleMenu_ADVICE_UnloadSGBFilesSoundTest::
	dw TitleMenu_ADVICE_UnloadSGBFilesSoundTest

Banked_TitleMenu_ADVICE_UnloadSGBFilesOverworld::
	dw TitleMenu_ADVICE_UnloadSGBFilesOverworld

;versions/(power|speed)/components/titlescreen/advice.asm
Banked_TitleScreen_ADVICE_CorruptSaveLoadSGBFiles::
	dw TitleScreen_ADVICE_CorruptSaveLoadSGBFiles

;components/zukan/advice.asm
Banked_Zukan_ADVICE_InitializeNameMetaSprite::
	dw Zukan_ADVICE_InitializeNameMetaSprite
   
Banked_Zukan_ADVICE_DrawRightAlignedHabitatName::
	dw Zukan_ADVICE_DrawRightAlignedHabitatName
   
Banked_Zukan_ADVICE_SetupSGBScreen::
	dw Zukan_ADVICE_SetupSGBScreen

Banked_Zukan_ADVICE_RefreshSGBScreen::
	dw Zukan_ADVICE_RefreshSGBScreen

Banked_Zukan_ADVICE_TeardownSGBScreenAndMetasprites::
	dw Zukan_ADVICE_TeardownSGBScreenAndMetasprites

Banked_Zukan_ADVICE_StateInnerviewInputButtonPress::
	dw Zukan_ADVICE_StateInnerviewInputButtonPress

Banked_Zukan_ADVICE_StateInnerviewInputSwitchSpecies::
	dw Zukan_ADVICE_StateInnerviewInputSwitchSpecies
   
;components/mainscript/statustext.asm
Banked_MainScript_ADVICE_CondenseTableStringShort::
	dw MainScript_ADVICE_CondenseTableStringShort
   
Banked_MainScript_ADVICE_CondenseTableStringLong::
	dw MainScript_ADVICE_CondenseTableStringLong
   
Banked_MainScript_ADVICE_CondenseStagedTableStringLong::
	dw MainScript_ADVICE_CondenseStagedTableStringLong

;components/battle/advice.asm
Banked_Battle_ADVICE_ClearStatusEffectTilemaps::
	dw Battle_ADVICE_ClearStatusEffectTilemaps

Banked_Battle_ADVICE_ExitToOverworld::
	dw Battle_ADVICE_ExitToOverworld

;components/battle/status.asm (why is this in battle, it's a MainScript sym)
;MainScript_ADVICE_DrawStatusEffectGfx lives around here.
;It's HOME Bank advice so it doesn't get a trampoline; but we need to mark it on
;the list.
   
;components/pausemenu/drawfuncs.asm
Banked_PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname::
	dw PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname

;components/status/advice.asm
Banked_Status_ADVICE_StateInitTilemaps::
	dw Status_ADVICE_StateInitTilemaps

Banked_Status_ADVICE_StateDrawDenjuu::
	dw Status_ADVICE_StateDrawDenjuu

Banked_Status_ADVICE_StateSwitchDenjuu::
	dw Status_ADVICE_StateSwitchDenjuu

Banked_Status_ADVICE_DrawRightAlignedHabitatName::
	dw Status_ADVICE_DrawRightAlignedHabitatName

Banked_Status_ADVICE_StateExit::
	dw Status_ADVICE_StateExit

;components/battle/articles.asm
Banked_Battle_ADVICE_BattleNoArticle::
	dw Battle_ADVICE_BattleNoArticle

Banked_Battle_ADVICE_BattleArticle::
	dw Battle_ADVICE_BattleArticle

;components/pausemenu/sms_utils.asm
Banked_PauseMenu_ADVICE_SMSMapTiles::
	dw PauseMenu_ADVICE_SMSMapTiles
	
Banked_PauseMenu_ADVICE_SMSContentsCheckInput::
	dw PauseMenu_ADVICE_SMSContentsCheckInput

;components/battle/advice.asm
Banked_Attack_ADVICE_PreAttackSGB::
	dw Attack_ADVICE_PreAttackSGB

Banked_Attack_ADVICE_PostAttackSGB::
	dw Attack_ADVICE_PostAttackSGB
	
;components/battle/articles.asm
Banked_Battle_ADVICE_StatusInflictionArticle::
	dw Battle_ADVICE_StatusInflictionArticle
	
;components/fusionlabevo/advice.asm
Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx::
	dw FusionLabEvo_ADVICE_DrawShopNumberGfx

;components/sgb/convert_colours.asm
Banked_PatchUtils_CommitStagedCGBToSGBBuffer_CBE::
	dw PatchUtils_CommitStagedCGBToSGBBuffer_CBE

Banked_PatchUtils_CommitSGBBufferToSGB_CBE::
	dw PatchUtils_CommitSGBBufferToSGB_CBE

Banked_PatchUtils_CommitStagedCGBToSGB_CBE::
	dw PatchUtils_CommitStagedCGBToSGB_CBE

;components/battle/message.asm
Banked_MainScript_ADVICE_AutoNarrowPhrase::
	dw MainScript_ADVICE_AutoNarrowPhrase

;components/summon/advice.asm
Banked_Summon_ADVICE_ExitIntoSummonScreen::
	dw Summon_ADVICE_ExitIntoSummonScreen

;components/zukan/advice.asm
Banked_Zukan_ADVICE_ClearMessageForSGB::
	dw Zukan_ADVICE_ClearMessageForSGB

Banked_Zukan_ADVICE_DrawDenjuuName::
	dw Zukan_ADVICE_DrawDenjuuName

;components/status/advice.asm
Banked_Status_ADVICE_StateInitGraphics::
	dw Status_ADVICE_StateInitGraphics

;components/pausemenu/advice.asm
Banked_PauseMenu_ADVICE_LoadSGBFiles::
	dw PauseMenu_ADVICE_LoadSGBFiles

;components/titlemenu/advice.asm
Banked_TitleMenu_ADVICE_LoadSGBFilesTimeInput::
	dw TitleMenu_ADVICE_LoadSGBFilesTimeInput

;components/pausemenu/advice.asm
Banked_PauseMenu_ADVICE_LoadSGBFilesMelody::
	dw PauseMenu_ADVICE_LoadSGBFilesMelody

Banked_PauseMenu_ADVICE_LoadSGBFilesInventory::
	dw PauseMenu_ADVICE_LoadSGBFilesInventory

Banked_PauseMenu_ADVICE_LoadSGBPalettesInventory::
	dw PauseMenu_ADVICE_LoadSGBPalettesInventory

;components/contactmenu/advice.asm
Banked_ContactMenu_ADVICE_LoadSGBFilesOverview::
	dw ContactMenu_ADVICE_LoadSGBFilesOverview

;components/zukan/advice.asm
Banked_Zukan_ADVICE_LoadSGBFilesOverview::
	dw Zukan_ADVICE_LoadSGBFilesOverview

Banked_Zukan_ADVICE_LoadSGBPalettesOverview::
	dw Zukan_ADVICE_LoadSGBPalettesOverview

Banked_Zukan_ADVICE_ReloadSGBPalettesOverview::
	dw Zukan_ADVICE_ReloadSGBPalettesOverview

;components/pausemenu/advice.asm
Banked_PauseMenu_ADVICE_LoadSGBFilesNumMessages::
	dw PauseMenu_ADVICE_LoadSGBFilesNumMessages

Banked_PauseMenu_ADVICE_LoadSGBFilesListMessages::
	dw PauseMenu_ADVICE_LoadSGBFilesListMessages

;components/callsmenu/advice.asm
Banked_PauseMenu_ADVICE_LoadSGBFilesInboundCall::
	dw PauseMenu_ADVICE_LoadSGBFilesInboundCall

Banked_LateDenjuu_ADVICE_LoadSGBFiles::
	dw LateDenjuu_ADVICE_LoadSGBFiles

Banked_PauseMenu_ADVICE_LoadSGBFilesOutboundCall::
	dw PauseMenu_ADVICE_LoadSGBFilesOutboundCall

;components/contactmenu/advice.asm
Banked_ContactMenu_ADVICE_LoadSGBFilesActionScreen::
	dw ContactMenu_ADVICE_LoadSGBFilesActionScreen

Banked_ContactMenu_ADVICE_LoadSGBFilesRingtone::
	dw ContactMenu_ADVICE_LoadSGBFilesRingtone

Banked_ContactMenu_ADVICE_LoadSGBFilesOverview_RingtoneExit::
	dw ContactMenu_ADVICE_LoadSGBFilesOverview_RingtoneExit

;components/pausemenu/advice.asm
Banked_PauseMenu_ADVICE_LoadSGBFilesPhoneIME::
	dw PauseMenu_ADVICE_LoadSGBFilesPhoneIME

Banked_PauseMenu_ADVICE_LoadSGBFilesMelodyEdit::
	dw PauseMenu_ADVICE_LoadSGBFilesMelodyEdit

Banked_PauseMenu_ADVICE_LoadSGBFilesMelodyEditExit::
	dw PauseMenu_ADVICE_LoadSGBFilesMelodyEditExit

;components/map/advice.asm
Banked_Map_ADVICE_DrawScreen::
	dw Map_ADVICE_DrawScreen

Banked_Map_ADVICE_LoadSGBFiles::
	dw Map_ADVICE_LoadSGBFiles

Banked_Map_ADVICE_UnloadSGBFiles::
	dw Map_ADVICE_UnloadSGBFiles

Banked_Map_ADVICE_WindowLoadSGBFiles::
	dw Map_ADVICE_WindowLoadSGBFiles

Banked_Map_ADVICE_WindowUnloadSGBFiles::
	dw Map_ADVICE_WindowUnloadSGBFiles

;components/encounter/advice.asm
Banked_Encounter_ADVICE_LoadSGBFiles::
	dw Encounter_ADVICE_LoadSGBFiles

Banked_Encounter_ADVICE_MapTFangerDenjuu::
	dw Encounter_ADVICE_MapTFangerDenjuu

;components/summon/advice.asm
Banked_Summon_ADVICE_LoadSGBFiles::
	dw Summon_ADVICE_LoadSGBFiles

;components/titlemenu/advice.asm
Banked_TitleMenu_ADVICE_InitNickname::
	dw TitleMenu_ADVICE_InitNickname

Banked_TitleMenu_ADVICE_SaveDenjuuNicknameFromBuffer::
	dw TitleMenu_ADVICE_SaveDenjuuNicknameFromBuffer

;components/victory/advice.asm
Banked_Victory_ADVICE_LoadSGBFilesRecruitment::
	dw Victory_ADVICE_LoadSGBFilesRecruitment

Banked_Victory_ADVICE_EvolutionLoadSGBFiles::
	dw Victory_ADVICE_EvolutionLoadSGBFiles

;components/battle/advice.asm
Banked_Battle_ADVICE_LoadDenjuuResources::
	dw Battle_ADVICE_LoadDenjuuResources

Banked_Battle_ADVICE_LoadSGBFiles::
	dw Battle_ADVICE_LoadSGBFiles

Banked_Battle_ADVICE_AttackWindowCorrectForSGBOnOpen::
	dw Battle_ADVICE_AttackWindowCorrectForSGBOnOpen

Banked_Battle_ADVICE_AttackWindowCorrectForSGBOnClose::
	dw Battle_ADVICE_AttackWindowCorrectForSGBOnClose

Banked_Battle_ADVICE_VictoryDrawWindowTiles::
	dw Battle_ADVICE_VictoryDrawWindowTiles

Banked_Battle_ADVICE_ArrivedMessageFix::
	dw Battle_ADVICE_ArrivedMessageFix

Banked_Battle_ADVICE_VictoryStatsLoadSGBFiles::
	dw Battle_ADVICE_VictoryStatsLoadSGBFiles

Banked_Battle_ADVICE_LoadSGBFilesAfterLateDenjuu::
	dw Battle_ADVICE_LoadSGBFilesAfterLateDenjuu

Banked_Battle_ADVICE_SGBPaletteOnPartnerFell::
	dw Battle_ADVICE_SGBPaletteOnPartnerFell

Banked_Battle_ADVICE_SGBPaletteOnOpponentFell::
	dw Battle_ADVICE_SGBPaletteOnOpponentFell

;components/map/advice.asm
Banked_DungeonMap_ADVICE_DrawScreen::
	dw DungeonMap_ADVICE_DrawScreen

Banked_DungeonMap_ADVICE_LoadSGBFiles::
	dw DungeonMap_ADVICE_LoadSGBFiles

;components/pausemenu/advice.asm
Banked_PauseMenu_ADVICE_LoadSGBFilesOptions::
	dw PauseMenu_ADVICE_LoadSGBFilesOptions

;components/gameover/advice.asm
Banked_GameOver_ADVICE_LoadSGBFiles::
	dw GameOver_ADVICE_LoadSGBFiles

;components/zukan/advice.asm
Banked_Certificate_ADVICE_LoadSGBFiles::
	dw Certificate_ADVICE_LoadSGBFiles

;components/mainscript/window.asm
Banked_MainScript_ADVICE_SGBRedrawOverworldLocationWindow::
	dw MainScript_ADVICE_SGBRedrawOverworldLocationWindow

Banked_MainScript_ADVICE_SGBRedrawOverworldWindow::
	dw MainScript_ADVICE_SGBRedrawOverworldWindow

Banked_MainScript_ADVICE_SGBRedrawHud::
	dw MainScript_ADVICE_SGBRedrawHud

;components/fusionlabevo/advice.asm
Banked_FusionLabEvo_ADVICE_LoadSGBFilesNoEvolution::
	dw FusionLabEvo_ADVICE_LoadSGBFilesNoEvolution

Banked_FusionLabEvo_ADVICE_LoadSGBFilesFusionAnimation::
	dw FusionLabEvo_ADVICE_LoadSGBFilesFusionAnimation

Banked_FusionLabEvo_ADVICE_LoadSGBFilesEvolution::
	dw FusionLabEvo_ADVICE_LoadSGBFilesEvolution

Banked_FusionLabEvo_ADVICE_LoadSGBFilesItemSelection::
	dw FusionLabEvo_ADVICE_LoadSGBFilesItemSelection

Banked_FusionLabEvo_ADVICE_SwitchSGBPaletteLayout::
	dw FusionLabEvo_ADVICE_SwitchSGBPaletteLayout

;components/overworld/advice.asm
Banked_Overworld_ADVICE_LoadSGBFiles::
	dw Overworld_ADVICE_LoadSGBFiles

Banked_Overworld_ADVICE_LoadSGBPaletteByAcre::
	dw Overworld_ADVICE_LoadSGBPaletteByAcre

;components/zukan/advice.asm
Banked_Zukan_ADVICE_DrawSpeciesPageText::
	dw Zukan_ADVICE_DrawSpeciesPageText

Banked_Map_ADVICE_SGBRedrawMapLocationWindow::
	dw Map_ADVICE_SGBRedrawMapLocationWindow

;components/pausemenu/advice.php
Banked_PauseMenu_ADVICE_ReloadSGBFiles::
	dw PauseMenu_ADVICE_ReloadSGBFiles

Banked_PauseMenu_ADVICE_ReloadSGBFilesNumMessages::
	dw PauseMenu_ADVICE_ReloadSGBFilesNumMessages

;components/victory/advice.asm
Banked_Victory_ADVICE_ClearMessageTextForPhoneNumber::
	dw Victory_ADVICE_ClearMessageTextForPhoneNumber

;components/mainscript/window.asm
Banked_MainScript_ADVICE_LoadWindowBorderTilesetSGBAdjusted::
	dw MainScript_ADVICE_LoadWindowBorderTilesetSGBAdjusted

;components/serio/advice.asm
Banked_VsSummon_ADVICE_LoadSGBFiles::
	dw VsSummon_ADVICE_LoadSGBFiles

;components/system/debug.asm
Banked_Debug_ADVICE_DrawDigitsForMapSelector::
	dw Debug_ADVICE_DrawDigitsForMapSelector

;The next one is at the END of Bank 1 and likely not conflicting
;with your section.

Banked_Battle_ADVICE_ParsePluralState::
	dw Battle_ADVICE_ParsePluralState

SECTION "Patch Utilities - Auxiliary Code", ROMX[$4140], BANK[$1]
PatchUtils_StoreDefaultCharaName:
	M_AdviceSetup
	
	ld a, 'S'
	ld [$C3A9], a
	ld a, 'h'
	ld [$C3AA], a
	ld a, 'i'
	ld [$C3AB], a
	ld a, 'g'
	ld [$C3AC], a
	ld a, 'e'
	ld [$C3AD], a
	ld a, 'k'
	ld [$C3AE], a
	ld a, 'i'
	ld [$C3AF], a
	
	M_AdviceTeardown
	ret

PatchUtils_InitializeRelocatedCharaName:
	M_AdviceSetup
	
	ld hl, W_TitleMenu_NameBuffer
	ld de, W_MainScript_CenteredNameBuffer
	ld b, $11
	
	ld a, $E0

.eraseLoop
	ld [de], a
	inc de
	dec b
	jr nz, .eraseLoop
	
	ld b, $A
	ld a, $20

.secondEraseLoop
	ld [hli], a
	dec b
	jr nz, .secondEraseLoop
	
	ld a, $E0
	ld [hli], a
	
	M_AdviceTeardown
	ret

PatchUtils_InitializeRelocatedCharaName_END::
