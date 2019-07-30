INCLUDE "telefang.inc"

SECTION "Defection Memory for Advice Code", WRAM0[$CCBF]
W_Victory_DefectedSpeciesForNickname:: ds 1

SECTION "Victory Advice Code", ROMX[$598A], BANK[$1D]
Victory_ADVICE_SubStateDrawDefectionScreen::
    ld a, [hl]
    
    push de
    
    ld de, W_Victory_DefectedSpeciesForNickname
    ld [de], a
    
    pop de
    
    ld a, M_SaveClock_DenjuuStatSize
    
.eraseLoop
    ld [hl], 0
    inc hl
    dec a
    jr nz, .eraseLoop
    
    ret

;All these functions take a VRAM ptr and number of tiles to clear.
Victory_ADVICE_ClearWindowTiles::
    xor a
.clearLoop
    push bc
    ld c, 8
    
.innerLoop
    call YetAnotherWFB
    ld [hli], a
    ld [hli], a
    dec c
    jr nz, .innerLoop
    
    pop bc
    dec b
    jr nz, .clearLoop
    
    ret

Victory_ADVICE_SubStateDrawStatWindow::
    ld hl, $9400
    ld a, $30
    call MainScript_DrawEmptySpaces
    
    ;We need some code here to make room for our pointcut...
    ld de, Victory_ADVICE_BattleScreenPrivateStrings_speed
    ld hl, $9400
    ld b, 8
    call Banked_MainScript_DrawStatusText
    
    ld de, Victory_ADVICE_BattleScreenPrivateStrings_attack
    ret
    
Victory_ADVICE_SubStateDrawStatWindow_END::

;These strings have been relocated from battle_statemachine.asm - all code
;should reference these new strings instead. These are extended to 8 characters
;long, so you also have to change the lengths along with it.
Victory_ADVICE_BattleScreenPrivateStrings_speed::
    db "Speed   "
    
Victory_ADVICE_BattleScreenPrivateStrings_attack::
    db "Attack  "
    
Victory_ADVICE_BattleScreenPrivateStrings_defense::
    db "Defense "
    
;This is treated as a prefix to both of the abbreviated prefixes below.
;If this doesn't work for your language you'll have to alter the code that draws
;these as well as the tilemaps...
Victory_ADVICE_BattleScreenPrivateStrings_denma::
    db "Denma   "

;These have four tiles of space, not five.
;If you need all five tiles, then you have to also remove the code that draws
;parentheses around the stat differences, or you'll get cut off...
Victory_ADVICE_BattleScreenPrivateStrings_denmaAtk::
    db "Atk.    "
    
Victory_ADVICE_BattleScreenPrivateStrings_denmaDef::
    db "Def.    "

SECTION "Victory Advice Code 2", ROMX[$5A06], BANK[$1D]
Victory_ADVICE_UnloadSGBFiles::
    ld [W_LateDenjuu_SubSubState], a
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

Victory_ADVICE_TileLowByteBlanketFill::
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

Victory_ADVICE_DrawPhoneNumber::
    push hl
    push bc
    push de
    call Banked_Status_LoadPhoneDigits_NowWithSGBSupport
    pop de
    ld a, $FF
    ld hl, $99C2
    call vmempoke
    ld l, $D1
    call vmempoke
    ld b, $10
    ld hl, $9A02

.loop
    call vmempoke
    dec b
    jr nz, .loop
    pop bc
    pop hl
    jp Banked_Status_DrawPhoneNumberForStatus

Victory_ADVICE_LoadEvolutionIndicatorBySpecies::
    call Status_LoadEvolutionIndicatorBySpecies

    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z
	
    ld hl, $9100
    ld b, $30
    jp Victory_ADVICE_TileLowByteBlanketFill

Victory_ADVICE_LoadUnevolvedPalette::
    ld [W_LateDenjuu_SubSubState], a

    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z

    ld d, M_SGB_Pal23 << 3 + 1
    ld bc, $506
    M_PrepAuxJmp Banked_PatchUtils_CommitStagedCGBToSGB_CBE
	jp PatchUtils_AuxCodeJmp

Victory_ADVICE_LoadEvolvedPalette::
    ld [W_LateDenjuu_SubSubState], a

    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z

    ld d, M_SGB_Pal23 << 3 + 1
    ld bc, $507
    M_PrepAuxJmp Banked_PatchUtils_CommitStagedCGBToSGB_CBE
	jp PatchUtils_AuxCodeJmp

SECTION "Recruitment Advice Code", ROMX[$5E50], BANK[$1]
Victory_ADVICE_LoadSGBFilesRecruitment::
    M_AdviceSetup

    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld hl, $9010
    ld b, $68
    call Zukan_ADVICE_TileLightColourReverse

    ld hl, $8F00
    ld b, $40
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $90E0
    ld b, $48
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $9580
    ld b, $A0
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld a, 3
    ld [W_MainScript_TextStyle], a

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld c, $10
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, 4
    call PatchUtils_CommitStagedCGBToSGB

    ld a, M_SGB_Pal23 << 3 + 1
    ld bc, $507
    call PatchUtils_CommitStagedCGBToSGB

.return
    M_AdviceTeardown
    ret

Victory_ADVICE_EvolutionLoadSGBFiles::
    M_AdviceSetup

    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation

    call PauseMenu_ADVICE_CheckSGB
    jr z, .return

    ld hl, $9010
    ld b, $78
    call Zukan_ADVICE_TileLightColourReverse

    ld hl, $8F00
    ld b, $40
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $9100
    ld b, $30
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld hl, $9580
    ld b, $20
    call Zukan_ADVICE_TileLowByteBlanketFill

    ld a, 3
    ld [W_MainScript_TextStyle], a

    ld hl, W_LCDC_CGBStagingBGPaletteArea + (M_LCDC_CGBStagingAreaStride * 5)
    call Zukan_ADVICE_FixPaletteForSGB_skipHLSet

    ld c, $10
    call Banked_SGB_ConstructATFSetPacket

    ld a, M_SGB_Pal01 << 3 + 1
    ld bc, $404 
    call PatchUtils_CommitStagedCGBToSGB

    call PauseMenu_ADVICE_CGBToSGB56Shorthand

.return
    M_AdviceTeardown
    ret
