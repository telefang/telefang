INCLUDE "telefang.inc"

SECTION "Cutscene Variables", WRAM0[$C1F4]
W_Cutscene_QuakeCycler:: ds 1
W_Cutscene_QuakeIntensifier:: ds 1
W_Cutscene_SubSubState:: ds 1

SECTION "Cutscene Variables 2", WRAM0[$C20A]
W_Cutscene_WaitTimer:: ds 1

SECTION "Cutscene Variables 3", WRAM0[$CA66]
W_Cutscene_CutsceneImageIndexBuffer:: ds 1

SECTION "Cutscene Variables 4", WRAM0[$CA6C]
W_Cutscene_ScrollAccelerator:: ds 1

SECTION "Cutscene States", ROMX[$5814], BANK[$29]
Cutscene_StateFadeOutFromOverworld::
	ld a, $2A
	ld hl, $4000
	call CallBankedFunction_int
	ld a, 0
	ld [W_Cutscene_SubSubState], a
	ret

; Draw screen substate.

Cutscene_StateDrawScreen::
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	add 3
	cp $14
	jr c, .parameterIsValid
	cp $32
	jr nc, .parameterIsValid
	sub $14
	jp .ohShitAbort

.parameterIsValid
	ld a, BANK(Cutscene_StateDrawScreen)
	ld [W_PreviousBank], a
	xor a
	ld [W_Cutscene_WaitTimer], a
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	cp 7
	jr nz, .notWeAreConnected
	call .weAreConnected
	jr .skipDraw

.notWeAreConnected
	ld c, $30
	add c
	ld c, a
	ld b, 0
	call Banked_CGBLoadBackgroundPalette
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	ld c, $50
	add c
	ld c, a
	ld b, 0
	call Banked_LoadMaliasGraphics
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	ld e, $C0
	add e
	ld e, a
	ld bc, 0
	xor a
	call Banked_RLEDecompressTMAP0
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	ld e, $C0
	add e
	ld e, a
	ld bc, 0
	xor a
	call Banked_RLEDecompressAttribsTMAP0
	call Cutscene_ADVICE_LoadSGBFiles

.skipDraw
	ld a, 0
	ld [W_MainScript_State], a
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	cp 0
	jr z, .antennaTreeCutscene
	cp 1
	jr z, .oneOfMySoldiers
	cp 2
	jr z, .unusedCutscene
	jr .unusedCutscene

.antennaTreeCutscene
	ld a, $40
	ld [W_ShadowREG_SCY], a
	ld a, 0
	ld [W_PauseMenu_CurrentItemGraphicBank], a
	ld a, 0
	ld [W_Cutscene_ScrollAccelerator], a
	ld a, $10
	ld [W_MainScript_WindowType], a
	jp System_ScheduleNextSubState

.oneOfMySoldiers
	ld a, 0
	ld [W_PauseMenu_CurrentItemGraphicBank], a
	ld a, $14
	ld [W_Cutscene_ScrollAccelerator], a
	ld a, $1E
	ld [W_MainScript_WindowType], a
	jp System_ScheduleNextSubState

.unusedCutscene
	ld a, 0
	ld [W_PauseMenu_CurrentItemGraphicBank], a
	jp System_ScheduleNextSubState

.weAreConnected
	ld bc, 0
	ld e, $3F
	ld a, 0
	call Banked_RLEDecompressTMAP0
	call WeAreConnected_ADVICE_LoadSGBFiles
	ld bc, 8
	call Banked_LoadMaliasGraphics
	ld bc, 0
	ld e, $3F
	ld a, 0
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $F
	call Banked_CGBLoadBackgroundPalette
	ld hl, $9A40
	ld a, 1
	ld bc, $80
	call $3775
	ld hl, $9B80
	ld a, 1
	ld bc, $80
	call $3775
	ld d, 4
	ld bc, $14
	ld hl, $9A40
	ld a, 1
	call LCDC_InitAttributesSquare
	ld d, 4
	ld bc, $14
	ld hl, $9B80
	ld a, 1
	call LCDC_InitAttributesSquare
	ret

.ohShitAbort
	ld b, a
	ld a, [W_Cutscene_SubSubState]
	cp 2
	jr c, .jpA
	call $5E27
	ld a, 0
	ld [W_byte_C9CF], a
	ld a, $A
	ld [W_SystemSubState], a
	ret

.jpA
	inc a
	ld [W_Cutscene_SubSubState], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ret

	nop
	nop
	nop

Cutscene_StateFadeInPrepare::
	ld bc, 0
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 0
	ld [W_Cutscene_SubSubState], a
	jp System_ScheduleNextSubState

Cutscene_StateFadeInAndAnimate::
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	cp 7
	jp z, .weAreConnectedTrampoline
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, [W_MainScript_WindowType]
	or a
	jr z, .theWaitIsOver
	dec a
	ld [W_MainScript_WindowType], a
	ret

.theWaitIsOver
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	cp 0
	jr z, .antennaTreeCutscene
	cp 1
	jr z, .oneOfMySoldiers
	cp 2
	jp z, .unusedCutscene

.antennaTreeCutscene
	ld a, [W_ShadowREG_SCY]
	cp $20
	jr c, .easeOut

.easeIn
	ld a, [W_Cutscene_ScrollAccelerator]
	add 1
	ld [W_Cutscene_ScrollAccelerator], a
	jr .checkIfCanScrollThisFrame

.easeOut
	ld a, [W_Cutscene_ScrollAccelerator]
	sub 1
	ld [W_Cutscene_ScrollAccelerator], a

.checkIfCanScrollThisFrame

	ld b, a
	ld a, [W_PauseMenu_CurrentItemGraphicBank]
	add b
	ld [W_PauseMenu_CurrentItemGraphicBank], a
	jr nc, .noScroll
	ld a, [W_ShadowREG_SCY]
	or a
	jr z, .noScroll
	dec a
	ld [W_ShadowREG_SCY], a

.noScroll
	ld a, [W_ShadowREG_SCY]
	or a
	ret nz
	jp .waitForInput

.oneOfMySoldiers
	ld a, [W_Cutscene_ScrollAccelerator]
	or a
	jr z, .cantDecreaseAnyFurther
	dec a

.cantDecreaseAnyFurther
	ld [W_Cutscene_ScrollAccelerator], a
	ld b, a
	ld a, [W_PauseMenu_CurrentItemGraphicBank]
	add b
	ld [W_PauseMenu_CurrentItemGraphicBank], a
	srl a
	ld [W_ShadowREG_SCX], a
	ld a, [W_Cutscene_ScrollAccelerator]
	or a
	jr nz, .stillScrolling

	ld b, 0
	ld c, $A1
	ld hl, W_MainScript_TilePtr
	ld a, $C
	ld [hli], a
	ld a, $98
	ld [hl], a
	ld a, [W_MainScript_State]
	or a
	jr nz, .textPlz
	ld a, 2
	ld [W_MainScript_TextStyle], a
	ld a, $D0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $F0
	ld [W_Status_NumericalTileIndex], a
	call Status_ExpandNumericalTiles
	ld d, $D
	ld a, $0B
	ld hl, $4760
	call CallBankedFunction_int

.textPlz
	call $2CC4

.stillScrolling
	ld a, [W_MainScript_State]
	cp 9
	jr nz, .waitForNextFrame
	ld a, 0
	ld [W_MainScript_TextStyle], a
	jr .waitForInput

.weAreConnectedTrampoline
	jp WeAreConnected_StateMachine

.unusedCutscene
	ld a, [W_MainScript_State]
	or a
	jr nz, .textPlz
	ld b, 0
	ld c, $A1
	ld a, 2
	ld [W_MainScript_TextStyle], a
	ld a, $D0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $F0
	ld [W_Status_NumericalTileIndex], a
	call Status_ExpandNumericalTiles
	ld d, $D
	ld a, $0B
	ld hl, $4766
	call CallBankedFunction_int
	ret

.waitForInput
	ld a, [W_Cutscene_WaitTimer]
	inc a
	ld [W_Cutscene_WaitTimer], a
	cp $78
	jr nc, .nextState
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A + M_JPInput_B
	jr z, .waitForNextFrame

.nextState
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	jp System_ScheduleNextSubState

.waitForNextFrame
	ret

SECTION "Cutscene States 2", ROMX[$5D17], BANK[$29]
Cutscene_StateFadeOutAndExitToOverworld::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	M_AuxJmp Banked_Map_ADVICE_UnloadSGBFiles
	ld a, $A
	ld [W_SystemSubState], a
	ret
