INCLUDE "telefang.inc"

SECTION "Summon Screen Advice Code", ROMX[$5060], BANK[$1]
Summon_ADVICE_ExitIntoSummonScreen::
    M_AdviceSetup

    ; Remove the habitat metasprite.
    ; This will be run when going from the encounter screen to the
    ; the summon screen too, which is superfluous, but no sprites
    ; carry over between the two screens - so it doesn't do any harm.
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 5
    call LCDC_ClearSingleMetasprite
    
    ; Original replaced code (modified to use the
    ; AuxCodeJmp return address instead of a jp)
    ld a, [W_Encounter_AlreadyInitialized]
    or a
    jr z, .initializeEncounter

.doNotInitializeEncounter
    add sp, 2 * 4
    ld hl, Summon_StateFadeOutIntoSummonScreen.encounterInitialized
    push hl
    add sp, -(2 * 3)
.initializeEncounter

    M_AdviceTeardown
    ret

SECTION "Summon Screen Advice Code 2", ROMX[$5C60], BANK[$1]
Summon_ADVICE_LoadSGBFiles::
    M_AdviceSetup

    xor a
    call Banked_RLEDecompressTMAP0

    call PauseMenu_ADVICE_CheckSGB
    jp z, .return

    ld hl, $9010
    ld b, $70
    call Zukan_ADVICE_TileLightColourReverse

    ld hl, $92E0
    ld b, 8
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $9380
    ld b, $20
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 1
    call PatchUtils_CommitStagedCGBToSGB

    call PauseMenu_ADVICE_CGBToSGB56Shorthand

    ld c, $11
    call Banked_SGB_ConstructATFSetPacket

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

	ld bc, $CFF
	ld e, $16
	ld hl, $980A

.tilemapRowLoop
	ld d, 5

.tilemapColumnLoop
	di

.wfb
	ldh a, [REG_STAT]
	and 2
	jr nz, .wfb

	ld a, c
	ld [hli], a
	ld [hli], a
	ei
	dec d
	jr nz, .tilemapColumnLoop
	dec b
	jr z, .tilemapExitLoop

; At this stage of the loop the register d should be 0. We will abuse this fact in order to add the value in e to hl via de.
	add hl, de
	jr .tilemapRowLoop

.tilemapExitLoop
	ld a, $FF
	ld hl, $99A1
	call vmempoke
	ld l, $B2
	call vmempoke
	ld l, $C1
	call vmempoke
	ld l, $D2
	call vmempoke
	ld l, $E1
	call vmempoke
	ld l, $F2
	call vmempoke
	ld hl, $9A01
	call vmempoke
	ld l, $12
	call vmempoke

.return

    M_AdviceTeardown
    ret

SECTION "Summon Screen Advice Code 3", ROMX[$7F4C], BANK[$1C]
Summon_ADVICE_PrepareTextStyle::
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

Summon_ADVICE_LoadDenjuuPalette::
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
