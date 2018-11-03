INCLUDE "telefang.inc"

SECTION "Pause Menu IME WRAM4", WRAM0[$CB43]
W_PauseMenu_NumberCallStatus:: ds 1

SECTION "Pause Menu Store Dialed Contact", ROMX[$760A], BANK[$4]
PauseMenu_StoreDialedContact::
    xor a
    ld [W_PauseMenu_NumberCallStatus], a
    ld [$CB03], a
    ld [W_PhoneIME_PhoneDigitIterator], a
    call PhoneIME_ReformatEnteredPhoneNumber
    
    ld hl, W_PhoneIME_DisplayedNumber
    call Banked_ContactEnlist_DecodePhoneNumber
    
    ;TODO: Disassemble this last bit