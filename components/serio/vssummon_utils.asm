INCLUDE "telefang.inc"

SECTION "SerIO VSSummon Utils", ROMX[$56FE], BANK[$1F]
;Oh look, a duplicate of existing Summon code...
SerIO_SummonDrawNicknames::
    ld a, [W_Summon_SelectedPageCount]
    cp 1
    jp c, .doneDrawingNames
    
.drawFirstContact
    call SaveClock_EnterSRAM2
    
    ld d, 0
    call SerIO_IndexContactArrayByPage
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuNickname
    call Battle_IndexStatisticsArray
    
    push hl
    pop de
    
    call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
    call SaveClock_EnterSRAM2
    
    ld hl, $9400
    ld de, W_SaveClock_NicknameStaging
    ld b, M_SaveClock_DenjuuNicknameStagingSize
    call Banked_MainScript_DrawStatusText
    
    ld bc, $B03
    ld e, $A7
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_Summon_SelectedPageCount]
    cp 2
    jr c, .doneDrawingNames
    
.drawSecondContact
    call SaveClock_EnterSRAM2
    
    ld d, 1
    call SerIO_IndexContactArrayByPage
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuNickname
    call Battle_IndexStatisticsArray
    
    push hl
    pop de
    
    call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
    call SaveClock_EnterSRAM2
    
    ld hl, $9480
    ld de, W_SaveClock_NicknameStaging
    ld b, M_SaveClock_DenjuuNicknameStagingSize
    call Banked_MainScript_DrawStatusText
    
    ld bc, $B06
    ld e, $A8
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld a, [W_Summon_SelectedPageCount]
    cp 3
    jr c, .doneDrawingNames
    
.drawThirdContact
    call SaveClock_EnterSRAM2
    
    ld d, 2
    call SerIO_IndexContactArrayByPage
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuNickname
    call Battle_IndexStatisticsArray
    
    push hl
    pop de
    
    call Banked_SaveClock_LoadDenjuuNicknameByStatPtr
    call SaveClock_EnterSRAM2
    
    ld hl, $9500
    ld de, W_SaveClock_NicknameStaging
    ld b, M_SaveClock_DenjuuNicknameStagingSize
    call Banked_MainScript_DrawStatusText
    
    ld bc, $B09
    ld e, $A9
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
.doneDrawingNames
    ret

SECTION "VSSummon Utils 2", ROMX[$5688], BANK[$1F]
SerIO_IndexContactArrayByPage::
    ld hl, W_PauseMenu_ContactsArray
    call SerIO_IndexCurrentContactPage
    
    ld d, 0
    ld e, a
    add hl, de
    ld a, [hl]
    ret
    
SECTION "VSSummon Utils 3", ROMX[$55F1], BANK[$1F]
SerIO_IndexCurrentContactPage::
    ld a, [W_Summon_CurrentPage]
    cp 0
    jr z, .returnIndex
    
    ld b, a
    ld a, d
    
.indexLoop
    add a, 3
    dec b
    jr nz, .indexLoop
    
    ld d, a
    
.returnIndex
    ld a, d
    ret