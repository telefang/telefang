INCLUDE "telefang.inc"

SECTION "Defection Memory for Advice Code", WRAM0[$CCBF]
W_Victory_DefectedSpeciesForNickname:: ds 1

SECTION "Victory Advice Code", ROMX[$598A], BANK[$1D]
Victory_ADVICE_SubStateDrawDefectionScreen::
    ld a, [hl]
    
    push de
    
    ld de, W_Victory_DefectedSpeciesForNickname
    ld [de], a
    
    pop de
    
    ld a, M_SaveClock_DenjuuStatSize
    
.eraseLoop
    ld [hl], 0
    inc hl
    dec a
    jr nz, .eraseLoop
    
    ret

;All these functions take a VRAM ptr and number of tiles to clear.
Victory_ADVICE_ClearWindowTiles::
    xor a
.clearLoop
    push bc
    ld c, 8
    
.innerLoop
    call YetAnotherWFB
    ld [hli], a
    ld [hli], a
    dec c
    jr nz, .innerLoop
    
    pop bc
    dec b
    jr nz, .clearLoop
    
    ret

Victory_ADVICE_SubStateDrawStatWindow::
    ld hl, $9400
    ld b, 20
    call Victory_ADVICE_ClearWindowTiles
    
    ;We need some code here to make room for our pointcut...
    ld de, Victory_ADVICE_BattleScreenPrivateStrings_speed
    ld hl, $9400
    ld b, 8
    call Banked_MainScript_DrawStatusText
    
    ld de, Victory_ADVICE_BattleScreenPrivateStrings_attack
    ret
    
Victory_ADVICE_SubStateDrawStatWindow_END::

;These strings have been relocated from battle_statemachine.asm - all code
;should reference these new strings instead. These are extended to 8 characters
;long, so you also have to change the lengths along with it.
Victory_ADVICE_BattleScreenPrivateStrings_speed::
    db "Speed   "
    
Victory_ADVICE_BattleScreenPrivateStrings_attack::
    db "Attack  "
    
Victory_ADVICE_BattleScreenPrivateStrings_defense::
    db "Defense "
    
;This is treated as a prefix to both of the abbreviated prefixes below.
;If this doesn't work for your language you'll have to alter the code that draws
;these as well as the tilemaps...
Victory_ADVICE_BattleScreenPrivateStrings_denma::
    db "Denma   "

;These have four tiles of space, not five.
;If you need all five tiles, then you have to also remove the code that draws
;parentheses around the stat differences, or you'll get cut off...
Victory_ADVICE_BattleScreenPrivateStrings_denmaAtk::
    db "Atk.    "
    
Victory_ADVICE_BattleScreenPrivateStrings_denmaDef::
    db "Def.    "