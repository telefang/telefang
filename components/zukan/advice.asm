INCLUDE "telefang.inc"

SECTION "Zukan Draw Advice", ROMX[$6980], BANK[$1]
Zukan_ADVICE_DrawSpeciesPageText::
	M_AdviceSetup

	ld b, $11
	ld d, $A
	call Banked_MainScript_InitializeMenuText
	ld a, [W_MainScript_TextPtr]
	ld [W_PauseMenu_SMSOriginPtr], a
	ld a, [W_MainScript_TextPtr + 1]
	ld [W_PauseMenu_SMSOriginPtr + 1], a

	call Zukan_ADVICE_CountLines
	call Zukan_ADVICE_MapArrow
	call PauseMenu_ADVICE_SMSLineSetInitialCache
	call Zukan_ADVICE_DrawThreeLines

	M_AdviceTeardown
	ret

Zukan_ADVICE_NextPage::
	ld a, [W_PauseMenu_SMSScrollMax]
	cp 4
	ret c
    call Zukan_ADVICE_ClearMessageForSGB_Direct
	ld a, [W_PauseMenu_SMSScrollMax]
	ld b, a
	ld a, [W_PauseMenu_SMSScrollPos]
	cp b
	jr c, Zukan_ADVICE_DrawThreeLines

	xor a
	ld [W_PauseMenu_SMSScrollPos], a
	; Continues into Zukan_ADVICE_DrawThreeLines

Zukan_ADVICE_DrawThreeLines::
	ld hl, $8C00
	call Zukan_ADVICE_NextPageDrawHelper
	ld hl, $8CE0
	call Zukan_ADVICE_NextPageDrawHelper
	ld hl, $8DC0
	call Zukan_ADVICE_NextPageDrawHelper
	ret

Zukan_ADVICE_MapArrow::
	ld hl, $99D1
	ld a, [W_PauseMenu_SMSScrollMax]
	cp 4
	ld a, 0
	jr c, .noArrow
	dec a
	dec a

.noArrow
	ld b, a

.wfb
	ld a, [REG_STAT]
	and 2
	jr nz, .wfb
	ld [hl], b
	ret

Zukan_ADVICE_CountLines::
	call PauseMenu_ADVICE_SMSGetOriginPointer
	ld b, 0
.searchLoop
	call MainScript_LoadFromBank
	cp $E1
	jr z, .exitLoop
	cp $E2
	jr nz, .searchLoop
	ld a, b
	cp $FE
	jr z, .exitLoop
	inc b
	jr .searchLoop

.exitLoop
	inc b
	ld a, b
	ld [W_PauseMenu_SMSScrollMax], a
	xor a
	ld [W_PauseMenu_SMSScrollPos], a

Zukan_ADVICE_FindLineForDrawing::
	ld hl, $8C00
	ld de, $E0
	
.mathLoop
	or a
	jr z, .exitLoop
	add hl, de
	dec a
	jr .mathLoop

.exitLoop
	call PauseMenu_ADVICE_SMSSetDrawAddress
	ret

Zukan_ADVICE_DrawTextLine::
	call PauseMenu_ADVICE_SMSResetLine
	call PauseMenu_ADVICE_SMSGetDrawAddress
	ld b, $70
	jp PauseMenu_ADVICE_SMSDrawLine_extEntry

Zukan_ADVICE_FirstPageDrawHelper::
	call PauseMenu_ADVICE_SMSLocateLineRelativeToCache
	ld a, c
	call Zukan_ADVICE_FindLineForDrawing
	jp Zukan_ADVICE_DrawTextLine

Zukan_ADVICE_NextPageDrawHelper::
	call PauseMenu_ADVICE_SMSSetDrawAddress
	ld a, [W_PauseMenu_SMSScrollPos]
	ld c, a
	call PauseMenu_ADVICE_SMSLocateLineRelativeToCache
	call Zukan_ADVICE_DrawTextLine
	; Continues into Zukan_ADVICE_NextScrollPos

Zukan_ADVICE_NextScrollPos::
	ld a, [W_PauseMenu_SMSScrollPos]
	inc a
	ld [W_PauseMenu_SMSScrollPos], a
	ret

SECTION "Zukan State Machine Advice", ROMX[$4580], BANK[$1]
Zukan_ADVICE_InitializeNameMetaSprite::
    M_AdviceSetup

    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3 + M_LCDC_MetaSpriteConfig_HiAttribs], a

    ; #177 in metasprite bank 8 is MetaSprite_zukan_denjuu_name.
    ld a, $80
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3 + M_LCDC_MetaSpriteConfig_Bank], a
    ld a, 177
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3 + M_LCDC_MetaSpriteConfig_Index], a
    ld a, 80 + 3
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3 + M_LCDC_MetaSpriteConfig_XOffset], a
    ld a, 5 * 8 - 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3 + M_LCDC_MetaSpriteConfig_YOffset], a

    M_AdviceTeardown
    ret

;cloned from PauseMenu_ClearScreenTiles 'cause I can't bankcall it
Zukan_ADVICE_ClearScreenTiles::
    push bc
    ld c, $10
    
.loop1
    xor a
    call YetAnotherWFB
    ld [hli], a
    dec c
    jr nz, .loop1
    
    pop bc
    dec b
    jr nz, Zukan_ADVICE_ClearScreenTiles
    
    ret
    
Zukan_ADVICE_DrawRightAlignedHabitatName::
    M_AdviceSetup

    call PauseMenu_ADVICE_SMSResetLine
    ld a, [W_Zukan_SelectedSpecies]
    call Zukan_ADVICE_DrawRightAlignedHabitatName_SGBTextStyle

    ld a, 7
    ld [W_MainScript_VWFNewlineWidth], a
    
    ;DrawHabitatString but inlined
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, M_Battle_SpeciesType
    call Banked_Battle_LoadSpeciesData
    
    ld a, [W_Battle_RetrSpeciesByte]
    ld [W_StringTable_ROMTblIndex], a
    
    ld de, StringTable_denjuu_habitats
    ld bc, $9380
    ld a, BANK(MainScript_ADVICE_DrawRightAlignedHabitatName)
    ld hl, MainScript_ADVICE_DrawRightAlignedHabitatName
    rst $20 ;CallBankedFunction

    ld a, M_MainScript_UndefinedWindowWidth
    ld [W_MainScript_VWFNewlineWidth], a
    
    M_AdviceTeardown
    ret
    
Zukan_ADVICE_SetupSGBScreen::
    M_AdviceSetup
    
    ;Load SGB ATF.
    ;We don't convert colors until after the denjuu is in place, so we just want
    ;to get the status screen attributes in place.
    ld a, 5
    ld b, 0
    ld c, 0
    ld d, 0
    ld e, 0
    call Zukan_ADVICE_SetupSGBScreen_RedrawForSGB
    
    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 1
    call PatchUtils_CommitStagedCGBToSGB
    
    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 6
    call PatchUtils_CommitStagedCGBToSGB
    
    M_AdviceTeardown
    ret
    
Zukan_ADVICE_RefreshSGBScreen::
    M_AdviceSetup
    
    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 6
    call PatchUtils_CommitStagedCGBToSGB
    
    M_AdviceTeardown
    ret
    
Zukan_ADVICE_TeardownSGBScreenAndMetasprites::
    M_AdviceSetup
    
    ;Remove the Denjuu name metasprite
    call LCDC_ClearMetasprites
    
    ;Load neutral/grayscale ATF
    ld a, 0
    ld b, 0
    ld c, 0
    ld d, 0
    ld e, 0
    call Zukan_ADVICE_TeardownSGBScreenAndMetasprites_ResetSGBTextStyle
    
    M_AdviceTeardown
    ret

Zukan_ADVICE_StateInnerviewInputButtonPress::
    M_AdviceSetup
    
.check_b_pressed
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .check_a_pressed
    
.exit_inner_screen
    ld a, 0
    ld [W_MainScript_State], a
    
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    call System_ScheduleNextSubSubState
    jr .nothing_pressed
    
.check_a_pressed
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .nothing_pressed
    
    call Zukan_ADVICE_NextPage
    
.nothing_pressed
    M_AdviceTeardown
    ret

    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    
Zukan_ADVICE_StateInnerviewInputSwitchSpecies::
    M_AdviceSetup
    
    ;Clear the page indicator
    ld hl, $99D1
    call YetAnotherWFB
    xor a
    ld [hl], a
    
    ;Reset script state (so we don't accidentally draw the next page)
    ld [W_MainScript_State], a
    
    ;Everything else the original code did
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, M_Zukan_StateInnerviewSwitchPage
    ld [W_SystemSubSubState], a
    
    M_AdviceTeardown
    ret

SECTION "Zukan SGB Recolour Window Advice", ROMX[$5360], BANK[$1]
Zukan_ADVICE_TileLightColourReverse::
    ld d, h
    ld e, l

.drawloop
    di

.wfb
    ld a, [REG_STAT]
    and 2
    jr nz, .wfb
    ld a, [hli]
    ld c, a
    ld a, [hli]
    xor c
    cpl
    ld [de], a
    ei
    inc de
    inc de
    dec b
    jr nz, .drawloop
    ret

Zukan_ADVICE_TileLowByteBlanketFill::
    ld c, $FF

.drawloop
    di

.wfb
    ld a, [REG_STAT]
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

Zukan_ADVICE_FixPaletteForSGB::
    ld hl, W_LCDC_CGBStagingBGPaletteArea

Zukan_ADVICE_FixPaletteForSGB_skipHLSet::
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a
    ld a, b
    ld [hli], a
    ld a, c
    ld [hli], a
    ret

Zukan_ADVICE_CheckSGB::
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z
    ld a, [W_SGB_DetectSuccess]
    or a
    ret

Zukan_ADVICE_SetupSGBScreen_RedrawForSGB::
    call Banked_SGB_ConstructPaletteSetPacket
    call Zukan_ADVICE_CheckSGB
    ret z
    ld hl, $9000
    ld b, $50
    call Zukan_ADVICE_TileLightColourReverse
    call Zukan_ADVICE_FixPaletteForSGB
    ld hl, $9530
    ld b, $20
    call Zukan_ADVICE_TileLowByteBlanketFill
    ld hl, $8FE0
    ld b, 4
    call Zukan_ADVICE_TileLowByteBlanketFill
    ret

Zukan_ADVICE_TeardownSGBScreenAndMetasprites_ResetSGBTextStyle::
    call Banked_SGB_ConstructPaletteSetPacket
    call Zukan_ADVICE_CheckSGB
    ret z
    xor a
    ld [W_MainScript_TextStyle], a
    ret

Zukan_ADVICE_DrawRightAlignedHabitatName_SGBTextStyle::
    ld [W_Status_SelectedDenjuuSpecies], a
    call Zukan_ADVICE_CheckSGB
    ret z
    ld a, 3
    ld [W_MainScript_TextStyle], a
    ret

Zukan_ADVICE_ClearMessageForSGB::
    M_AdviceSetup
    call Zukan_ADVICE_ClearMessageForSGB_Direct
    M_AdviceTeardown
    ret

Zukan_ADVICE_ClearMessageForSGB_Direct::
    ld hl, $8C00
    ld b, $E0
    call Zukan_ADVICE_CheckSGB
    jr z, .notsgb
    ld de, $FF
    jr .clearloop

.notsgb
    ld d, 0
    ld e, d

.clearloop
    di

.wfb
    ld a, [REG_STAT]
    and 2
    jr nz, .wfb
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    ld a, e
    ld [hli], a
    ei
    ld e, d
    ld d, a
    dec b
    jr nz, .clearloop
    ret

Zukan_ADVICE_DrawDenjuuName::
    M_AdviceSetup
    
    ld a, [W_Zukan_SelectedSpecies]
    ld de, StringTable_denjuu_species
    ld bc, $8F00
    call MainScript_DrawCenteredName75
    
    call Zukan_ADVICE_CheckSGB
    jr z, .notsgb
    ld a, 3
    ld [W_MainScript_TextStyle], a

.notsgb
    M_AdviceTeardown
    ret

SECTION "Zukan SGB Recolour Overview Advice", ROMX[$5680], BANK[$1]
Zukan_ADVICE_LoadSGBFilesOverview::
    M_AdviceSetup

    call ContactMenu_ADVICE_LoadSGBFilesOverview_Common

    ld bc, $48

    M_AdviceTeardown
    ret

Zukan_ADVICE_LoadSGBPalettesOverview::
    M_AdviceSetup

    ld a, 1
    ld [W_CGBPaletteStagedBGP], a

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 7
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

Zukan_ADVICE_ReloadSGBPalettesOverview::
    M_AdviceSetup

    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld c, 9
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 2
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 7
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

SECTION "Zukan Certificate SGB Colours", ROMX[$6410], BANK[$1]
Certificate_ADVICE_LoadSGBFiles::
    M_AdviceSetup

    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld bc, $D81D
    call TitleScreen_ADVICE_IdentifyFadePalettesCommon
    ld c, $1E
    call Banked_SGB_ConstructATFSetPacket

.return
    M_AdviceTeardown
    ret