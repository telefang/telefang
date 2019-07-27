INCLUDE "telefang.inc"

SECTION "VS Summon Screen Advice Code 3", ROMX[$7A1D], BANK[$1F]
VsSummon_ADVICE_DrawOkIndicator::
    call Banked_Status_LoadUIGraphics

    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z

    ld a, BANK(BattleContactSelectSgb)
    ld hl, $8370
    ld de, BattleContactSelectSgb
    ld bc, $90
    jp Banked_LCDC_LoadTiles

LinkTrade_ADVICE_DrawDenjuuIndicators::
    call $6CB2
    jr VsSummon_ADVICE_DrawDenjuuIndicators.extEntry

VsSummon_ADVICE_DrawDenjuuIndicators::
    call $5694

.extEntry
    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z

    ld a, [W_Summon_SelectedPageCount]
    cp 2
    jr z, .oneempty
    cp 1
    jr z, .twoempty
    ret

.twoempty
    ld hl, $98EB
    call VsSummon_ADVICE_ClearDenjuuIndicators

.oneempty
    ld hl, $994B
    jp VsSummon_ADVICE_ClearDenjuuIndicators

VsSummon_ADVICE_ClearDenjuuIndicators::
    ld bc, $4FF

.loop
    di

.wfb
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfb

    ld a, c
    ld [hli], a
    ld [hli], a
    ei
    dec b
    jr nz, .loop
    ret

VsSummon_ADVICE_PrepareTextStyle::
    ld hl, $9400
	
    ld a, [W_SGB_DetectSuccess]
    or a
    ret z
	
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z
	
    ld a, 3
    ld [W_MainScript_TextStyle], a
    ret

VsSummon_ADVICE_LoadDenjuuPalette::
    call Battle_LoadDenjuuPalettePartner

    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z

    ld b, 5
    ld c, 6
    ld d, M_SGB_Pal23 << 3 + 1
    M_AuxJmp Banked_PatchUtils_CommitStagedCGBToSGB_CBE

    ret

LinkTrade_ADVICE_UnloadSGBFiles::
    ld [W_Battle_4thOrderSubState], a
    jr VsSummon_ADVICE_UnloadSGBFiles.extEntry

VsSummon_ADVICE_UnloadSGBFiles::
    ld [W_SystemState], a

.extEntry
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
    ret

VsSummon_ADVICE_ExitStatusScreen::
    ld a, [W_Encounter_AlreadyInitialized]
    cp 1
    ret nz
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 5
    call LCDC_ClearSingleMetasprite
    ld a, [W_Encounter_AlreadyInitialized]
    ret

LinkTrade_ADVICE_RememberDefectedSpecies::
    ld [W_Victory_DefectedSpeciesForNickname], a
    ld [W_Victory_DefectedContactSpecies], a
    ret
