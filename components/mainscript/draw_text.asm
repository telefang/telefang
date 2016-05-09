INCLUDE "registers.inc"

;Text-drawing routine present in Telefang.
;For some reason they actually draw text out rather than using tiles to do it
;instead. It's completely unnecessary for Japanese text.

SECTION "MainScript Text Drawing Options", WRAM0[$CDB1]
W_MainScript_TextStyle:: ds 1

;Draw the letter at A.
;The 1bpp font is turned into a 2bpp color
SECTION "MainScript Text Drawing Routine", ROMX[$4E29], BANK[$B]
MainScript_DrawLetter::
	push hl
	ld b, 0
	add a, a
	jr nc, .mulBy8
	inc b
.mulBy8
	sla a
	rl b
	sla a
	rl b
	ld c, a
	ld hl, MainScript_Font
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [W_MainScript_TextStyle]
	cp 0
	jr z, .textColor0
	cp 1
	jr z, .textColor1
	cp 2
	jr z, .textColor2
	cp 3
	jr z, .textColor3
	
	;Mode 0: (and also any illegal modes)
	;0ff pixels translate to color 0
	;1n  pixels translate to color 4
	
.textColor0
	ld b, 8
.textColor0Loop
	di
.wfbTC0
	ld a, [REG_STAT]
	and 2
	jr nz, .wfbTC0
	ld a, [de]
	ld [hli], a
	ld [hli], a
	ei
	inc de
	dec b
	jr nz, .textColor0Loop
	ret
	
	;Mode 1:
	;0ff pixels translate to color 2
	;1n  pixels translate to color 3
.textColor1
	ld b, 8
.textColor1Loop
	di
.wfbTC1
	ld a, [REG_STAT]
	and 2
	jr nz, .wfbTC1
	ld a, [de]
	ld [hli], a
	ld a, $FF
	ld [hli], a
	ei
	inc de
	dec b
	jr nz, .textColor1Loop
	ret
	
	;Mode 2:
	;0ff pixels translate to color 3
	;1n  pixels translate to color 0
.textColor2
	ld b, 8
.textColor2Loop
	di
.wfbTC2
	ld a, [REG_STAT]
	and 2
	jr nz, .wfbTC2
	ld a, [de]
	cpl
	ld [hli], a
	ld [hli], a
	ei
	inc de
	dec b
	jr nz, .textColor2Loop
	ret
	
	;Mode 3:
	;0ff pixels translate to color 1
	;1n  pixels translate to color 3
.textColor3
	ld b, 8
.textColor3Loop
	di
.wfbTC3
	ld a, [REG_STAT]
	and 2
	jr nz, .wfbTC3
	ld a, $FF
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ei
	inc de
	dec b
	jr nz, .textColor3Loop
	ret