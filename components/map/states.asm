INCLUDE "telefang.inc"

;These states are part of the Overworld state (05).

SECTION "Map Cursor X Position Buffer", WRAM0[$C0A8]
W_Map_CursorXPosBuffer:: ds 1

SECTION "Map Cursor Y Position Buffer", WRAM0[$C0AC]
W_Map_CursorYPosBuffer:: ds 1

SECTION "Map Screen Display Loop", ROMX[$4210], BANK[$2A]
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