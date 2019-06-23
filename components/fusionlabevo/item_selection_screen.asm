INCLUDE "telefang.inc"

SECTION "Fusion/Lab Evolution - Inventory Quantities Address Buffer",  WRAM0[$C2AE]
W_FusionLabEvo_InventoryQuantitiesAddressBuffer:: ds 2

SECTION "Fusion/Lab Evolution - In-Focus Item Number",  WRAM0[$C2B1]
W_FusionLabEvo_InFocusItemNumber:: ds 1

SECTION "Fusion/Lab Evolution - Inventory Quantities Length Buffer",  WRAM0[$C2B4]
W_FusionLabEvo_InventoryQuantitiesLengthBuffer:: ds 1
W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer:: ds 1

SECTION "Fusion/Lab Evolution Variables",  WRAM0[$CADF]
W_FusionLabEvo_PreviousItem:: ds 1
W_FusionLabEvo_SelectedItem:: ds 1
W_FusionLabEvo_NextItem:: ds 1
W_FusionLabEvo_NextNextItem:: ds 1
W_FusionLabEvo_NoApplicableItems:: ds 1
W_FusionLabEvo_ScrollPosition:: ds 1
W_FusionLabEvo_ScrollAccelerator:: ds 1
W_FusionLabEvo_ScrollPositionIndex:: ds 1
W_FusionLabEvo_ArrowAnimationState:: ds 1
W_FusionLabEvo_LeftButtonHoldCountdownTimer:: ds 1
W_FusionLabEvo_RightButtonHoldCountdownTimer:: ds 1

SECTION "Fusion/Lab Evolution Variables 2",  WRAM0[$CAEA]
W_FusionLabEvo_TypematicBtns:: ds 1
W_FusionLabEvo_ScrollState:: ds 1

SECTION "Fusion/Lab Evolution - Skip Fade In",  WRAM0[$CAEC]
W_FusionLabEvo_SkipFadeIn:: ds 1

SECTION "Fusion/Lab Evolution - Is Lab Evo",  WRAM0[$CAEE]
W_FusionLabEvo_IsLabEvo:: ds 1

SECTION "Fusion/Lab Evolution States", ROMX[$49DD], BANK[$2A]
FusionLabEvo_StateFadeOutFromOverworld::
	ld a, $2A
	ld hl, $4000
	jp CallBankedFunction_int

FusionLabEvo_StateDrawScreen::
	ld a, 2
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a
	ld a, BANK(FusionLabEvo_StateDrawScreen)
	ld [W_PreviousBank], a
	ld a, [W_Overworld_PartnerSpecies]
	ld [$CAED], a
	ld a, [$CDEC]
	ld [$C908], a
	ld a, 0
	ld [$CDEC], a
	ld a, [$CDEE]
	ld [$C2DD], a
	ld a, 0
	ld [$CDEE], a
	ld a, [$CDE1]
	ld [$C2FD], a
	ld a, 0
	ld [$CDE1], a
	ld bc, $89
	call Overworld_CheckFlagValue
	jr z, .isFusionEvo

.isLabEvo
	ld a, 1
	ld [W_FusionLabEvo_IsLabEvo], a
	ld a, [$C90C]
	ld [W_FusionLabEvo_InFocusItemNumber], a
	jr .specifyApplicableItems

.isFusionEvo
	ld a, 0
	ld [W_FusionLabEvo_IsLabEvo], a
	ld a, [$C90E]
	ld [W_FusionLabEvo_InFocusItemNumber], a

.specifyApplicableItems
	ld a, [W_FusionLabEvo_IsLabEvo]
	or a
	jr z, .useFusionEvoItems

.useLabEvoItems
	ld hl, W_FusionLabEvo_InventoryQuantitiesAddressBuffer
	ld a, (W_PauseMenu_InventoryQuantities + $40) & $FF
	ld [hli], a
	ld a, (W_PauseMenu_InventoryQuantities + $40) >> 8
	ld [hl], a
	ld a, 4
	ld [W_FusionLabEvo_InventoryQuantitiesLengthBuffer], a
	ld a, $40
	ld [W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer], a
	ld de, $5288
	jr .loadTiles

.useFusionEvoItems
	ld hl, W_FusionLabEvo_InventoryQuantitiesAddressBuffer
	ld a, W_PauseMenu_InventoryQuantities & $FF
	ld [hli], a
	ld a, W_PauseMenu_InventoryQuantities >> 8
	ld [hl], a
	ld a, $3A
	ld [W_FusionLabEvo_InventoryQuantitiesLengthBuffer], a
	ld a, 0
	ld [W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer], a
	ld de, $5208

.loadTiles
	ld a, $38
	ld hl, $8800
	ld bc, $80
	call Banked_LCDC_LoadTiles
	ld a, 0
	ld [W_FusionLabEvo_ScrollPosition], a
	ld [W_FusionLabEvo_ScrollAccelerator], a
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld [W_FusionLabEvo_ScrollState], a
	ld [W_FusionLabEvo_SkipFadeIn], a
	ld a, 3
	ld [W_FusionLabEvo_ScrollPositionIndex], a
	ld a, $38
	ld hl, $8F00
	ld de, $4D28
	ld bc, $F0
	call Banked_LCDC_LoadTiles
	ld a, $38
	ld hl, $81F0
	ld de, $51F8
	ld bc, $10
	call Banked_LCDC_LoadTiles
	ld a, $38
	ld hl, $8400
	ld de, $5560
	ld bc, $100
	call Banked_LCDC_LoadTiles
	ld a, $38
	ld hl, $8880
	ld de, $5650
	ld bc, $40
	call Banked_LCDC_LoadTiles
	ld a, $10
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_Bank], a
	ld a, $43
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_LoAttribs], a
	ld a, $34
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, $44
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_YOffset], a
	ld a, $10
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Bank], a
	ld a, $42
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, 0
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_LoAttribs], a
	ld a, $6C
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, $44
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_YOffset], a
	ld a, $10
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_Bank], a
	ld a, $44
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_Index], a
	ld a, 1
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_LoAttribs], a
	ld a, $80
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_XOffset], a
	ld a, $44
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 2) + M_LCDC_MetaSpriteConfig_YOffset], a
	call FusionLabEvo_MapTopAndBottomWindows
	ld a, $B0
	ld [W_MainScript_TileBaseIdx], a
	ld a, BANK(MainScript_ClearTilesShopWindow)
	ld hl, MainScript_ClearTilesShopWindow
	call CallBankedFunction_int
	ld a, $C0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $E0
	ld [W_Status_NumericalTileIndex], a
	ld a, 1
	ld [$CA65], a
	ld a, $B
	ld hl, $4CE5
	call CallBankedFunction_int
	ld a, BANK(FusionLabEvo_StateDrawScreen)
	ld [W_PreviousBank], a
	ld bc, $A
	call Banked_CGBLoadBackgroundPalette
	ld a, 0
	ld [W_FusionLabEvo_NoApplicableItems], a
	call FusionLabEvo_CheckApplicableItemQuantities
	jr z, .noApplicableItemsFound

.applicableItemsFound
	call FusionLabEvo_CorrectInFocusItemNumber
	ld d, $C
	ld b, 0
	ld c, $B9
	call $33D6
	call FusionLabEvo_MapItems
	call FusionLabEvo_DrawVisibleItems
	ld a, 2
	ld [$CADA], a
	call $2CC4
	call $2CC4
	jr .continue

.noApplicableItemsFound
	ld a, 1
	ld [W_FusionLabEvo_NoApplicableItems], a
	ld d, $C
	ld b, 0
	ld c, $B8
	call $33D6
	ld a, 2
	ld [$CADA], a

.continue
	ld a, BANK(FusionLabEvo_StateDrawScreen)
	ld [W_PreviousBank], a
	ld bc, $11
	call Banked_CGBLoadObjectPalette
	call FusionLabEvo_GetWindowFlavourColour
	ld a, $29
	ld hl, $5509
	call CallBankedFunction_int
	ld a, b
	ld [$C2DF], a
	ld a, c
	ld [$C2DE], a
	ld a, 0
	ld [W_CGBPaletteStagedBGP], a
	ld a, 1
	ld [W_OAM_SpritesReady], a
	jp System_ScheduleNextSubState

SECTION "Fusion/Lab Evolution States 2", ROMX[$4E7E], BANK[$2A]
FusionLabEvo_StateFadeInAndBranchOnNoItems::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld bc, 0
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, [W_FusionLabEvo_NoApplicableItems]
	or a
	jp z, .haveItems
	ld a, $1D
	ld [W_SystemSubState], a
	ld a, 5
	ld [W_Sound_NextSFXSelect], a
	ret

.haveItems
	call FusionLabEvo_PrepareItemScroll
	jp System_ScheduleNextSubState

FusionLabEvo_StateItemSelectInputHandler::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_FusionLabEvo_SkipFadeIn]
	or a
	jr nz, .skipFadeIn
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, 1
	ld [W_FusionLabEvo_SkipFadeIn], a

.skipFadeIn
	call FusionLabEvo_AnimateArrows
	call FusionLabEvo_DrawItemData
	call $2CC4
	call FusionLabEvo_AnimateMessageBoxInputIndicator
	call FusionLabEvo_ItemSelectionScrollInputHandler
	call FusionLabEvo_AnimateItemScrollPosition
	ld hl, $C463
	ld a, [W_FusionLabEvo_ScrollPosition]
	ld [hli], a
	ld a, [W_FusionLabEvo_ScrollAccelerator]
	or a
	jr nz, .aNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_A
	jr z, .aNotPressed
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, $C0
	ld [W_MainScript_TileBaseIdx], a
	ld a, $E0
	ld [W_Status_NumericalTileIndex], a
	ld a, 1
	ld [$CA65], a
	ld a, $B
	ld hl, $4CE5
	call CallBankedFunction_int
	ld d, $C
	ld b, 0
	ld c, $B7
	call $33D6
	ld a, 2
	ld [$CADA], a
	ld a, $1E
	ld [W_SystemSubState], a
	call FusionLabEvo_MapBottomWindowTiles

.aNotPressed
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jp z, .bNotPressed
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	call FusionLabEvo_StateNoItems.justExitPlz
	ld a, 0
	ld [W_FusionLabEvo_ArrowAnimationState], a

.bNotPressed
	ret

SECTION "Fusion/Lab Evolution States 3", ROMX[$51A3], BANK[$2A]
FusionLabEvo_StateNoItems::
	ld a, 0
	call Banked_LCDC_PaletteFade
	or a
	ret z
	call $2CC4
	ld a, [W_MainScript_State]
	cp 9
	jr nz, .exit

.justExitPlz
	ld a, 3
	ld [W_Sound_NextSFXSelect], a
	ld a, $2A
	ld [W_PreviousBank], a
	ld a, $1F
	ld [W_SystemSubState], a
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	call FusionLabEvo_ItemSelectionScreenCleanup
	ld a, $C
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld a, 2
	ld [$C917], a
	call Sound_IndexMusicSetBySong
	ld [W_Sound_NextBGMSelect], a

.exit
	ret

FusionLabEvo_StateFadeOutAndReturnToOverworld::
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	inc a
	ld [W_FusionLabEvo_ArrowAnimationState], a
	cp $C
	ret c
	ld a, 1
	call Banked_LCDC_PaletteFade
	or a
	ret z
	ld a, 0
	ld [W_byte_C9CF], a
	ld a, $A
	ld [W_SystemSubState], a
	ld a, [$C908]
	ld [$CDEC], a
	ld a, [$C2DD]
	ld [$CDEE], a
	ld a, [$C2FD]
	ld [$CDE1], a
	call FusionLabEvo_RememberLastItemOfFocus
	ret

SECTION "Fusion/Lab Evolution States 4", ROMX[$5223], BANK[$2A]
FusionLabEvo_StateItemSelectionConfirmation::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	call FusionLabEvo_AnimateArrows
	call $2CC4
	ldh a, [H_JPInput_Changed]
	and M_JPInput_B
	jr nz, .noSelected
	ld a, [W_MainScript_State]
	cp 9
	jr nz, .exit
	ld bc, $C3E
	call Overworld_CheckFlagValue
	jr nz, .yesSelected

.noSelected
	ld c, $B9
	call FusionLabEvo_ClearMessageBox
	ld a, $1C
	ld [W_SystemSubState], a
	ld a, 4
	ld [W_Sound_NextSFXSelect], a
	ret

.yesSelected
	ld a, [W_FusionLabEvo_SelectedItem]
	ld c, a
	dec c
	ld a, [W_FusionLabEvo_InventoryQuantitiesAddressOffsetBuffer]
	add c
	ld c, a
	ld hl, $8000
	call PauseMenu_LoadItemGraphic
	ld a, 0
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 0) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld [W_MetaSpriteConfig2 + (M_MetaSpriteConfig_Size * 1) + M_LCDC_MetaSpriteConfig_HiAttribs], a
	ld a, $20
	ld [W_SystemSubState], a
	ld a, 3
	ld [W_Sound_NextSFXSelect], a

.exit
	ret

SECTION "Fusion/Lab Evolution States 5", ROMX[$5377], BANK[$2A]
; Heaps of redundant code in here.
FusionLabEvo_StatePrepareForFusionScreenTransition::
	ld a, 1
	ld [W_OAM_SpritesReady], a
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	cp 2
	jp c, FusionLabEvo_StatePrepareForFusionScreenTransition_wait
	cp $14
	jp c, FusionLabEvo_StatePrepareForFusionScreenTransition_wait
	cp $14
	jr nz, .cleanup
	jp FusionLabEvo_StatePrepareForFusionScreenTransition_wait

.cleanup
	cp $15
	jr nz, .cleanupB
	call FusionLabEvo_ItemSelectionScreenCleanup
	ld a, $15
	ld [W_FusionLabEvo_ArrowAnimationState], a
	jp FusionLabEvo_StatePrepareForFusionScreenTransition_wait

.cleanupB
	cp $16
	jr nz, .thisShouldNeverFire
	ld b, $70
	ld hl, $98A0
	call FusionLabEvo_DrawItem_itemGfxClearLoop
	call FusionLabEvo_ItemSelectionScreenCleanup
	ld a, [$CAED]
	ld c, 0
	ld de, $9010
	call Banked_Battle_LoadDenjuuPortrait
	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation
	ld a, 0
	ld [W_FusionLabEvo_ArrowAnimationState], a
	jp System_ScheduleNextSubState

.thisShouldNeverFire
	ret

FusionLabEvo_StatePrepareForFusionScreenTransition_wait::
	ld a, [W_FusionLabEvo_ArrowAnimationState]
	inc a
	ld [W_FusionLabEvo_ArrowAnimationState], a
	ret
