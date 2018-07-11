; Event Action 00
; Argmap: -
M_ES_StandardEnd_A: MACRO
	db 0
ENDM

; Event Action 01
; Argmap: bb
M_ES_OutputMessage_A: MACRO
	db 1, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 02
; Argmap: bb
M_ES_OutputMessage_B: MACRO
	db 2, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 03
; Argmap: -
M_ES_ClearMessageWindow: MACRO
	db 3
ENDM

; Event Action 04
; Argmap: b
M_ES_WaitXFrames: MACRO
	db 4, (\1) & $FF
ENDM

; Event Action 05
; Argmap: -
M_ES_WaitForButtonPress: MACRO
	db 5
ENDM

; Event Action 06
; Argmap: -
M_ES_StandardEnd_B: MACRO
	db 6
ENDM

; Event Action 07
; Argmap: bbb
M_ES_WarpPlayer_A: MACRO
	db 7, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 08
; Argmap: bbb
M_ES_WarpPlayer_B: MACRO
	db 8, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 09
; Argmap: bbb
M_ES_WarpPlayer_C: MACRO
	db 9, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 0A
; Argmap: bbb
M_ES_WarpPlayer_D: MACRO
	db $A, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 0B
; Argmap: bbb
M_ES_WarpPlayer_E: MACRO
	db $B, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 0C
; Argmap: b
M_ES_PlayerFaceDirection_A: MACRO
	db $C, (\1) & $FF
ENDM

; Event Action 0D
; Argmap: b
M_ES_PlayerFaceDirection_B: MACRO
	db $D, (\1) & $FF
ENDM

; Event Action 0E
; Argmap: -
M_ES_PlayerScheduleHop: MACRO
	db $E
ENDM

; Event Action 0F
; Argmap: b
M_ES_PlayerScheduleHopInDirection: MACRO
	db $F, (\1) & $FF
ENDM

; Event Action 10
; Argmap: nnb
M_ES_PlayerScheduleWalk: MACRO
	db $10, (((\1) & $0F) * $10) + ((\2) & $0F), (\3) & $FF
ENDM

; Event Action 11
; Argmap: w
M_ES_EventFlag800S_A: MACRO
	db $11, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 12
; Argmap: w
M_ES_EventFlag800S_B: MACRO
	db $12, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 13
; Argmap: w
M_ES_EventFlag400S800R: MACRO
	db $13, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 14
; Argmap: -
M_ES_CurrentEventFlag400S800R: MACRO
	db $14
ENDM

; Event Action 15
; Argmap: -
M_ES_CurrentEventFlag800R: MACRO
	db $15
ENDM

; Event Action 16
; Argmap: w
M_ES_EffectiveEventFlag400S800R: MACRO
	db $16, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 17
; Argmap: b
M_ES_SetMultiJumpConditional: MACRO
	db $17, (\1) & $FF
ENDM

; Event Action 18
; Argmap: -
M_ES_IncrementMultiJumpConditional: MACRO
	db $18
ENDM

; Event Action 19
; Argmap: w
M_ES_FuckingWeirdSequenceJump: MACRO
	db $19, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 1A
; Argmap: -
M_ES_PartnerFacePlayer_A: MACRO
	db $1A
ENDM

; Event Action 1B
; Argmap: -
M_ES_PartnerFacePlayer_B: MACRO
	db $1B
ENDM

; Event Action 1C
; Argmap: b
M_ES_PartnerFaceDirection: MACRO
	db $1C, (\1) & $FF
ENDM

; Event Action 1D
; Argmap: -
M_ES_PartnerScheduleHop: MACRO
	db $1D
ENDM

; Event Action 1E
; Argmap: b
M_ES_FlickerPartner: MACRO
	db $1E, (\1) & $FF
ENDM

; Event Action 1F
; Argmap: bbnn
M_ES_InitiateNPC_A: MACRO
	db $1F, (\1) & $FF, (\2) & $FF, (((\3) & $0F) * $10) + ((\4) & $0F)
ENDM

; Event Action 20
; Argmap: bbnn
M_ES_InitiateNPC_B: MACRO
	db $20, (\1) & $FF, (\2) & $FF, (((\3) & $0F) * $10) + ((\4) & $0F)
ENDM

; Event Action 21
; Argmap: bbnn
M_ES_InitiateNPC_C: MACRO
	db $21, (\1) & $FF, (\2) & $FF, (((\3) & $0F) * $10) + ((\4) & $0F)
ENDM

; Event Action 22
; Argmap: bb
M_ES_NPCFaceDirection: MACRO
	db $22, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 23
; Argmap: bnnb
M_ES_NPCScheduleWalk: MACRO
	db $23, (\1) & $FF, (((\2) & $0F) * $10) + ((\3) & $0F), (\4) & $FF
ENDM

; Event Action 24
; Argmap: b
M_ES_NPCRemoveSprite_A: MACRO
	db $24, (\1) & $FF
ENDM

; Event Action 25
; Argmap: b
M_ES_NPCRemoveSprite_B: MACRO
	db $25, (\1) & $FF
ENDM

; Event Action 26
; Argmap: bb
M_ES_FlickerNPC: MACRO
	db $26, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 27
; Argmap: b
M_ES_NPCScheduleHop_A: MACRO
	db $27, (\1) & $FF
ENDM

; Event Action 28
; Argmap: b
M_ES_NPCScheduleHop_B: MACRO
	db $28, (\1) & $FF
ENDM

; Event Action 29
; Argmap: w
M_ES_JumpUsingMultiJumpConditional_1P_A: MACRO
	db $29
.ea29P1JumpOrigin\@
	db ((\1)-(.ea29P1JumpOrigin\@)) & $FF
ENDM
; Argmap: ww
M_ES_JumpUsingMultiJumpConditional_2P_A: MACRO
	db $29
.ea29P2JumpOrigin\@
	db ((\1)-(.ea29P2JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P2JumpOrigin\@)) & $FF
ENDM
; Argmap: www
M_ES_JumpUsingMultiJumpConditional_3P_A: MACRO
	db $29
.ea29P3JumpOrigin\@
	db ((\1)-(.ea29P3JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P3JumpOrigin\@)) & $FF
	db ((\3)-(.ea29P3JumpOrigin\@)) & $FF
ENDM
; Argmap: wwww
M_ES_JumpUsingMultiJumpConditional_4P_A: MACRO
	db $29
.ea29P4JumpOrigin\@
	db ((\1)-(.ea29P4JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P4JumpOrigin\@)) & $FF
	db ((\3)-(.ea29P4JumpOrigin\@)) & $FF
	db ((\4)-(.ea29P4JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwww
M_ES_JumpUsingMultiJumpConditional_5P_A: MACRO
	db $29
.ea29P5JumpOrigin\@
	db ((\1)-(.ea29P5JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P5JumpOrigin\@)) & $FF
	db ((\3)-(.ea29P5JumpOrigin\@)) & $FF
	db ((\4)-(.ea29P5JumpOrigin\@)) & $FF
	db ((\5)-(.ea29P5JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwww
M_ES_JumpUsingMultiJumpConditional_6P_A: MACRO
	db $29
.ea29P6JumpOrigin\@
	db ((\1)-(.ea29P6JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P6JumpOrigin\@)) & $FF
	db ((\3)-(.ea29P6JumpOrigin\@)) & $FF
	db ((\4)-(.ea29P6JumpOrigin\@)) & $FF
	db ((\5)-(.ea29P6JumpOrigin\@)) & $FF
	db ((\6)-(.ea29P6JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwwww
M_ES_JumpUsingMultiJumpConditional_7P_A: MACRO
	db $29
.ea29P7JumpOrigin\@
	db ((\1)-(.ea29P7JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P7JumpOrigin\@)) & $FF
	db ((\3)-(.ea29P7JumpOrigin\@)) & $FF
	db ((\4)-(.ea29P7JumpOrigin\@)) & $FF
	db ((\5)-(.ea29P7JumpOrigin\@)) & $FF
	db ((\6)-(.ea29P7JumpOrigin\@)) & $FF
	db ((\7)-(.ea29P7JumpOrigin\@)) & $FF
ENDM

; Event Action 2A
; Argmap: -
M_ES_PlayerWaitUntilDoneWalking: MACRO
	db $2A
ENDM

; Event Action 2B
; Argmap: w
M_ES_JumpUsingMultiJumpConditional_1P_B: MACRO
	db $2B
.ea2BP1JumpOrigin\@
	db ((\1)-(.ea2BP1JumpOrigin\@)) & $FF
ENDM
; Argmap: ww
M_ES_JumpUsingMultiJumpConditional_2P_B: MACRO
	db $2B
.ea2BP2JumpOrigin\@
	db ((\1)-(.ea2BP2JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP2JumpOrigin\@)) & $FF
ENDM
; Argmap: www
M_ES_JumpUsingMultiJumpConditional_3P_B: MACRO
	db $2B
.ea2BP3JumpOrigin\@
	db ((\1)-(.ea2BP3JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP3JumpOrigin\@)) & $FF
	db ((\3)-(.ea2BP3JumpOrigin\@)) & $FF
ENDM
; Argmap: wwww
M_ES_JumpUsingMultiJumpConditional_4P_B: MACRO
	db $2B
.ea2BP4JumpOrigin\@
	db ((\1)-(.ea2BP4JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP4JumpOrigin\@)) & $FF
	db ((\3)-(.ea2BP4JumpOrigin\@)) & $FF
	db ((\4)-(.ea2BP4JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwww
M_ES_JumpUsingMultiJumpConditional_5P_B: MACRO
	db $2B
.ea2BP5JumpOrigin\@
	db ((\1)-(.ea2BP5JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP5JumpOrigin\@)) & $FF
	db ((\3)-(.ea2BP5JumpOrigin\@)) & $FF
	db ((\4)-(.ea2BP5JumpOrigin\@)) & $FF
	db ((\5)-(.ea2BP5JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwww
M_ES_JumpUsingMultiJumpConditional_6P_B: MACRO
	db $2B
.ea2BP6JumpOrigin\@
	db ((\1)-(.ea2BP6JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP6JumpOrigin\@)) & $FF
	db ((\3)-(.ea2BP6JumpOrigin\@)) & $FF
	db ((\4)-(.ea2BP6JumpOrigin\@)) & $FF
	db ((\5)-(.ea2BP6JumpOrigin\@)) & $FF
	db ((\6)-(.ea2BP6JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwwww
M_ES_JumpUsingMultiJumpConditional_7P_B: MACRO
	db $2B
.ea2BP7JumpOrigin\@
	db ((\1)-(.ea2BP7JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP7JumpOrigin\@)) & $FF
	db ((\3)-(.ea2BP7JumpOrigin\@)) & $FF
	db ((\4)-(.ea2BP7JumpOrigin\@)) & $FF
	db ((\5)-(.ea2BP7JumpOrigin\@)) & $FF
	db ((\6)-(.ea2BP7JumpOrigin\@)) & $FF
	db ((\7)-(.ea2BP7JumpOrigin\@)) & $FF
ENDM

; Event Action 2C
; Argmap: b
M_ES_PartnerScheduleHopInDirection: MACRO
	db $2C, (\1) & $FF 
ENDM

; Event Action 2D
; Argmap: w
M_ES_JumpUsingMultiJumpConditional_1P_C: MACRO
	db $2D
.ea2DP1JumpOrigin\@
	db ((\1)-(.ea2DP1JumpOrigin\@)) & $FF
ENDM
; Argmap: ww
M_ES_JumpUsingMultiJumpConditional_2P_C: MACRO
	db $2D
.ea2DP2JumpOrigin\@
	db ((\1)-(.ea2DP2JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP2JumpOrigin\@)) & $FF
ENDM
; Argmap: www
M_ES_JumpUsingMultiJumpConditional_3P_C: MACRO
	db $2D
.ea2DP3JumpOrigin\@
	db ((\1)-(.ea2DP3JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP3JumpOrigin\@)) & $FF
	db ((\3)-(.ea2DP3JumpOrigin\@)) & $FF
ENDM
; Argmap: wwww
M_ES_JumpUsingMultiJumpConditional_4P_C: MACRO
	db $2D
.ea2DP4JumpOrigin\@
	db ((\1)-(.ea2DP4JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP4JumpOrigin\@)) & $FF
	db ((\3)-(.ea2DP4JumpOrigin\@)) & $FF
	db ((\4)-(.ea2DP4JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwww
M_ES_JumpUsingMultiJumpConditional_5P_C: MACRO
	db $2D
.ea2DP5JumpOrigin\@
	db ((\1)-(.ea2DP5JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP5JumpOrigin\@)) & $FF
	db ((\3)-(.ea2DP5JumpOrigin\@)) & $FF
	db ((\4)-(.ea2DP5JumpOrigin\@)) & $FF
	db ((\5)-(.ea2DP5JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwww
M_ES_JumpUsingMultiJumpConditional_6P_C: MACRO
	db $2D
.ea2DP6JumpOrigin\@
	db ((\1)-(.ea2DP6JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP6JumpOrigin\@)) & $FF
	db ((\3)-(.ea2DP6JumpOrigin\@)) & $FF
	db ((\4)-(.ea2DP6JumpOrigin\@)) & $FF
	db ((\5)-(.ea2DP6JumpOrigin\@)) & $FF
	db ((\6)-(.ea2DP6JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwwww
M_ES_JumpUsingMultiJumpConditional_7P_C: MACRO
	db $2D
.ea2DP7JumpOrigin\@
	db ((\1)-(.ea2DP7JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP7JumpOrigin\@)) & $FF
	db ((\3)-(.ea2DP7JumpOrigin\@)) & $FF
	db ((\4)-(.ea2DP7JumpOrigin\@)) & $FF
	db ((\5)-(.ea2DP7JumpOrigin\@)) & $FF
	db ((\6)-(.ea2DP7JumpOrigin\@)) & $FF
	db ((\7)-(.ea2DP7JumpOrigin\@)) & $FF
ENDM

; Event Action 2E
M_ES_NPCScheduleHopInDirection: MACRO
	db $2E, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 2F
; Argmap: w
M_ES_JumpUsingMultiJumpConditional_1P_D: MACRO
	db $2F
.ea2FP1JumpOrigin\@
	db ((\1)-(.ea2FP1JumpOrigin\@)) & $FF
ENDM
; Argmap: ww
M_ES_JumpUsingMultiJumpConditional_2P_D: MACRO
	db $2F
.ea2FP2JumpOrigin\@
	db ((\1)-(.ea2FP2JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP2JumpOrigin\@)) & $FF
ENDM
; Argmap: www
M_ES_JumpUsingMultiJumpConditional_3P_D: MACRO
	db $2F
.ea2FP3JumpOrigin\@
	db ((\1)-(.ea2FP3JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP3JumpOrigin\@)) & $FF
	db ((\3)-(.ea2FP3JumpOrigin\@)) & $FF
ENDM
; Argmap: wwww
M_ES_JumpUsingMultiJumpConditional_4P_D: MACRO
	db $2F
.ea2FP4JumpOrigin\@
	db ((\1)-(.ea2FP4JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP4JumpOrigin\@)) & $FF
	db ((\3)-(.ea2FP4JumpOrigin\@)) & $FF
	db ((\4)-(.ea2FP4JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwww
M_ES_JumpUsingMultiJumpConditional_5P_D: MACRO
	db $2F
.ea2FP5JumpOrigin\@
	db ((\1)-(.ea2FP5JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP5JumpOrigin\@)) & $FF
	db ((\3)-(.ea2FP5JumpOrigin\@)) & $FF
	db ((\4)-(.ea2FP5JumpOrigin\@)) & $FF
	db ((\5)-(.ea2FP5JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwww
M_ES_JumpUsingMultiJumpConditional_6P_D: MACRO
	db $2F
.ea2FP6JumpOrigin\@
	db ((\1)-(.ea2FP6JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP6JumpOrigin\@)) & $FF
	db ((\3)-(.ea2FP6JumpOrigin\@)) & $FF
	db ((\4)-(.ea2FP6JumpOrigin\@)) & $FF
	db ((\5)-(.ea2FP6JumpOrigin\@)) & $FF
	db ((\6)-(.ea2FP6JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwwww
M_ES_JumpUsingMultiJumpConditional_7P_D: MACRO
	db $2F
.ea2FP7JumpOrigin\@
	db ((\1)-(.ea2FP7JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP7JumpOrigin\@)) & $FF
	db ((\3)-(.ea2FP7JumpOrigin\@)) & $FF
	db ((\4)-(.ea2FP7JumpOrigin\@)) & $FF
	db ((\5)-(.ea2FP7JumpOrigin\@)) & $FF
	db ((\6)-(.ea2FP7JumpOrigin\@)) & $FF
	db ((\7)-(.ea2FP7JumpOrigin\@)) & $FF
ENDM

; Event Action 30
; Argmap: w
M_ES_RelativeLongJump: MACRO
	db $30
.ea30JumpOrigin\@
	db (((\1)-(.ea30JumpOrigin\@)) >> 8) & $FF
	db ((\1)-(.ea30JumpOrigin\@)) & $FF
ENDM

; Event Action 31
; Argmap: bbb
M_ES_InitiateBattle_A: MACRO
	db $31, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 32
; Argmap: bbb
M_ES_InitiateBattle_B: MACRO
	db $32, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 33
; Argmap: bbb
M_ES_InitiateBattle_C: MACRO
	db $33, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 34
; Argmap: w
M_ES_SetFlag: MACRO
	db $34, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 35
; Argmap: w
M_ES_ResetFlag: MACRO
	db $35, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 36
; Argmap: bb
M_ES_IncreaseInventory: MACRO
	db $36, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 37
; Argmap: bb
M_ES_DecreaseInventory: MACRO
	db $37, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 38
; Argmap: ww
M_ES_JumpIfFlagSet: MACRO
	db $38
.ea38JumpOrigin\@
	db ((\1) >> 8) & $FF, (\1) & $FF
	db ((\2)-(.ea38JumpOrigin\@)) & $FF
ENDM

; Event Action 39
; Argmap: ww
M_ES_JumpIfFlagUnset: MACRO
	db $39
.ea39JumpOrigin\@
	db ((\1) >> 8) & $FF, (\1) & $FF
	db ((\2)-(.ea39JumpOrigin\@)) & $FF
ENDM

; Event Action 3A
; Argmap: w
M_ES_AddChiru: MACRO
	db $3A
	; Unlike with many other event actions this argument is little-endian.
	dw (\1) & $FFFF
ENDM

; Event Action 3B
; Argmap: w
M_ES_SubtractChiru: MACRO
	db $3B
	; Unlike with many other event actions this argument is little-endian.
	dw (\1) & $FFFF
ENDM

; Event Action 3C
; Argmap: nnb
M_ES_PartnerScheduleWalk: MACRO
	db $3C, (((\1) & $0F) * $10) + ((\2) & $0F), (\3) & $FF
ENDM

; Event Action 3D
; Argmap: b
M_ES_NPCFacePlayer: MACRO
	db $3D, (\1) & $FF
ENDM

; Event Action 3E
; Argmap: nn
M_ES_PositionPlayer: MACRO
	db $3E, (((\1) & $0F) * $10) + ((\2) & $0F)
ENDM

; Event Action 3F
; Argmap: nn
M_ES_PositionPartner: MACRO
	db $3F, (((\1) & $0F) * $10) + ((\2) & $0F)
ENDM

; Event Action 40
; Argmap: bb
M_ES_BeginEarthquake_A: MACRO
	db $40, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 41
; Argmap: bb
M_ES_BeginEarthquake_B: MACRO
	db $41, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 42
; Argmap: bb
M_ES_BeginEarthquake_C: MACRO
	db $42, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 43
; Argmap: bb
M_ES_BeginEarthquake_D: MACRO
	db $43, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 44
; Argmap: b
M_ES_ScheduleSFX: MACRO
	db $44, (\1) & $FF
ENDM

; Event Action 45
; Argmap: b
M_ES_SetMusic: MACRO
	db $45, (\1) & $FF
ENDM

; Event Action 46
; Argmap: bw
M_ES_JumpOnPlayerDirection_A: MACRO
	db $46
.ea46JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea46JumpOrigin\@)) & $FF
ENDM

; Event Action 47
; Argmap: bw
M_ES_JumpOnPlayerDirection_B: MACRO
	db $47
.ea47JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea47JumpOrigin\@)) & $FF
ENDM

; Event Action 48
; Argmap: bw
M_ES_JumpOnPlayerDirection_C: MACRO
	db $48
.ea48JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea48JumpOrigin\@)) & $FF
ENDM

; Event Action 49
; Argmap: bw
M_ES_JumpOnPlayerDirection_D: MACRO
	db $49
.ea49JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea49JumpOrigin\@)) & $FF
ENDM

; Event Action 4A
; Argmap: bw
M_ES_JumpOnPlayerDirection_E: MACRO
	db $4A
.ea4AJumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea4AJumpOrigin\@)) & $FF
ENDM

; Event Action 4B
; Argmap: w
M_ES_JumpOnPlayerWin_A: MACRO
	db $4B
.ea4BJumpOrigin\@
	db ((\1)-(.ea4BJumpOrigin\@)) & $FF
ENDM

; Event Action 4C
; Argmap: b
M_ES_NPCRemoveGeneralSprite: MACRO
	db $4C, (\1) & $FF
ENDM

; Event Action 4D
; Argmap: b
M_ES_ExecuteCutsceneBehaviour: MACRO
	db $4D, (\1) & $FF
ENDM

; Event Action 4E
; Argmap: w
M_ES_JumpOnPlayerWin_B: MACRO
	db $4E
.ea4EJumpOrigin\@
	db ((\1)-(.ea4EJumpOrigin\@)) & $FF
ENDM

; Event Action 4F
; Argmap: w
M_ES_JumpOnPlayerWin_C: MACRO
	db $4F
.ea4FJumpOrigin\@
	db ((\1)-(.ea4FJumpOrigin\@)) & $FF
ENDM

; Event Action 50
; Argmap: bb
M_ES_ShopPriceMessage_A: MACRO
	db $50, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 51
; Argmap: -
M_ES_IncrementComparative: MACRO
	db $51
ENDM

; Event Action 52
; Argmap: -
M_ES_DecrementComparative: MACRO
	db $52
ENDM

; Event Action 53
; Argmap: b
M_ES_SetComparative: MACRO
	db $53, (\1) & $FF
ENDM

; Event Action 54
; Argmap: bw
M_ES_JumpIfMatchComparative: MACRO
	db $54
.ea54JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea54JumpOrigin\@)) & $FF
ENDM

; Event Action 55
; Argmap: bw
M_ES_JumpIfNotMatchComparative: MACRO
	db $55
.ea55JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea55JumpOrigin\@)) & $FF
ENDM

; Event Action 56
; Argmap: bb
M_ES_ShopPriceMessage_B: MACRO
	db $56, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 57
; Argmap: b
M_ES_NPCWaitUntilDoneWalking: MACRO
	db $57, (\1) & $FF
ENDM

; Event Action 58
; Argmap: -
M_ES_PartnerWaitUntilDoneWalking: MACRO
	db $58
ENDM

; Event Action 59
; Argmap: bbbbb
M_ES_GetEventDenjuu: MACRO
	db $59, (\1) & $FF, (\2) & $FF, (\3) & $FF, (\4) & $FF, (\5) & $FF
ENDM

; Event Action 5A
; Argmap: bbw
M_ES_JumpIfLTEInventory: MACRO
	db $5A
.ea5AJumpOrigin\@
	db (\1) & $FF, (\2) & $FF
	db ((\3)-(.ea5AJumpOrigin\@)) & $FF
ENDM

; Event Action 5B
; Argmap: -
M_ES_DisplayMapLocation: MACRO
	db $5B
ENDM

; Event Action 5C
; Argmap: b
M_ES_RingRing: MACRO
	db $5C
	; This is rather bizarre. This event action has 1 parameter, but there is no indication that it is ever used.
	db (\1) & $FF
ENDM

; Event Action 5D
; Argmap: -
M_ES_StopRinging: MACRO
	db $5D
ENDM

; Event Action 5E
; Argmap: b
M_ES_SetReception: MACRO
	db $5E, (\1) & $FF
ENDM

; Event Action 5F
; Argmap: b
M_ES_EventNPCSetPaletteRangeA: MACRO
	db $5F, (\1) & $FF
ENDM

; Event Action 60
; Argmap: b
M_ES_EventNPCSetPaletteRangeB: MACRO
	db $60, (\1) & $FF
ENDM

; Event Action 61
; Argmap: bw
M_ES_JumpOnOverworldPartnerSpecies: MACRO
	db $61
.ea61JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea61JumpOrigin\@)) & $FF
ENDM

; Event Action 62
; Argmap: nnb
M_ES_PlayerScheduleWalkBackwards: MACRO
	db $62, (((\1) & $0F) * $10) + ((\2) & $0F), (\3) & $FF
ENDM

; Event Action 63
; Argmap: bnnb
M_ES_NPCScheduleWalkBackwards: MACRO
	db $63, (\1) & $FF, (((\2) & $0F) * $10) + ((\3) & $0F), (\4) & $FF
ENDM

; Event Action 64
; Argmap: b
M_ES_NPCFaceAwayFromPlayer: MACRO
	db $64, (\1) & $FF
ENDM

; Event Action 65
; Argmap: b
M_ES_EventNPCSetPaletteRangeBAndDontUseItWTFSmilesoftB: MACRO
	db $65, (\1) & $FF
ENDM

; Event Action 66
; Argmap: b
M_ES_EventNPCSetPaletteRangeBAndDontUseItWTFSmilesoftA: MACRO
	db $66, (\1) & $FF
ENDM

; Event Action 67
; Argmap: -
M_ES_ResetOverworldInteration: MACRO
	db $67
ENDM

; Event Action 68
; Argmap: bbb
M_ES_Mode7WarpPlayer: MACRO
	db $68, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 69
; Argmap: bw
M_ES_JumpOnSpeciesInContacts: MACRO
	db $69
.ea69JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea69JumpOrigin\@)) & $FF
ENDM

; Event Action 6A
; Argmap: -
M_ES_PlayCredits: MACRO
	db $6A
ENDM

; Event Action 6B
; Argmap: b
M_ES_ChangePhoneState: MACRO
	db $6B, (\1) & $FF
ENDM

; Event Action 6C
; Argmap: w
M_ES_EventFlag400R800R: MACRO
	db $6C, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 6D
; Argmap: w
M_ES_JumpOnSilentMode: MACRO
	db $6D
.ea6DJumpOrigin\@
	db ((\1)-(.ea6DJumpOrigin\@)) & $FF
ENDM

; Event Action 6E
; Argmap: w
M_ES_JumpIfZukanComplete: MACRO
	db $6E
.ea6EJumpOrigin\@
	db ((\1)-(.ea6EJumpOrigin\@)) & $FF
ENDM

; Event Action 6F
; Argmap: -
M_ES_BasicEnd_A: MACRO
	db $6F
ENDM

; Event Action 70
; Argmap: -
M_ES_BasicEnd_B: MACRO
	db $70
ENDM

; Event Action 71
; Argmap: -
M_ES_BasicEnd_C: MACRO
	db $71
ENDM

; Event Action 72
; Argmap: -
M_ES_BasicEnd_D: MACRO
	db $72
ENDM

; Event Action 73
; Argmap: -
M_ES_BasicEnd_E: MACRO
	db $73
ENDM

; Event Action 74
; Argmap: -
M_ES_BasicEnd_F: MACRO
	db $74
ENDM

; Event Action 75
; Argmap: -
M_ES_BasicEnd_G: MACRO
	db $75
ENDM

; Event Action 76
; Argmap: -
M_ES_BasicEnd_H: MACRO
	db $76
ENDM

; Event Action 77
; Argmap: -
M_ES_BasicEnd_I: MACRO
	db $77
ENDM

; Event Action 78
; Argmap: -
M_ES_BasicEnd_J: MACRO
	db $78
ENDM
