M_TitleScreen_StateLoadGraphicsAndSound EQU $00
M_TitleScreen_StateLoadTilemapsAndSprites EQU $01
M_TitleScreen_StateLoadPalettes EQU $02
M_TitleScreen_StateFadeIn EQU $03
M_TitleScreen_StateStageSprites EQU $04
M_TitleScreen_StatePlaySample EQU $05
M_TitleScreen_StateIdle EQU $06
M_TitleScreen_StateFadeOutToMenu EQU $07

;Corrupt Save warning
M_TitleScreen_StateCorruptSaveCheck EQU $08
M_TitleScreen_StateCorruptSaveLoadPalettes EQU $09
M_TitleScreen_StateCorruptSaveLoadGraphics EQU $0A
M_TitleScreen_StateCorruptSaveLoadTilemaps EQU $0B
M_TitleScreen_StateCorruptSaveFadeIn EQU $0C ;alias of $03
M_TitleScreen_StateCorruptSaveStageSprites EQU $0D ;alias of $04
M_TitleScreen_StateCorruptSaveIdle EQU $0E
M_TitleScreen_StateCorruptSaveFadeOut EQU $0F ;alias of $07
M_TitleScreen_StateJumpToTitleMenu EQU $10

;Attract time-out
M_TitleScreen_StateFadeOutToAttract EQU $11 ;alias of $07
M_TitleScreen_StateJumpToAttract EQU $12