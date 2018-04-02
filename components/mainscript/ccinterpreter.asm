INCLUDE "components/jpinput/jpinput.inc"

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
   
.j2StateOpcode
	jp MainScript_StateOpcode
	
.opcodeE7 ;Don't know what this does yet.
	cp $E7
	jr nz, .thirdPersonCheckCC
	call $422F
	jp MainScript_EndOpcode.checkIfSkipping
	
.thirdPersonCheckCC
	cp $E9
	jr nz, .textSpeedCC
	call MainScript_Moveup
	jp MainScript_EndOpcode.skipNewlineCheck
	
.textSpeedCC
	cp $E3
	jr nz, .jumpCC
	call MainScript_LoadFromBank
	ld [W_MainScript_TextSpeed], a
	call MainScript_Moveup
	jp MainScript_EndOpcode.skipNewlineCheck
	
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
	jp MainScript_EndOpcode.skipNewlineCheck

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
	call LCDC_TileIdx2Ptr
	call .swapRegsThing
	ld a, c
	call MainScript_DrawLetter
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
	call MainScript_LowControlCode
	jr z, .isAsciiNonprintable
	ld a, [W_MainScript_NumNewlines]
	inc a
	ld [W_MainScript_NumNewlines], a
	ld a, 0
	ld [W_MainScript_TilesDrawn], a
	jp MainScript_EndOpcode

.isAsciiNonprintable
	jp MainScript_EndOpcode.skipNewlineCheck

.swapRegsThing ;Not sure WTF this does, only called from one place!
	ld a, c
	ret

;Appears to be some kind of recovery routine.
;Gets jumped to for nonprintable ASCII, does some weird crap
SECTION "Main Script Control Code Interpreter 2", ROMX[$42BE], BANK[$B]
MainScript_LowControlCode::
    ld b, 0
.loc_42C0
    call MainScript_LoadFromBank
    cp $E1
    jr c, .loc_42E2
    cp $E1
    jr nz, .loc_42D6
    ld a, b
    or a
    jr z, .loc_42D1
    xor a
    ret

.loc_42D1
    call MainScript_CCInterpreter.j2StateOpcode
    xor a
    ret
    
.loc_42D6
    cp $E2
    jr nz, .loc_42E0
    ld a, b
    or a
    jr nz, .loc_42E2
    xor a
    ret

.loc_42E0
    jr .loc_42C0

.loc_42E2
    inc b
    ld a, b
    cp 1
    jr z, .loc_42C0
    or a
    ret

MainScript_EndOpcode:: ;2C2EA $42EA
	call MainScript_Moveup
	ld a, [W_MainScript_NumNewlines]
	cp 2
	jr nc, .moreThan1Newline
	jr MainScript_EndOpcode.checkIfSkipping
	
.moreThan1Newline
	and 1
	jr nz, .oneOrLessNewlines
	ld a, 2
	ld [W_MainScript_State], a
	ld a, 0
	ld [W_MainScript_WaitFrames], a
	jr MainScript_EndOpcode.checkIfSkipping
	
.oneOrLessNewlines
	ld a, [W_MainScript_FramesCount]
	ld [W_MainScript_WaitFrames], a
	ld a, 3
	ld [W_MainScript_State], a
	jr MainScript_EndOpcode.checkIfSkipping
	
.skipNewlineCheck:
	call MainScript_Moveup
   
.checkIfSkipping:
	ld a, [W_MainScript_TextSpeed]
	or a
	jp z, MainScriptMachine
	ld a, [W_MainScript_ContinueBtnPressed]
	or a
	jp nz, MainScriptMachine
	ld a, [H_JPInput_HeldDown]
	and M_JPInput_B
	jp nz, MainScriptMachine
	ld a, [H_JPInput_Changed]
	and M_JPInput_A
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