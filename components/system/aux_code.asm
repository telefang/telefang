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
	nop

Banked_PatchUtils_InitializeRelocatedCharaName::
	jp PatchUtils_InitializeRelocatedCharaName
	nop

Banked_TitleMenu_ADVICE_LoadRTCValues::
	jp TitleMenu_ADVICE_LoadRTCValues
	nop

Banked_SaveClock_ADVICE_ValidateRTCFunction::
	jp SaveClock_ADVICE_ValidateRTCFunction
	nop

Banked_PauseMenu_ADVICE_DrawSMSFromMessages::
	jp PauseMenu_ADVICE_DrawSMSFromMessages
	nop

Banked_TitleMenu_ADVICE_StateLoadGraphics::
	jp TitleMenu_ADVICE_StateLoadGraphics
	nop

Banked_TitleMenu_ADVICE_LoadSGBFiles::
	jp TitleMenu_ADVICE_LoadSGBFiles
	nop

Banked_TitleMenu_ADVICE_UnloadSGBFilesOverworld::
	jp TitleMenu_ADVICE_UnloadSGBFilesOverworld
	nop

Banked_TitleMenu_ADVICE_UnloadSGBFilesLink::
	jp TitleMenu_ADVICE_UnloadSGBFilesLink
	nop

;components/zukan/draw_utils.asm
Banked_Zukan_ADVICE_DrawSpeciesPageText::
	jp Zukan_ADVICE_DrawSpeciesPageText
	nop

;components/zukan/state_machine.asm
Banked_Zukan_ADVICE_InitializeNameMetaSprite::
	jp Zukan_ADVICE_InitializeNameMetaSprite
	nop

Banked_Zukan_ADVICE_StateInnerviewInputButtonPress::
	jp Zukan_ADVICE_StateInnerviewInputButtonPress
	nop

Banked_Zukan_ADVICE_StateInnerviewInputSwitchSpecies::
	jp Zukan_ADVICE_StateInnerviewInputSwitchSpecies
	nop
   
Banked_MainScript_ADVICE_DrawNarrowLetter::
	jp MainScript_ADVICE_DrawNarrowLetter
	nop
   
Banked_Zukan_ADVICE_DrawRightAlignedHabitatName::
	jp Zukan_ADVICE_DrawRightAlignedHabitatName
	nop
   
;components/mainscript/statustext.asm
Banked_MainScript_ADVICE_CondenseTableStringShort::
	jp MainScript_ADVICE_CondenseTableStringShort
	nop
   
Banked_MainScript_ADVICE_CondenseTableStringLong::
	jp MainScript_ADVICE_CondenseTableStringLong
	nop
   
Banked_MainScript_ADVICE_CondenseStagedTableStringLong::
	jp MainScript_ADVICE_CondenseStagedTableStringLong
	nop
   
;components/pausemenu/drawfuncs.asm
Banked_PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname::
	jp PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname
	nop

;components/battle/status.asm (why is this in battle, it's a MainScript sym)
;MainScript_ADVICE_DrawStatusEffectGfx lives around here.
;It's HOME Bank advice so it doesn't get a trampoline; but we need to mark it on
;the list.

;Sections beyond this point are at the END of Bank 1 and likely not conflicting
;with your section.
Banked_Battle_ADVICE_ParsePluralState::
	jp Battle_ADVICE_ParsePluralState
	nop

SECTION "Patch Utilities - Auxiliary Code", ROMX[$4100], BANK[$1]
PatchUtils_StoreDefaultCharaName:
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
	ret

PatchUtils_InitializeRelocatedCharaName:
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
	ret

PatchUtils_InitializeRelocatedCharaName_END::
