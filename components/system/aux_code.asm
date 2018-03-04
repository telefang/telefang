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
   
Banked_TitleMenu_ADVICE_LoadSGBFiles::
	jp TitleMenu_ADVICE_LoadSGBFiles
	nop

Banked_TitleMenu_ADVICE_UnloadSGBFilesOverworld::
	jp TitleMenu_ADVICE_UnloadSGBFilesOverworld
	nop

Banked_TitleMenu_ADVICE_UnloadSGBFilesLink::
	jp TitleMenu_ADVICE_UnloadSGBFilesLink
	nop
   
Banked_Zukan_ADVICE_DrawSpeciesPageText::
	jp Zukan_ADVICE_DrawSpeciesPageText
	nop
   
Banked_Zukan_ADVICE_StateInnerviewInputButtonPress::
	jp Zukan_ADVICE_StateInnerviewInputButtonPress
	nop
   
Banked_Zukan_ADVICE_StateInnerviewInputSwitchSpecies::
	jp Zukan_ADVICE_StateInnerviewInputSwitchSpecies
	nop
   
Banked_TitleMenu_ADVICE_StateLoadGraphics::
	jp TitleMenu_ADVICE_StateLoadGraphics
	nop
   
Banked_MainScript_ADVICE_DrawNarrowLetter::
	jp MainScript_ADVICE_DrawNarrowLetter
   nop
   
Banked_Zukan_ADVICE_DrawRightAlignedHabitatName::
	jp Zukan_ADVICE_DrawRightAlignedHabitatName
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