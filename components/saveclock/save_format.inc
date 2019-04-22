;TODO: Determine actual size of array
M_SaveClock_MaxDenjuuContacts EQU $FE

;Size of individual save data elements.
;WARNING: Other routines assume these values when calculating pointers.
;Changing these values will break code.
M_SaveClock_DenjuuStatSize EQU $10
M_SaveClock_DenjuuNicknameSize EQU 6
M_SaveClock_DenjuuNicknameEntrySize EQU $A
M_SaveClock_DenjuuNicknameExtensionSize EQU 4

;Size of various staging areas.
M_SaveClock_DenjuuNicknameStagingSize EQU M_StringTable_Load8AreaSize + 1

;Offsets of denjuu-specific data
M_SaveClock_DenjuuSpecies EQU $0
M_SaveClock_DenjuuLevel EQU $1
M_SaveClock_DenjuuFriendship EQU $2
M_SaveClock_DenjuuPersonality EQU $3
M_SaveClock_DenjuuExperience EQU $4 ;2 bytes

;IDK what this is, but all the nickname code uses this offset
M_SaveClock_DenjuuNickname EQU $6
M_SaveClock_DenjuuPhoneVals EQU $A ;5 bytes

M_SaveClock_DenjuuLevelCap EQU $63

;Inventory data
M_SaveClock_InventoryCount EQU $44
M_SaveClock_InventorySize EQU $2

M_SaveClock_InventoryQuantity EQU 0
M_SaveClock_InventoryItem EQU 1