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
	jp PatchUtils_StoreDefaultCharaName

Banked_PatchUtils_InitializeRelocatedCharaName::
	jp PatchUtils_InitializeRelocatedCharaName

;components/saveclock/rtc.asm - $4180
Banked_SaveClock_ADVICE_ValidateRTCFunction::
	jp SaveClock_ADVICE_ValidateRTCFunction

;components/titlemenu/rtc.asm - $4240
Banked_TitleMenu_ADVICE_LoadRTCValues::
	jp TitleMenu_ADVICE_LoadRTCValues

;components/pausemenu/sms_utils.asm - $4280
Banked_PauseMenu_ADVICE_DrawSMSFromMessages::
	jp PauseMenu_ADVICE_DrawSMSFromMessages

;components/titlemenu/advice.asm - $4340
Banked_TitleMenu_ADVICE_StateLoadGraphics::
	jp TitleMenu_ADVICE_StateLoadGraphics

Banked_TitleMenu_ADVICE_LoadSGBFiles::
	jp TitleMenu_ADVICE_LoadSGBFiles

Banked_TitleMenu_ADVICE_LoadSGBFilesSoundTest::
	jp TitleMenu_ADVICE_LoadSGBFilesSoundTest

Banked_TitleMenu_ADVICE_UnloadSGBFilesSoundTest::
	jp TitleMenu_ADVICE_UnloadSGBFilesSoundTest

Banked_TitleMenu_ADVICE_UnloadSGBFilesOverworld::
	jp TitleMenu_ADVICE_UnloadSGBFilesOverworld

Banked_TitleMenu_ADVICE_UnloadSGBFilesLink::
	jp TitleMenu_ADVICE_UnloadSGBFilesLink

;components/zukan/draw_utils.asm
Banked_Zukan_ADVICE_DrawSpeciesPageText::
	jp Zukan_ADVICE_DrawSpeciesPageText

;components/zukan/state_machine.asm
Banked_Zukan_ADVICE_InitializeNameMetaSprite::
	jp Zukan_ADVICE_InitializeNameMetaSprite
   
Banked_Zukan_ADVICE_DrawRightAlignedHabitatName::
	jp Zukan_ADVICE_DrawRightAlignedHabitatName
   
Banked_Zukan_ADVICE_SetupSGBScreen::
	jp Zukan_ADVICE_SetupSGBScreen

Banked_Zukan_ADVICE_RefreshSGBScreen::
	jp Zukan_ADVICE_RefreshSGBScreen

Banked_Zukan_ADVICE_TeardownSGBScreenAndMetasprites::
	jp Zukan_ADVICE_TeardownSGBScreenAndMetasprites

Banked_Zukan_ADVICE_StateInnerviewInputButtonPress::
	jp Zukan_ADVICE_StateInnerviewInputButtonPress

Banked_Zukan_ADVICE_StateInnerviewInputSwitchSpecies::
	jp Zukan_ADVICE_StateInnerviewInputSwitchSpecies
   
;components/mainscript/statustext.asm
Banked_MainScript_ADVICE_CondenseTableStringShort::
	jp MainScript_ADVICE_CondenseTableStringShort
   
Banked_MainScript_ADVICE_CondenseTableStringLong::
	jp MainScript_ADVICE_CondenseTableStringLong
   
Banked_MainScript_ADVICE_CondenseStagedTableStringLong::
	jp MainScript_ADVICE_CondenseStagedTableStringLong

;components/battle/advice.asm
Banked_Battle_ADVICE_ClearStatusEffectTilemaps::
	jp Battle_ADVICE_ClearStatusEffectTilemaps

;components/battle/status.asm (why is this in battle, it's a MainScript sym)
;MainScript_ADVICE_DrawStatusEffectGfx lives around here.
;It's HOME Bank advice so it doesn't get a trampoline; but we need to mark it on
;the list.
   
;components/pausemenu/drawfuncs.asm
Banked_PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname::
	jp PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname

;components/status/advice.asm
Banked_Status_ADVICE_StateInitTilemaps::
	jp Status_ADVICE_StateInitTilemaps

Banked_Status_ADVICE_StateDrawDenjuu::
	jp Status_ADVICE_StateDrawDenjuu

Banked_Status_ADVICE_StateSwitchDenjuu::
	jp Status_ADVICE_StateSwitchDenjuu

Banked_Status_ADVICE_DrawRightAlignedHabitatName::
	jp Status_ADVICE_DrawRightAlignedHabitatName

Banked_Status_ADVICE_StateExit::
	jp Status_ADVICE_StateExit

;components/battle/articles.asm
Banked_Battle_ADVICE_BattleNoArticle::
	jp Battle_ADVICE_BattleNoArticle

Banked_Battle_ADVICE_BattleArticle::
	jp Battle_ADVICE_BattleArticle

;components/pausemenu/sms_utils.asm
Banked_PauseMenu_ADVICE_SMSMapTiles::
	jp PauseMenu_ADVICE_SMSMapTiles
	
Banked_PauseMenu_ADVICE_SMSContentsCheckInput::
	jp PauseMenu_ADVICE_SMSContentsCheckInput
	
Banked_Battle_ADVICE_StatusInflictionArticle::
	jp Battle_ADVICE_StatusInflictionArticle
	
Banked_FusionLabEvo_ADVICE_DrawShopNumberGfx::
	jp FusionLabEvo_ADVICE_DrawShopNumberGfx

Banked_PatchUtils_CommitStagedCGBToSGB_CBE::
	jp PatchUtils_CommitStagedCGBToSGB_CBE
	
Banked_MainScript_ADVICE_AutoNarrowPhrase::
	jp MainScript_ADVICE_AutoNarrowPhrase

;components/summon/advice.asm
Banked_Summon_ADVICE_ExitIntoSummonScreen::
	jp Summon_ADVICE_ExitIntoSummonScreen

;components/zukan/state_machine.asm
Banked_Zukan_ADVICE_ClearMessageForSGB::
	jp Zukan_ADVICE_ClearMessageForSGB

Banked_Zukan_ADVICE_DrawDenjuuName::
	jp Zukan_ADVICE_DrawDenjuuName

;components/status/advice.asm
Banked_Status_ADVICE_StateInitGraphics::
	jp Status_ADVICE_StateInitGraphics

;components/pausemenu/advice.asm
Banked_Banked_PauseMenu_ADVICE_LoadSGBFiles::
	jp Banked_PauseMenu_ADVICE_LoadSGBFiles

;components/titlemenu/advice.asm
Banked_TitleMenu_ADVICE_LoadSGBFilesTimeInput::
	jp TitleMenu_ADVICE_LoadSGBFilesTimeInput

;components/pausemenu/advice.asm
Banked_PauseMenu_ADVICE_LoadSGBFilesMelody::
	jp PauseMenu_ADVICE_LoadSGBFilesMelody

Banked_PauseMenu_ADVICE_LoadSGBFilesInventory::
	jp PauseMenu_ADVICE_LoadSGBFilesInventory

Banked_PauseMenu_ADVICE_LoadSGBPalettesInventory::
	jp PauseMenu_ADVICE_LoadSGBPalettesInventory

;The next two are at the END of Bank 1 and likely not conflicting
;with your section.
Banked_MainScript_ADVICE_DrawNarrowLetter::
	jp MainScript_ADVICE_DrawNarrowLetter

Banked_Battle_ADVICE_ParsePluralState::
	jp Battle_ADVICE_ParsePluralState

SECTION "Patch Utilities - Auxiliary Code", ROMX[$4100], BANK[$1]
PatchUtils_StoreDefaultCharaName:
	M_AdviceSetup
	
	ld a, "S"
	ld [$C3A9], a
	ld a, "h"
	ld [$C3AA], a
	ld a, "i"
	ld [$C3AB], a
	ld a, "g"
	ld [$C3AC], a
	ld a, "e"
	ld [$C3AD], a
	ld a, "k"
	ld [$C3AE], a
	ld a, "i"
	ld [$C3AF], a
	
	M_AdviceTeardown
	ret

PatchUtils_InitializeRelocatedCharaName:
	M_AdviceSetup
	
	ld hl, $C3A9
	ld de, $CC90
	ld b, $11
	
.eraseLoop
	ld a, $E0
	ld [de], a
	inc de
	dec b
	jr nz, .eraseLoop
	
	ld b, 9
.secondEraseLoop
	xor a
	ld [hli], a
	dec b
	jr nz, .secondEraseLoop
	
	M_AdviceTeardown
	ret

PatchUtils_InitializeRelocatedCharaName_END::
