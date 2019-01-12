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
    
.searchLoop
    ld a, [bc]
    cp [hl]
    jp nz, .normalCopy
    
    inc hl
    inc bc
    ld a, l
    cp $96
    jp c, .searchLoop
    
    ld a, $E6
    ld [W_MainScript_CenteredNameBuffer], a
    
    ld hl, (W_MainScript_CenteredNameBuffer + 1)
    
.searchLoopTwo
    ld [hl], $E0
    inc hl
    ld a, l
    cp $A1
    jp c, .searchLoopTwo
    
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
	 
    ;Do nothing if no SGB detected.
    ld a, [W_SGB_DetectSuccess]
    or a
    jr z, .return
    
    ;Do nothing if CGB hardware detected. This is possible if, say, we're in bgb
    ;or someone builds a Super Game Boy Color cart
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .return
    
    ;Load our ATF
    ld c, 3
    call Banked_SGB_ConstructATFSetPacket
    
    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 2
    call PatchUtils_CommitStagedCGBToSGB
    
    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 6
    call PatchUtils_CommitStagedCGBToSGB
    
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
