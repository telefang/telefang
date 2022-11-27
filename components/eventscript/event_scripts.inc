; Event Action 00
; Argmap: -
MACRO M_ES_StandardEnd_A
	db 0
ENDM

; Event Action 01
; Argmap: bb
MACRO M_ES_OutputMessage_A
	db 1, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 02
; Argmap: bb
MACRO M_ES_OutputMessage_B
	db 2, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 03
; Argmap: -
MACRO M_ES_ClearMessageWindow
	db 3
ENDM

; Event Action 04
; Argmap: b
MACRO M_ES_WaitXFrames
	db 4, (\1) & $FF
ENDM

; Event Action 05
; Argmap: -
MACRO M_ES_WaitForButtonPress
	db 5
ENDM

; Event Action 06
; Argmap: -
MACRO M_ES_StandardEnd_B
	db 6
ENDM

; Event Action 07
; Argmap: bbb
MACRO M_ES_WarpPlayer_A
	db 7, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 08
; Argmap: bbb
MACRO M_ES_WarpPlayer_B
	db 8, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 09
; Argmap: bbb
MACRO M_ES_WarpPlayer_C
	db 9, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 0A
; Argmap: bbb
MACRO M_ES_WarpPlayer_D
	db $A, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 0B
; Argmap: bbb
MACRO M_ES_WarpPlayer_E
	db $B, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 0C
; Argmap: b
MACRO M_ES_PlayerFaceDirection_A
	db $C, (\1) & $FF
ENDM

; Event Action 0D
; Argmap: b
MACRO M_ES_PlayerFaceDirection_B
	db $D, (\1) & $FF
ENDM

; Event Action 0E
; Argmap: -
MACRO M_ES_PlayerScheduleHop
	db $E
ENDM

; Event Action 0F
; Argmap: b
MACRO M_ES_PlayerScheduleHopInDirection
	db $F, (\1) & $FF
ENDM

; Event Action 10
; Argmap: nnb
MACRO M_ES_PlayerScheduleWalk
	db $10, (((\1) & $0F) * $10) + ((\2) & $0F), (\3) & $FF
ENDM

; Event Action 11
; Argmap: w
MACRO M_ES_EventFlag800S_A
	db $11, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 12
; Argmap: w
MACRO M_ES_EventFlag800S_B
	db $12, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 13
; Argmap: w
MACRO M_ES_EventFlag400S800R
	db $13, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 14
; Argmap: -
MACRO M_ES_CurrentEventFlag400S800R
	db $14
ENDM

; Event Action 15
; Argmap: -
MACRO M_ES_CurrentEventFlag800R
	db $15
ENDM

; Event Action 16
; Argmap: w
MACRO M_ES_EffectiveEventFlag400S800R
	db $16, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 17
; Argmap: b
MACRO M_ES_SetMultiJumpConditional
	db $17, (\1) & $FF
ENDM

; Event Action 18
; Argmap: -
MACRO M_ES_IncrementMultiJumpConditional
	db $18
ENDM

; Event Action 19
; Argmap: w
MACRO M_ES_FuckingWeirdSequenceJump
	db $19, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 1A
; Argmap: -
MACRO M_ES_PartnerFacePlayer_A
	db $1A
ENDM

; Event Action 1B
; Argmap: -
MACRO M_ES_PartnerFacePlayer_B
	db $1B
ENDM

; Event Action 1C
; Argmap: b
MACRO M_ES_PartnerFaceDirection
	db $1C, (\1) & $FF
ENDM

; Event Action 1D
; Argmap: -
MACRO M_ES_PartnerScheduleHop
	db $1D
ENDM

; Event Action 1E
; Argmap: b
MACRO M_ES_FlickerPartner
	db $1E, (\1) & $FF
ENDM

; Event Action 1F
; Argmap: bbnn
MACRO M_ES_InitiateNPC_A
	db $1F, (\1) & $FF, (\2) & $FF, (((\3) & $0F) * $10) + ((\4) & $0F)
ENDM

; Event Action 20
; Argmap: bbnn
MACRO M_ES_InitiateNPC_B
	db $20, (\1) & $FF, (\2) & $FF, (((\3) & $0F) * $10) + ((\4) & $0F)
ENDM

; Event Action 21
; Argmap: bbnn
MACRO M_ES_InitiateNPC_C
	db $21, (\1) & $FF, (\2) & $FF, (((\3) & $0F) * $10) + ((\4) & $0F)
ENDM

; Event Action 22
; Argmap: bb
MACRO M_ES_NPCFaceDirection
	db $22, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 23
; Argmap: bnnb
MACRO M_ES_NPCScheduleWalk
	db $23, (\1) & $FF, (((\2) & $0F) * $10) + ((\3) & $0F), (\4) & $FF
ENDM

; Event Action 24
; Argmap: b
MACRO M_ES_NPCRemoveSprite_A
	db $24, (\1) & $FF
ENDM

; Event Action 25
; Argmap: b
MACRO M_ES_NPCRemoveSprite_B
	db $25, (\1) & $FF
ENDM

; Event Action 26
; Argmap: bb
MACRO M_ES_FlickerNPC
	db $26, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 27
; Argmap: b
MACRO M_ES_NPCScheduleHop_A
	db $27, (\1) & $FF
ENDM

; Event Action 28
; Argmap: b
MACRO M_ES_NPCScheduleHop_B
	db $28, (\1) & $FF
ENDM

; Event Action 29
; Argmap: w
MACRO M_ES_JumpUsingMultiJumpConditional_1P_A
	db $29
.ea29P1JumpOrigin\@
	db ((\1)-(.ea29P1JumpOrigin\@)) & $FF
ENDM
; Argmap: ww
MACRO M_ES_JumpUsingMultiJumpConditional_2P_A
	db $29
.ea29P2JumpOrigin\@
	db ((\1)-(.ea29P2JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P2JumpOrigin\@)) & $FF
ENDM
; Argmap: www
MACRO M_ES_JumpUsingMultiJumpConditional_3P_A
	db $29
.ea29P3JumpOrigin\@
	db ((\1)-(.ea29P3JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P3JumpOrigin\@)) & $FF
	db ((\3)-(.ea29P3JumpOrigin\@)) & $FF
ENDM
; Argmap: wwww
MACRO M_ES_JumpUsingMultiJumpConditional_4P_A
	db $29
.ea29P4JumpOrigin\@
	db ((\1)-(.ea29P4JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P4JumpOrigin\@)) & $FF
	db ((\3)-(.ea29P4JumpOrigin\@)) & $FF
	db ((\4)-(.ea29P4JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwww
MACRO M_ES_JumpUsingMultiJumpConditional_5P_A
	db $29
.ea29P5JumpOrigin\@
	db ((\1)-(.ea29P5JumpOrigin\@)) & $FF
	db ((\2)-(.ea29P5JumpOrigin\@)) & $FF
	db ((\3)-(.ea29P5JumpOrigin\@)) & $FF
	db ((\4)-(.ea29P5JumpOrigin\@)) & $FF
	db ((\5)-(.ea29P5JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwww
MACRO M_ES_JumpUsingMultiJumpConditional_6P_A
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
MACRO M_ES_JumpUsingMultiJumpConditional_7P_A
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
MACRO M_ES_PlayerWaitUntilDoneWalking
	db $2A
ENDM

; Event Action 2B
; Argmap: w
MACRO M_ES_JumpUsingMultiJumpConditional_1P_B
	db $2B
.ea2BP1JumpOrigin\@
	db ((\1)-(.ea2BP1JumpOrigin\@)) & $FF
ENDM
; Argmap: ww
MACRO M_ES_JumpUsingMultiJumpConditional_2P_B
	db $2B
.ea2BP2JumpOrigin\@
	db ((\1)-(.ea2BP2JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP2JumpOrigin\@)) & $FF
ENDM
; Argmap: www
MACRO M_ES_JumpUsingMultiJumpConditional_3P_B
	db $2B
.ea2BP3JumpOrigin\@
	db ((\1)-(.ea2BP3JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP3JumpOrigin\@)) & $FF
	db ((\3)-(.ea2BP3JumpOrigin\@)) & $FF
ENDM
; Argmap: wwww
MACRO M_ES_JumpUsingMultiJumpConditional_4P_B
	db $2B
.ea2BP4JumpOrigin\@
	db ((\1)-(.ea2BP4JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP4JumpOrigin\@)) & $FF
	db ((\3)-(.ea2BP4JumpOrigin\@)) & $FF
	db ((\4)-(.ea2BP4JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwww
MACRO M_ES_JumpUsingMultiJumpConditional_5P_B
	db $2B
.ea2BP5JumpOrigin\@
	db ((\1)-(.ea2BP5JumpOrigin\@)) & $FF
	db ((\2)-(.ea2BP5JumpOrigin\@)) & $FF
	db ((\3)-(.ea2BP5JumpOrigin\@)) & $FF
	db ((\4)-(.ea2BP5JumpOrigin\@)) & $FF
	db ((\5)-(.ea2BP5JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwww
MACRO M_ES_JumpUsingMultiJumpConditional_6P_B
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
MACRO M_ES_JumpUsingMultiJumpConditional_7P_B
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
MACRO M_ES_PartnerScheduleHopInDirection
	db $2C, (\1) & $FF 
ENDM

; Event Action 2D
; Argmap: w
MACRO M_ES_JumpUsingMultiJumpConditional_1P_C
	db $2D
.ea2DP1JumpOrigin\@
	db ((\1)-(.ea2DP1JumpOrigin\@)) & $FF
ENDM
; Argmap: ww
MACRO M_ES_JumpUsingMultiJumpConditional_2P_C
	db $2D
.ea2DP2JumpOrigin\@
	db ((\1)-(.ea2DP2JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP2JumpOrigin\@)) & $FF
ENDM
; Argmap: www
MACRO M_ES_JumpUsingMultiJumpConditional_3P_C
	db $2D
.ea2DP3JumpOrigin\@
	db ((\1)-(.ea2DP3JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP3JumpOrigin\@)) & $FF
	db ((\3)-(.ea2DP3JumpOrigin\@)) & $FF
ENDM
; Argmap: wwww
MACRO M_ES_JumpUsingMultiJumpConditional_4P_C
	db $2D
.ea2DP4JumpOrigin\@
	db ((\1)-(.ea2DP4JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP4JumpOrigin\@)) & $FF
	db ((\3)-(.ea2DP4JumpOrigin\@)) & $FF
	db ((\4)-(.ea2DP4JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwww
MACRO M_ES_JumpUsingMultiJumpConditional_5P_C
	db $2D
.ea2DP5JumpOrigin\@
	db ((\1)-(.ea2DP5JumpOrigin\@)) & $FF
	db ((\2)-(.ea2DP5JumpOrigin\@)) & $FF
	db ((\3)-(.ea2DP5JumpOrigin\@)) & $FF
	db ((\4)-(.ea2DP5JumpOrigin\@)) & $FF
	db ((\5)-(.ea2DP5JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwww
MACRO M_ES_JumpUsingMultiJumpConditional_6P_C
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
MACRO M_ES_JumpUsingMultiJumpConditional_7P_C
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
MACRO M_ES_NPCScheduleHopInDirection
	db $2E, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 2F
; Argmap: w
MACRO M_ES_JumpUsingMultiJumpConditional_1P_D
	db $2F
.ea2FP1JumpOrigin\@
	db ((\1)-(.ea2FP1JumpOrigin\@)) & $FF
ENDM
; Argmap: ww
MACRO M_ES_JumpUsingMultiJumpConditional_2P_D
	db $2F
.ea2FP2JumpOrigin\@
	db ((\1)-(.ea2FP2JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP2JumpOrigin\@)) & $FF
ENDM
; Argmap: www
MACRO M_ES_JumpUsingMultiJumpConditional_3P_D
	db $2F
.ea2FP3JumpOrigin\@
	db ((\1)-(.ea2FP3JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP3JumpOrigin\@)) & $FF
	db ((\3)-(.ea2FP3JumpOrigin\@)) & $FF
ENDM
; Argmap: wwww
MACRO M_ES_JumpUsingMultiJumpConditional_4P_D
	db $2F
.ea2FP4JumpOrigin\@
	db ((\1)-(.ea2FP4JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP4JumpOrigin\@)) & $FF
	db ((\3)-(.ea2FP4JumpOrigin\@)) & $FF
	db ((\4)-(.ea2FP4JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwww
MACRO M_ES_JumpUsingMultiJumpConditional_5P_D
	db $2F
.ea2FP5JumpOrigin\@
	db ((\1)-(.ea2FP5JumpOrigin\@)) & $FF
	db ((\2)-(.ea2FP5JumpOrigin\@)) & $FF
	db ((\3)-(.ea2FP5JumpOrigin\@)) & $FF
	db ((\4)-(.ea2FP5JumpOrigin\@)) & $FF
	db ((\5)-(.ea2FP5JumpOrigin\@)) & $FF
ENDM
; Argmap: wwwwww
MACRO M_ES_JumpUsingMultiJumpConditional_6P_D
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
MACRO M_ES_JumpUsingMultiJumpConditional_7P_D
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
MACRO M_ES_RelativeLongJump
	db $30
.ea30JumpOrigin\@
	db (((\1)-(.ea30JumpOrigin\@)) >> 8) & $FF
	db ((\1)-(.ea30JumpOrigin\@)) & $FF
ENDM

; Event Action 31
; Argmap: bbb
MACRO M_ES_InitiateBattle_A
	db $31, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 32
; Argmap: bbb
MACRO M_ES_InitiateBattle_B
	db $32, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 33
; Argmap: bbb
MACRO M_ES_InitiateBattle_C
	db $33, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 34
; Argmap: w
MACRO M_ES_SetFlag
	db $34, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 35
; Argmap: w
MACRO M_ES_ResetFlag
	db $35, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 36
; Argmap: bb
MACRO M_ES_IncreaseInventory
	db $36, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 37
; Argmap: bb
MACRO M_ES_DecreaseInventory
	db $37, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 38
; Argmap: ww
MACRO M_ES_JumpIfFlagSet
	db $38
.ea38JumpOrigin\@
	db ((\1) >> 8) & $FF, (\1) & $FF
	db ((\2)-(.ea38JumpOrigin\@)) & $FF
ENDM

; Event Action 39
; Argmap: ww
MACRO M_ES_JumpIfFlagUnset
	db $39
.ea39JumpOrigin\@
	db ((\1) >> 8) & $FF, (\1) & $FF
	db ((\2)-(.ea39JumpOrigin\@)) & $FF
ENDM

; Event Action 3A
; Argmap: w
MACRO M_ES_AddChiru
	db $3A
	; Unlike with many other event actions this argument is little-endian.
	dw (\1) & $FFFF
ENDM

; Event Action 3B
; Argmap: w
MACRO M_ES_SubtractChiru
	db $3B
	; Unlike with many other event actions this argument is little-endian.
	dw (\1) & $FFFF
ENDM

; Event Action 3C
; Argmap: nnb
MACRO M_ES_PartnerScheduleWalk
	db $3C, (((\1) & $0F) * $10) + ((\2) & $0F), (\3) & $FF
ENDM

; Event Action 3D
; Argmap: b
MACRO M_ES_NPCFacePlayer
	db $3D, (\1) & $FF
ENDM

; Event Action 3E
; Argmap: nn
MACRO M_ES_PositionPlayer
	db $3E, (((\1) & $0F) * $10) + ((\2) & $0F)
ENDM

; Event Action 3F
; Argmap: nn
MACRO M_ES_PositionPartner
	db $3F, (((\1) & $0F) * $10) + ((\2) & $0F)
ENDM

; Event Action 40
; Argmap: bb
MACRO M_ES_BeginEarthquake_A
	db $40, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 41
; Argmap: bb
MACRO M_ES_BeginEarthquake_B
	db $41, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 42
; Argmap: bb
MACRO M_ES_BeginEarthquake_C
	db $42, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 43
; Argmap: bb
MACRO M_ES_BeginEarthquake_D
	db $43, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 44
; Argmap: b
MACRO M_ES_ScheduleSFX
	db $44, (\1) & $FF
ENDM

; Event Action 45
; Argmap: b
MACRO M_ES_SetMusic
	db $45, (\1) & $FF
ENDM

; Event Action 46
; Argmap: bw
MACRO M_ES_JumpOnPlayerDirection_A
	db $46
.ea46JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea46JumpOrigin\@)) & $FF
ENDM

; Event Action 47
; Argmap: bw
MACRO M_ES_JumpOnPlayerDirection_B
	db $47
.ea47JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea47JumpOrigin\@)) & $FF
ENDM

; Event Action 48
; Argmap: bw
MACRO M_ES_JumpOnPlayerDirection_C
	db $48
.ea48JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea48JumpOrigin\@)) & $FF
ENDM

; Event Action 49
; Argmap: bw
MACRO M_ES_JumpOnPlayerDirection_D
	db $49
.ea49JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea49JumpOrigin\@)) & $FF
ENDM

; Event Action 4A
; Argmap: bw
MACRO M_ES_JumpOnPlayerDirection_E
	db $4A
.ea4AJumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea4AJumpOrigin\@)) & $FF
ENDM

; Event Action 4B
; Argmap: w
MACRO M_ES_JumpOnPlayerWin_A
	db $4B
.ea4BJumpOrigin\@
	db ((\1)-(.ea4BJumpOrigin\@)) & $FF
ENDM

; Event Action 4C
; Argmap: b
MACRO M_ES_NPCRemoveGeneralSprite
	db $4C, (\1) & $FF
ENDM

; Event Action 4D
; Argmap: b
MACRO M_ES_ExecuteCutsceneBehaviour
	db $4D, (\1) & $FF
ENDM

; Event Action 4E
; Argmap: w
MACRO M_ES_JumpOnPlayerWin_B
	db $4E
.ea4EJumpOrigin\@
	db ((\1)-(.ea4EJumpOrigin\@)) & $FF
ENDM

; Event Action 4F
; Argmap: w
MACRO M_ES_JumpOnPlayerWin_C
	db $4F
.ea4FJumpOrigin\@
	db ((\1)-(.ea4FJumpOrigin\@)) & $FF
ENDM

; Event Action 50
; Argmap: bb
MACRO M_ES_ShopPriceMessage_A
	db $50, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 51
; Argmap: -
MACRO M_ES_IncrementComparative
	db $51
ENDM

; Event Action 52
; Argmap: -
MACRO M_ES_DecrementComparative
	db $52
ENDM

; Event Action 53
; Argmap: b
MACRO M_ES_SetComparative
	db $53, (\1) & $FF
ENDM

; Event Action 54
; Argmap: bw
MACRO M_ES_JumpIfMatchComparative
	db $54
.ea54JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea54JumpOrigin\@)) & $FF
ENDM

; Event Action 55
; Argmap: bw
MACRO M_ES_JumpIfNotMatchComparative
	db $55
.ea55JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea55JumpOrigin\@)) & $FF
ENDM

; Event Action 56
; Argmap: bb
MACRO M_ES_ShopPriceMessage_B
	db $56, (\1) & $FF, (\2) & $FF
ENDM

; Event Action 57
; Argmap: b
MACRO M_ES_NPCWaitUntilDoneWalking
	db $57, (\1) & $FF
ENDM

; Event Action 58
; Argmap: -
MACRO M_ES_PartnerWaitUntilDoneWalking
	db $58
ENDM

; Event Action 59
; Argmap: bbbbb
MACRO M_ES_GetEventDenjuu
	db $59, (\1) & $FF, (\2) & $FF, (\3) & $FF, (\4) & $FF, (\5) & $FF
ENDM

; Event Action 5A
; Argmap: bbw
MACRO M_ES_JumpIfLTEInventory
	db $5A
.ea5AJumpOrigin\@
	db (\1) & $FF, (\2) & $FF
	db ((\3)-(.ea5AJumpOrigin\@)) & $FF
ENDM

; Event Action 5B
; Argmap: -
MACRO M_ES_DisplayMapLocation
	db $5B
ENDM

; Event Action 5C
; Argmap: b
MACRO M_ES_RingRing
	db $5C
	; This is rather bizarre. This event action has 1 parameter, but there is no indication that it is ever used.
	db (\1) & $FF
ENDM

; Event Action 5D
; Argmap: -
MACRO M_ES_StopRinging
	db $5D
ENDM

; Event Action 5E
; Argmap: b
MACRO M_ES_SetReception
	db $5E, (\1) & $FF
ENDM

; Event Action 5F
; Argmap: b
MACRO M_ES_EventNPCSetPaletteRangeA
	db $5F, (\1) & $FF
ENDM

; Event Action 60
; Argmap: b
MACRO M_ES_EventNPCSetPaletteRangeB
	db $60, (\1) & $FF
ENDM

; Event Action 61
; Argmap: bw
MACRO M_ES_JumpOnOverworldPartnerSpecies
	db $61
.ea61JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea61JumpOrigin\@)) & $FF
ENDM

; Event Action 62
; Argmap: nnb
MACRO M_ES_PlayerScheduleWalkBackwards
	db $62, (((\1) & $0F) * $10) + ((\2) & $0F), (\3) & $FF
ENDM

; Event Action 63
; Argmap: bnnb
MACRO M_ES_NPCScheduleWalkBackwards
	db $63, (\1) & $FF, (((\2) & $0F) * $10) + ((\3) & $0F), (\4) & $FF
ENDM

; Event Action 64
; Argmap: b
MACRO M_ES_NPCFaceAwayFromPlayer
	db $64, (\1) & $FF
ENDM

; Event Action 65
; Argmap: b
MACRO M_ES_EventNPCSetPaletteRangeBAndDontUseItWTFSmilesoftB
	db $65, (\1) & $FF
ENDM

; Event Action 66
; Argmap: b
MACRO M_ES_EventNPCSetPaletteRangeBAndDontUseItWTFSmilesoftA
	db $66, (\1) & $FF
ENDM

; Event Action 67
; Argmap: -
MACRO M_ES_ResetOverworldInteration
	db $67
ENDM

; Event Action 68
; Argmap: bbb
MACRO M_ES_Mode7WarpPlayer
	db $68, (\1) & $FF, (\2) & $FF, (\3) & $FF
ENDM

; Event Action 69
; Argmap: bw
MACRO M_ES_JumpOnSpeciesInContacts
	db $69
.ea69JumpOrigin\@
	db (\1) & $FF
	db ((\2)-(.ea69JumpOrigin\@)) & $FF
ENDM

; Event Action 6A
; Argmap: -
MACRO M_ES_PlayCredits
	db $6A
ENDM

; Event Action 6B
; Argmap: b
MACRO M_ES_ChangePhoneState
	db $6B, (\1) & $FF
ENDM

; Event Action 6C
; Argmap: w
MACRO M_ES_EventFlag400R800R
	db $6C, ((\1) >> 8) & $FF, (\1) & $FF
ENDM

; Event Action 6D
; Argmap: w
MACRO M_ES_JumpOnSilentMode
	db $6D
.ea6DJumpOrigin\@
	db ((\1)-(.ea6DJumpOrigin\@)) & $FF
ENDM

; Event Action 6E
; Argmap: w
MACRO M_ES_JumpIfZukanComplete
	db $6E
.ea6EJumpOrigin\@
	db ((\1)-(.ea6EJumpOrigin\@)) & $FF
ENDM

; Event Action 6F
; Argmap: -
MACRO M_ES_BasicEnd_A
	db $6F
ENDM

; Event Action 70
; Argmap: -
MACRO M_ES_BasicEnd_B
	db $70
ENDM

; Event Action 71
; Argmap: -
MACRO M_ES_BasicEnd_C
	db $71
ENDM

; Event Action 72
; Argmap: -
MACRO M_ES_BasicEnd_D
	db $72
ENDM

; Event Action 73
; Argmap: -
MACRO M_ES_BasicEnd_E
	db $73
ENDM

; Event Action 74
; Argmap: -
MACRO M_ES_BasicEnd_F
	db $74
ENDM

; Event Action 75
; Argmap: -
MACRO M_ES_BasicEnd_G
	db $75
ENDM

; Event Action 76
; Argmap: -
MACRO M_ES_BasicEnd_H
	db $76
ENDM

; Event Action 77
; Argmap: -
MACRO M_ES_BasicEnd_I
	db $77
ENDM

; Event Action 78
; Argmap: -
MACRO M_ES_BasicEnd_J
	db $78
ENDM
