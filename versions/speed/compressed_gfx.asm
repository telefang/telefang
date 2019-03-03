INCLUDE "macros.asm"

SECTION "Compressed gfx pointer table", ROMX[$4000], BANK[$6]
	dbwb $00,	$8000, 0 ; $00
	dbwb BANK(BattleMessagesGfx),	$8100, 0 ; $01
	dbwb BANK(UnknownFontGfx),	$8cd0, 0 ; $02
	dbwb BANK(IntroScreensGfx),	$9000, 0 ; $03
	dbwb BANK(IntroBonbonGfx),	$8800, 0 ; $04
	dbwb BANK(MenuOptionsGfx),	$9400, 0 ; $05
	dbwb BANK(TitleSpritesGfx),	$8000, 0 ; $06
	dbwb BANK(CutsceneConnected1Gfx),	$9000, 0 ; $07
	dbwb BANK(CutsceneConnected2Gfx),	$8800, 0 ; $08
	dbwb BANK(EvolveBgGfx),	$8b80, 0 ; $09
	dbwb BANK(TitleTitle1Gfx),	$9000, 0 ; $0a
	dbwb BANK(TitleTitle2Gfx),	$8800, 0 ; $0b
	dbwb BANK(ScreenSaveDeletedGfx),	$9000, 0 ; $0c
	dbwb BANK(MenuUnkGfx),	$8e00, 0 ; $0d
	dbwb BANK(MenuStatsGfx),	$9000, 0 ; $0e
	dbwb BANK(MenuEncounterGfx),	$9000, 0 ; $0f
	dbwb BANK(MenuBattleGfx),	$9000, 0 ; $10
	dbwb BANK(MenuMiscSpritesGfx),	$8000, 0 ; $11
	dbwb BANK(MenuTotalGfx),	$8f00, 0 ; $12
	dbwb BANK(MenuDmeloGfx),	$9400, 0 ; $13
	dbwb BANK(MenuBattle2Gfx),	$9000, 0 ; $14
	dbwb BANK(MenuBattle3Gfx),	$9000, 0 ; $15
	dbwb BANK(MenuGotNumberGfx),	$9000, 0 ; $16
	dbwb BANK(MenuNicknameGfx),	$8e00, 0 ; $17
	dbwb BANK(MenuNumbersGfx),	$9600, 0 ; $18
	dbwb BANK(EvolveBg2Gfx),	$8b80, 0 ; $19
	dbwb BANK(MenuMain1Gfx),	$9400, 0 ; $1a
	dbwb BANK(MenuMain2Gfx),	$8e00, 0 ; $1b
	dbwb $36,	$9000, 0 ; $1c
	dbwb BANK(EvolveBg3Gfx),	$9000, 0 ; $1d
	dbwb BANK(EvolveBg4Gfx),	$9000, 0 ; $1e
	dbwb BANK(EvolveCannotGfx),	$9400, 0 ; $1f
	dbwb BANK(TilemapOverworldGfx),	$9000, 0 ; $20
	dbwb BANK(TilemapAntennaGfx),	$9000, 0 ; $21
	dbwb BANK(TilemapDungeonGfx),	$9000, 0 ; $22
	dbwb BANK(TilemapCaveGfx),	$9000, 0 ; $23
	dbwb BANK(TilemapHouseGfx),	$9000, 0 ; $24
	dbwb BANK(TilemapTreeGfx),	$9000, 0 ; $25
	dbwb BANK(TilemapDungeon2Gfx),	$9000, 0 ; $26
	dbwb BANK(TilemapDungeon3Gfx),	$9000, 0 ; $27
	dbwb BANK(TilemapDungeon4Gfx),	$9000, 0 ; $28
	dbwb BANK(TilemapHuman1Gfx),	$9000, 0 ; $29
	dbwb BANK(TilemapHumanAntennaGfx),	$9000, 0 ; $2a
	dbwb BANK(TilemapHuman2Gfx),	$9000, 0 ; $2b
	dbwb BANK(TilemapShrineGfx),	$9000, 0 ; $2c
	dbwb $29,	$9000, 0 ; $2d
	dbwb $29,	$9000, 0 ; $2e
	dbwb $29,	$9000, 0 ; $2f
	dbwb BANK(IntroShadowGymnos1Gfx),	$9000, 0 ; $30
	dbwb BANK(IntroShadowGymnos2Gfx),	$8800, 0 ; $31
	dbwb BANK(IntroShigekiGfx),	$9000, 0 ; $32
	dbwb BANK(IntroTreesGfx),	$9000, 0 ; $33
	dbwb BANK(IntroFungusShigeki1Gfx),	$9000, 0 ; $34
	dbwb BANK(IntroFungusShigeki2Gfx),	$8800, 0 ; $35
	dbwb BANK(IntroGymnos1Gfx),	$9000, 0 ; $36
	dbwb BANK(IntroGymnos2Gfx),	$8800, 0 ; $37
	dbwb BANK(IntroFungus1Gfx),	$9000, 0 ; $38
	dbwb BANK(IntroFungus2Gfx),	$8800, 0 ; $39
	dbwb BANK(IntroShigekiSprites1Gfx),	$8000, 0 ; $3a
	dbwb BANK(IntroShigekiSprites2Gfx),	$8000, 0 ; $3b
	dbwb BANK(IntroShigekiMouthGfx),	$8000, 0 ; $3c
	dbwb BANK(IntroFungusCallGfx),	$8000, 0 ; $3d
	dbwb BANK(IntroCryptoShigekiSpritesGfx),	$8000, 0 ; $3e
	dbwb BANK(UnusedClawGfx),	$8000, 0 ; $3f
	dbwb BANK(MenuMultiplayerGfx),	$9000, 0 ; $40
	dbwb BANK(MenuMultiplayer2Gfx),	$8800, 0 ; $41
	dbwb BANK(ScreenGameOverGfx),	$9000, 0 ; $42
	dbwb BANK(ScreenGameOver2Gfx),	$8800, 0 ; $43
	dbwb $29,	$9000, 0 ; $44
	dbwb $29,	$9000, 0 ; $45
	dbwb $29,	$9000, 0 ; $46
	dbwb $29,	$9000, 0 ; $47
	dbwb BANK(MenuMetGfx),	$8f00, 0 ; $48
	dbwb $29,	$9000, 0 ; $49
	dbwb $29,	$9000, 0 ; $4a
	dbwb $29,	$9000, 0 ; $4b
	dbwb $29,	$9000, 0 ; $4c
	dbwb $29,	$9000, 0 ; $4d
	dbwb $29,	$9000, 0 ; $4e
	dbwb $29,	$9000, 0 ; $4f
	dbwb BANK(CutsceneAntennaTreeGfx),	$9000, 0 ; $50
	dbwb BANK(CutsceneKaiGfx),	$9000, 0 ; $51
	dbwb BANK(CutsceneUnusedGfx),	$9000, 0 ; $52
	dbwb $37,	$9000, 0 ; $53
	dbwb BANK(MenuMain1DMGGfx),	$9400, 0 ; $54
	dbwb BANK(MenuMain2DMGGfx),	$8e00, 0 ; $55
	dbwb BANK(MenuUnkDMGGfx),	$8e00, 0 ; $56
	dbwb BANK(MenuTotalDMGGfx),	$8f00, 0 ; $57
	dbwb BANK(MenuNicknameDMGGfx),	$8e00, 0 ; $58
	dbwb BANK(MenuOptionsDMGGfx),	$9400, 0 ; $59
	dbwb BANK(MenuDmeloDMGGfx),	$9400, 0 ; $5a
	dbwb BANK(MenuMetDMGGfx),	$8f00, 0 ; $5b
	dbwb $29,	$9000, 0 ; $5c
	dbwb $29,	$9000, 0 ; $5d
	dbwb $29,	$9000, 0 ; $5e
	dbwb $29,	$9000, 0 ; $5f

SECTION "Compressed gfx pointer table 2", ROM0[$1DE1]
	dw $0000 ; $00
	dw BattleMessagesGfx ; $01
	dw UnknownFontGfx ; $02
	dw IntroScreensGfx ; $03
	dw IntroBonbonGfx ; $04
	dw MenuOptionsGfx ; $05
	dw TitleSpritesGfx ; $06
	dw CutsceneConnected1Gfx ; $07
	dw CutsceneConnected2Gfx ; $08
	dw EvolveBgGfx ; $09
	dw TitleTitle1Gfx ; $0a
	dw TitleTitle2Gfx ; $0b
	dw ScreenSaveDeletedGfx ; $0c
	dw MenuUnkGfx ; $0d
	dw MenuStatsGfx ; $0e
	dw MenuEncounterGfx ; $0f
	dw MenuBattleGfx ; $10
	dw MenuMiscSpritesGfx ; $11
	dw MenuTotalGfx ; $12
	dw MenuDmeloGfx ; $13
	dw MenuBattle2Gfx ; $14
	dw MenuBattle3Gfx ; $15
	dw MenuGotNumberGfx ; $16
	dw MenuNicknameGfx ; $17
	dw MenuNumbersGfx ; $18
	dw EvolveBg2Gfx ; $19
	dw MenuMain1Gfx ; $1a
	dw MenuMain2Gfx ; $1b
	dw $0000 ; $1c
	dw EvolveBg3Gfx ; $1d
	dw EvolveBg4Gfx ; $1e
	dw EvolveCannotGfx ; $1f
	dw TilemapOverworldGfx ; $20
	dw TilemapAntennaGfx ; $21
	dw TilemapDungeonGfx ; $22
	dw TilemapCaveGfx ; $23
	dw TilemapHouseGfx ; $24
	dw TilemapTreeGfx ; $25
	dw TilemapDungeon2Gfx ; $26
	dw TilemapDungeon3Gfx ; $27
	dw TilemapDungeon4Gfx ; $28
	dw TilemapHuman1Gfx ; $29
	dw TilemapHumanAntennaGfx ; $2a
	dw TilemapHuman2Gfx ; $2b
	dw TilemapShrineGfx ; $2c
	dw $0000 ; $2d
	dw $0000 ; $2e
	dw $0000 ; $2f
	dw IntroShadowGymnos1Gfx ; $30
	dw IntroShadowGymnos2Gfx ; $31
	dw IntroShigekiGfx ; $32
	dw IntroTreesGfx ; $33
	dw IntroFungusShigeki1Gfx ; $34
	dw IntroFungusShigeki2Gfx ; $35
	dw IntroGymnos1Gfx ; $36
	dw IntroGymnos2Gfx ; $37
	dw IntroFungus1Gfx ; $38
	dw IntroFungus2Gfx ; $39
	dw IntroShigekiSprites1Gfx ; $3a
	dw IntroShigekiSprites2Gfx ; $3b
	dw IntroShigekiMouthGfx ; $3c
	dw IntroFungusCallGfx ; $3d
	dw IntroCryptoShigekiSpritesGfx ; $3e
	dw UnusedClawGfx ; $3f
	dw MenuMultiplayerGfx ; $40
	dw MenuMultiplayer2Gfx ; $41
	dw ScreenGameOverGfx ; $42
	dw ScreenGameOver2Gfx ; $43
	dw $0000 ; $44
	dw $0000 ; $45
	dw $0000 ; $46
	dw $0000 ; $47
	dw MenuMetGfx ; $48
	dw $0000 ; $49
	dw $0000 ; $4a
	dw $0000 ; $4b
	dw $0000 ; $4c
	dw $0000 ; $4d
	dw $0000 ; $4e
	dw $0000 ; $4f
	dw CutsceneAntennaTreeGfx ; $50
	dw CutsceneKaiGfx ; $51
	dw CutsceneUnusedGfx ; $52
	dw $0000 ; $53
	dw MenuMain1DMGGfx ; $54
	dw MenuMain2DMGGfx ; $55
	dw MenuUnkDMGGfx ; $56
	dw MenuTotalDMGGfx ; $57
	dw MenuNicknameDMGGfx ; $58
	dw MenuOptionsDMGGfx ; $59
	dw MenuDmeloDMGGfx ; $5a
	dw MenuMetDMGGfx ; $5b
	dw $0000 ; $5c
	dw $0000 ; $5d
	dw $0000 ; $5e
	dw $0000 ; $5f
NOT_COMPRESSED EQU 0
COMPRESSED EQU 1

SECTION "Battle Messages Compressed GFX", ROMX[$41ee], BANK[$37]
BattleMessagesGfx:
	db COMPRESSED
	INCBIN "gfx/battle_messages.malias"
BattleMessagesGfxEnd

SECTION "Unknown Font Compressed GFX", ROMX[$615c], BANK[$36]
UnknownFontGfx:
	db COMPRESSED
	INCBIN "gfx/unknown_font.malias"
UnknownFontGfxEnd

SECTION "Intro - Screens Compressed GFX", ROMX[$4000], BANK[$36]
IntroScreensGfx:
	db COMPRESSED
	INCBIN "gfx/intro/screens.malias"
IntroScreensGfxEnd

IntroBonbonGfx:
	db COMPRESSED
	INCBIN "gfx/intro/bonbon.malias"
IntroBonbonGfxEnd

SECTION "Menu - Options Compressed GFX", ROMX[$5512], BANK[$37]
MenuOptionsGfx:
	db COMPRESSED
	INCBIN "gfx/menu/options.malias"
MenuOptionsGfxEnd

SECTION "Title - Sprites Compressed GFX", ROMX[$5a26], BANK[$36]
TitleSpritesGfx:
	db COMPRESSED
	INCBIN "gfx/title/sprites.malias"
TitleSpritesGfxEnd

SECTION "Cutscene - Connected1 Compressed GFX", ROMX[$47d9], BANK[$37]
CutsceneConnected1Gfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/connected1.malias"
CutsceneConnected1GfxEnd

CutsceneConnected2Gfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/connected2.malias"
CutsceneConnected2GfxEnd

EvolveBgGfx:
	db COMPRESSED
	INCBIN "gfx/evolve/bg.malias"
EvolveBgGfxEnd

SECTION "Title - Title1 Compressed GFX", ROMX[$4e55], BANK[$36]
TitleTitle1Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/title/title1.malias"
TitleTitle1GfxEnd

TitleTitle2Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/title/title2.malias"
TitleTitle2GfxEnd

SECTION "Screen - Save Deleted Compressed GFX", ROMX[$43ed], BANK[$37]
ScreenSaveDeletedGfx:
	db COMPRESSED
	INCBIN "gfx/screen/save_deleted.malias"
ScreenSaveDeletedGfxEnd

SECTION "Menu - Unk Compressed GFX", ROMX[$5b75], BANK[$37]
MenuUnkGfx:
	db COMPRESSED
	INCBIN "gfx/menu/unk.malias"
MenuUnkGfxEnd

SECTION "Menu - Stats Compressed GFX", ROMX[$5ce9], BANK[$36]
MenuStatsGfx:
	db COMPRESSED
	INCBIN "gfx/menu/stats.malias"
MenuStatsGfxEnd

SECTION "Menu - Encounter Compressed GFX", ROMX[$4a92], BANK[$36]
MenuEncounterGfx:
	db COMPRESSED
	INCBIN "gfx/menu/encounter.malias"
MenuEncounterGfxEnd

MenuBattleGfx:
	db COMPRESSED
	INCBIN "gfx/menu/battle.malias"
MenuBattleGfxEnd

SECTION "Menu - Misc Sprites Compressed GFX", ROMX[$4000], BANK[$37]
MenuMiscSpritesGfx:
	db COMPRESSED
	INCBIN "gfx/menu/misc_sprites.malias"
MenuMiscSpritesGfxEnd

SECTION "Menu - Total Compressed GFX", ROMX[$5c34], BANK[$37]
MenuTotalGfx:
	db COMPRESSED
	INCBIN "gfx/menu/total.malias"
MenuTotalGfxEnd

SECTION "Menu - Dmelo Compressed GFX", ROMX[$52ac], BANK[$37]
MenuDmeloGfx:
	db COMPRESSED
	INCBIN "gfx/menu/dmelo.malias"
MenuDmeloGfxEnd

SECTION "Menu - Battle2 Compressed GFX", ROMX[$6232], BANK[$36]
MenuBattle2Gfx:
	db COMPRESSED
	INCBIN "gfx/menu/battle2.malias"
MenuBattle2GfxEnd

MenuBattle3Gfx:
	db COMPRESSED
	INCBIN "gfx/menu/battle3.malias"
MenuBattle3GfxEnd

SECTION "Menu - Got Number Compressed GFX", ROMX[$5190], BANK[$37]
MenuGotNumberGfx:
	db COMPRESSED
	INCBIN "gfx/menu/got_number.malias"
MenuGotNumberGfxEnd

SECTION "Menu - Nickname Compressed GFX", ROMX[$5c8e], BANK[$37]
MenuNicknameGfx:
	db COMPRESSED
	INCBIN "gfx/menu/nickname.malias"
MenuNicknameGfxEnd

SECTION "Menu - Numbers Compressed GFX", ROMX[$64b2], BANK[$36]
MenuNumbersGfx:
	db COMPRESSED
	INCBIN "gfx/menu/numbers.malias"
MenuNumbersGfxEnd

SECTION "Evolve - Bg2 Compressed GFX", ROMX[$5649], BANK[$37]
EvolveBg2Gfx:
	db COMPRESSED
	INCBIN "gfx/evolve/bg2.malias"
EvolveBg2GfxEnd

MenuMain1Gfx:
	db COMPRESSED
	INCBIN "components/pausemenu/resources/text1.malias"
MenuMain1GfxEnd

MenuMain2Gfx:
	db COMPRESSED
	INCBIN "components/pausemenu/resources/text2.malias"
MenuMain2GfxEnd

SECTION "Evolve - Bg3 Compressed GFX", ROMX[$65c9], BANK[$4d]
EvolveBg3Gfx:
	db COMPRESSED
	INCBIN "gfx/evolve/bg3.malias"
EvolveBg3GfxEnd

SECTION "Evolve - Bg4 Compressed GFX", ROMX[$622e], BANK[$4d]
EvolveBg4Gfx:
	db COMPRESSED
	INCBIN "gfx/evolve/bg4.malias"
EvolveBg4GfxEnd

EvolveCannotGfx:
	db COMPRESSED
	INCBIN "gfx/evolve/cannot.malias"
EvolveCannotGfxEnd

SECTION "Tilemap - Overworld Compressed GFX", ROMX[$4000], BANK[$59]
TilemapOverworldGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/overworld.malias"
TilemapOverworldGfxEnd

TilemapAntennaGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/antenna.malias"
TilemapAntennaGfxEnd

TilemapDungeonGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/dungeon.malias"
TilemapDungeonGfxEnd

TilemapCaveGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/cave.malias"
TilemapCaveGfxEnd

TilemapHouseGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/house.malias"
TilemapHouseGfxEnd

TilemapTreeGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/tree.malias"
TilemapTreeGfxEnd

TilemapDungeon2Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/dungeon2.malias"
TilemapDungeon2GfxEnd

TilemapDungeon3Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/dungeon3.malias"
TilemapDungeon3GfxEnd

TilemapDungeon4Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/dungeon4.malias"
TilemapDungeon4GfxEnd

TilemapHuman1Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/human1.malias"
TilemapHuman1GfxEnd

TilemapHumanAntennaGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/human_antenna.malias"
TilemapHumanAntennaGfxEnd

SECTION "Tilemap - Human2 Compressed GFX", ROMX[$6d29], BANK[$29]
TilemapHuman2Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/human2.malias"
TilemapHuman2GfxEnd

TilemapShrineGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/shrine.malias"
TilemapShrineGfxEnd

SECTION "Intro - Shadow Gymnos1 Compressed GFX", ROMX[$4000], BANK[$39]
IntroShadowGymnos1Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/shadow_gymnos1.malias"
IntroShadowGymnos1GfxEnd

IntroShadowGymnos2Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/shadow_gymnos2.malias"
IntroShadowGymnos2GfxEnd

IntroShigekiGfx:
	db COMPRESSED
	INCBIN "gfx/intro/shigeki.malias"
IntroShigekiGfxEnd

IntroTreesGfx:
	db COMPRESSED
	INCBIN "gfx/intro/trees.malias"
IntroTreesGfxEnd

IntroFungusShigeki1Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/fungus_shigeki1.malias"
IntroFungusShigeki1GfxEnd

IntroFungusShigeki2Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/fungus_shigeki2.malias"
IntroFungusShigeki2GfxEnd

IntroGymnos1Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/gymnos1.malias"
IntroGymnos1GfxEnd

IntroGymnos2Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/gymnos2.malias"
IntroGymnos2GfxEnd

IntroFungus1Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/fungus1.malias"
IntroFungus1GfxEnd

IntroFungus2Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/fungus2.malias"
IntroFungus2GfxEnd

SECTION "Intro - Shigeki Sprites1 Compressed GFX", ROMX[$4000], BANK[$3a]
IntroShigekiSprites1Gfx:
	db COMPRESSED
	INCBIN "gfx/intro/shigeki_sprites1.malias"
IntroShigekiSprites1GfxEnd

IntroShigekiSprites2Gfx:
	db COMPRESSED
	INCBIN "gfx/intro/shigeki_sprites2.malias"
IntroShigekiSprites2GfxEnd

IntroShigekiMouthGfx:
	db COMPRESSED
	INCBIN "gfx/intro/shigeki_mouth.malias"
IntroShigekiMouthGfxEnd

IntroFungusCallGfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/intro/fungus_call.malias"
IntroFungusCallGfxEnd

IntroCryptoShigekiSpritesGfx:
	db COMPRESSED
	INCBIN "gfx/intro/crypto_shigeki_sprites.malias"
IntroCryptoShigekiSpritesGfxEnd

UnusedClawGfx:
	db COMPRESSED
	INCBIN "gfx/unused_claw.malias"
UnusedClawGfxEnd

MenuMultiplayerGfx:
	db COMPRESSED
	INCBIN "gfx/menu/multiplayer.malias"
MenuMultiplayerGfxEnd

MenuMultiplayer2Gfx:
	db COMPRESSED
	INCBIN "gfx/menu/multiplayer2.malias"
MenuMultiplayer2GfxEnd

ScreenGameOverGfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/screen/game_over.malias"
ScreenGameOverGfxEnd

ScreenGameOver2Gfx:
	db COMPRESSED
	INCBIN "versions/speed/gfx/screen/game_over2.malias"
ScreenGameOver2GfxEnd

SECTION "Menu - Met Compressed GFX", ROMX[$5ce2], BANK[$37]
MenuMetGfx:
	db COMPRESSED
	INCBIN "gfx/menu/met.malias"
MenuMetGfxEnd

SECTION "Cutscene - Antenna Tree Compressed GFX", ROMX[$6d07], BANK[$39]
CutsceneAntennaTreeGfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/antenna_tree.malias"
CutsceneAntennaTreeGfxEnd

CutsceneKaiGfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/kai.malias"
CutsceneKaiGfxEnd

CutsceneUnusedGfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/unused.malias"
CutsceneUnusedGfxEnd

SECTION "Menu - Main1 DMG Compressed GFX", ROMX[$439d], BANK[$35]
MenuMain1DMGGfx:
	db COMPRESSED
	INCBIN "components/pausemenu/resources/text1_dmg.malias"
MenuMain1DMGGfxEnd

MenuMain2DMGGfx:
	db COMPRESSED
	INCBIN "components/pausemenu/resources/text2_dmg.malias"
MenuMain2DMGGfxEnd

MenuUnkDMGGfx:
	db COMPRESSED
	INCBIN "gfx/menu/unk_dmg.malias"
MenuUnkDMGGfxEnd

MenuTotalDMGGfx:
	db COMPRESSED
	INCBIN "gfx/menu/total_dmg.malias"
MenuTotalDMGGfxEnd

MenuNicknameDMGGfx:
	db COMPRESSED
	INCBIN "gfx/menu/nickname_dmg.malias"
MenuNicknameDMGGfxEnd

SECTION "Menu - Options DMG Compressed GFX", ROMX[$4267], BANK[$35]
MenuOptionsDMGGfx:
	db COMPRESSED
	INCBIN "gfx/menu/options_dmg.malias"
MenuOptionsDMGGfxEnd

SECTION "Menu - Dmelo DMG Compressed GFX", ROMX[$4000], BANK[$35]
MenuDmeloDMGGfx:
	db COMPRESSED
	INCBIN "gfx/menu/dmelo_dmg.malias"
MenuDmeloDMGGfxEnd

SECTION "Menu - Met DMG Compressed GFX", ROMX[$4996], BANK[$35]
MenuMetDMGGfx:
	db COMPRESSED
	INCBIN "gfx/menu/met_dmg.malias"
MenuMetDMGGfxEnd
