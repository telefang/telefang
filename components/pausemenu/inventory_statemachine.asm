INCLUDE "telefang.inc"

SECTION "Pause Menu Inventory State Machine", ROMX[$4EE7], BANK[$4]
PauseMenu_InventoryStateMachine::
    call $56E7
    ld a, [W_SystemSubSubState]
    ld hl, .stateTbl
    call System_IndexWordList
    jp hl
    
.stateTbl
    dw PauseMenu_SubStateInventoryCheck
    dw PauseMenu_SubStateInventoryLoadGraphic
    dw PauseMenu_SubStateInventoryDrawNameQty
    dw PauseMenu_SubStateInventoryListingIdle
    dw PauseMenu_SubStateInventoryEmptyIdle
    dw PauseMenu_SubStateInventoryHang5
    dw PauseMenu_SubStateInventoryHang6
    dw PauseMenu_SubStateSMSExit1
    dw PauseMenu_SubStateSMSExit2
    
;State 0C 12 00
PauseMenu_SubStateInventoryCheck::
    xor a
    ld [W_PauseMenu_CurrentInventorySlot], a
    call PauseMenu_CompactItemInventory
    
    ld a, [W_PauseMenu_ActiveInventoryCount]
    cp 0
    jr z, .noItems
    
.hasItems
    xor a
    ld [W_PauseMenu_CurrentInventorySlot], a
    jp System_ScheduleNextSubSubState
    
.noItems
    ld c, $43
    ld hl, $9400
    call Banked_PauseMenu_LoadItemGraphic
    
    ld b, $43
    call PauseMenu_LoadItemPalette
    
    ld e, $31
    call PauseMenu_LoadMenuMap0
    
    xor a
    ld hl, $9A06
    call PauseMenu_DecimalizeAndDrawBothDigits
    
    ld a, M_PauseMenu_SubStateInventoryEmptyIdle
    ld [W_SystemSubSubState], a
    ret
    
;State 0C 12 01
PauseMenu_SubStateInventoryLoadGraphic::
    ld a, [W_PauseMenu_CurrentInventorySlot]
    call PauseMenu_ReadInventorySlotData
    
    ld c, b
    ld hl, $9400
    call Banked_PauseMenu_LoadItemGraphic
    call PauseMenu_LoadCurrentSlotItemPalette
    jp System_ScheduleNextSubSubState
    
;State 0C 12 02
PauseMenu_SubStateInventoryDrawNameQty::
    ld a, [W_PauseMenu_CurrentInventorySlot]
    call PauseMenu_ReadInventorySlotData
    
    ld a, b
    call PauseMenu_ItemPrepName
    
    ld e, $31
    call PauseMenu_LoadMenuMap0
    
    ld bc, $10D
    ld e, $2F
    ld a, 0
    call Banked_RLEDecompressTMAP0
    call PauseMenu_DrawInventorySlotQuantity
    
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_InitializeCursor
    
    ld a, $B
    ld [W_PauseMenu_SelectedCursorType], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    call Banked_PauseMenu_InitializeCursor
    jp System_ScheduleNextSubSubState
    
;State 0C 12 03
PauseMenu_SubStateInventoryListingIdle::
    call PauseMenu_UpdateItemScreenCursorAnimations
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Right ;Right
    jr z, .checkLeft
    
.rightPressed
    ld a, [W_PauseMenu_ActiveInventoryCount]
    dec a
    ld b, a
    
    ld a, [W_PauseMenu_CurrentInventorySlot]
    cp b
    jr nz, .incrementSlot
    
.resetToZero
    ld a, $FF
    
.incrementSlot
    inc a
    ld [W_PauseMenu_CurrentInventorySlot], a
    
    ld a, M_PauseMenu_SubStateInventoryLoadGraphic
    ld [W_SystemSubSubState], a
    
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ret
    
.checkLeft
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Left ;Left
    jr z, .checkButtonB
    
.leftPressed
    ld a, [W_PauseMenu_CurrentInventorySlot]
    cp 0
    jr nz, .decrementSlot
    
.resetToMax
    ld a, [W_PauseMenu_ActiveInventoryCount]
    
.decrementSlot
    dec a
    ld [W_PauseMenu_CurrentInventorySlot], a
    
    ld a, M_PauseMenu_SubStateInventoryLoadGraphic
    ld [W_SystemSubSubState], a
    
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    ret
    
.checkButtonB
    ld a, [H_JPInput_Changed]
    and M_JPInput_B ;Button B
    jr z, .checkButtonA
    
.buttonBPressed
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    call PauseMenu_ClearArrowMetasprites
    
    ld a, M_PauseMenu_SubStateInventoryExit1
    ld [W_SystemSubSubState], a
    ret
    
.checkButtonA
    ld a, [H_JPInput_Changed]
    and M_JPInput_A ;Button A
    ret z
    
.buttonAPressed
    ld a, 3
    ld [W_Overworld_State], a
    
    ld a, [W_PauseMenu_CurrentInventorySlot]
    call PauseMenu_ReadInventorySlotData
    
    ld a, b
    ld [$C90D], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    call PauseMenu_ClearArrowMetasprites
    
    ld a, $17
    ld [W_SystemSubState], a
    
    xor a
    ld [W_SystemSubSubState], a
    
    ret
    
;State 0C 12 04
PauseMenu_SubStateInventoryEmptyIdle::
    ld a, [H_JPInput_Changed]
    and M_JPInput_A + M_JPInput_B
    ret z
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    ld a, M_PauseMenu_SubStateInventoryExit1
    ld [W_SystemSubSubState], a
    ret
    
;State 0C 12 05
PauseMenu_SubStateInventoryHang5::
    ret
    
;State 0C 12 06
PauseMenu_SubStateInventoryHang6::
    ret