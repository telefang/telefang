INCLUDE "telefang.inc"

SECTION "Title Menu Nickname Loader", ROMX[$7D8C], BANK[$4]
TitleMenu_LoadDenjuuNicknameIntoBuffer::
    ld c, a
    ld b, 0
    ld de, M_SaveClock_DenjuuNicknameSize
    call System_Multiply16
    
    ld hl, S_SaveClock_NicknameArray
    add hl, de
    
    ld b, BANK(S_SaveClock_NicknameArray)
    call TitleMenu_EnterSRAM
    
    ld de, W_TitleMenu_NameBuffer
    ld bc, M_SaveClock_DenjuuNicknameSize
    call memcpy
    
    call TitleMenu_ExitSRAM
    
    ld hl, W_TitleMenu_NameBuffer
    ld b, 0
    ld c, M_SaveClock_DenjuuNicknameSize
    
.reterminateLoop
    ld a, [hl]
    
    cp $E0
    jr z, .changeTerminator
    inc b
    jr .noChangeTerminator
    
.changeTerminator
    xor a
    ld [hl], a
    
.noChangeTerminator
    inc hl
    dec c
    
    jr nz, .reterminateLoop
    
    ;Position the cursor at the end of the string.
    ld a, b
    cp (M_SaveClock_DenjuuNicknameSize - 1)
    jr c, .setCursorPos
    
    ld a, (M_SaveClock_DenjuuNicknameSize - 1)
.setCursorPos
    ld [W_PauseMenu_SelectedMenuItem], a
    
    ret
    
TitleMenu_SaveDenjuuNicknameFromBuffer::
    ld c, a
    ld b, 0
    ld de, M_SaveClock_DenjuuNicknameSize
    call System_Multiply16
    
    ld hl, S_SaveClock_NicknameArray
    add hl, de
    push hl
    pop de
    
    ld b, BANK(S_SaveClock_NicknameArray)
    call TitleMenu_EnterSRAM
    
    ld hl, W_MainScript_CenteredNameBuffer
    ld bc, M_SaveClock_DenjuuNicknameSize
    call memcpy
    
    jp TitleMenu_ExitSRAM