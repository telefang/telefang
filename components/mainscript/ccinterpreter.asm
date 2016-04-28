INCLUDE "components/system/input.inc"

;Control codes are as follows:
;E1: Local state change (1 byte follows)
;E2: Newline
;E3: Change text speed (1 byte follows)
;E5: Jump to new location (farptr follows)


MainScript_StateOpcode EQU $45C8

SECTION "Main Script Control Code Interpreter", ROMX[$413C], BANK[$B]
MainScript_CCInterpreter::
	ld a, [W_MainScript_TextPtr]
	ld l, a
	ld a, [W_MainScript_TextPtr + 1]
	ld h, a
	call MainScript_LoadFromBank
	or a ;TODO: Pointcut exists in English patch
	jr nz, .newlineCC
	push af
	ld a, [W_MainScript_TilesDrawn]
	ld [W_MainScript_SecondAnswerTile], a
	pop af
	
.newlineCC
	cp $E2
	jr nz, .localStateJumpCC
	ld a, [W_MainScript_TilesDrawn]
	cp $10
	jr nc, .earlyNewline
	ld a, $10
	ld [W_MainScript_TilesDrawn], a
	ld a, [W_MainScript_NumNewlines]
	inc a
	ld [W_MainScript_NumNewlines], a
	jp MainScript_EndOpcode
.earlyNewline
	ld a, 0
	ld [W_MainScript_TilesDrawn], a
	ld a, [W_MainScript_NumNewlines]
	inc a
	ld [W_MainScript_NumNewlines], a
	jp MainScript_EndOpcode

.localStateJumpCC
	cp $E1
	jr nz, .opcodeE7
	jp MainScript_StateOpcode
	
.opcodeE7 ;Don't know what this does yet.
	cp $E7
	jr nz, .thirdPersonCheckCC
	call $422F
	jp $4316
	
.thirdPersonCheckCC
	cp $E9
	jr nz, .textSpeedCC
	call MainScript_Moveup
	jp MainScript_EndOpcodeSkipNewlineCheck
	
.textSpeedCC
	cp $E3
	jr nz, .jumpCC
	call MainScript_LoadFromBank
	ld [W_MainScript_TextSpeed], a
	call MainScript_Moveup
	jp MainScript_EndOpcodeSkipNewlineCheck
	
.jumpCC
	cp $E5
	jr nz, .returnCC
	ld a, [W_MainScript_TextPtr + 1]
	ld [W_MainScript_CodePtrSpill + 1], a
	ld a, [W_MainScript_TextPtr]
	ld [W_MainScript_CodePtrSpill], a
	call MainScript_Jump2Operand
	ret
	
.returnCC
	cp $E0
	jr nz, .regularText
	ld a, [W_MainScript_CodePtrSpill]
	ld [W_MainScript_TextPtr], a
	ld a, [W_MainScript_CodePtrSpill + 1]
	ld [W_MainScript_TextPtr + 1], a
	call MainScript_Moveup
	call MainScript_Moveup
	jp MainScript_EndOpcodeSkipNewlineCheck

.regularText
	cp $E1
	jp nc, MainScript_Moveup
	ld a, [W_MainScript_WaitFrames]
	or a
	jp z, .noWaiting
	dec a
	jp nz, MainScript_ContinueWaiting
	
.noWaiting
	push hl
	ld a, [W_MainScript_TextSpeed]
	ld [W_MainScript_WaitFrames], a
	ld a, [W_MainScript_TilesDrawn]
	ld b, a
	ld a, [W_MainScript_TileBaseIdx]
	add a, b
	call $35C2 ;Converts tile base index to a VRAM ptr
	call $422D
	ld a, c
	call $4E29 ;Draws text. Heavily patched in the patch.
	pop hl
	ld a, [W_MainScript_TilesDrawn]
	inc a
	ld [W_MainScript_TilesDrawn], a
	cp $10
	jr nz, .noAutomaticNewline
	ld a, [W_MainScript_NumNewlines]
	inc a
	ld [W_MainScript_NumNewlines], a
	jp MainScript_EndOpcode
	
.noAutomaticNewline
	cp $1F
	jr c, .isAsciiNonprintable
	call $42BE
	jr z, .isAsciiNonprintable
	ld a, [W_MainScript_NumNewlines]
	inc a
	ld [W_MainScript_NumNewlines], a
	ld a, 0
	ld [W_MainScript_TilesDrawn], a
	jp MainScript_EndOpcode

.isAsciiNonprintable
	jp MainScript_EndOpcodeSkipNewlineCheck

SECTION "Main Script Control Code Interpreter 2", ROMX[$42EA], BANK[$B]
MainScript_EndOpcode:: ;2C2EA $42EA
	call MainScript_Moveup
	ld a, [W_MainScript_NumNewlines]
	cp 2
	jr nc, .moreThan1Newline
	jr MainScript_EndOpcodeCheckIfSkipping
	
.moreThan1Newline
	and 1
	jr nz, .oneOrLessNewlines
	ld a, 2
	ld [W_MainScript_State], a
	ld a, 0
	ld [W_MainScript_WaitFrames], a
	jr MainScript_EndOpcodeCheckIfSkipping
	
.oneOrLessNewlines
	ld a, [W_MainScript_FramesCount]
	ld [W_MainScript_WaitFrames], a
	ld a, 3
	ld [W_MainScript_State], a
	jr MainScript_EndOpcodeCheckIfSkipping
	
;This and the following stupid label names are brought to you by rgbds' and
;it's inability to resolve local symbols across a global one
MainScript_EndOpcodeSkipNewlineCheck:
	call MainScript_Moveup
   
MainScript_EndOpcodeCheckIfSkipping:
	ld a, [W_MainScript_TextSpeed]
	or a
	jp z, MainScriptMachine
	ld a, [W_MainScript_ContinueBtnPressed]
	or a
	jp nz, MainScriptMachine
	ld a, [H_ButtonsPressed]
	and 2
	jp nz, MainScriptMachine
	ld a, [H_ButtonsChanged]
	and 1
	jr z, .finished
	ld a, 1
	ld [W_MainScript_ContinueBtnPressed], a
	
.finished
	ret

MainScript_Moveup::
	ld a, [W_MainScript_TextPtr + 1]
	ld c, a
	ld a, [W_MainScript_TextPtr]
	add a, 1
	ld [W_MainScript_TextPtr], a
	ld a, 0
	adc a, c
	ld [W_MainScript_TextPtr + 1], a
	ret

MainScript_ContinueWaiting::
	ld [W_MainScript_WaitFrames], a
	ret