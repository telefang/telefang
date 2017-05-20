INCLUDE "telefang.inc"

W_Overworld_IncomingCallerName EQU $C210

SECTION "Overworld Incoming Caller Name Draw Func", ROMX[$560A], BANK[$29]
Overworld_DrawIncomingCallerName::
    ld a, [W_SaveClock_SelectedDenjuu]
    ld c, a
    ld a, BANK(SaveClock_LoadDenjuuNicknameByIndex)
    ld hl, SaveClock_LoadDenjuuNicknameByIndex
    call CallBankedFunction_int
    
    ld hl, W_SaveClock_NicknameStaging
    ld de, W_Overworld_IncomingCallerName
    call Banked_StringTable_PadCopyBuffer
    
    ld b, 8
    ld c, $B0
    ld hl, $9866
    
.allocateTextArea
    di
    call WaitForBlanking
    ld a, c
    ld [hli], a
    ei
    
    inc c
    dec b
    jr nz, .allocateTextArea
    
    ld b, 8
    ld hl, $8B00
    ld de, W_Overworld_IncomingCallerName
    
.letterDrawingLoop
    ld a, [de]
    cp $E0
    jr nz, .noTerminate
    
.terminate
    ld a, 0
    
.noTerminate
    inc de
    push bc
    push de
    call Banked_MainScript_DrawLetter
    pop de
    pop bc
    dec b
    jr nz, .letterDrawingLoop
    
    ld d, 1
    ld bc, 8
    ld hl, $9866
    ld a, 1
    call $377B
    
    ret