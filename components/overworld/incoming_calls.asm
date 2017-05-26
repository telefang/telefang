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
    jp Overworld_ADVICE_DrawIncomingCallerName
    
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    
.adviceComefrom
    ld d, 1
    ld bc, 8
    ld hl, $9866
    ld a, 1
    call $377B
    
    ret
    
SECTION "Overworld Incoming Caller Name Draw Advice", ROMX[$786A], BANK[$29]
Overworld_ADVICE_DrawIncomingCallerName::
    inc de
    push bc
    push de
    push hl
    call Banked_MainScript_DrawLetter
    pop hl
    pop de
    pop bc
    
    ld a, [W_MainScript_VWFOldTileMode]
    dec a
    jr nz, .noAdjustment
    
.adjustment
    push de
    
    ld d, 0
    ld e, $10
    add hl, de
    
    pop de
    
    dec b

.noAdjustment
    jp nz, Overworld_DrawIncomingCallerName.letterDrawingLoop
    jp Overworld_DrawIncomingCallerName.adviceComefrom
Overworld_ADVICE_DrawIncomingCallerName_END::