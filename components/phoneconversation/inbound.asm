INCLUDE "telefang.inc"

W_PhoneConversation_IncomingCallerName EQU $C210
W_PhoneConversation_IncomingCallerFD EQU $C20B
W_PhoneConversation_IncomingCallerFDOffset EQU $C20E

SECTION "Phone Conversation Incoming Caller States", ROMX[$560A], BANK[$29]
PhoneConversation_DrawIncomingCallerName::
    ld a, [W_SaveClock_SelectedDenjuu]
    ld c, a
    ld a, BANK(SaveClock_LoadDenjuuNicknameByIndex)
    ld hl, SaveClock_LoadDenjuuNicknameByIndex
    call CallBankedFunction_int
    
    ld hl, W_SaveClock_NicknameStaging
    ld de, W_PhoneConversation_IncomingCallerName
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
    ld de, W_PhoneConversation_IncomingCallerName
    
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
    
PhoneConversation_DrawFDDisplay::
    di
    
    call WaitForBlanking
    ld a, $AA
    ld [$9966], a
    
    call WaitForBlanking
    ld a, $AB
    ld [$9967], a
    
    ei
    
    ld a, [W_PhoneConversation_IncomingCallerFD]
    call Status_DecimalizeStatValue
    
    ld hl, $9968
    
    di
    call PhoneConversation_DrawFDBaseValue
    ei
    
    ld c, $AC
    ld a, [W_PhoneConversation_IncomingCallerFDOffset]
    
    bit 7, a
    jr z, .drawInfixSign
.negativeOffset
    ld c, $AD
    cpl
    inc a
    
.drawInfixSign
    ld b, a
    
    di
    call WaitForBlanking
    ld a, c
    ld [hli], a
    ei
    
    ld a, b
    call Status_DecimalizeStatValue
    
    di
    call PhoneConversation_DrawFDOffsetValue
    ei
    
    ret
    
PhoneConversation_DrawFDBaseValue::
    ld a, [Malias_CmpSrcBank]
    and $F
    add a, $A0
    ld c, a
    call WaitForBlanking
    ld a, c
    ld [hli], a
    
PhoneConversation_DrawFDOffsetValue::
    ld a, [W_GenericRegPreserve]
    swap a
    and $F
    add a, $A0
    ld c, a
    
    call WaitForBlanking
    ld a, c
    ld [hli], a
    
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $A0
    ld c, a
    
    call WaitForBlanking
    ld a, c
    ld [hli], a
    
    ret