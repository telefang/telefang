INCLUDE "telefang.inc"

;These states are part of the Overworld state (05).

SECTION "Map Cursor X Position Buffer", WRAM0[$C0A8]
W_Map_CursorXPosBuffer:: ds 1

SECTION "Map Cursor Y Position Buffer", WRAM0[$C0AC]
W_Map_CursorYPosBuffer:: ds 1

SECTION "Map Acre Completion Data", WRAM0[$C960]
W_Map_AcreCompletionData:: ds $20

SECTION "Map Screen States", ROMX[$4046], BANK[$2A]
Map_StateDrawScreen::
	M_AuxJmp Banked_Map_ADVICE_DrawScreen
	call Map_MapScreenTiles
	ld a, 3
	ld [W_MetaSpriteConfig1], a
	ld a, $10
	ld [$C0A1], a
	ld a, $38
	ld [$C0A2], a
	ld a, 6
	ld [$C0A5], a
	ld a, [$C913]
	srl a
	srl a
	srl a
	ld e, a
	ld a, [$C913]
	and 7
	ld d, a
	sla a
	sla a
	sla a
	ld b, a
	ld a, [$C914]
	cp 6
	jr c, .jpA
	sub 4

.jpA
	ld c, a
	and 1
	jr z, .jpB
	ld a, 8
	add d
	ld d, a
	ld a, $40

.jpB
	add b
	add $14
	ld [W_Map_CursorXPosBuffer], a
	ld [$C0A3], a
	ld a, [$C913]
	and $F8
	ld b, a
	ld a, c
	and 4
	jr z, .jpC
	ld a, 8
	add e
	ld e, a
	ld a, $40

.jpC
	add b
	add $C
	ld [W_Map_CursorYPosBuffer], a
	ld [$C0A4], a
	ld hl, W_MetaSpriteConfig1
	ld de, $C0C0
	ld b, $20
	call Banked_Memcpy_INTERNAL
	ld a, $41
	ld [$C0C2], a
	ld a, 0
	ld [$C0C5], a
	ld bc, 8
	call Banked_CGBLoadBackgroundPalette
	ld bc, $10
	call Banked_CGBLoadObjectPalette
	M_AuxJmp Banked_Map_ADVICE_LoadSGBFiles
	jp System_ScheduleNextSubState

Map_ADVICE_StateMainLoop_OpenWindow::
	call CallBankedFunction_int
	M_AuxJmp Banked_Map_ADVICE_WindowLoadSGBFiles
	ret

Map_ADVICE_StateMainLoop_CloseWindow::
	call $44C5
	M_AuxJmp Banked_Map_ADVICE_WindowUnloadSGBFiles
	ret

	; Note: Free Space
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

Map_MapSingleAcre::
	call Map_CanMapAcre
	ret z
	ld hl, $9822
	ld de, MapAcreTilemap
	ld a, c
	swap a
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	ld a, b
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	ld a, c
	swap a
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, c
	swap a
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, b
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	push hl
	push de

; Map single acre tile.
	ld a, $38
	ld bc, 1
	call Banked_LCDC_LoadTiles
	pop de
	ld hl, $100
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld a, [W_GameboyType]
	cp M_BIOS_CPU_CGB
	ret nz

; Map single acre attrib.
	ld a, 1
	ldh [REG_VBK], a
	ld a, $38
	ld bc, 1
	call Banked_LCDC_LoadTiles
	ld a, 0
	ldh [REG_VBK], a
	ret

Map_CanMapAcre::
	dec b
	dec c
	ld d, 0
	ld a, b
	cp 8
	jr c, .jpA
	inc d

.jpA
	ld a, c
	cp 8
	jr c, .jpB
	inc d
	inc d

.jpB
	ld a, d
	sla a
	sla a
	sla a
	ld hl, W_Map_AcreCompletionData
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, c
	and 7
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, b
	and 7
	ld d, 1
	or a
	jr z, .skipLoop

.bitSelectionLoop
	sla d
	dec a
	jr nz, .bitSelectionLoop

.skipLoop
	ld a, [hl]
	and d
	ret

Map_MapScreenTiles::
	ld hl, $9800
	ld de, $59FC
	ld b, $12

.tileMappingLoop
	push bc
	push hl
	ld bc, $14
	ld a, $38

; Don't be fooled, this is being used to map tiles, not draw them.
	call Banked_LCDC_LoadTiles
	pop hl
	ld a, $20
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	pop bc
	dec b
	jr nz, .tileMappingLoop

	ld a, [W_GameboyType]
	cp M_BIOS_CPU_CGB
	jr nz, .dmgGameboy

	ld hl, $9800
	ld b, $12
	ld a, 1
	ldh [REG_VBK], a

.attribmapWriteLoop
	ld c, $14

.attribmapWriteLine
	di

.waitforblank
	ldh a, [REG_STAT]
	and 2
	jr nz, .waitforblank

	ld a, 6
	ldi [hl], a
	ei
	dec c
	jr nz, .attribmapWriteLine
	ld a, $C
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	dec b
	jr nz, .attribmapWriteLoop

	ld a, 0
	ldh [REG_VBK], a

.dmgGameboy
	ld c, $10

.acreWriteLoop
	ld b, $10

.acreWriteLine
	push bc
	call Map_MapSingleAcre
	pop bc
	dec b
	jr nz, .acreWriteLine
	dec c
	jr nz, .acreWriteLoop
	ret

Map_StateFadeIn::
	ld bc, 0
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation_PlusSetupSGBWhiteFade
	ld a, 9
	ld [W_MainScript_State], a
	jp System_ScheduleNextSubState

;State 05 0F
Map_StateMainLoop::

; Initial fade in.

	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z

	ld a, 6
	ld [W_MetaSpriteConfig1 + M_LCDC_MetaSpriteConfig_LoAttribs], a

; If MainScriptMachine is active then do not load the window.

	ld a, [W_MainScript_State]
	cp a, 9
	jp nz, .skipIfMainScriptActive

; Was A pressed? If so then let's load the window.

	ldh a, [H_JPInput_Changed]
	and a, 1
	jp z, .afterWindowRender

; Convert the buffered cursor position into something that Map_LoadLocationName can parse.

	ld a, [W_Map_CursorYPosBuffer]
	sub a, $C
	sla a
	ld b, a
	ld a, [W_Map_CursorXPosBuffer]
	sub a, $14
	srl a
	srl a
	srl a
	add b
	ld b, a

; Load map location name.

	call Map_LoadLocationName

; Check if the map location was visited at some point.

	ld a, [W_Map_CursorXPosBuffer]
	sub a, $14
	srl a
	srl a
	srl a
	inc a
	ld b, a
	ld a, [W_Map_CursorYPosBuffer]
	sub a, $C
	srl a
	srl a
	srl a
	inc a
	ld c, a
	call Map_CanMapAcre
	jr nz, .openWindow

; If the map location has never been visited then throw an error sound at the user.

	ld a, 5
	ld [W_Sound_NextSFXSelect], a
	jr .afterWindowRender

; Sound effect when opening window.

.openWindow
	ld a, 7
	ld [W_Sound_NextSFXSelect], a

; Determine the window position based on the cursor position.

	ld d, 2
	ld a, [W_Map_CursorYPosBuffer]
	cp a, $4C
	jr nc, .cursorOnBottomHalf
	ld d, $C

; Draw window.

.cursorOnBottomHalf
	push de
	ld b, d
	ld c, 4
	call $4459
	pop de
	ld b, 0
	ld c, $BC
	ld a, BANK(Map_MapLocationWindow)
	ld hl, Map_MapLocationWindow
	call Map_ADVICE_StateMainLoop_OpenWindow
	ld a, [W_MainScript_WindowLocation]
	dec a
	ld [W_MainScript_WindowLocation], a
	ld a, [W_MainScript_WindowLocation]
	dec a
	ld [W_MainScript_WindowLocation], a
	jr .afterWindowRender

; The following call is to an alternate version of Banked_MainScriptMachine that preserves the value of "a". Which is stupid because the next instruction overwrites "a".

.skipIfMainScriptActive
	call $2CC4

; If MainScriptMachine is active then this code shouldn't run.

	ld a, [W_MainScript_State]
	cp a, 9
	jr nz, .afterWindowRender

; Determine the window position based on the cursor position, this time in order to close the window.

	ld b, 2
	ld a, [W_Map_CursorYPosBuffer]
	cp a, $4C
	jr nc, .cursorOnBottomHalfRedux
	ld b, $C

.cursorOnBottomHalfRedux
	ld c, 4

; Close the window because MainScriptMachine is now inactive.

	call Map_ADVICE_StateMainLoop_CloseWindow

; This handles the blinking "you are here" dot's animation.

.afterWindowRender
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [$C984]
	srl a
	and a, 7
	add a, $38
	ld [W_MetaSpriteConfig1 + M_LCDC_MetaSpriteConfig_Index], a
	ld b, 3
	ld a, [$C984]
	and a, 8
	jr z, .nopeThreeItIs
	ld b, 2

.nopeThreeItIs
	ld a, b
	ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size + M_LCDC_MetaSpriteConfig_HiAttribs], a

; If MainScriptMachine is idle then do not move the cursor.

	ld a, [W_MainScript_State]
	cp a, 9
	jr nz, .skipDownPressAction
  
; This section notes dpad presses and determines new x and y positions for the map cursor.

; Check if the "right" button is pressed.
 
	ld a, [W_JPInput_TypematicBtns]
	and a, M_JPInput_Right
	jr z, .skipRightPressAction

; Check the stored cursor position against the right map boundary.

	ld a, [W_Map_CursorXPosBuffer]
	cp a, $8C
	jr nc, .skipRightPressAction

; Reposition the stored cursor position 8px rightwards.

	add a, 8
	ld [W_Map_CursorXPosBuffer], a
	ld a, 2
	ld [W_Sound_NextSFXSelect], a

; Check if the "left" button is pressed.

.skipRightPressAction
	ld a, [W_JPInput_TypematicBtns]
	and a, M_JPInput_Left
	jr z, .skipLeftPressAction

; Check the stored cursor position against the left map boundary.

	ld a, [W_Map_CursorXPosBuffer]
	cp a, $1C
	jr c, .skipLeftPressAction

; Reposition the stored cursor position 8px leftwards.

	sub a, 8
	ld [W_Map_CursorXPosBuffer],a
	ld a, 2
	ld [W_Sound_NextSFXSelect],a

; Check if the "up" button is pressed.
 
.skipLeftPressAction
	ld a, [W_JPInput_TypematicBtns]
	and a, M_JPInput_Up
	jr z, .skipUpPressAction

; Check the stored cursor position against the top map boundary.

	ld a, [W_Map_CursorYPosBuffer]
	cp a, $14
	jr c, .skipUpPressAction

; Reposition the stored cursor position 8px upwards.

	sub a, 8
	ld [W_Map_CursorYPosBuffer], a
	ld a, 2
	ld [W_Sound_NextSFXSelect], a

; Check if the "down" button is pressed.
 
.skipUpPressAction
	ld a, [W_JPInput_TypematicBtns]
	and a, M_JPInput_Down
	jr z, .skipDownPressAction

; Check the stored cursor position against the bottom map boundary.

	ld a, [W_Map_CursorYPosBuffer]
	cp a, $84
	jr nc, .skipDownPressAction

; Reposition the stored cursor position 8px downwards.

	add a, 8
	ld [W_Map_CursorYPosBuffer], a
	ld a, 2
	ld [W_Sound_NextSFXSelect], a

.skipDownPressAction
	ld a, [W_Map_CursorXPosBuffer]
	ld [W_MetaSpriteConfig1 + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, [W_Map_CursorYPosBuffer]
	ld [W_MetaSpriteConfig1 + M_LCDC_MetaSpriteConfig_YOffset], a

; Animate the background tiles.

	ld a, [W_FrameCounter]
	and a, 3
	jr nz, .notFourthFrame
	ld hl, $8C00
	call Status_ShiftBackgroundTiles

; Check if "b" or "start" have been pressed, and if so then exit the screen, otherwise keep looping.

.notFourthFrame
	ldh a, [H_JPInput_Changed]
	and a, M_JPInput_B + M_JPInput_Start
	jr z, .noExit
	ld a, $11
	ld [W_SystemSubState], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation_PlusSetupSGBWhiteFade

.noExit
	ret

Map_StateFadeToOverworld::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	M_AuxJmp Banked_Map_ADVICE_UnloadSGBFiles
	ld a, $A
	ld [W_SystemSubState], a
	ret

SECTION "Dungeon Map Screen States", ROMX[$47E7], BANK[$2A]
DungeonMap_StateDrawScreen::
	ld hl, $5F9F
	ld a, [W_Overworld_AcreType]
	sub $A
	cp $28
	jr c, .jpA
	sub 7

.jpA
	add a
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	call $2FE4
	ld h, b
	ld l, c
	ld a, d
	cpl
	inc a
	ld b, a
	ld a, e
	cpl
	inc a
	ld c, a
	add hl, bc
	ld b, h
	ld c, l
	ld a, $28
	ld hl, $9000
	call Banked_LCDC_LoadTiles
	ld a, $38
	ld hl, $8000
	ld de, $67C4
	ld bc, $490
	call Banked_LCDC_LoadTiles
	M_AuxJmp Banked_DungeonMap_ADVICE_DrawScreen
	ld de, $6FA4
	ld hl, $9800
	ld b, $12
	ld c, $14
	ld a, 2
	call $33FD
	ld a, BANK(DungeonMap_LoadLocationName)
	call Banked_DungeonMap_LoadLocationName
	ld d, 2
	ld b, 0
	ld c, $BB
	ld a, BANK(Map_MapLocationWindow)
	ld hl, Map_MapLocationWindow
	call CallBankedFunction_int
	ld a, [W_MainScript_WindowLocation]
	dec a
	ld [W_MainScript_WindowLocation], a
	ld a, [W_MainScript_WindowLocation]
	dec a
	ld [W_MainScript_WindowLocation], a
	call $2CC4
	ld a, 3
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, $10
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_Bank], a
	ld a, $41
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, 0
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_LoAttribs], a
	ld a, [$C906]
	ld b, a
	and 7
	swap a
	srl a
	add $34
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, b
	and $F8
	add $44
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_YOffset], a
	ld a, [W_Overworld_AcreType]
	sub $A
	cp $28
	jr c, .jpB
	sub $07

.jpB
	ld c, $40
	ld e, a
	call System_Multiply8
	ld hl, $5FE9
	add hl, de
	ld d, h
	ld e, l
	call $48DD
	ld a, $2A
	ld [W_PreviousBank], a
	ld bc, 9
	call Banked_CGBLoadBackgroundPalette
	ld bc, $10
	call Banked_CGBLoadObjectPalette
	ld b, 7
	call $33AF
	ld bc, $225
	ld a, [W_Overworld_AcreType]
	sub $A
	cp $28
	jr c, .jpC
	sub 7

.jpC
	add c
	ld c, a
	jr nc, .skipPseudoAdc
	inc b

.skipPseudoAdc
	ld a, 1
	call CGBLoadBackgroundPaletteBanked
	M_AuxJmp Banked_DungeonMap_ADVICE_LoadSGBFiles
	jp System_ScheduleNextSubState
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

DungeonMap_MapAcres::
	ld b, 0

.loopRows
	ld c, 0

.loopAcres
	push bc
	call DungeonMap_CanMapAcre
	pop bc
	jr z, .doNotMapAcre
	push de
	push bc
	ld a, c
	swap a
	srl a
	add b
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	pop bc
	push bc
	ld hl, $9906
	ld a, c
	swap a
	sla a
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, b
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, $29
	ld bc, 1
	push hl
	call Banked_LCDC_LoadTiles
	pop hl
	ld a, [W_GameboyType]
	cp $11
	jr nz, .notGBC
	ld a, 1
	ldh [REG_VBK], a
	call WaitForBlanking
	ld a, 1
	ld [hl], a
	ld a, 0
	ldh [REG_VBK], a

.notGBC
	pop bc
	pop de

.doNotMapAcre
	inc c
	ld a, 8
	cp c
	jr nz, .loopAcres
	inc b
	ld a, 8
	cp b
	jr nz, .loopRows
	ret

DungeonMap_CanMapAcre::
	push de
	ld a, c
	ld hl, $B000
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld d, 1
	ld a, b
	or a
	jr z, .skipLoop

.loop
	sla d
	dec a
	jr nz, .loop

.skipLoop
	ld a, [W_Overworld_AcreType]
	sub $A
	cp $28
	jr c, .jpA
	sub 7

.jpA
	ld c, a
	ld b, 0
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, 2
	ld [REG_MBC3_SRAMBANK], a
	ld a, [hl]
	and d
	pop de
	push af
	ld a, 0
	ld [REG_MBC3_SRAMENABLE], a
	pop af
	ret

DungeonMap_StatePrepareFadeIn::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld bc, 0
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation_PlusSetupSGBWhiteFade
	jp System_ScheduleNextSubState

DungeonMap_StateFadeInAndIdle::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	call $2CC4
	ld b, 3
	ld a, [$C984]
	and 8
	jr z, .jpA
	ld b, 2

.jpA
	ld a, b
	ld [W_MetaSpriteConfig1], a
 	ld a, [W_FrameCounter]
 	and 3
 	jr nz, .dontAnimateBgThisFrame
 	ld hl, $9400
 	call Status_ShiftBackgroundTiles

.dontAnimateBgThisFrame
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B + M_JPInput_Select + M_JPInput_Start
	jr z, .buttonNotPressed
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation_PlusSetupSGBWhiteFade
	jp System_ScheduleNextSubState

.buttonNotPressed
	ret

DungeonMap_StateFadeToOverworld::
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	M_AuxJmp Banked_Map_ADVICE_UnloadSGBFiles
	ld a, $A
	ld [W_SystemSubState], a
	ret
