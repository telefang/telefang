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
    dw $4263,EventScript_OutputMessageAndContinue,EventScript_OutputMessageAndContinue,$423D,EventScript_WaitXFramesAndContinue,$4254,$4263,$428F ; 00-07
    dw $428F,$428F,$428F,$428F,$4314,$4314,$435E,$438B ; 08-0F
    dw $43C7,$43EE,$43EE,$4406,$4458,$4481,$4499,$449C ; 10-17
    dw $44A9,$44B7,$44D4,$44D4,$450A,$4536,$4596,$45C7 ; 18-1F
    dw $45C7,$45C7,$461B,$4645,$4696,$4696,$46AA,$46ED ; 20-27
    dw $46ED,$473A,$4977,$473A,$4987,$473A,$49B4,$473A ; 28-2F
    dw $474E,$476A,$476A,$476A,$4A66,$4A78,$478B,$47A5 ; 30-37
    dw $4A8A,$4AA8,$47BF,$47D6,$4A46,$4A06,$4AF0,$4ABC ; 38-3F
    dw $47F0,$47F0,$47F0,$47F0,$4802,EventScript_SetMusicAndContinue,$4822,$4822 ; 40-47
    dw $4822,$4822,$4822,$4843,$4B2A,$4B46,$4843,$4843 ; 48-4F
    dw $485A,$4CD9,$4CE7,$4CF5,$4D02,$4D1D,$485A,$4943 ; 50-57
    dw $4962,EventScript_GetEventDenjuuAndContinue,$4E0F,$4E34,$4E70,$4E97,$4EB6,$4ECD ; 58-5F
    dw $4F13,$4F28,$43E4,$4687,$4A32,$4F1A,$4F21,$4F44 ; 60-67
    dw $42D9,$4F54,$4F93,$4FA6,$442F,$4FB3,$4FCA,$4972 ; 68-6F
    dw $4972,$4972,$4972,$4972,$4972,$4972,$4972,$4972 ; 70-77
    dw $4972
	