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

SECTION "Event Jump Comparative", WRAM0[$CAD9]
W_EventScript_JumpComparative:: ds 1

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
    jp hl

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
	dw EventScript_ClearMessageWindowAndContinue ; 03
	dw EventScript_WaitXFramesAndContinue ; 04
	dw EventScript_WaitForButtonPressAndContinue ; 05
	dw EventScript_StandardEnd ; 06
	dw EventScript_WarpPlayerAndContinue ; 07
	dw EventScript_WarpPlayerAndContinue ; 08
	dw EventScript_WarpPlayerAndContinue ; 09
	dw EventScript_WarpPlayerAndContinue ; 0A
	dw EventScript_WarpPlayerAndContinue ; 0B
	dw EventScript_PlayerFaceDirectionAndContinue ; 0C
	dw EventScript_PlayerFaceDirectionAndContinue ; 0D
	dw EventScript_PlayerScheduleHopAndContinue ; 0E
	dw EventScript_PlayerScheduleHopInDirectionAndContinue ; 0F
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
	dw EventScript_PartnerFacePlayerAndContinue ; 1A
	dw EventScript_PartnerFacePlayerAndContinue ; 1B
	dw EventScript_PartnerFaceDirectionAndContinue ; 1C
	dw EventScript_PartnerScheduleHopAndContinue ; 1D
	dw EventScript_FlickerPartnerAndContinue ; 1E
	dw EventScript_InitiateNPCAndContinue ; 1F
	dw EventScript_InitiateNPCAndContinue ; 20
	dw EventScript_InitiateNPCAndContinue ; 21
	dw EventScript_NPCFaceDirectionAndContinue ; 22
	dw EventScript_NPCScheduleWalkAndContinue ; 23
	dw EventScript_NPCRemoveSpriteAndContinue ; 24
	dw EventScript_NPCRemoveSpriteAndContinue ; 25
	dw EventScript_FlickerNPCAndContinue ; 26
	dw EventScript_NPCScheduleHopAndContinue ; 27
	dw EventScript_NPCScheduleHopAndContinue ; 28
	dw EventScript_JumpUsingMultiJumpConditionalAndContinue ; 29
	dw EventScript_PlayerWaitUntilDoneWalkingAndContinue ; 2A
	dw EventScript_JumpUsingMultiJumpConditionalAndContinue ; 2B
	dw EventScript_PartnerScheduleHopInDirectionAndContinue ; 2C
	dw EventScript_JumpUsingMultiJumpConditionalAndContinue ; 2D
	dw EventScript_NPCScheduleHopInDirectionAndContinue ; 2E
	dw EventScript_JumpUsingMultiJumpConditionalAndContinue ; 2F
	dw EventScript_RelativeLongJumpAndContinue ; 30
	dw EventScript_InitiateBattleAndContinue ; 31
	dw EventScript_InitiateBattleAndContinue ; 32
	dw EventScript_InitiateBattleAndContinue ; 33
	dw EventScript_SetFlagAndContinue ; 34
	dw EventScript_ResetFlagAndContinue ; 35
	dw EventScript_IncreaseInventoryAndContinue ; 36
	dw EventScript_DecreaseInventoryAndContinue ; 37
	dw EventScript_JumpIfFlagSetAndContinue ; 38
	dw EventScript_JumpIfFlagUnsetAndContinue ; 39
	dw EventScript_AddChiruAndContinue ; 3A
	dw EventScript_SubtractChiruAndContinue ; 3B
	dw EventScript_PartnerScheduleWalkAndContinue ; 3C
	dw EventScript_NPCFacePlayerAndContinue ; 3D
	dw EventScript_PositionPlayerAndContinue ; 3E
	dw EventScript_PositionPartnerAndContinue ; 3F
	dw EventScript_BeginEarthquakeAndContinue ; 40
	dw EventScript_BeginEarthquakeAndContinue ; 41
	dw EventScript_BeginEarthquakeAndContinue ; 42
	dw EventScript_BeginEarthquakeAndContinue ; 43
	dw EventScript_ScheduleSFXAndContinue ; 44
	dw EventScript_SetMusicAndContinue ; 45
	dw EventScript_JumpOnPlayerDirectionAndContinue ; 46
	dw EventScript_JumpOnPlayerDirectionAndContinue ; 47
	dw EventScript_JumpOnPlayerDirectionAndContinue ; 48
	dw EventScript_JumpOnPlayerDirectionAndContinue ; 49
	dw EventScript_JumpOnPlayerDirectionAndContinue ; 4A
	dw EventScript_JumpOnPlayerWinAndContinue ; 4B
	dw EventScript_NPCRemoveGeneralSpriteAndContinue ; 4C
	dw EventScript_ExecuteCutsceneBehaviourAndContinue ; 4D
	dw EventScript_JumpOnPlayerWinAndContinue ; 4E
	dw EventScript_JumpOnPlayerWinAndContinue ; 4F
	dw EventScript_ShopPriceMessageAndContinue ; 50
	dw EventScript_IncrementComparativeAndContinue ; 51
	dw EventScript_DecrementComparativeAndContinue ; 52
	dw EventScript_SetComparativeAndContinue ; 53
	dw EventScript_JumpIfMatchComparativeAndContinue ; 54
	dw EventScript_JumpIfNotMatchComparativeAndContinue ; 55
	dw EventScript_ShopPriceMessageAndContinue ; 56
	dw EventScript_NPCWaitUntilDoneWalkingAndContinue ; 57
	dw EventScript_PartnerWaitUntilDoneWalkingAndContinue ; 58
	dw EventScript_GetEventDenjuuAndContinue ; 59
	dw EventScript_JumpIfLTEInventoryAndContinue ; 5A
	dw EventScript_DisplayMapLocationAndContinue ; 5B
	dw EventScript_RingRingAndContinue ; 5C
	dw EventScript_StopRingingAndContinue ; 5D
	dw EventScript_SetReceptionAndContinue ; 5E
	dw EventScript_EventNPCSetPaletteRangeAAndContinue ; 5F
	dw EventScript_EventNPCSetPaletteRangeBAndContinue ; 60
	dw EventScript_JumpOnOverworldPartnerSpeciesAndContinue ; 61
	dw EventScript_PlayerScheduleWalkBackwardsAndContinue ; 62
	dw EventScript_NPCScheduleWalkBackwardsAndContinue ; 63
	dw EventScript_NPCFaceAwayFromPlayerAndContinue ; 64
	dw EventScript_EventNPCSetPaletteRangeBAndDontUseItWTFSmilesoftBAndContinue ; 65
	dw EventScript_EventNPCSetPaletteRangeBAndDontUseItWTFSmilesoftAAndContinue ; 66
	dw EventScript_ResetOverworldInterationAndContinue ; 67
	dw EventScript_Mode7WarpPlayerAndContinue ; 68
	dw EventScript_JumpOnSpeciesInContactsAndContinue ; 69
	dw EventScript_PlayCreditsAndContinue ; 6A
	dw EventScript_ChangePhoneStateAndContinue ; 6B
	dw EventScript_EventFlag400R800RAndContinue ; 6C
	dw EventScript_JumpOnSilentModeAndContinue ; 6D
	dw EventScript_JumpIfZukanCompleteAndContinue ; 6E
	dw EventScript_BasicEnd ; 6F
	dw EventScript_BasicEnd ; 70
	dw EventScript_BasicEnd ; 71
	dw EventScript_BasicEnd ; 72
	dw EventScript_BasicEnd ; 73
	dw EventScript_BasicEnd ; 74
	dw EventScript_BasicEnd ; 75
	dw EventScript_BasicEnd ; 76
	dw EventScript_BasicEnd ; 77
	dw EventScript_BasicEnd ; 78
	