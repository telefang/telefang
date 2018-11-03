M_PauseMenu_StateLoadGraphics EQU $00
M_PauseMenu_StateLoadMenuHalves EQU $01
M_PauseMenu_StateLoadPalettes EQU $02
M_PauseMenu_StateLoadDMGCompatibility EQU $03
M_PauseMenu_StateAnimateMenuHalvesIn EQU $04
M_PauseMenu_StateInputHandler EQU $05

;Menu animations
M_PauseMenu_StateAnimateMenuScrollUpOne EQU $0B
M_PauseMenu_StateAnimateMenuScrollUpTwo EQU $0C
M_PauseMenu_StateAnimateMenuScrollFinish EQU $0D
M_PauseMenu_StateAnimateMenuScrollDownOne EQU $0E
M_PauseMenu_StateAnimateMenuScrollDownTwo EQU $0F

;Subscreens - each one it's own state machine!
M_PauseMenu_StateContactSubscreen EQU $10
M_PauseMenu_StateMeloDSubscreen EQU $11
M_PauseMenu_StateInventorySubscreen EQU $12
M_PauseMenu_StateSMSSubscreen EQU $13
M_PauseMenu_StateSaveSubscreen EQU $14
M_PauseMenu_StateCallsSubscreen EQU $16
M_PauseMenu_StateExitToOverworld EQU $17
M_PauseMenu_StateZukanSubscreen EQU $18

;Enumeration for menu items
M_PauseMenu_MenuItemContacts EQU $00
M_PauseMenu_MenuItemCalls EQU $01
M_PauseMenu_MenuItemMeloD EQU $02
M_PauseMenu_MenuItemInventory EQU $03
M_PauseMenu_MenuItemSMS EQU $04
M_PauseMenu_MenuItemSave EQU $05
M_PauseMenu_MenuItemOptions EQU $06
M_PauseMenu_MenuItemExit EQU $07
M_PauseMenu_MenuItemZukan EQU $08