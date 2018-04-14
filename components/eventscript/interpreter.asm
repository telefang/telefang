INCLUDE "telefang.inc"

SECTION "Event Sequence Pointer", WRAM0[$CD02]
W_EventScript_EventSequencePointerIndex:: ds 2

SECTION "Event Arguments", WRAM0[$CD06]
W_EventScript_EventChainingOffset:: ds 2
W_EventScript_EventType:: ds 1
W_EventScript_ParameterA:: ds 1
W_EventScript_ParameterB:: ds 1
W_EventScript_ParameterC:: ds 1
W_EventScript_ParameterD:: ds 1
W_EventScript_ParameterE:: ds 1
W_EventScript_ParameterF:: ds 1
W_EventScript_ParameterG:: ds 1
W_EventScript_WaitFrames:: ds 1

SECTION "Event Multi Jump Conditional", WRAM0[$CD26]
W_EventScript_MultiJumpConditional:: ds 1

SECTION "Event System - Load Event", ROM0[$2F43]
EventScript_LoadEvent::
    ld a, [W_CurrentBank]
    push af
    ld a, b
    rst $10
    ld a, [W_EventScript_EventSequencePointerIndex]
    ld e, a
    ld a, [W_EventScript_EventSequencePointerIndex + 1]
    ld d, a
    add hl, de
    add hl, de
    ldi a, [hl]
    ld h, [hl]
    ld l, a
    ld a, [W_EventScript_EventChainingOffset + 1]
    ld d, a
    ld a, [W_EventScript_EventChainingOffset]
    ld e, a
    add hl, de
    ld de, W_EventScript_EventType
    ld b, 8
    call Banked_Memcpy_INTERNAL
    pop af
    rst $10
    ret

SECTION "Event System - Fire Event", ROMX[$4041], BANK[$F]
EventScript_FireEventAction::
    ld a, [W_EventScript_EventType]
    ld c, a
    ld b, 0
    ld hl, EventScript_EventActionTable
    add hl, bc
    add hl, bc
    ldi a, [hl]
    ld h, [hl]
    ld l, a
    jp [hl]

SECTION "Event System - Calculate Offset", ROMX[$4112], BANK[$F]
EventScript_CalculateNextOffset::
    push hl
    push de
    ld a, [W_EventScript_EventChainingOffset]
    ld l, a
    ld a, [W_EventScript_EventChainingOffset + 1]
    ld h, a
    ld d, 0
    ld e, b
    bit 7,b
    jr z, .notNegative
    dec d
    
.notNegative
    add hl, de
    ld a, l
    ld [W_EventScript_EventChainingOffset], a
    ld a, h
    ld [W_EventScript_EventChainingOffset + 1], a
    pop de
    pop hl
    ret
    
SECTION "Event System Pointer Table", ROMX[$4130], BANK[$F]
EventScript_EventActionTable::
	dw EventScript_StandardEnd ; 00
	dw EventScript_OutputMessageAndContinue ; 01
	dw EventScript_OutputMessageAndContinue ; 02
	dw $423D ; 03
	dw EventScript_WaitXFramesAndContinue ; 04
	dw $4254 ; 05
	dw EventScript_StandardEnd ; 06
	dw EventScript_WarpPlayerAndContinue ; 07
	dw EventScript_WarpPlayerAndContinue ; 08
	dw EventScript_WarpPlayerAndContinue ; 09
	dw EventScript_WarpPlayerAndContinue ; 0A
	dw EventScript_WarpPlayerAndContinue ; 0B
	dw EventScript_PlayerFaceDirectionAndContinue ; 0C
	dw EventScript_PlayerFaceDirectionAndContinue ; 0D
	dw EventScript_PlayerScheduleHopAndContinue ; 0E
	dw $438B ; 0F
	dw EventScript_PlayerScheduleWalkAndContinue ; 10
	dw EventScript_EventFlag800SAndContinue ; 11
	dw EventScript_EventFlag800SAndContinue ; 12
	dw EventScript_EventFlag400S800RAndContinue ; 13
	dw EventScript_CurrentEventFlag400S800RAndContinue ; 14
	dw EventScript_CurrentEventFlag800RAndContinue ; 15
	dw EventScript_EffectiveEventFlag400S800RAndContinue ; 16
	dw EventScript_SetMultiJumpConditionalAndContinue ; 17
	dw EventScript_IncrementMultiJumpConditionalAndContinue ; 18
	dw EventScript_FuckingWeirdSequenceJumpAndContinue ; 19
	dw $44D4 ; 1A
	dw $44D4 ; 1B
	dw $450A ; 1C
	dw $4536 ; 1D
	dw $4596 ; 1E
	dw $45C7 ; 1F
	dw $45C7 ; 20
	dw $45C7 ; 21
	dw EventScript_NPCFaceDirectionAndContinue ; 22
	dw EventScript_NPCScheduleWalkAndContinue ; 23
	dw $4696 ; 24
	dw $4696 ; 25
	dw $46AA ; 26
	dw EventScript_NPCScheduleHopAndContinue ; 27
	dw EventScript_NPCScheduleHopAndContinue ; 28
	dw EventScript_JumpUsingMultiJumpConditionalAndContinue ; 29
	dw EventScript_PlayerWaitUntilDoneWalkingAndContinue ; 2A
	dw EventScript_JumpUsingMultiJumpConditionalAndContinue ; 2B
	dw $4987 ; 2C
	dw EventScript_JumpUsingMultiJumpConditionalAndContinue ; 2D
	dw $49B4 ; 2E
	dw EventScript_JumpUsingMultiJumpConditionalAndContinue ; 2F
	dw EventScript_RelativeLongJumpAndContinue ; 30
	dw $476A ; 31
	dw $476A ; 32
	dw $476A ; 33
	dw EventScript_SetFlagAndContinue ; 34
	dw EventScript_ResetFlagAndContinue ; 35
	dw $478B ; 36
	dw $47A5 ; 37
	dw EventScript_JumpIfFlagSetAndContinue ; 38
	dw EventScript_JumpIfFlagUnsetAndContinue ; 39
	dw $47BF ; 3A
	dw $47D6 ; 3B
	dw $4A46 ; 3C
	dw EventScript_NPCFacePlayerAndContinue ; 3D
	dw $4AF0 ; 3E
	dw $4ABC ; 3F
	dw $47F0 ; 40
	dw $47F0 ; 41
	dw $47F0 ; 42
	dw $47F0 ; 43
	dw $4802 ; 44
	dw EventScript_SetMusicAndContinue ; 45
	dw $4822 ; 46
	dw $4822 ; 47
	dw $4822 ; 48
	dw $4822 ; 49
	dw $4822 ; 4A
	dw EventScript_JumpOnPlayerWinAndContinue ; 4B
	dw $4B2A ; 4C
	dw EventScript_ExecuteCutsceneBehaviourAndContinue ; 4D
	dw EventScript_JumpOnPlayerWinAndContinue ; 4E
	dw EventScript_JumpOnPlayerWinAndContinue ; 4F
	dw $485A ; 50
	dw $4CD9 ; 51
	dw $4CE7 ; 52
	dw $4CF5 ; 53
	dw $4D02 ; 54
	dw $4D1D ; 55
	dw $485A ; 56
	dw EventScript_NPCWaitUntilDoneWalkingAndContinue ; 57
	dw $4962 ; 58
	dw EventScript_GetEventDenjuuAndContinue ; 59
	dw $4E0F ; 5A
	dw $4E34 ; 5B
	dw $4E70 ; 5C
	dw $4E97 ; 5D
	dw $4EB6 ; 5E
	dw $4ECD ; 5F
	dw $4F13 ; 60
	dw $4F28 ; 61
	dw $43E4 ; 62
	dw $4687 ; 63
	dw $4A32 ; 64
	dw $4F1A ; 65
	dw $4F21 ; 66
	dw $4F44 ; 67
	dw $42D9 ; 68
	dw $4F54 ; 69
	dw $4F93 ; 6A
	dw $4FA6 ; 6B
	dw EventScript_EventFlag400R800RAndContinue ; 6C
	dw $4FB3 ; 6D
	dw $4FCA ; 6E
	dw $4972 ; 6F
	dw $4972 ; 70
	dw $4972 ; 71
	dw $4972 ; 72
	dw $4972 ; 73
	dw $4972 ; 74
	dw $4972 ; 75
	dw $4972 ; 76
	dw $4972 ; 77
	dw $4972 ; 78
	