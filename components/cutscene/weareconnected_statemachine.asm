INCLUDE "telefang.inc"

SECTION "Cutscene We Are Connected State Machine", ROMX[$5A4B], BANK[$29]
WeAreConnected_StateMachine::
	ld a, [W_Cutscene_SubSubState]
	cp 0
	jr z, WeAreConnected_StateFadeIn
	cp 1
	jr z, WeAreConnected_StatePrintMessageAndWait
	cp 2
	jr z, WeAreConnected_StateEarthquake
	cp 3
	jp z, WeAreConnected_StateWaaaaahh
	cp 4
	jp z, WeAreConnected_WaitAndExit

WeAreConnected_StateFadeIn::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, 1
	ld [$C95B], a
	ld b, 0
	ld c, $A0
	call WeAreConnected_PrepareForTextRendering
	ld a, [W_Cutscene_SubSubState]
	inc a
	ld [W_Cutscene_SubSubState], a
	ret

WeAreConnected_StatePrintMessageAndWait::
	call $2CC4
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, [W_Cutscene_WaitTimer]
	inc a
	ld [W_Cutscene_WaitTimer], a
	cp $3C
	jr nc, .continue
	ret

.continue
	ld a, 0
	ld [W_Cutscene_WaitTimer], a
	ld a, [W_Cutscene_SubSubState]
	inc a
	ld [W_Cutscene_SubSubState], a
	ld a, 4
	call WeAreConnected_ADVICE_LoadSGBFiles_BeforeFadeToBlack
	ld a, $71
	ld [W_Sound_NextSFXSelect], a
	ret

WeAreConnected_StateEarthquake::
	ld a, [W_Cutscene_WaitTimer]
	inc a
	ld [W_Cutscene_WaitTimer], a
	push af
	cp $78
	jr c, .letsQuake
	ld a, 3
	call Banked_LCDC_PaletteFade
	or a
	jr nz, .fadeComplete

.letsQuake
	pop af
	and 1
	jr z, .waitOneFrame
	ld a, [W_Cutscene_WaitTimer]
	and 1
	jr z, .doNotIntensify
	ld a, [W_Cutscene_QuakeIntensifier]
	inc a
	ld [W_Cutscene_QuakeIntensifier], a

.doNotIntensify
	ld a, [W_Cutscene_QuakeIntensifier]
	ld b, a
	ld a, [W_Cutscene_QuakeCycler]
	add b
	ld [W_Cutscene_QuakeCycler], a
	ld d, a
	call $3058
	sra d
	sra d
	sra d
	sra d
	ld a, d
	ld [W_ShadowREG_SCY], a

.waitOneFrame
	ret

.fadeComplete
	add sp, 2
	xor a
	ld [W_ShadowREG_SCY], a
	ld a, [W_Cutscene_SubSubState]
	inc a
	ld [W_Cutscene_SubSubState], a
	ld hl, $9800
	ld a, 1
	ld bc, $240
	call $3775
	ld d, $12
	ld bc, $14
	ld hl, $9800
	ld a, 1
	call LCDC_InitAttributesSquare
	ld bc, $98
	call WeAreConnected_PrepareForTextRendering
	ld a, BANK(WeAreConnected_StateEarthquake)
	ld [W_PreviousBank], a
	ld bc, $F
	call Banked_CGBLoadBackgroundPalette
	ld bc, $14
	ld a, 4
	call CGBLoadObjectPaletteBanked
	ld bc, $2E5
	ld a, 5
	call CGBLoadObjectPaletteBanked
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	call WeAreConnected_ADVICE_LoadSGBFiles_Waaaaahh
	jp $5BB5

WeAreConnected_StateWaaaaahh::
	call $5C2B
	call $5CA7
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, BANK(WeAreConnected_StateWaaaaahh)
	ld [W_PreviousBank], a
	ld a, 2
	call Banked_LCDC_PaletteFade
	or a
	ret z
	call $2CC4
	ld a, [W_MainScript_State]
	cp 9
	ret nz
	ld a, [$C0B5]
	cp 4
	ret nc
	ld a, 0
	ld [W_Cutscene_WaitTimer], a
	ld a, [W_Cutscene_SubSubState]
	inc a
	ld [W_Cutscene_SubSubState], a
	ld a, 0
	ld [W_MetaSpriteConfig1], a
	ret

WeAreConnected_WaitAndExit::
	ld a, [W_Cutscene_WaitTimer]
	inc a
	ld [W_Cutscene_WaitTimer], a
	cp $1E
	ret c
	ld a, 4
	call WeAreConnected_ADVICE_PrepareForFade
	jp System_ScheduleNextSubState
	ret

WeAreConnected_PrepareForTextRendering::
	ld hl, W_MainScript_TilePtr
	ld a, 0
	ld [hli], a
	ld a, $98
	ld [hl], a
	ld a, 2
	ld [W_MainScript_TextStyle], a
	ld a, $D0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $F0
	ld [W_Status_NumericalTileIndex], a
	call Status_ExpandNumericalTiles
	ld a, BANK(WeAreConnected_PrepareForTextRendering)
	ld [W_PreviousBank], a
	ld d, $D
	ld a, $0B
	ld hl, $4760
	call CallBankedFunction_int
	ret
