INCLUDE "telefang.inc"

SECTION "Summon Draw Funcs 1", ROMX[$5744], BANK[$1C]
Summon_DrawPageContactNames::
    call SaveClock_EnterSRAM2
    
    ld d, 0
    call Summon_GetContactIDForCurrentPage
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuSpecies
    call Battle_IndexStatisticsArray
    
    push hl
    pop de
    call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
    
    ld hl, $9400
    ld de, W_SaveClock_NicknameStaging
    ld b, M_SaveClock_DenjuuNicknameSize
    call Banked_MainScript_DrawStatusText
    
    ld bc, $B03
    ld e, $A7
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_Summon_SelectedPageCount]
    cp 2
    ret c
    
    call SaveClock_EnterSRAM2
    
    ld d, 1
    call Summon_GetContactIDForCurrentPage
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuSpecies
    call Battle_IndexStatisticsArray
    
    push hl
    pop de
    call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
    
    ld hl, $9480
    ld de, W_SaveClock_NicknameStaging
    ld b, M_SaveClock_DenjuuNicknameSize
    call Banked_MainScript_DrawStatusText
    
    ld bc, $B06
    ld e, $A8
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_Summon_SelectedPageCount]
    cp 3
    ret c
    
    call SaveClock_EnterSRAM2
    
    ld d, 2
    call Summon_GetContactIDForCurrentPage
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuSpecies
    call Battle_IndexStatisticsArray
    
    push hl
    pop de
    call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
    
    ld hl, $9500
    ld de, W_SaveClock_NicknameStaging
    ld b, M_SaveClock_DenjuuNicknameSize
    call Banked_MainScript_DrawStatusText
    
    ld bc, $B09
    ld e, $A9
    ld a, 0
    jp Banked_RLEDecompressTMAP0