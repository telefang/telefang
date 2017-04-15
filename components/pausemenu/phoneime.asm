INCLUDE "telefang.inc"

; BANK() is stupid
IMPORT PhoneKeypadGfx
IMPORT PhoneKeypadGfxDmg

SECTION "Pause Menu IME WRAM", WRAM0[$CDB5]
W_PauseMenu_PhoneState:: ds 1

SECTION "Pause Menu IME WRAM2", WRAM0[$CB3E]
W_PauseMenu_PhoneIMEPressCount:: ds 1

SECTION "Pause Menu IME WRAM3", WRAM0[$CB28]
W_PauseMenu_NextPhoneIME:: ds 1
    ds 1 ; ???
W_PauseMenu_CurrentPhoneIME:: ds 1

SECTION "Pause Menu IME WRAM4", WRAM0[$CB65]
W_MelodyEdit_State::
W_PauseMenu_PhoneIMEButton:: ds 1
W_PauseMenu_PhoneIMELastPressedButton:: ds 1

SECTION "Pause menu IME stuff", ROMX[$665A], BANK[$4]
PauseMenu_LoadPhoneIMETilemap::
    ld e, $15
    ld a, [W_PauseMenu_CurrentPhoneIME]
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
    
PauseMenu_PhoneIMEPlayerNameDiacritic::
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    push hl
    call PauseMenu_PhoneIMEApplyDiacritic
    pop hl
    ld [hl], a
    call PauseMenu_PhoneIMESyncPlayerName
    jp PauseMenu_DrawCenteredNameBuffer
    
PauseMenu_PhoneIMEDenjuuNicknameDiacritic::
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    push hl
    call PauseMenu_PhoneIMEApplyDiacritic
    pop hl
    ld [hl], a
    call PauseMenu_PhoneIMESyncDenjuuNickname
    jp PauseMenu_DrawCenteredNameBuffer

SECTION "Pause Menu Phone Stuff", ROMX[$693B], BANK[$4]
PauseMenu_LoadPhoneIMEGraphics::
    ld hl, .imeGraphicsTableCGB
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .tableSelected
    ld hl, .imeGraphicsTableDMG
    
.tableSelected
    ld a, [W_PauseMenu_PhoneState]
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    ld a, [W_PauseMenu_NextPhoneIME]
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr z, .selectCGBBank
    ld a, BANK(PhoneKeypadGfx)
    jr .bankSelected
    
.selectCGBBank
    ld a, BANK(PhoneKeypadGfxDmg) ;yeah IDK WTF, I think our PNGs are mislabeled
    
.bankSelected
    ld de, $8A00
    ld bc, $400
    jp Banked_LCDC_LoadGraphicIntoVRAM
    
;TODO: These are all offsets of PhoneKeypadGfx
.imeGraphicsTableCGB
    dw .imeGraphicsTableCGBPhone0, .imeGraphicsTableCGBPhone0, .imeGraphicsTableCGBPhone0
    dw .imeGraphicsTableCGBPhone1, .imeGraphicsTableCGBPhone1, .imeGraphicsTableCGBPhone1
    dw .imeGraphicsTableCGBPhone2, .imeGraphicsTableCGBPhone2, .imeGraphicsTableCGBPhone2
    
.imeGraphicsTableCGBPhone0
    dw $4000,$4400,$4800,$4C00
.imeGraphicsTableCGBPhone1
    dw $5000,$5400,$5800,$5C00
.imeGraphicsTableCGBPhone2
    dw $6000,$6400,$6800,$6C00

.imeGraphicsTableDMG
    dw .imeGraphicsTableDMGPhone0, .imeGraphicsTableDMGPhone0, .imeGraphicsTableDMGPhone0
    dw .imeGraphicsTableDMGPhone1, .imeGraphicsTableDMGPhone1, .imeGraphicsTableDMGPhone1
    dw .imeGraphicsTableDMGPhone2, .imeGraphicsTableDMGPhone2, .imeGraphicsTableDMGPhone2
    
.imeGraphicsTableDMGPhone0
    dw $4000,$4400,$4800,$4C00
.imeGraphicsTableDMGPhone1
    dw $5000,$5400,$5800,$5C00
.imeGraphicsTableDMGPhone2
    dw $6000,$6400,$6800,$6C00

PauseMenu_LoadPhoneGraphics::
    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    sla e
    rl d
    
    push de
    ld hl, PauseMenu_PhoneGraphicsTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, $9000
    ld bc, $400
    ld a, $37 ; '7'
    call Banked_LCDC_LoadGraphicIntoVRAM ; Phone
    
    pop de
    push de
    ld hl, PauseMenu_PhoneGraphicsTable.buttonsTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, $8800
    ld bc, $200
    ld a, $7A ; 'z'
    call Banked_LCDC_LoadGraphicIntoVRAM ; Buttons
    
    pop de
    ld hl, PauseMenu_PhoneGraphicsTable.modelNoTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, $9210
    ld bc, $30 ; '0'
    ld a, $37 ; '7'
    jp Banked_LCDC_LoadGraphicIntoVRAM ; Model no
    
;This should be in palette.asm, but it's not because it's sandwiched between these other two bits
PauseMenu_CGBLoadPhonePalette::
    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    
    ld hl, $390
    add hl, de
    
    push hl
    pop bc
    
    xor a
    jp CGBLoadBackgroundPaletteBanked
    
PauseMenu_PhoneGraphicsTable::
    dw $5D5F,$5D5F,$5D5F,$615F,$615F,$615F,$655F,$655F,$655F
.buttonsTable
    dw $4000,$4200,$4400,$4600,$4800,$4A00,$4C00,$4E00,$5000
.modelNoTable
    dw $6E5F,$6E8F,$6EBF,$6EEF,$6F1F,$6F4F,$6F7F,$6FAF,$6FDF

SECTION "Title Menu Player Name Input 4", ROMX[$5B37], BANK[$4]
PauseMenu_PhoneIMEWraparoundProcessing::
    ld a, [W_JPInput_TypematicBtns]
    and $10
    jr z, .checkLeftBtn
    
    ld a, $63
    ld [byte_FFA1], a
    
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp M_PhoneMenu_ButtonConfirm
    jr nz, .checkWraparoundRight
    xor a
    jr .saveNewButtonRight
    
.checkWraparoundRight
    cp M_PhoneMenu_Button3
    jr z, .wraparoundPtRight
    cp M_PhoneMenu_Button6
    jr z, .wraparoundPtRight
    cp M_PhoneMenu_Button9
    jr z, .wraparoundPtRight
    cp M_PhoneMenu_ButtonPound
    jr z, .wraparoundPtRight
    
    jr .incrementButtonRight
    
.wraparoundPtRight
    sub 3
    
.incrementButtonRight
    inc a
    
.saveNewButtonRight
    ld [W_PauseMenu_PhoneIMEButton], a
    jp $5D40
    
.checkLeftBtn
    ld a, [W_JPInput_TypematicBtns]
    and $20
    jr z, .checkUpBtn
    
    ld a, $63
    ld [byte_FFA1], a
    
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp M_PhoneMenu_ButtonNote
    jr nz, .checkWraparoundLeft
    
    ld a, M_PhoneMenu_ButtonConfirm
    jr .saveNewButtonLeft
    
.checkWraparoundLeft
    cp M_PhoneMenu_Button1
    jr z, .wraparoundPtLeft
    cp M_PhoneMenu_Button4
    jr z, .wraparoundPtLeft
    cp M_PhoneMenu_Button7
    jr z, .wraparoundPtLeft
    cp M_PhoneMenu_ButtonStar
    jr z, .wraparoundPtLeft
    jr .decrementButtonLeft
    
.wraparoundPtLeft
    adc a, 3
    
.decrementButtonLeft
    dec a
    
.saveNewButtonLeft
    ld [W_PauseMenu_PhoneIMEButton], a
    jp $5D40
    
.checkUpBtn
    ld a, [W_JPInput_TypematicBtns]
    and $40
    jr z, .checkDownBtn
    
    ld a, $63
    ld [byte_FFA1], a
    
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp M_PhoneMenu_ButtonNote
    jr nz, .checkUpFromLeftKey
    ld a, M_PhoneMenu_ButtonStar
    jr .saveButtonUp
    
.checkUpFromLeftKey
    cp M_PhoneMenu_ButtonLeft
    jr nz, .checkUpFromRightKey
    ld a, M_PhoneMenu_Button0
    jr .saveButtonUp
    
.checkUpFromRightKey
    cp M_PhoneMenu_ButtonRight
    jr nz, .checkUpFromConfirmKey
    ld a, M_PhoneMenu_Button0
    jr .saveButtonUp
    
.checkUpFromConfirmKey
    cp M_PhoneMenu_ButtonConfirm
    jr nz, .checkUpFromOneKey
    ld a, M_PhoneMenu_ButtonPound
    jr .saveButtonUp
    
.checkUpFromOneKey
    cp M_PhoneMenu_Button1
    jr nz, .decrementButtonUp
    ld a, M_PhoneMenu_ButtonNote
    jr .saveButtonUp
    
.decrementButtonUp
    sub 3
    and $F
    
.saveButtonUp
    ld [W_PauseMenu_PhoneIMEButton], a
    jp $5D40

.checkDownBtn
    ld a, [W_JPInput_TypematicBtns]
    and $80
    jr z, .return
    
    ld a, $63
    ld [byte_FFA1], a
    
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp M_PhoneMenu_ButtonNote
    jr nz, .checkDownFromLeftKey
    ld a, M_PhoneMenu_Button1
    jr .saveButtonDown
    
.checkDownFromLeftKey
    cp M_PhoneMenu_ButtonLeft
    jr nz, .checkDownFromRightKey
    ld a, M_PhoneMenu_Button2
    jr .saveButtonDown
    
.checkDownFromRightKey
    cp M_PhoneMenu_ButtonRight
    jr nz, .checkDownFromConfirmKey
    ld a, M_PhoneMenu_Button2
    jr .saveButtonDown
    
.checkDownFromConfirmKey
    cp M_PhoneMenu_ButtonConfirm
    jr nz, .checkDownFromPoundKey
    ld a, M_PhoneMenu_Button3
    jr .saveButtonDown
    
.checkDownFromPoundKey
    cp M_PhoneMenu_ButtonPound
    jr nz, .incrementButtonDown
    ld a, M_PhoneMenu_ButtonConfirm
    jr .saveButtonDown
    
.incrementButtonDown
    adc a, 2
    and $F
    
.saveButtonDown
    ld [W_PauseMenu_PhoneIMEButton], a
    jp $5D40
    
.return
    ret