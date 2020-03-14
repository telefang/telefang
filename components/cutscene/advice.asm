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

WeAreConnected_ADVICE_PrepareForFade::
	call Banked_LCDC_SetupPalswapAnimation
	call Cutscene_ADVICE_CheckSGB
	ret z
	xor a
	ld b, a
	ld c, a
	ld d, a
	ld e, a
	jp Banked_SGB_ConstructPaletteSetPacket

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

Cutscene_ADVICE_IdentifyFadePalettesCommon::
	ld hl, W_SGB_FadeMethod
	ld a, 1
	ld [hli], a
	ld a, $4B
	ld [hli], a
	ld a, b
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	ld a, c
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
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

	ld bc, $7C05
	call Cutscene_ADVICE_IdentifyFadePalettesCommon

	ld c, $16
	jp  Banked_SGB_ConstructATFSetPacket

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

	ld hl, $9893
	ld a, d
	call vmempoke

	ld bc, $9415
	call Cutscene_ADVICE_IdentifyFadePalettesCommon
	ld a, $F
	ld [W_SGB_PreloadedFadeStageD], a

	xor a
	ld [W_Cutscene_KaiSGBRevealState], a
	ret
	
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
	ld a, $19
	ld bc, $F10
	ld de, $1112
	call Banked_SGB_ConstructPaletteSetPacket
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

Cutscene_ADVICE_CheckGBC::
	ld a, [W_GameboyType]
	cp M_BIOS_CPU_CGB
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
	
	ld bc, $8409
	call Cutscene_ADVICE_IdentifyFadePalettesCommon

	ld c, $17
	jp Banked_SGB_ConstructATFSetPacket
	
WeAreConnected_ADVICE_LoadSGBFiles_BeforeFadeToBlack::
	call Banked_LCDC_SetupPalswapAnimation
	
	ld bc, $8C09
	call Cutscene_ADVICE_IdentifyFadePalettesCommon
	ld a, $4A
	ld [W_SGB_PreloadedFadeStageA], a
	ret
	
WeAreConnected_ADVICE_LoadSGBFiles_Waaaaahh::
	call Cutscene_ADVICE_CheckSGB
	ret z
	ld a, $18
	ld bc, $D0E
	ld d, b
	ld e, c
	jp Banked_SGB_ConstructPaletteSetPacket

SECTION "Cutscene - Recruitment Phone Number", ROMX[$7FDA], BANK[$E]
Cutscene_ADVICE_DrawPhoneNumberForRecruitment::
	push af
	push hl
	push bc
	push de
	call Banked_Status_LoadPhoneDigits_NowWithSGBSupport
	pop de
	ld a, $FF
	ld hl, $99C2
	call vmempoke
	ld l, $D1
	call vmempoke
	ld b, $10
	ld hl, $9A02

.loop
	call vmempoke
	dec b
	jr nz, .loop
	pop bc
	pop hl
	pop af
	jp Banked_Status_DrawPhoneNumberForStatus

SECTION "Cutscene - Antenna Tree SGB Overlay", ROMX[$42C0], BANK[$77]
CutsceneAntennaTreeSGBOverlayGfx::
	INCBIN "build/gfx/cutscene/antenna_tree_sgb_overlay.2bpp"

SECTION "Cutscene - We Are Connected SGB Tiles", ROMX[$7600], BANK[$62]
CutsceneConnected1SGBGfx::
	INCBIN "build/gfx/cutscene/connected1_sgb.2bpp"
