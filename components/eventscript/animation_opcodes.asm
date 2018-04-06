INCLUDE "telefang.inc"

SECTION "Event System MetaSprite Config Address Buffer", WRAM0[$C98A]
W_EventScript_MetaspriteConfigAddressBuffer:: ds 1

SECTION "Event Action - NPC Schedule Walk and Continue", ROMX[$4645], BANK[$F]
EventScript_NPCScheduleWalkAndContinue::
; Parameter A is used to find the metasprite config.
; Parameter B represents where we are walking to. I honestly don't understand the format.
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
