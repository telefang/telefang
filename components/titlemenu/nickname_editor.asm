INCLUDE "telefang.inc"
    
SECTION "Title Menu Nickname Saver", ROMX[$7DC9], BANK[$4]
TitleMenu_SaveDenjuuNicknameFromBuffer::
	ld l, a
    M_AuxJmp Banked_TitleMenu_ADVICE_SaveDenjuuNicknameFromBuffer
    jp TitleMenu_ExitSRAM
