INCLUDE "telefang.inc"

SECTION "PauseMenu Contacts Array", WRAMX[$D000], BANK[1]
W_PauseMenu_ContactsArray:: ds 1 ;longer than this, but it's aliased

SECTION "PauseMenu Contacts Array 2", WRAM0[$CD24]
W_PauseMenu_CurrentContact:: ds 1

SECTION "PauseMenu Contacts Array 3", WRAM0[$CDB4]
W_PauseMenu_DeletedContact:: ds 1

SECTION "PauseMenu Contacts Funcs", ROMX[$7E4C], BANK[$4]
PauseMenu_IndexContactArray::
    ld a, [W_Status_SelectedContactIndex]
    ld e, a
    ld d, 0
    ld hl, W_PauseMenu_ContactsArray
    add hl, de
    ld a, [hl]
    ret