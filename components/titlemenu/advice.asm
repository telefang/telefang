INCLUDE "telefang.inc"

SECTION "TitleMenu Check If Either SGB or CGB", ROMX[$5A8B], BANK[$4]
TitleMenu_ADVICE_CanUseCGBTiles::
; Sets the z flag if in CGB or SGB mode.
    ld a, [W_SGB_DetectSuccess]
    dec a
    ret z
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret
    nop
    nop
    nop

SECTION "Title Menu Advice Code", ROMX[$7D14], BANK[$34]
TitleMenu_ADVICE_SplitNickAndSpeciesNamesBrokenCallsite::
    REPT $B7
    nop
    ENDR
    
TitleMenu_ADVICE_SplitNickAndSpeciesNames::
    ld hl, W_MainScript_CenteredNameBuffer
    ld bc, $CCB5
    
.compareLoop
    ld a, [bc]
    cp [hl]
    jp nz, .normalCopy
    
    inc hl
    inc bc
    ld a, l
    cp (W_MainScript_CenteredNameBuffer + M_SaveClock_DenjuuNicknameSize) & $FF
    jp c, .compareLoop
    
    ld a, $E6
    ld [W_MainScript_CenteredNameBuffer], a
    
    ld hl, (W_MainScript_CenteredNameBuffer + 1)
    
.terminateLoop
    ld [hl], $E0
    inc hl
    ld a, l
    cp $A1
    jp c, .terminateLoop
    
.normalCopy
    ld hl, W_MainScript_CenteredNameBuffer
    ld bc, M_SaveClock_DenjuuNicknameSize
    call memcpy
    ret
    
    nop
    nop
    nop
    nop
    
TitleMenu_ADVICE_EnterSRAM2::
    push bc
    ld b, BANK(S_SaveClock_NicknameArray)
    call TitleMenu_ADVICE_EnterSRAM
    pop bc
    ret
    
    nop
    nop
    nop
    
TitleMenu_ADVICE_EnterSRAM::
    push af
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, b
    ld [REG_MBC3_SRAMBANK], a
    pop af
    ret
    
TitleMenu_ADVICE_ExitSRAM::
    push af
    xor a
    ld [REG_MBC3_SRAMENABLE], a
    pop af
    ret
    
    nop
    nop
    
SECTION "Title Menu Advice Code 2", ROMX[$7E45], BANK[$34]
TitleMenu_ADVICE_LoadDenjuuNicknameIntoBuffer::
    call System_Multiply16
    ld hl, S_SaveClock_NicknameArray
    add hl, de
    push af
    call TitleMenu_ADVICE_EnterSRAM2
    
    ld a, [hl]
    cp $E6
    jp z, .useSpeciesName
    
    call TitleMenu_ADVICE_SplitNickAndSpeciesNamesBrokenCallsite
    
    pop af
    ret
    
    ;WARNING: SRAM never closed!!
    
    nop
    nop
    nop
    nop
    
.useSpeciesName
    push bc
    call TitleMenu_ADVICE_IndexArray16
    ld a, $A0
    add a, b
    ld b, a
    ld a, [bc]
    ld c, a
    ld b, 0
    
    call TitleMenu_ADVICE_IndexArray16
    ld a, $40
    add a, b
    ld b, a
    
    push de
    push bc
    pop hl
    
    ld c, M_SaveClock_DenjuuNicknameSize
    ld de, $CCB5
    
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jp nz, .copyLoop
    
    ld hl, $CCB5
    pop de
    pop bc
    
    call TitleMenu_ADVICE_ExitSRAM
    pop af
    ret
    
    nop
    
;TODO: this could be implemented better...
TitleMenu_ADVICE_IndexArray16::
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    ret

;TODO: Move all the above advice into this section
SECTION "Title Menu Aux-Code Advice", ROMX[$4340], BANK[$1]
TitleMenu_ADVICE_StateLoadGraphics::
    M_AdviceSetup
    
    call ClearGBCTileMap0
    call ClearGBCTileMap1
    call LCDC_ClearMetasprites
    
    nop
    nop
    call TitleMenu_ADVICE_CanUseCGBTiles_Alt
    jr z, .cgbGfx
    
.dmgGfx
    ld bc, $5E
    call Banked_LoadMaliasGraphics
    ld bc, $55
    call Banked_LoadMaliasGraphics
    jr .advice_exit

.cgbGfx
    ld bc, $5D
    call Banked_LoadMaliasGraphics
    ld bc, $1B
    call Banked_LoadMaliasGraphics
    
.advice_exit
    M_AdviceTeardown
    ret

TitleMenu_ADVICE_LoadSGBFiles::
    M_AdviceSetup
    
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
	
TitleMenu_ADVICE_LoadSGBFiles_externalEntry::
	 
    call PauseMenu_ADVICE_CheckSGB
    jr z, .return
    
    ;Load our ATF
    ld c, 3
    call Banked_SGB_ConstructATFSetPacket
    
    call PauseMenu_ADVICE_CGBToSGB02Shorthand
    call PauseMenu_ADVICE_CGBToSGB56Shorthand
    
.return
    M_AdviceTeardown
    ret
    
TitleMenu_ADVICE_LoadSGBFilesSoundTest::
    M_AdviceSetup
    
    ld a, 4
    ld [W_PauseMenu_SelectedCursorType], a
	
TitleMenu_ADVICE_LoadSGBFilesSoundTest_externalEntry::
    
    ld c, 6
    call Banked_SGB_ConstructATFSetPacket
    
    M_AdviceTeardown
    ret
    
TitleMenu_ADVICE_UnloadSGBFilesSoundTest::
    M_AdviceSetup
    
    ld a, M_TitleMenu_StateMenuInputHandler
    ld [W_SystemSubState], a
    
    ld c, 3
    call Banked_SGB_ConstructATFSetPacket
    
    M_AdviceTeardown
    ret
    
TitleMenu_ADVICE_UnloadSGBFilesOverworld::
    M_AdviceSetup
    
    ld a, 5
    ld [W_SystemState], a
    
    ;Load a neutral ATF
    ld a, 0
    ld b, 0
    ld c, 0
    ld d, 0
    ld e, 0
    call Banked_SGB_ConstructPaletteSetPacket
    
    M_AdviceTeardown
    ret
    
TitleMenu_ADVICE_UnloadSGBFilesLink::
    M_AdviceSetup
    
    ld a, $F
    ld [W_SystemState], a
    
    ;Load a neutral ATF
    ld a, 0
    ld b, 0
    ld c, 0
    ld d, 0
    ld e, 0
    call Banked_SGB_ConstructPaletteSetPacket
    
    M_AdviceTeardown
    ret
    
TitleMenu_ADVICE_CanUseCGBTiles_Alt::
; A bank 1 copy of TitleMenu_ADVICE_CanUseCGBTiles.
    ld a, [W_SGB_DetectSuccess]
    dec a
    ret z
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret

SECTION "Title Menu Aux-Code Advice 2", ROMX[$5560], BANK[$1]
TitleMenu_ADVICE_LoadSGBFilesTimeInput::
    M_AdviceSetup
    ld a, 5
    ld [W_PauseMenu_SelectedCursorType], a
    jp TitleMenu_ADVICE_LoadSGBFilesSoundTest_externalEntry

SECTION "Title Menu Aux-Code Advice 3", ROMX[$5D30], BANK[$1]
TitleMenu_ADVICE_Nickname_RedrawTiles::
	di

.wfb
	ldh a, [REG_STAT]
	and 2
	jr nz, .wfb

	ld a, [hli]
	ld [hli], a
	ld a, [hli]
	ld [hli], a
	ei
	dec b
	jr nz, TitleMenu_ADVICE_Nickname_RedrawTiles
	ret

TitleMenu_ADVICE_Nickname_RemapBlankTiles::
	ld hl, $9921
	ld de, $FF18
	ld c, 3

.rowloop
	ld b, 8

.maploop
	di

.wfb
	ldh a, [REG_STAT]
	and 2
	jr nz, .wfb

	ld a, [hl]
	cp $D0
	jr nz, .ignore

	ld a, d
	ld [hl], a

.ignore
	ei
	inc hl
	dec b
	jr nz, .maploop

	ld a, e
	add l
	ld l, a
	dec c
	jr nz, .rowloop
	ret

TitleMenu_ADVICE_Nickname_RemapTilesToBlank::
	ld bc, $4FF

.maploop
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
	jr nz, .maploop
	ret

TitleMenu_ADVICE_InitNickname::
	M_AdviceSetup

	ld a, 4
	call Banked_LCDC_SetupPalswapAnimation

	call PauseMenu_ADVICE_CheckSGB
	jr z, .return

	ld hl, $98E1
	call TitleMenu_ADVICE_Nickname_RemapTilesToBlank
	ld hl, $9901
	call TitleMenu_ADVICE_Nickname_RemapTilesToBlank
	ld l, $81
	call TitleMenu_ADVICE_Nickname_RemapTilesToBlank
	call TitleMenu_ADVICE_Nickname_RemapBlankTiles

	ld hl, $8E50
	ld b, $14
	call TitleMenu_ADVICE_Nickname_RedrawTiles
	ld hl, $95C0
	ld b, $C
	call TitleMenu_ADVICE_Nickname_RedrawTiles
	ld hl, $9700
	ld b, $20
	call TitleMenu_ADVICE_Nickname_RedrawTiles
	
	ld c, $12
	call Banked_SGB_ConstructATFSetPacket
	
	ld a, M_SGB_Pal01 << 3 + 1
	ld b, 0
	ld c, $C
	call PatchUtils_CommitStagedCGBToSGB

	call PauseMenu_ADVICE_CGBToSGB56Shorthand

.return

	M_AdviceTeardown
	ret
