INCLUDE "telefang.inc"

SECTION "Event System MetaSprite Config Address Buffer", WRAM0[$C98A]
W_EventScript_MetaspriteConfigAddressBuffer:: ds 2

SECTION "Event Action - Position Player and Continue", ROMX[$4AF0], BANK[$F]
EventScript_PositionPlayerAndContinue::
; Parameter A is the X and Y tile number offset (in 4-bit format) from the top-left corner. So for example a value of $43 means 4 tiles from the left and 3 tiles from the top.
	ld hl, W_EventScript_MetaspriteConfigAddressBuffer
	ld a, W_MetaSpriteConfigPlayer & $FF
	ldi [hl], a
	ld a, W_MetaSpriteConfigPlayer >> 8
	ld [hl], a
	ld hl, W_MetaSpriteConfigPlayer
	ld de, W_EventScript_ParameterA
	call $2D4C
	ld de, W_MetaSpriteConfigPlayer + 3
	ld hl, W_MetaSpriteConfigPlayer + 8
	ldi a, [hl]
	ld c, a
	ldi a, [hl]
	sla c
	rl a
	sla c
	rl a
	ld [de], a
	inc de
	inc hl
	inc hl
	ldi a, [hl]
	ld c, a
	ld a, [hl]
	sla c
	rl a
	sla c
	rl a
	ld [de], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Position Partner and Continue", ROMX[$4ABC], BANK[$F]
EventScript_PositionPartnerAndContinue::
	ld hl, W_EventScript_MetaspriteConfigAddressBuffer
	ld a, W_MetaSpriteConfigPartner & $FF
	ldi [hl], a
	ld a, W_MetaSpriteConfigPartner >> 8
	ld [hl], a
	ld hl, W_MetaSpriteConfigPartner
	ld a, [W_EventScript_ParameterA]
	ld b, a
	inc a
	ld c, a
	and a, $F0
	add a, 8
	ld b, a
	ld a, c
	swap a
	and a, $F0
	ld c, a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, 3
	ld l, a
	ld a, b
	ld [hl], a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, 4
	ld l, a
	ld a, c
	ld [hl], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - NPC Schedule Walk and Continue", ROMX[$4645], BANK[$F]
EventScript_NPCScheduleWalkAndContinue::
; Parameter A is used to find the metasprite config.
; Parameter B represents the X and Y co-ordinates we are walking to. See the notes for EventScript_PositionPlayerAndContinue for more info.
; Parameter C represents walking speed. Lower is slower, higher is faster. Never set to 0.

	ld a, [W_EventScript_ParameterA]
	add a, $10
	ld c, a
	call EventScript_FindMetaSpriteConfig
	jr z, .configNotFound
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $14
	ld l, a
	ld a, [W_EventScript_ParameterB]
	ld [hl], a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $16
	ld l, a
	ld a, [W_EventScript_ParameterC]
	ld [hl], a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $1A
	ld l, a
	ld a, 2
	ld [hl], a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $17
	ld l, a
	ld a, $FF
	ld [hl], a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $19
	ld l, a
	ld a, [hl]
	and a, $BF
	ld [hl], a

.configNotFound
	ld b, 4
	call EventScript_CalculateNextOffset
	scf 
	ret
	
SECTION "Event Action - Player Schedule Walk and Continue", ROMX[$43C7], BANK[$F]
EventScript_PlayerScheduleWalkAndContinue::
	ld a, [W_EventScript_ParameterA]
	ld [W_MetaSpriteConfigPlayer + $14], a
	ld a, [W_EventScript_ParameterB]
	ld [W_MetaSpriteConfigPlayer + $16], a
	ld a, $15
	ld [W_MetaSpriteConfigPlayer + $1A], a
	ld a, $FF
	ld [W_MetaSpriteConfigPlayer + $17], a
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - NPC Wait Until Done Walking and Continue", ROMX[$4943], BANK[$F]
EventScript_NPCWaitUntilDoneWalkingAndContinue::
	ld a, [W_EventScript_ParameterA]
	add a, $10
	ld c, a
	call EventScript_FindMetaSpriteConfig
	jr z, .endWaitPeriod
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $14
	ld l, a
	ld a, [hl]
	cp a, $FF
	jr z, .endWaitPeriod
	xor a
	ret

.endWaitPeriod
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Player Wait Until Done Walking and Continue", ROMX[$4977], BANK[$F]
EventScript_PlayerWaitUntilDoneWalkingAndContinue::
	ld a, [W_MetaSpriteConfigPlayer + $14]
	cp a, $FF
	jr z, .endWaitPeriod
	xor a
	ret

.endWaitPeriod
	ld b, 1
	call EventScript_CalculateNextOffset
	scf  
	ret 

SECTION "Event Action - NPC Schedule Hop and Continue", ROMX[$46ED], BANK[$F]
EventScript_NPCScheduleHopAndContinue::
	ld a, [W_EventScript_ParameterA]
	add a, $10
	ld c, a
	call EventScript_FindMetaSpriteConfig
	jr z, .configNotFound
	ld a, $10
	ld [W_Sound_NextSFXSelect], a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, M_LCDC_MetaSpriteConfig_AnimStopped
	ld l, a
	ld a, 0
	ld [hli], a
	ld a, 0
	ld [hl], a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $E
	ld l, a
	ld a, 0
	ld [hli], a
	ld a, 0
	ld [hl], a
	ld b, 2
	call EventScript_CalculateNextOffset
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $16
	ld l, a
	ld a, 0
	ld [hl], a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $1A
	ld l, a
	ld a, 4
	ld [hl], a
	scf  
	ret

.configNotFound
	ld a, $10
	ld [W_Sound_NextSFXSelect], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event Action - Player Schedule Hop and Continue", ROMX[$435E], BANK[$F]
EventScript_PlayerScheduleHopAndContinue::
	ld hl, W_MetaSpriteConfigPlayer + $A
	ld a, 0
	ld [hli], a
	ld a, 0
	ld [hl], a
	ld hl, W_MetaSpriteConfigPlayer + $E
	ld a, 0
	ld [hli], a
	ld a, 0
	ld [hl], a
	ld b, 1
	call EventScript_CalculateNextOffset
	ld a, $10
	ld [W_Sound_NextSFXSelect], a
	ld a, 0
	ld [W_MetaSpriteConfigPlayer + $16], a
	ld a, $14
	ld [W_MetaSpriteConfigPlayer + $1A], a
	ld a, 0
	ld [$C9EF], a
	scf
	ret

SECTION "Event Action - NPC Face Player and Continue", ROMX[$4A06], BANK[$F]
EventScript_NPCFacePlayerAndContinue::
; Do not ask me how this works, it just does.
	ld a, [W_EventScript_ParameterA]
	add a, $10
	ld c, a
	call EventScript_FindMetaSpriteConfig
	jr z, .configNotFound
	call $2CB7
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $10
	ld l, a
	ld a, [hl]
	cp $12
	jr nc, .jpA
	ld a, b
	add a
	add b
	ld b, a

.jpA
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $12
	ld l, a
	ld a, b
	ld [hl], a

.configNotFound
	ld b, 2
	call EventScript_CalculateNextOffset
	scf  
	ret

SECTION "Event Action - Player Face Direction and Continue", ROMX[$4314], BANK[$F]
EventScript_PlayerFaceDirectionAndContinue::
	ld d, 0
	ld a, [W_EventScript_ParameterA]
	ld b, a
	or a
	jr nz, .jpA
	ld d, 1

.jpA
	ld a, d
	ld [W_MetaSpriteConfigPlayer + 2], a
	ld a, b
	ld hl, .tableA
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]
	ld [$C9F4], a
	ld a, [W_MetaSpriteConfigPlayer + $19]
	bit 2, a
	jp z, .jpB
	ld a, [$C9F4]
	add a, $2D
	ld [$C9F4], a

.jpB
	ld a, b
	ld hl, .tableB
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]
	ld [W_MetaSpriteConfigPlayer + $17], a
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

.tableA
	db 6,0,6,3

.tableB
	db 0,3,2,1

SECTION "Event Action - NPC Face Direction and Continue", ROMX[$461B], BANK[$F]
EventScript_NPCFaceDirectionAndContinue::
	ld a, [W_EventScript_ParameterA]
	add a, $10
	ld c, a
	call EventScript_FindMetaSpriteConfig
	jr z, .configNotFound
	ld a, [W_EventScript_ParameterB]
	ld de, .table
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	ld a, [W_EventScript_MetaspriteConfigAddressBuffer]
	add a, $12
	ld l, a
	ld a, [de]
	ld [hl], a

.configNotFound
	ld b, 3
	call EventScript_CalculateNextOffset
	scf
	ret
  
.table
	db 9,0,6,3

SECTION "Event Action - Initiate NPC and Continue", ROMX[$45C7], BANK[$F]
EventScript_InitiateNPCAndContinue::
; There's every chance that "initiate" is the wrong word to use here, but I'm going to run with it.
; Parameter A is used to find the metasprite config.
; Parameter B represents the graphic to be used for the NPC sprite.
; Parameter C is the X and Y tile coordinate pair for the NPC sprite to be placed upon.
	ld a, [W_EventScript_ParameterA]
	add a, $10
	ld c, a
	call EventScript_FindMetaSpriteConfig
	jr nz, .configNotFound
	ld a, c
	ld hl, $CA00
	ldi [hl], a
	ld a, [W_EventScript_ParameterC]
	ldi [hl], a
	ld a, [W_EventScript_ParameterB]
	ldi [hl], a
	xor a
	ldi [hl], a
	ld [hl], a
	call $33F0
	call $2E85
.configNotFound
	ld b, 4
	call EventScript_CalculateNextOffset
	scf
	ret

SECTION "Event System - Find MetaSprite Config", ROMX[$45EF], BANK[$F]
EventScript_FindMetaSpriteConfig::
	ld b, 8
	ld hl, W_MetaSpriteConfig2
	ld de, $20

.configFindLoop
	ld a, [hl]
	and a, 2
	jr z, .notThisOne
	push hl
	ld a, $10
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]
	cp c
	pop hl
	jr z, .configFound

.notThisOne
	add hl, de
	dec b
	jr nz, .configFindLoop
	xor a
	ret

.configFound
	ld a, h
	ld [W_EventScript_MetaspriteConfigAddressBuffer + 1], a
	ld a, l
	ld [W_EventScript_MetaspriteConfigAddressBuffer], a
	or a, 1
	ret

SECTION "Event Action - Execute Cutscene Behaviour and Continue", ROMX[$4B46], BANK[$F]
EventScript_ExecuteCutsceneBehaviourAndContinue::
; This one is super fun to toy around with. It handles a bunch of stuff like cutscene images, screens, and special animations.
; 00 = Open menu
; 01 = Open post item selection fusion screen
; 02 = Ball animation from intro
; 03 = Antenna tree cutscene image (post-tronco)
; 04 = "This guy is one of my soldiers" cutscene image
; 05 = Unused cutscene image
; 09 = INDEX FULL! Congrats!
; 0A = "Finally we are connected..." cutscene
; 65 = Item obtained animation
; 68 = Noisy's signal block animation.
; 96 = Obtained starter denjuu number screen
	ld a, [W_EventScript_ParameterA]
	cp a, $14
	jr c, .parameterIsValid
	cp a, $32
	jr nc, .parameterIsValid
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret

.parameterIsValid
	ld a, [W_EventScript_ParameterA]
	cp a, 0
	jp z, $4C5E
	cp a, 1
	jp z, $4C6D
	cp a, 2
	jr z, EventScript_CutsceneBehaviour_BallAnimation
	cp a, $64
	jp z, $4C91
	cp a, $65
	jr z, EventScript_CutsceneBehaviour_ItemObtainedAnimation
	cp a, $66
	jr z, Loc_4BC9
	cp a, $67
	jp z, $4C10
	cp a, $68
	jr z, .jpA
	cp a, $96
	jp z, $4C2F
	cp a, 9
	jp z, $4C7F
	cp a, 3
	jp nc, $4C47
.jpA
	ld a, [W_MetaSpriteConfigPartner + 3]
	ld d, a
	ld a, [W_MetaSpriteConfigPartner + 4]
	sub a, 8
	ld e, a
	ld a, $C
	ld hl, $775F
	call CallBankedFunction_int
	ld b, 2
	call EventScript_CalculateNextOffset
	scf
	ret
 
EventScript_CutsceneBehaviour_BallAnimation::
	ld b, $1D
	ld a, $C
	ld hl, $7886
	call CallBankedFunction_int
	ld b, 2
	call EventScript_CalculateNextOffset
	scf 
	ret

EventScript_CutsceneBehaviour_ItemObtainedAnimation::
	ld b, $1E
	ld a, $C
	ld hl, $7886
	call CallBankedFunction_int
	ld b, 2
	call EventScript_CalculateNextOffset
	scf 
	ret

Loc_4BC9:
;TODO: Fill in what this code does. This label only exists 'cause rgbds won't
;assemble jrs to absolute addresses.