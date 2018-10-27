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

;Sound test
M_TitleMenu_StateLoadSoundTestScreen EQU $18
M_TitleMenu_StateSoundTestInputHandler EQU $19
M_TitleMenu_StateSoundTestExit EQU $1A

;Save Overwrite Warning
M_TitleMenu_StateSaveOverwriteEnter EQU $1B
M_TitleMenu_StateSaveOverwriteInputHandler EQU $1C
M_TitleMenu_StateSaveOverwriteConfirmed EQU $1D
M_TitleMenu_StateSaveOverwriteCancelled EQU $1E
M_TitleMenu_StateSaveOverwriteExitLoadGraphics EQU $1F

;Name input (denjuu)
M_TitleMenu_StateInitNickname EQU $20
M_TitleMenu_StateFadeNickname EQU $21
M_TitleMenu_StateNickname EQU $22
M_TitleMenu_StateSaveNickname EQU $23
M_TitleMenu_StateReturnToOverworld EQU $24

;Menu items
M_TitleMenu_ItemContinue EQU 0
M_TitleMenu_ItemSoundTest EQU 1
M_TitleMenu_ItemLink EQU 2
M_TitleMenu_ItemNewGame EQU 3