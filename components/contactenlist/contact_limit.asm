INCLUDE "telefang.inc"

SECTION "Contact Enlist Limits", ROMX[$7B3A], BANK[$4]

; Determine if the player has space in their phone to enlist another Denjuu.
; 
; The contact limit can vary based on the current model of phone the user has.
; See .contact_limits_table for the full list of limits.
; 
; Returns:
; 
; A = 0 if contact limit has not yet been met
; A = 1 if contact limit has been met or exceeded
ContactEnlist_CheckContactLimit::
    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    ld hl, .contact_limits_table
    add hl, de
    ld a, [hl]
    
    push af
    
    ld [$CB33], a
    
    ld b, 2
    call TitleMenu_EnterSRAM
    
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuLevel
    ld c, $FE
    ld b, 0
    ld de, $10
    
.contact_count_loop
    ld a, [hl]
    cp 0
    jr z, .invalid_contact_entry
    
.valid_contact_entry
    inc b
    
.invalid_contact_entry
    add hl, de
    dec c
    jr nz, .contact_count_loop
    call TitleMenu_ExitSRAM
    
    pop af
    
    cp b
    jr z, .contact_limit_exceeded
    jr nc, .contact_limit_not_met
    
.contact_limit_exceeded
    ld a, 1
    ret

.contact_limit_not_met
    xor a
    ret

.contact_limits_table
    db $46, $96, $F0, $46, $96, $F0, $46, $96, $F0
