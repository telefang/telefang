M_MetaSpriteConfig_Size EQU $20
M_MetaSpriteConfig1_Count EQU $C
M_MetaSpriteConfig2_Count EQU $8
M_MetaSpriteConfig3_Count EQU $4

;The Sprite Prep routines store metasprite data in a number of standardized
;areas right after the DMA staging area. There are multiple staging areas all
;of which are eventually poured into LoadMetasprite down below.
SECTION "LCDC Sprite Prep Data", WRAM0[$C0A0]
W_MetaSpriteConfig1:: ds M_MetaSpriteConfig_Size * M_MetaSpriteConfig1_Count
W_MetaSpriteConfig3:: ds M_MetaSpriteConfig_Size * M_MetaSpriteConfig3_Count
W_MetaSpriteConfig2:: ds M_MetaSpriteConfig_Size * M_MetaSpriteConfig2_Count

SECTION "LCDC Sprite Prep Vars", WRAM0[$C430]
W_OAM_SpritesReady:: ds 1 ;Flag set to 1 when sprites need to be changed.
W_OAM_SpritesBrk:: ds 1 ;Number of sprites currently in the DMA area.

SECTION "LCDC Sprite Prep Vars 2", WRAM0[$C418]
W_Metasprite_Bank: ds 1
W_Metasprite_HiAttributes: ds 1
W_Metasprite_Index: ds 1
W_Metasprite_OAMYOffset: ds 1
W_Metasprite_OAMXOffset: ds 1
W_Metasprite_LowAttributes: ds 1

;Called by the main gameloop.
;It loads "metasprites" from other staging locations and places the calculated
;OAM data in the DMA area for transfer on the next Vblank.
SECTION "Graphics Sprite Prep", ROM0[$0824]
LoadSpritesForDMA::
	ld a, [W_OAM_SpritesReady]
	or a
	ret z
	xor a
	ld [W_OAM_SpritesBrk], a
	ld hl, W_MetaSpriteConfig1
	ld bc, W_ShadowOAM
	ld a, M_MetaSpriteConfig1_Count
	
.firstConfigListLoop
	push af
	ld a, [hl]
	and 1
	call nz, LoadMetasprite
	ld de, M_MetaSpriteConfig_Size
	add hl, de
	pop af
	dec a
	jr nz, .firstConfigListLoop
	ld hl, W_MetaSpriteConfig2
	ld a, M_MetaSpriteConfig2_Count
	
.secondConfigListLoop
	push af
	ld a, [hl]
	and $81
	cp $81
	call z, LoadMetasprite
	ld de, M_MetaSpriteConfig_Size
	add hl, de
	pop af
	dec a
	jr nz, .secondConfigListLoop
	ld hl, W_MetaSpriteConfig3
	ld a, $C
	ld [$C40B], a
	
.thirdConfigListLoop
	ld a, [hl]
	and $81
	cp $81
	jr z, .thirdCfgSkipSprite
	and 1
	call nz, LoadMetasprite

.thirdCfgSkipSprite
	ld de, M_MetaSpriteConfig_Size
	add hl, de
	ld a, [$C40B]
	dec a
	ld [$C40B], a
	jr nz, .thirdConfigListLoop
	ld a, [$C432]
	ld h, a
	ld a, [W_OAM_SpritesBrk]
	ld [$C432], a
	sub h
	jr nc, .markSpritesReadyAndExit
	xor $FF
	inc a
	ld h, b
	ld l, c
	ld b, a
	xor a
	
.eraseLoop
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	dec b
	jr nz, .eraseLoop
	
.markSpritesReadyAndExit
	ld a, 1
	ld [W_OAM_DMAReady], a
	ret

;Loads a precomposed set of sprites (called a metasprite) and generates a set
;of OAM entries based on a few bytes of configuration data which affects all
;of the sprites in the set.
LoadMetasprite::
	push hl
	ld a, [hli]
	ld [W_Metasprite_HiAttributes], a
	ld a, [hli]
	ld [W_Metasprite_Bank], a
	ld a, [hli]
	ld [W_Metasprite_Index], a
	ld a, [hli]
	add a, 8
	ld [W_Metasprite_OAMXOffset], a
	ld a, [hli]
	add a, $10
	ld [W_Metasprite_OAMYOffset], a
	ld a, [hli]
	ld [W_Metasprite_LowAttributes], a
	push bc
	ld a, [W_Metasprite_Bank]
	and $F0
	swap a
	ld hl, MetaspriteBankMetatable
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	rst $10
	pop bc
	ld a, [W_Metasprite_Bank]
	and $F0
	swap a
	ld hl, MetaspriteAddressMetatable
	ld d, 0
	ld e, a
	sla e
	rl d
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [W_Metasprite_Index]
	ld d, 0
	ld e, a
	sla e
	rl d
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ld d, h
	ld e, l
	
	;At the start of this loop, the following registers hold:
	; A = Number of sprites left to build.
	;DE = Current byte of the metasprite list we're working with.
	;BC = Current byte of target we're writing OAM memory to (usually shadow-OAM)
.spriteComposeLoop
	push af
	ld a, [W_OAM_SpritesBrk]
	inc a
	cp $29
	jp z, .outOfSprites
	ld [W_OAM_SpritesBrk], a
	
	;Write the next sprite's Y position.
	ld a, [W_Metasprite_OAMYOffset]
	ld h, a
	ld a, [de]
	add a, h
	ld [bc], a
	inc bc
	inc de
	
	;Write the next sprite's X position.
	ld a, [W_Metasprite_OAMXOffset]
	ld h, a
	ld a, [de]
	add a, h
	ld [bc], a
	inc bc
	inc de
	
	;Copy the tile pattern number we're interested in.
	ld a, [de]
	ld [bc], a
	inc bc
	inc de
	
	;Calculate sprite attributes.
	;First byte is a flag determining how the sprite and configuration
	;attributes get mixed together. Second byte is OAM attribute data.
	; 0 = Use metasprite config attributes
	; 1 = Use individual sprite attributes
	; 2 = Use individual sprite's high attributes && config's low attributes
	ld a, [de]
	or a
	jr nz, .spriteOverridesConfigAttributes
	ld a, [W_Metasprite_HiAttributes]
	and $F0
	push bc
	ld b, a
	ld a, [W_Metasprite_LowAttributes]
	and 7
	or b
	pop bc
	ld [bc], a
	inc de
	jr .spriteComposeLoopEpilogue
	
.spriteOverridesConfigAttributes
	cp 1
	jr nz, .useSpriteHiAttributes
	inc de
	ld a, [de]
	ld [bc], a
	jr .spriteComposeLoopEpilogue
	
.useSpriteHiAttributes
	inc de
	ld a, [de]
	and $F0
	push bc
	ld b, a
	ld a, [W_Metasprite_LowAttributes]
	and 7
	or b
	pop bc
	ld [bc], a
	
.spriteComposeLoopEpilogue
	inc bc
	inc de
	pop af
	dec a
	jp nz, .spriteComposeLoop
	pop hl
	ret
	
.outOfSprites
	pop af
	pop hl
	ret

;TODO: Rip metasprite data into the disassembly.
;Each entry in this metatable points to another table of pointers in ROM.
;Pointed to by that table are metasprite data, which looks something like this:
; First byte: Number of sprite entries
; 5 bytes * number of entries:
;   Y offset from origin
;   X offset from origin
;   Tile ID
;   Attribute mixing flag
;   Attribute data
MetaspriteBankMetatable: db $A, $E, $13, $14, $15, $16, $17, $18, $19
MetaspriteAddressMetatable: dw $4000, $4120, $4000, $4000, $4000, $4000, $4000, $4000, $4000