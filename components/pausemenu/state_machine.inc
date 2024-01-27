DEF M_PauseMenu_StateLoadGraphics EQU $00
DEF M_PauseMenu_StateLoadMenuHalves EQU $01
DEF M_PauseMenu_StateLoadPalettes EQU $02
DEF M_PauseMenu_StateLoadDMGCompatibility EQU $03
DEF M_PauseMenu_StateAnimateMenuHalvesIn EQU $04
DEF M_PauseMenu_StateInputHandler EQU $05

;Phone number input
DEF M_PauseMenu_StatePhoneIMEInputHandler EQU $06
DEF M_PauseMenu_StatePlayOutCallSFX EQU $07
DEF M_PauseMenu_StatePlayCallSFX2 EQU $08
DEF M_PauseMenu_StateCheckCallStatusAndTransition EQU $09
DEF M_PauseMenu_StateExitPhoneIME EQU $0A

;Menu animations
DEF M_PauseMenu_StateAnimateMenuScrollUpOne EQU $0B
DEF M_PauseMenu_StateAnimateMenuScrollUpTwo EQU $0C
DEF M_PauseMenu_StateAnimateMenuScrollFinish EQU $0D
DEF M_PauseMenu_StateAnimateMenuScrollDownOne EQU $0E
DEF M_PauseMenu_StateAnimateMenuScrollDownTwo EQU $0F

;Subscreens - each one it's own state machine!
DEF M_PauseMenu_StateContactSubscreen EQU $10
DEF M_PauseMenu_StateMeloDSubscreen EQU $11
DEF M_PauseMenu_StateInventorySubscreen EQU $12
DEF M_PauseMenu_StateSMSSubscreen EQU $13
DEF M_PauseMenu_StateSaveSubscreen EQU $14
DEF M_PauseMenu_StateOptionsSubscreen EQU $15
DEF M_PauseMenu_StateCallsSubscreen EQU $16
DEF M_PauseMenu_StateExitToOverworld EQU $17
DEF M_PauseMenu_StateZukanSubscreen EQU $18

;Outgoing call logic
DEF M_PauseMenu_StateTransitionToOutgoingCall EQU $19

;Contact call dialogue sequence
DEF M_PauseMenu_StateLoadOutgoingContactCallGraphics EQU $1A
DEF M_PauseMenu_StateFadeInAndQueueContactMessage EQU $1B
DEF M_PauseMenu_StateDeliverContactMessage EQU $1C
DEF M_PauseMenu_StateTransitionOutOfOutboundContactCall EQU $1D

;Dummy states
DEF M_PauseMenu_State1E EQU $1E
DEF M_PauseMenu_State1F EQU $1F

;Secret denjuu recruitment sequence
DEF M_PauseMenu_StateLoadOutgoingSecretCallGraphics EQU $20
DEF M_PauseMenu_StateFadeInAndQueueSecretMessage EQU $21
DEF M_PauseMenu_StateDeliverSecretMessage EQU $22
DEF M_PauseMenu_StateTransitionOutOfOutboundSecretCall EQU $23

;Enumeration for menu items
DEF M_PauseMenu_MenuItemContacts EQU $00
DEF M_PauseMenu_MenuItemCalls EQU $01
DEF M_PauseMenu_MenuItemMeloD EQU $02
DEF M_PauseMenu_MenuItemInventory EQU $03
DEF M_PauseMenu_MenuItemSMS EQU $04
DEF M_PauseMenu_MenuItemSave EQU $05
DEF M_PauseMenu_MenuItemOptions EQU $06
DEF M_PauseMenu_MenuItemExit EQU $07
DEF M_PauseMenu_MenuItemZukan EQU $08