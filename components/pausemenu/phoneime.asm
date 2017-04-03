INCLUDE "telefang.inc"

SECTION "Pause Menu IME Memory", WRAM0[$CB28]
W_PauseMenu_PhoneIME:: ds 1
    ds 1 ; ???
W_PauseMenu_NextPhoneIME:: ds 1

SECTION "Pause menu IME stuff", ROMX[$665A], BANK[$4]
PauseMenu_LoadPhoneIMETilemap::
    ld e, $15
    ld a, [W_PauseMenu_NextPhoneIME]
    cp 0
    jr z, .loadTmap
    ld e, $16
    cp 1
    jr z, .loadTmap
    ld e, $1B
    
.loadTmap
    ld bc, $111
    ld a, 0
    jp Banked_RLEDecompressTMAP0