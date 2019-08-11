INCLUDE "telefang.inc"

SECTION "Link Menu State Machine (Speed)", ROMX[$424A], BANK[$1F]
LinkMenu_StateDrawMenuScreen::
	ld bc, 2
	call Banked_CGBLoadBackgroundPalette
	ld bc, $40
	call Banked_LoadMaliasGraphics
	ld bc, $41
	call Banked_LoadMaliasGraphics
	ld bc, 0
	ld e, $60
	xor a
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $60
	xor a
	call Banked_RLEDecompressAttribsTMAP0
	ld a, 6
	ld [W_Battle_CurrentParticipant], a
	ld a, $B0
	ld [W_LCDC_MetaspriteAnimationIndex], a
	ld a, 0
	ld [W_LCDC_MetaspriteAnimationBank], a
	ld [W_LCDC_NextMetaspriteSlot], a
	ld a, [W_Battle_CurrentParticipant]
	ld b, 0
	call $43E3
	ld a, 1
	ld [W_LCDC_NextMetaspriteSlot], a
	ld a, [W_Battle_CurrentParticipant]
	ld b, 1
	call $43E3
	ld a, 4
	ld [$D459], a
	ld a, $1C
	ld hl, $4448
	call CallBankedFunction_int
	ld a, BANK(LinkMenu_StateDrawMenuScreen)
	ld [W_PreviousBank], a
	xor a
	ld [W_Victory_UserSelection], a
	call $441B
	ld a, 0
	ld [W_LCDC_NextMetaspriteSlot], a
	ld a, $C
	ld [W_PauseMenu_SelectedCursorType], a
	call LCDC_BeginAnimationComplex
	ld a, 1
	ld [W_LCDC_NextMetaspriteSlot], a
	call LCDC_BeginAnimationComplex
	xor a
	ld [W_Battle_OpponentUsingLinkCable], a
	ld a, $27
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, 1
	call Banked_LCDC_SetupPalswapAnimation
	call LinkMenu_ADVICE_LoadSGBFiles
	jp Battle_IncrementSubSubState
