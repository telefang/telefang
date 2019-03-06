INCLUDE "macros.asm"

;Telefang uses a nested state machine to control code execution across multiple
;frames. There are 16 states in total, many of which are sub-state machines of
;variable cardinality. Some sub-state machines have a third level of execution
;in a sub-sub-state machine as well; as well as or alongside their own private
;state machines as well.

SECTION "SystemStateMachine WRAM", WRAM0[$C3E0]
W_SystemState:: ds 1
W_SystemSubState:: ds 1
W_SystemSubSubState:: ds 1

SECTION "StateMachine Tools", ROM0[$E97]
System_IndexWordList::
    ld b, 0
    ld c, a
    sla c
    rl b
    add hl, bc
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret
    
System_ScheduleNextSubState::
    ld a, [W_SystemSubState]
    inc a
    ld [W_SystemSubState], a
    ret
    
System_ScheduleNextSubSubState::
    ld a, [W_SystemSubSubState]
    inc a
    ld [W_SystemSubSubState], a
    ret

SECTION "StateMachine Execution", ROM0[$1BE2]
GameStateMachine::
	ld a, [W_SystemState]
	ld hl, GameStateMachineTable
	ld d, 0
	ld e, a
	sla e
	rl d
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

GameStateMachineTable:
	dw GameState00, GameState01, GameState02, GameState03
	dw GameState04, GameState05, GameState06, GameState07
	dw GameState08, GameState09, GameState0A, GameState0B
	dw GameState0B, GameState0D, GameState0E, GameState0F

;Disassembly of individual substates follows.
;TODO: Name each state.

GameState00: ;Intro Logos
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $5300

GameState01: ;Title Screen
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $493F

GameState02:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $4000

GameState03: ;Title Menu
	ld a, BANK(TitleMenu_GameStateMachine)
	ld [W_PreviousBank], a
	rst $10
	jp TitleMenu_GameStateMachine

GameState04: ;Attract Screen
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $40BF

GameState05: ;Overworld
	ld a, $B
	ld [W_PreviousBank], a
	rst $10
	jp $1EA1

GameState06: ;Encounter
	ld a, BANK(Encounter_GameStateMachine)
	ld [W_PreviousBank], a
	rst $10
	jp Encounter_GameStateMachine

GameState07: ;Battle
	ld a, 5
	ld [W_PreviousBank], a
	rst $10
	jp $441B

GameState08: ;Victory
	ld a, BANK(Victory_ExternalStateMachine)
	ld [W_PreviousBank], a
	rst $10
	jp Victory_ExternalStateMachine

GameState09: ;Denjuu Status
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $4B8B

GameState0A:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $4824

GameState0B: ;Pause Menu. Repeated twice in original ROM. State 0C is what it runs under normally
	ld a, 4
	ld [W_PreviousBank], a
	rst $10
	jp $45C0

GameState0D:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $44CF

GameState0E:
	ld a, 2
	ld [W_PreviousBank], a
	rst $10
	jp $458E

GameState0F: ;Link Communications
	ld a, $1F
	ld [W_PreviousBank], a
	rst $10
	jp $4000