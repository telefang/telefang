;Title Menu
M_TitleMenu_StateSetupPalettes EQU $00
M_TitleMenu_StateLoadGraphics EQU $01
M_TitleMenu_StateLoadTMaps EQU $02
M_TitleMenu_StateDrawMenu EQU $03
M_TitleMenu_StatePositionMenuHalves EQU $04
M_TitleMenu_StateCommitMenuPalettes EQU $05
M_TitleMenu_StatePlayMenuBGM EQU $06
M_TitleMenu_StateAnimateMenuHalvesIn EQU $07
M_TitleMenu_StateMenuInputHandler EQU $08
M_TitleMenu_StateAnimateMenuScrollUpOne EQU $09
M_TitleMenu_StateAnimateMenuScrollUpTwo EQU $0A
M_TitleMenu_StateAnimateMenuScrollFinish EQU $0B
M_TitleMenu_StateAnimateMenuScrollDownOne EQU $0C
M_TitleMenu_StateAnimateMenuScrollDownTwo EQU $0D

;Continue option
M_TitleMenu_StateFadeToOverworldContinue EQU $0E

;Time input
M_TitleMenu_StateLoadTimeInputScreen EQU $0F
M_TitleMenu_StateResetTimeDrawWidget EQU $10
M_TitleMenu_StateTimeInputHandler EQU $11

;Name input (player)
M_TitleMenu_StateLoadNameInputScreen EQU $12
M_TitleMenu_StateClearNameInput EQU $13
M_TitleMenu_StateNameInput EQU $14
M_TitleMenu_StateStorePlayerName EQU $15

;Start option
M_TitleMenu_StateInitNewGame EQU $16
M_TitleMenu_StateFadeToOverworldNewGame EQU $17

;Name input (denjuu)
M_TitleMenu_StateInitNickname EQU $20
M_TitleMenu_StateFadeNickname EQU $21
M_TitleMenu_StateNickname EQU $22
M_TitleMenu_StateSaveNickname EQU $23