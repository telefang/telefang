;Title Menu
DEF M_TitleMenu_StateSetupPalettes EQU $00
DEF M_TitleMenu_StateLoadGraphics EQU $01
DEF M_TitleMenu_StateLoadTMaps EQU $02
DEF M_TitleMenu_StateDrawMenu EQU $03
DEF M_TitleMenu_StatePositionMenuHalves EQU $04
DEF M_TitleMenu_StateCommitMenuPalettes EQU $05
DEF M_TitleMenu_StatePlayMenuBGM EQU $06
DEF M_TitleMenu_StateAnimateMenuHalvesIn EQU $07
DEF M_TitleMenu_StateMenuInputHandler EQU $08
DEF M_TitleMenu_StateAnimateMenuScrollUpOne EQU $09
DEF M_TitleMenu_StateAnimateMenuScrollUpTwo EQU $0A
DEF M_TitleMenu_StateAnimateMenuScrollFinish EQU $0B
DEF M_TitleMenu_StateAnimateMenuScrollDownOne EQU $0C
DEF M_TitleMenu_StateAnimateMenuScrollDownTwo EQU $0D

;Continue option
DEF M_TitleMenu_StateFadeToOverworldContinue EQU $0E

;Time input
DEF M_TitleMenu_StateLoadTimeInputScreen EQU $0F
DEF M_TitleMenu_StateResetTimeDrawWidget EQU $10
DEF M_TitleMenu_StateTimeInputHandler EQU $11

;Name input (player)
DEF M_TitleMenu_StateLoadNameInputScreen EQU $12
DEF M_TitleMenu_StateClearNameInput EQU $13
DEF M_TitleMenu_StateNameInput EQU $14
DEF M_TitleMenu_StateStorePlayerName EQU $15

;Start option
DEF M_TitleMenu_StateInitNewGame EQU $16
DEF M_TitleMenu_StateFadeToOverworldNewGame EQU $17

;Sound test
DEF M_TitleMenu_StateLoadSoundTestScreen EQU $18
DEF M_TitleMenu_StateSoundTestInputHandler EQU $19
DEF M_TitleMenu_StateSoundTestExit EQU $1A

;Save Overwrite Warning
DEF M_TitleMenu_StateSaveOverwriteEnter EQU $1B
DEF M_TitleMenu_StateSaveOverwriteInputHandler EQU $1C
DEF M_TitleMenu_StateSaveOverwriteConfirmed EQU $1D
DEF M_TitleMenu_StateSaveOverwriteCancelled EQU $1E
DEF M_TitleMenu_StateSaveOverwriteExitLoadGraphics EQU $1F

;Name input (denjuu)
DEF M_TitleMenu_StateInitNickname EQU $20
DEF M_TitleMenu_StateFadeNickname EQU $21
DEF M_TitleMenu_StateNickname EQU $22
DEF M_TitleMenu_StateSaveNickname EQU $23
DEF M_TitleMenu_StateReturnToOverworld EQU $24

;Menu items
DEF M_TitleMenu_ItemContinue EQU 0
DEF M_TitleMenu_ItemSoundTest EQU 1
DEF M_TitleMenu_ItemLink EQU 2
DEF M_TitleMenu_ItemNewGame EQU 3