DEF M_TitleScreen_StateLoadGraphicsAndSound EQU $00
DEF M_TitleScreen_StateLoadTilemapsAndSprites EQU $01
DEF M_TitleScreen_StateLoadPalettes EQU $02
DEF M_TitleScreen_StateFadeIn EQU $03
DEF M_TitleScreen_StateStageSprites EQU $04
DEF M_TitleScreen_StatePlaySample EQU $05
DEF M_TitleScreen_StateIdle EQU $06
DEF M_TitleScreen_StateFadeOutToMenu EQU $07

;Corrupt Save warning
DEF M_TitleScreen_StateCorruptSaveCheck EQU $08
DEF M_TitleScreen_StateCorruptSaveLoadPalettes EQU $09
DEF M_TitleScreen_StateCorruptSaveLoadGraphics EQU $0A
DEF M_TitleScreen_StateCorruptSaveLoadTilemaps EQU $0B
DEF M_TitleScreen_StateCorruptSaveFadeIn EQU $0C ;alias of $03
DEF M_TitleScreen_StateCorruptSaveStageSprites EQU $0D ;alias of $04
DEF M_TitleScreen_StateCorruptSaveIdle EQU $0E
DEF M_TitleScreen_StateCorruptSaveFadeOut EQU $0F ;alias of $07
DEF M_TitleScreen_StateJumpToTitleMenu EQU $10

;Attract time-out
DEF M_TitleScreen_StateFadeOutToAttract EQU $11 ;alias of $07
DEF M_TitleScreen_StateJumpToAttract EQU $12