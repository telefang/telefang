;Telefang has a separate state machine for scripts at B:4100. It is called as
;substate 5 of main state 5, which has yet to be disassembled.

SECTION "Main Script Variables", WRAM0[$C9C5]
W_MainScript_FramesCount:: ds 1
W_MainScript_TextPtr:: ds 2
W_MainScript_TextBank:: ds 1
W_MainScript_State:: ds 1
W_MainScript_WindowLocation:: ds 1
W_MainScript_TilesDrawn:: ds 1
W_MainScript_WaitFrames:: ds 1
W_MainScript_TextSpeed:: ds 1
W_MainScript_NumNewlines:: ds 1
W_byte_C9CF:: ds 2 ;Unsure what this does yet.
W_MainScript_CodePtrSpill:: ds 2

SECTION "Main Script State Machine", ROMX[$4100], BANK[$B]
MainScriptMachine::
	ld a, [W_MainScript_FramesCount]
	inc a
	ld [W_MainScript_FramesCount], a
	ld a, [W_MainScript_State]
	cp 0
	jp z, $457D
	cp 1
	jr z, MainScriptCCInterpret ;MainScriptCCInterpret
	cp 2
	jp z, $434E ;MainScriptNewlineClearEven
	cp 3
	jp z, $43C7 ;MainScriptNewlineClearOdd
	cp 4
	jp z, $43C7 ;MainScriptNewlineClearOdd
	cp 5
	jp z, $4432 ;MainScriptEndWindowClear
	cp 6
	jp z, $440D
	cp 7
	jp z, $4413
	cp 8
	jp z, $4429
	cp $A
	jp z, $4445
	ret

MainScriptCCInterpret: