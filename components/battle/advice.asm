INCLUDE "telefang.inc"

SECTION "Main Script Temporary Storage for Text Style", WRAM0[$C7CD]
W_MainScript_TextStylePreserve:: ds 1

SECTION "Battle Advice Code", ROMX[$50A0], BANK[$1]
Battle_ADVICE_ClearStatusEffectTilemaps::
    M_AdviceSetup

    ; Original replaced code.
    ld bc, $01
    call Banked_LoadMaliasGraphics
    call Battle_ADVICE_ClearStatusEffectTilemaps_externalEntry

    M_AdviceTeardown
    ret

Battle_ADVICE_ClearStatusEffectTilemaps_externalEntry::
    ; And then we gotta clear the status effect tilemaps.
    ld hl, $9801 ; Partner's tiles
    ld bc, (2 << 8) | (5 / 2)
    xor a
.clearLoop
    di
    call YetAnotherWFB
    ld [hli], a
    ld [hli], a
    ei
    dec c
    jr nz, .clearLoop

    di
    call YetAnotherWFB
    ld [hli], a ; Aaand the fifth tile.
    ei
    
    ld hl, $9D01 ; Opponent's tiles
    dec b
    jr nz, .clearLoop
    ret

SECTION "Direct Battle Screen Exit To Overworld Advice Code", ROMX[$5100], BANK[$1]
Battle_ADVICE_ExitToOverworld::
    M_AdviceSetup
    ld a, M_System_GameStateOverworld
    ld [W_SystemState], a
    ld a, [W_SGB_DetectSuccess]
    or a
    jr z, .noSGB

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .noSGB

    xor a
    ld b, a
    ld c, a
    ld d, a
    ld e, a
    ld [W_MainScript_TextStyle], a
    call Banked_SGB_ConstructPaletteSetPacket

.noSGB
    M_AdviceTeardown
    ret

SECTION "Battle Advice Code 2", ROMX[$5F90], BANK[$1]
Battle_ADVICE_LoadDenjuuResources::
    M_AdviceSetup

    ld c, e
    ld a, c
    or a
    ld a, d
    jr z, .isOpponent
    ld de, $8B80
    jr .loadPortrait

.isOpponent
    ld de, $8800

; This "push af" also preserves the flags from the "or a" above.
.loadPortrait
    push af
    call Banked_Battle_LoadDenjuuPortrait
    pop af
    jr z, .isOpponentPalette
    call Battle_LoadDenjuuPalettePartner
    jr .checkSGB

.isOpponentPalette
    call Battle_LoadDenjuuPaletteOpponent

.checkSGB
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld a, M_SGB_Pal23 << 3 + 1
    ld bc, $607
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

Battle_ADVICE_LoadSGBFiles::
    M_AdviceSetup

    ld a, $20
    ld [W_LCDC_MetaspriteAnimationBank], a

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld a, 3
    ld [W_MainScript_TextStyle], a

    ld hl, $9010
    ld b, $48
    call Zukan_ADVICE_TileLightColourReverse

.extEntry
    ld hl, .table
    ld de, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 1) + (M_LCDC_CGBColorSize * 1)
	ld b, 6

.loop
    ld a, [hli]
	ld [de], a
	inc de
    dec b
    jr nz, .loop

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, $405
    call PatchUtils_CommitStagedCGBToSGB

    ld c, $13
    call Banked_SGB_ConstructATFSetPacket

.return
    M_AdviceTeardown
    ret

.table
    dw $233C, $7FE0, 0

Battle_ADVICE_AttackWindowCorrectForSGBOnOpen::
    M_AdviceSetup

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld de, $40
    ld hl, $994A
    ld bc, $2FF

.maploop
    di

.wfbA
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfbA

    ld [hl], c
    add hl, de
    ld [hl], c
    ei
    add hl, de
    dec b
    jr nz, .maploop

    ld de, $37FF
    ld hl, $996A
    ld b, 3

.maprowloop
    ld c, 3

.mapcolloop
    di

.wfbB
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfbB

    ld a, e
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ei
    dec c
    jr nz, .mapcolloop

    ld a, d
    add l
    ld l, a
    dec b
    jr nz, .maprowloop

    ld c, $14
    call Banked_SGB_ConstructATFSetPacket

.return
    ld bc, $909
    ld e, $80

    M_AdviceTeardown
    ret

Battle_ADVICE_AttackWindowCorrectForSGBOnClose::
    M_AdviceSetup

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld de, $16FF
    ld hl, $99A9
    ld b, 4

.maprowloop
    ld c, 5

.mapcolloop
    di

.wfb
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfb

    ld a, e
    ld [hli], a
    ld [hli], a
    ei
    dec c
    jr nz, .mapcolloop

    ld a, d
    add l
    ld l, a

; Cheaper than ld a, 0 / adc h / ld h, a.

    jr nc, .noIncH
    inc h

.noIncH
    dec b
    jr nz, .maprowloop

    ld c, $13
    call Banked_SGB_ConstructATFSetPacket

.return
    ld hl, $9600
    ld a, $20
    call MainScript_DrawEmptySpaces

    ld bc, $909
    ld e, $81

    M_AdviceTeardown
    ret

Battle_ADVICE_VictoryDrawWindowTiles::
    M_AdviceSetup

    call Battle_ADVICE_ClearStatusEffectTilemaps_externalEntry
    call PauseMenu_ADVICE_CheckSGB
    jr z, .noSGB

    ld a, BANK(MenuBattle2GfxSGB)
    ld hl, $9000
    ld de, MenuBattle2GfxSGB
    ld bc, $200
    call Banked_LCDC_LoadTiles
    jr .exit

.noSGB
    ld bc, $14
    call Banked_LoadMaliasGraphics

.exit
    M_AdviceTeardown
    ret

Battle_ADVICE_ArrivedMessageFix::
    M_AdviceSetup

    call PauseMenu_ADVICE_CheckSGB
    jr z, .noSGB

    ld a, $99
    cp e
    jr z, .isPartner
    ld bc, $9280
    ld hl, $9480
    ld d, $40
    call Battle_ADVICE_ArrivedMessageFix_CopyTiles
    ld hl, $9480
    ld b, $20
    call Zukan_ADVICE_TileLowByteBlanketFill
    ld c, $48
    jr .commonSGB

.isPartner
    ld bc, $9200
    ld hl, $9400
    ld d, $40
    call Battle_ADVICE_ArrivedMessageFix_CopyTiles
    ld hl, $9400
    ld b, $20
    call Zukan_ADVICE_TileLowByteBlanketFill
    ld c, $40

.commonSGB
    ld hl, $99C2
    call Battle_ADVICE_ArrivedMessageFix_FillBySequence
    ld hl, $99E2
    call Battle_ADVICE_ArrivedMessageFix_FFFill
    ld c, $78
    ld hl, $9A02
    call Battle_ADVICE_ArrivedMessageFix_FillBySequence
    jr .exit

.noSGB
    xor a
    ld bc, $20E
    call Banked_RLEDecompressTMAP0

.exit
    M_AdviceTeardown
    ret

Battle_ADVICE_ArrivedMessageFix_CopyTiles::
    di

.wfb
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfb
    ld a, [bc]
    ld [hli], a
    ld c, l
    ld a, [bc]
    ld [hli], a
    ei
    ld c, l
    dec d
    jr nz, Battle_ADVICE_ArrivedMessageFix_CopyTiles
    ret

Battle_ADVICE_ArrivedMessageFix_FillBySequence::
    ld b, 4

.loop
    di

.wfb
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfb
    ld a, c
    ld [hli], a
    inc a
    ld [hli], a
    ei
    inc a
    ld c, a
    dec b
    jr nz, .loop
    ret

Battle_ADVICE_ArrivedMessageFix_FFFill::
    ld bc, $2FF

.loop
    di

.wfb
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfb
    ld a, c
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    jr nz, .loop
    ret

Battle_ADVICE_VictoryStatsLoadSGBFiles::
    M_AdviceSetup

    xor a
    call Banked_RLEDecompressTMAP0

    call PauseMenu_ADVICE_CheckSGB
    jr z, .noSGB

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, $505
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld bc, $605
    call PatchUtils_CommitStagedCGBToSGB

    ld c, $14
    call Banked_SGB_ConstructATFSetPacket

    ld hl, $90A0
    ld b, 8
    call Zukan_ADVICE_TileLowByteBlanketFill

.noSGB
    M_AdviceTeardown
    ret

Battle_ADVICE_LoadSGBFilesAfterLateDenjuu::
    M_AdviceSetup

    xor a
    call Banked_RLEDecompressAttribsTMAP1

    call PauseMenu_ADVICE_CheckSGB
    jp z, Battle_ADVICE_LoadSGBFiles.return

    ld a, M_SGB_Pal23 << 3 + 1
    ld bc, $607
    call PatchUtils_CommitStagedCGBToSGB

    jp Battle_ADVICE_LoadSGBFiles.extEntry

Battle_ADVICE_SGBPaletteOnPartnerFell::
    ld d, 7
    jr Battle_ADVICE_SGBPaletteOnOpponentFell.jumpFromPartnerFell
    
Battle_ADVICE_SGBPaletteOnOpponentFell::
    ld d, 6

.jumpFromPartnerFell
    M_AdviceSetup

    push de
    ld b, 0
    call Banked_MainScript_DrawStatusEffectString
    pop de

    call PauseMenu_ADVICE_CheckSGB
    jp z, Battle_ADVICE_LoadSGBFiles.return

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, d
    ld c, d
    call PatchUtils_CommitStagedCGBToSGB
    jp Battle_ADVICE_LoadSGBFiles.return

SECTION "MenuBattle2GfxSGB", ROMX[$7E00], BANK[$77]
MenuBattle2GfxSGB::
    INCBIN "build/gfx/menu/battle2_sgb.2bpp"
MenuBattle2GfxSGBEnd

SECTION "Battle Advice Code 3", ROMX[$42F0], BANK[$5]
Battle_ADVICE_DrawOpponentName::
    call Battle_ADVICE_TemporarilyClearTextStyle
    call Banked_MainScript_DrawName75
    jp Battle_ADVICE_DrawPartnerName.restoreTextStyle

SECTION "Battle Advice Code 4", ROMX[$6454], BANK[$5]
Battle_ADVICE_TemporarilyClearTextStyle::
    push af
    ld a, [W_MainScript_TextStyle]
    ld [W_MainScript_TextStylePreserve], a
    xor a
    ld [W_MainScript_TextStyle], a
    pop af
    ret

SECTION "Battle Advice Code 5", ROMX[$647A], BANK[$5]
Battle_ADVICE_DrawPartnerName::
    call Battle_ADVICE_TemporarilyClearTextStyle
    call Battle_DrawSpecifiedDenjuuNickname

.restoreTextStyle
    ld a, [W_MainScript_TextStylePreserve]
    ld [W_MainScript_TextStyle], a
    ret

SECTION "Battle Attack Animation Advice Code", ROMX[$5150], BANK[$1]
Attack_ADVICE_PreAttackSGB::
    M_AdviceSetup

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet
    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, $705
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

Attack_ADVICE_PostAttackSGB::
    M_AdviceSetup

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, $405
    call PatchUtils_CommitStagedCGBToSGB

.return
    ld bc, 1
    M_AdviceTeardown
    ret
