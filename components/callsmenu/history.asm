INCLUDE "telefang.inc"

SECTION "Calls Menu History Memory", WRAM0[$CD70]
W_CallsMenu_CallHistory:: ds M_CallsMenu_CallHistoryEntrySize * M_CallsMenu_CallHistoryEntryCount

SECTION "Calls Menu History Count", ROMX[$6F14], BANK[$4]
; Counts the number of valid entries in the call history.
; 
; Returns:
; 
; [W_MelodyEdit_DataCount] = Number of valid calls
CallsMenu_GetCallHistoryEntryCount::
    xor a
    ld [W_MelodyEdit_DataCount], a
    
    ld hl, W_CallsMenu_CallHistory
    ld de, M_CallsMenu_CallHistoryEntrySize
    ld b, M_CallsMenu_CallHistoryEntryCount
    
.count_loop
    ld a, [hl]
    cp 0
    jr z, .invalid_entry
    
.valid_entry
    ld a, [W_MelodyEdit_DataCount]
    inc a
    ld [W_MelodyEdit_DataCount], a
    
.invalid_entry
    add hl, de
    dec b
    jr nz, .count_loop
    ret
    
SECTION "Calls Menu History Indexing", ROMX[$77D9], BANK[$4]
; Queues up a set of sound effects to be played at a later time, corresponding
; to the phone number for a particular entry.
; 
; [W_MelodyEdit_DataCurrent] = Call history index
; 
; Returns
; 
; 
CallsMenu_QueuePhoneNumberSFXForHistoryEntry::
    call CallsMenu_IndexCallHistory
    jp CallsMenu_QueuePhoneNumberSFXForContact
    
; Given a call history index, return the Denjuu who placed the call.
;
; [W_MelodyEdit_DataCurrent] = Call history index
;
; Returns
;
; A = Contact index
CallsMenu_IndexCallHistory::
    ld a, [W_MelodyEdit_DataCurrent]
    ld b, a
    ld a, [W_MelodyEdit_DataCount]
    dec a
    sub b
    ld e, a
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    ld hl, W_CallsMenu_CallHistory
    add hl, de
    ldi a, [hl]
    dec a
    ret

; Given a contact index, return the species of the Denjuu that called.
;
; A = Contact index
;
; Returns
;
; A = Species index
CallsMenu_IndexContactSpecies::
    push af
    
    and $F0
    swap a
    ld d, a
    
    pop af
    
    and $F
    swap a
    ld e, a
    ld b, BANK(S_SaveClock_StatisticsArray)
    call TitleMenu_EnterSRAM
    
    ld hl, S_SaveClock_StatisticsArray
    add hl, de
    ld a, [hl]
    
    push af
    
    call TitleMenu_ExitSRAM
    
    pop af
    
    ret
