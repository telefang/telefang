M_PauseMenu_StateLoadGraphics EQU $00
M_PauseMenu_StateLoadMenuHalves EQU $01
M_PauseMenu_StateLoadPalettes EQU $02
M_PauseMenu_StateLoadDMGCompatibility EQU $03
M_PauseMenu_StateAnimateMenuHalvesIn EQU $04
M_PauseMenu_StateInputHandler EQU $05

;Phone number input
M_PauseMenu_StatePhoneIMEInputHandler EQU $06
M_PauseMenu_StatePlayOutCallSFX EQU $07
M_PauseMenu_StatePlayCallSFX2 EQU $08
M_PauseMenu_StateCheckCallStatusAndTransition EQU $09
M_PauseMenu_StateExitPhoneIME EQU $0A

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

;Outgoing call logic
M_PauseMenu_StateTransitionToOutgoingCall EQU $19

;Contact call dialogue sequence
M_PauseMenu_StateLoadOutgoingContactCallGraphics EQU $1A
M_PauseMenu_StateFadeInAndQueueContactMessage EQU $1B
M_PauseMenu_StateDeliverContactMessage EQU $1C
M_PauseMenu_StateTransitionOutOfOutboundContactCall EQU $1D

;Dummy states
M_PauseMenu_State1E EQU $1E
M_PauseMenu_State1F EQU $1F

;Secret denjuu recruitment sequence
M_PauseMenu_StateLoadOutgoingSecretCallGraphics EQU $20
M_PauseMenu_StateFadeInAndQueueSecretMessage EQU $21
M_PauseMenu_StateDeliverSecretMessage EQU $22
M_PauseMenu_StateTransitionOutOfOutboundSecretCall EQU $23

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