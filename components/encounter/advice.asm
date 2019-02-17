INCLUDE "telefang.inc"

SECTION "Encounter Screen Advice Code 1", ROMX[$5BB0], BANK[$1]
Encounter_ADVICE_LoadSGBFiles::
    M_AdviceSetup

    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld hl, $9010
    ld b, $70
    call Zukan_ADVICE_TileLightColourReverse

    ld hl, $8F00
    ld b, $40
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $9300
    ld b, $2C
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $9500
    ld b, $20
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $9600
    ld b, $80
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld a, 3
    ld [W_MainScript_TextStyle], a

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet
    call PauseMenu_ADVICE_FixSGBSceneryPalette

    ld c, $10
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 4
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 7
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

Encounter_ADVICE_MapTFangerDenjuu::
    M_AdviceSetup

    xor a
	call Banked_RLEDecompressTMAP0

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return
	
    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 7
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

SECTION "Encounter Screen Advice Code 2", ROMX[$7FB3], BANK[$1C]
Encounter_ADVICE_QueueMessage::
	call Battle_QueueMessage

    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z ; C8
	
	ld hl, $8F00
	ld b, $40
	; Continues into Encounter_ADVICE_TileLowByteBlanketFill

Encounter_ADVICE_TileLowByteBlanketFill::
	ld c, $FF

.drawloop
	di

.wfb
	ldh a, [REG_STAT]
	and 2
	jr nz, .wfb
	ld a, c
	ld [hli], a
	inc hl
	ld a, c
	ld [hli], a
	ei
	inc hl
	dec b
	jr nz, .drawloop
	ret

Encounter_ADVICE_UnloadSGBFilesOnFlee::
	call Encounter_ADVICE_UnloadSGBFiles_Common
    jp Battle_IncrementSubSubState
	
Encounter_ADVICE_UnloadSGBFiles::
	call Encounter_ADVICE_UnloadSGBFiles_Common
    jp System_ScheduleNextSubState

Encounter_ADVICE_UnloadSGBFiles_Common::
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
