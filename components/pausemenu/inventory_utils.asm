INCLUDE "telefang.inc"

SECTION "Pause Menu Inventory Utility Memory", WRAM0[$CB21]
W_PauseMenu_InventorySlotCounter:: ds 1

SECTION "Pause Menu Inventory Utility Memory 2", WRAM0[$CB37]
W_PauseMenu_ActiveInventoryCount:: ds 1

SECTION "Pause Menu Inventory Utility Memory 3", WRAM0[$CB6F]
W_PauseMenu_CurrentInventorySlot:: ds 1

SECTION "Pause Menu Inventory Utility Memory 4", WRAM0[$CDBC]
W_PauseMenu_InventoryQuantities:: ds M_SaveClock_InventoryCount

SECTION "Pause Menu Inventory Utilities", ROMX[$6279], BANK[$4]
PauseMenu_CompactItemInventory::
    xor a
    ld [W_PauseMenu_ActiveInventoryCount], a
    ld [W_PauseMenu_InventorySlotCounter], a
    
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    
    ld hl, W_PauseMenu_InventoryQuantities
    ld b, M_SaveClock_InventoryCount
    ld de, S_SaveClock_InventoryArray
    
.compactLoop
    push bc
    
    ld a, [hli]
    ld [W_System_GenericCounter], a
    
    cp 0
    jr z, .gotoNextSlot
    
    ld a, BANK(S_SaveClock_InventoryArray)
    ld [REG_MBC3_SRAMBANK], a
    
    ld a, [W_System_GenericCounter]
    ld [de], a
    
    inc de
    ld a, [W_PauseMenu_InventorySlotCounter]
    ld [de], a
    
    inc de
    ld a, [W_PauseMenu_ActiveInventoryCount]
    inc a
    ld [W_PauseMenu_ActiveInventoryCount], a
    
.gotoNextSlot
    ld a, [W_PauseMenu_InventorySlotCounter]
    inc a
    ld [W_PauseMenu_InventorySlotCounter], a
    
    pop bc
    
    dec b
    jr nz, .compactLoop
    jp TitleMenu_ExitSRAM
    
PauseMenu_ReadInventorySlotData::
    push af
    
    ld b, BANK(S_SaveClock_InventoryArray)
    call TitleMenu_EnterSRAM
    
    pop af
    
    ld hl, S_SaveClock_InventoryArray
    call PauseMenu_IndexPtrTable
    
    ld a, [hli] ;Quantity
    
    push af
    
    ld a, [hli] ;Item ID
    ld b, a
    call TitleMenu_ExitSRAM
    
    pop af
    
    ret
    
PauseMenu_LoadCurrentSlotItemPalette::
    ld a, [W_PauseMenu_CurrentInventorySlot]
    call PauseMenu_ReadInventorySlotData
    
PauseMenu_LoadItemPalette::
    ld e, b
    ld d, 0
    ld hl, $1E0
    add hl, de
    
    push hl
    pop bc
    
    ld a, 7
    call CGBLoadBackgroundPaletteBanked
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ret
    
SECTION "Pause Menu Inventory Utilities 2", ROMX[$736E], BANK[$4]
PauseMenu_UpdateItemScreenCursorAnimations::
    ld a, $40
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, 8
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $50
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, [W_PauseMenu_ActiveInventoryCount]
    dec a
    cp 0
    jr nz, .dontRemoveSprites
    
.removeSprites
    xor a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
.dontRemoveSprites
    ld a, 0
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_Bank], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_Bank], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    jp Banked_PauseMenu_IterateCursorAnimation