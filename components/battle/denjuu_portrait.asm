INCLUDE "components/battle/denjuu_portrait.inc"

SECTION "Denjuu Portrait Loader WRAM", WRAM0[$CB02]
W_Battle_SelectedPortraitBank: ds 1

SECTION "Denjuu Portrait Loader", ROM0[$1620]
;Loads the individual pictures of each denjuu from a massive 10-bank
;uncompressed graphics array. Seriously!
;TODO: Extract the Denjuu graphics so we can symbolize the bank numbers.
Battle_LoadDenjuuPortrait::
    push de
    cp M_Battle_DenjuuPortraitStride
    jp nc, .bank2Denjuu
    push af
    ld a, $6B
    jp .denjuuBankAndOffsetSelected
    
.bank2Denjuu
    cp M_Battle_DenjuuPortraitStride * 2
    jp nc, .bank3Denjuu
    sub M_Battle_DenjuuPortraitStride
    push af
    ld a, $6C
    jp .denjuuBankAndOffsetSelected
    
.bank3Denjuu
    cp M_Battle_DenjuuPortraitStride * 3
    jp nc, .bank4Denjuu
    sub M_Battle_DenjuuPortraitStride * 2
    push af
    ld a, $6D
    jp .denjuuBankAndOffsetSelected
    
.bank4Denjuu
    cp M_Battle_DenjuuPortraitStride * 4
    jp nc, .bank5Denjuu
    sub M_Battle_DenjuuPortraitStride * 3
    push af
    ld a, $6E
    jp .denjuuBankAndOffsetSelected
    
.bank5Denjuu
    cp M_Battle_DenjuuPortraitStride * 5
    jp nc, .bank6Denjuu
    sub M_Battle_DenjuuPortraitStride * 4
    push af
    ld a, $6F
    jp .denjuuBankAndOffsetSelected
    
.bank6Denjuu
    cp M_Battle_DenjuuPortraitStride * 6
    jp nc, .bank7Denjuu
    sub M_Battle_DenjuuPortraitStride * 5
    push af
    ld a, $70
    jp .denjuuBankAndOffsetSelected
    
.bank7Denjuu
    cp M_Battle_DenjuuPortraitStride * 7
    jp nc, .bank8Denjuu
    sub M_Battle_DenjuuPortraitStride * 6
    push af
    ld a, $71
    jp .denjuuBankAndOffsetSelected
    
.bank8Denjuu
    cp M_Battle_DenjuuPortraitStride * 8
    jp nc, .bank9Denjuu
    sub M_Battle_DenjuuPortraitStride * 7
    push af
    ld a, $72
    jp .denjuuBankAndOffsetSelected
    
.bank9Denjuu
    cp M_Battle_DenjuuPortraitStride * 9
    jp nc, .bank10Denjuu
    sub M_Battle_DenjuuPortraitStride * 8
    push af
    ld a, $73
    jp .denjuuBankAndOffsetSelected
    
.bank10Denjuu
    sub M_Battle_DenjuuPortraitStride * 9
    push af
    ld a, $74

.denjuuBankAndOffsetSelected
    ld [W_Battle_SelectedPortraitBank], a
    pop af
    ld hl, Battle_DenjuuPortraitLookupTable
    ld d, 0
    ld e, a
    sla e
    rl d
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    ld a, [W_Battle_SelectedPortraitBank]
    rst $10
    
    pop de
    ld a, c
    cp 1
    jp z, .loadReversedGraphic
    ld bc, M_Battle_DenjuuPortraitSize
    jp LCDC_LoadGraphicIntoVRAM

.loadReversedGraphic
    ld bc, M_Battle_DenjuuPortraitSize ;wastefully duplicated instr
    jp LCDC_LoadReversedGraphic
    
SECTION "Denjuu Portrait Loader Ptr Lookup Table", ROM0[$1732]
Battle_DenjuuPortraitLookupTable::
DEF Vi = 0
REPT M_Battle_DenjuuPortraitStride
    dw $4000 + Vi
DEF Vi = Vi + M_Battle_DenjuuPortraitSize
ENDR

;todo: What palettes live at $1B0?
Battle_LoadExtraPalette::
    ld b, M_Battle_OpponentDenjuuPalette
    push bc
    ld hl, $1B0
    jp Battle_LoadDenjuuBackgroundPalette.indexPaletteId

Battle_LoadDenjuuPalettePartner::
    ld b, M_Battle_PartnerDenjuuPalette
    jp Battle_LoadDenjuuBackgroundPalette
    
Battle_LoadDenjuuPaletteOpponent::
    ld b, M_Battle_OpponentDenjuuPalette
    
Battle_LoadDenjuuBackgroundPalette::
    push bc
    ld hl, $100
    
.indexPaletteId
    ld d, 0
    ld e, a
    add hl, de
    pop bc
    ld a, b
    ld b, h
    ld c, l
    jp CGBLoadBackgroundPaletteBanked
    
Battle_LoadDenjuuObjectPalette::
    push bc
    ld hl, $100
    ld d, 0
    ld e, a
    add hl, de
    pop bc
    ld a, b
    ld b, h
    ld c, l
    jp CGBLoadObjectPaletteBanked
    
SECTION "Battle Resource Loaders", ROMX[$42DF], BANK[$5]
Battle_LoadDenjuuResourcesOpponent::
    push af
    ld c, 0
    ld de, $8800
    call Banked_Battle_LoadDenjuuPortrait
    pop af
    jp Battle_LoadDenjuuPaletteOpponent

Battle_LoadDenjuuResourcesPartner::
    push af
    ld c, 1
    ld de, $8B80
    call Banked_Battle_LoadDenjuuPortrait
    pop af
    jp Battle_LoadDenjuuPalettePartner