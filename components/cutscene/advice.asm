INCLUDE "telefang.inc"

SECTION "Cutscene Kai SGB Reveal State", WRAM0[$C7E0]
W_Cutscene_KaiSGBRevealState:: ds 1

SECTION "Cutscene SGB Colour Advice", ROMX[$7A50], BANK[$29]
Cutscene_ADVICE_CheckSGB::
	ld a, [W_GameboyType]
	cp M_BIOS_CPU_CGB
	ret z
	ld a, [W_SGB_DetectSuccess]
	or a
	ret

Cutscene_ADVICE_TileLightColourClear::
	ld d, h
	ld e, l

.loop
	inc l
	di

.wfb
	ld a, [REG_STAT]
	and 2
	jr nz, .wfb

	ld c, [hl]
	ld a, [de]
	and c
	ld [de], a
	ei
	inc hl
	inc e
	inc de
	dec b
	jr nz, .loop
	ret

Cutscene_ADVICE_LoadSGBFiles::
	call Cutscene_ADVICE_CheckSGB
	ret z
	ld a, [W_Cutscene_CutsceneImageIndexBuffer]
	or a
	jr z, Cutscene_ADVICE_LoadSGBFiles_AntennaTree
	dec a 
	jp z, Cutscene_ADVICE_LoadSGBFiles_OneOfMySoldiers
	dec a 
	jp z, .placeholderJumpPoint

.placeholderJumpPoint
	ret
	
Cutscene_ADVICE_LoadSGBFiles_AntennaTree::
	ld a, BANK(CutsceneAntennaTreeSGBOverlayGfx)
	ld hl, $9480
	ld de, CutsceneAntennaTreeSGBOverlayGfx
	ld bc, $60
	call Banked_LCDC_LoadTiles
	ld hl, $91A0
	ld b, $10
	call Cutscene_ADVICE_TileLightColourClear
	ld hl, $9200
	ld b, $28
	call Cutscene_ADVICE_TileLightColourClear
	ld l, $70
	ld b, 8
	call Cutscene_ADVICE_TileLightColourClear
	ld l, $A0
	ld b, $28
	call Cutscene_ADVICE_TileLightColourClear
	ld hl, $9310
	ld b, $20
	call Cutscene_ADVICE_TileLightColourClear
	ld l, $60
	ld b, $10
	call Cutscene_ADVICE_TileLightColourClear
	ld l, $B0
	ld b, $20
	call Cutscene_ADVICE_TileLightColourClear
	ld b, $1E
	ld d, $99
	ld hl, .table

.loop
	di

.wfb
	ld a, [REG_STAT]
	and 2
	jr nz, .wfb
	ld e, [hl]
	xor a
	ld [de], a
	ei
	inc hl
	dec b
	jr nz, .loop

	ld a, $16
	ld bc, $506
	ld de, $708
	jp Banked_SGB_ConstructPaletteSetPacket

.table
	db $20, $21, $32, $33, $40, $41
	db $42, $43, $44, $45, $46, $47
	db $4B, $4C, $4D, $4E, $4F, $50
	db $63, $64, $65, $66, $6C, $6D
	db $6E, $84, $85, $86, $8C, $8D

Cutscene_ADVICE_LoadSGBFiles_OneOfMySoldiers::
	ld hl, $9874
	ld de, $D14
	ld b, $B

.row
	ld c, 3

.col
	di

.wfb
	ld a, [REG_STAT]
	and 2
	jr nz, .wfb
	ld a, d
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ei
	dec c
	jr nz, .col
	ld a, l
	add e
	ld l, a
	dec b
	jr nz, .row

	xor a
	ld [W_Cutscene_KaiSGBRevealState], a
	ld bc, $F10
	ld de, $1112
	jp Banked_SGB_ConstructPaletteSetPacket
	
Cutscene_ADVICE_LoadSGBFiles_OneOfMySoldiers_ShowKai::
	call Cutscene_ADVICE_CheckSGB
	ret z

	ld a, [W_Cutscene_KaiSGBRevealState]
	or a
	jr z, .stageA
	cp 4
	jr z, .stageB
	cp 8
	jr z, .stageC
	cp 9
	jr z, .stageD
	jr .nextStage

.stageA
	ld c, $19
	call Banked_SGB_ConstructATFSetPacket
	ld e, $C1
	xor a
	ld b, a
	ld c, a
	call Banked_RLEDecompressTMAP0
	jr .nextStage

.stageB
	ld a, $19
	ld bc, $F13
	ld de, $1415
	call Banked_SGB_ConstructPaletteSetPacket
	jr .nextStage
	
.stageC
	ld a, $19
	ld bc, $F16
	ld de, $1718
	call Banked_SGB_ConstructPaletteSetPacket

.nextStage
	ld a, [W_Cutscene_KaiSGBRevealState]
	inc a
	ld [W_Cutscene_KaiSGBRevealState], a
	or a
	ret

.stageD
	xor a
	ret

WeAreConnected_ADVICE_LoadSGBFiles::
	call Cutscene_ADVICE_CheckSGB
	jr nz, .isSGB
	ld bc, 7
	jp Banked_LoadMaliasGraphics

.isSGB
	ld a, BANK(CutsceneConnected1SGBGfx)
	ld hl, $9000
	ld de, CutsceneConnected1SGBGfx
	ld bc, $800
	call Banked_LCDC_LoadTiles
	
	ld hl, $9910
	xor a
	call vmempoke
	
	ld hl, $9943
	ld a, $4F
	call vmempoke
	
	ld a, $17
	ld bc, $90A
	ld de, $B0C
	jp Banked_SGB_ConstructPaletteSetPacket
	
WeAreConnected_ADVICE_LoadSGBFiles_Waaaaahh::
	call Cutscene_ADVICE_CheckSGB
	ret z
	ld a, $18
	ld bc, $D0E
	ld d, b
	ld e, c
	jp Banked_SGB_ConstructPaletteSetPacket

SECTION "Cutscene - Antenna Tree SGB Overlay", ROMX[$42C0], BANK[$77]
CutsceneAntennaTreeSGBOverlayGfx::
	INCBIN "build/gfx/cutscene/antenna_tree_sgb_overlay.2bpp"

SECTION "Cutscene - We Are Connected SGB Tiles", ROMX[$7600], BANK[$62]
CutsceneConnected1SGBGfx::
	INCBIN "build/gfx/cutscene/connected1_sgb.2bpp"
