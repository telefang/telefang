INCLUDE "telefang.inc"

SECTION "Active Save File", SRAM[$A000], BANK[2]
S_SaveClock_StatisticsArray:: REPT M_SaveClock_MaxDenjuuContacts
	ds M_SaveClock_DenjuuStatSize
	ENDR
	
SECTION "Active Save File 2", SRAM[$B200], BANK[2]
S_SaveClock_NicknameArray:: REPT M_SaveClock_MaxDenjuuContacts
	ds M_SaveClock_DenjuuNicknameSize
	ENDR
   
SECTION "Active Save File 3", SRAM[$B000], BANK[1]
S_SaveClock_InventoryArray:: REPT M_SaveClock_InventoryCount
	ds M_SaveClock_InventorySize
	ENDR