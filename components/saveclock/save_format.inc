;TODO: Determine actual size of array
DEF M_SaveClock_MaxDenjuuContacts EQU $FE

;Size of individual save data elements.
;WARNING: Other routines assume these values when calculating pointers.
;Changing these values will break code.
DEF M_SaveClock_DenjuuStatSize EQU $10
DEF M_SaveClock_DenjuuNicknameSize EQU 6

;Size of various staging areas.
DEF M_SaveClock_DenjuuNicknameStagingSize EQU M_SaveClock_DenjuuNicknameSize + 1

;Offsets of denjuu-specific data
DEF M_SaveClock_DenjuuSpecies EQU $0
DEF M_SaveClock_DenjuuLevel EQU $1
DEF M_SaveClock_DenjuuFriendship EQU $2
DEF M_SaveClock_DenjuuPersonality EQU $3
DEF M_SaveClock_DenjuuExperience EQU $4 ;2 bytes

;IDK what this is, but all the nickname code uses this offset
DEF M_SaveClock_DenjuuNickname EQU $6
DEF M_SaveClock_DenjuuPhoneVals EQU $A ;5 bytes

DEF M_SaveClock_DenjuuLevelCap EQU $63

;Inventory data
DEF M_SaveClock_InventoryCount EQU $44
DEF M_SaveClock_InventorySize EQU $2

DEF M_SaveClock_InventoryQuantity EQU 0
DEF M_SaveClock_InventoryItem EQU 1