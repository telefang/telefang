INCLUDE "telefang.inc"

;These states are part of the Overworld state (05).

SECTION "Map Cursor X Position Buffer", WRAM0[$C0A8]
W_Map_CursorXPosBuffer:: ds 1

SECTION "Map Cursor Y Position Buffer", WRAM0[$C0AC]
W_Map_CursorYPosBuffer:: ds 1

SECTION "Map Acre Completion Data", WRAM0[$C960]
W_Map_AcreCompletionData:: ds $20

SECTION "Map Screen Display Loop", ROMX[$4046], BANK[$2A]
Map_StateDrawScreen::
	ld a, BANK(MapAcreGfxA)
	ld hl, $9000
	ld de, MapAcreGfxA
	ld bc, $800
	call Banked_LCDC_LoadTiles
	ld a, BANK(MapAcreGfxB)
	ld hl, $8800
	ld de, MapAcreGfxB
	ld bc, $260
	call Banked_LCDC_LoadTiles
	ld a, $38
	ld hl, $8000
	ld de, $67C4
	ld bc, $490
	call Banked_LCDC_LoadTiles
	ld a, $38
	ld hl, $8C00
	ld de, $6ED4
	ld bc, $C0
	call Banked_LCDC_LoadTiles
	call $41A2
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
	ld b, 7
	call $33AF
	jp System_ScheduleNextSubState

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
	call Banked_LCDC_SetupPalswapAnimation
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
	call $4168
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
	ld a, $B
	ld hl, $47B9
	call CallBankedFunction_int
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

	call $44C5

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
	call Banked_LCDC_SetupPalswapAnimation

.noExit
	ret