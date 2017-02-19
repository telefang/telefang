INCLUDE "registers.inc"
INCLUDE "components/jpinput/jpinput.inc"

;JPInput stands for JoyPad INPUT.
;It handles player input.

SECTION "JoyPad INPUT Variables", WRAM0[$C473]
W_JPInput_TypematicBtns:: ds 1
W_JPInput_TypematicTimeout:: ds 1

SECTION "JoyPad INPUT", ROM0[$0737]

;Typematic is a feature of keyboard controllers that cause a button to be
;repeatedly registered as pushed down when it is consistently held down for a
;period of time. This function generates a version of HeldDown that repeats
;directional inputs after 16 frames.
;Used by: most menus
JPInput_TypematicDPad:
	ld a, [H_JPInput_Changed]
	ld [W_JPInput_TypematicBtns], a
	and $F0
	jr z, .noButtonWasChanged
	ld a, M_JPInput_TypematicDelay
	ld [W_JPInput_TypematicTimeout], a
	
.noButtonWasChanged
	ld a, [H_JPInput_HeldDown]
	and $F0
	ret z
	ld a, [W_JPInput_TypematicTimeout]
	or a
	jr z, .setActiveButtons
	dec a
	ld [W_JPInput_TypematicTimeout], a
	ret
	
.setActiveButtons
	ld a, M_JPInput_TypematicRepeat
	ld [W_JPInput_TypematicTimeout], a
	ld a, [H_JPInput_HeldDown]
	and $F0
	ld b, a
	ld a, [H_JPInput_Changed]
	or b
	ld [W_JPInput_TypematicBtns], a
	ret
	
JPInput_SampleJoypad::
	ld a, $20
	ld [REG_JOYP], a
	ld a, [REG_JOYP]
	ld a, [REG_JOYP]
	cpl
	and $F
	swap a
	ld b, a
	ld a, $10
	ld [REG_JOYP], a
	ld a, [REG_JOYP]
	ld a, [REG_JOYP]
	ld a, [REG_JOYP]
	ld a, [REG_JOYP]
	ld a, [REG_JOYP]
	ld a, [REG_JOYP]
	cpl
	and $F
	or b
	ld c, a
	ld a, [H_JPInput_HeldDown]
	xor c
	and c
	ld [H_JPInput_Changed], a
	ld a, c
	ld [H_JPInput_HeldDown], a
	ld a, $30
	ld [REG_JOYP], a
	call JPInput_TypematicDPad
	ret