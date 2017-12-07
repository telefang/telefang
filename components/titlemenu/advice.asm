INCLUDE "telefang.inc"

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

SECTION "Title Menu SGB Advice", ROMX[$4300], BANK[$1]
TitleMenu_ADVICE_LoadSGBFiles::
    ld a, $32
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
	 
    ;Do nothing if no SGB detected.
    ld a, [W_SGB_DetectSuccess]
    or a
    ret z
    
    ;Do nothing if CGB hardware detected. This is possible if, say, we're in bgb
    ;or someone builds a Super Game Boy Color cart
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z
    
    ;Load our ATF
    ld a, 2
    ld b, 1
    ld c, 2
    ld d, 3
    ld e, 4
    call Banked_SGB_ConstructPaletteSetPacket
    ret
    
TitleMenu_ADVICE_UnloadSGBFiles::
    ;Load a neutral ATF
    ld a, 0
    ld b, 0
    ld c, 0
    ld d, 0
    ld e, 0
    call Banked_SGB_ConstructPaletteSetPacket
    ret