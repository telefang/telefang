INCLUDE "telefang.inc"

SECTION "Title Menu Nickname Ex-Loader Nops", ROMX[$7D8C], BANK[$4]
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
    
SECTION "Title Menu Nickname Saver", ROMX[$7DCA], BANK[$4]
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