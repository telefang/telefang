INCLUDE "telefang.inc"

SECTION "Attract Mode State Machine (Speed)", ROMX[$427E], BANK[$2]
AttractMode_StateDrawScene3::
	call LCDC_ClearMetasprites
	ld bc, $33
	call Banked_LoadMaliasGraphics
	ld bc, $3D
	call Banked_LoadMaliasGraphics
	ld bc, 0
	ld e, $B
	ld a, 1
	call Banked_RLEDecompressTMAP0
	ld bc, 0
	ld e, $B
	ld a, 1
	call Banked_RLEDecompressAttribsTMAP0
	ld bc, $22
	call Banked_CGBLoadBackgroundPalette
	ld bc, 7
	call Banked_CGBLoadObjectPalette
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, $44
	ld [W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ld de, W_MetaSpriteConfig1 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs
	ld bc, $C068
	call TitleScreen_PositionSprite
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, $A0
	ld [W_System_CountdownTimer], a
	jp System_ScheduleNextSubState
