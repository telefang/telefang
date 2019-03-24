INCLUDE "telefang.inc"

; BANK() is stupid
IMPORT PhoneKeypadGfx
IMPORT PhoneKeypadGfxDmg

SECTION "Pause Menu IME WRAM2", WRAM0[$CB3E]
W_PhoneIME_PressCount:: ds 1

SECTION "Pause Menu IME WRAM 2.5", WRAM0[$CB22]
W_PhoneIME_PhoneDigitIterator:: ds 1

SECTION "Pause Menu IME WRAM3", WRAM0[$CB28]
W_PhoneIME_NextIME:: ds 1
W_PhoneIME_CurrentNumberLength:: ds 1
W_PhoneIME_CurrentIME:: ds 1

SECTION "Pause Menu IME WRAM5", WRAM0[$CB65]
W_MelodyEdit_State::
W_PhoneIME_Button:: ds 1
W_PhoneIME_LastPressedButton:: ds 1

SECTION "Pause menu IME stuff", ROMX[$665A], BANK[$4]
PhoneIME_LoadTilemapForIME::
    ld a, [W_PhoneIME_CurrentIME]
    add a
    ld l, $F4
    add l
    ld hl, $9A21
    call vmempoke
    inc a
    jp vmempoke
    
SECTION "Pause menu IME Diacritic stuff", ROMX[$6673], BANK[$4]
PhoneIME_PlayerNameDiacritic::
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    push hl
    call PhoneIME_ApplyDiacritic
    pop hl
    ld [hl], a
    call PhoneIME_SyncPlayerName
    jp PauseMenu_DrawCenteredNameBufferNoVWF
    
PhoneIME_DenjuuNicknameDiacritic::
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    push hl
    call PhoneIME_ApplyDiacritic
    pop hl
    ld [hl], a
    call PhoneIME_SyncDenjuuNickname
    jp PauseMenu_DrawCenteredNameBufferNoVWF

SECTION "Pause Menu Phone Stuff", ROMX[$693B], BANK[$4]
PhoneIME_LoadGraphicsForIME::
    ld hl, .imeGraphicsTableCGB
    call TitleMenu_ADVICE_CanUseCGBTiles
    jr z, .tableSelected
    ld hl, .imeGraphicsTableDMG
    
.tableSelected
    ld a, [W_PauseMenu_PhoneState]
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    ld a, [W_PhoneIME_NextIME]
    call PhoneIME_GetIMEGraphicsID
    call PauseMenu_IndexPtrTable
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    call TitleMenu_ADVICE_CanUseCGBTiles
    jr z, .selectCGBBank
    ld a, BANK(PhoneKeypadGfx)
    jr .bankSelected
    
.selectCGBBank
    ld a, BANK(PhoneKeypadGfxDmg) ;yeah IDK WTF, I think our PNGs are mislabeled
    
.bankSelected
    ld de, $8A00
    ld bc, $400
    jp Banked_LCDC_LoadGraphicIntoVRAM
    nop
    
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

SECTION "Phone IME stuff 2", ROMX[$5D40], BANK[$4]
PhoneIME_PlaceCursor::
    ld hl, .positionTable
    ld a, [W_PhoneIME_Button]
    call PauseMenu_IndexPtrTable
    
    ld a, [hli]
    ld b, a
    ld a, [hl]
    ld c, a
    ld a, 7
    ld [$C0A2], a
    
    ld de, W_MetaSpriteConfig1
    call PauseMenu_PositionCursor
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ret
    
.positionTable
    dw $2868, $2878, $2888, $2898
    dw $4068, $4080, $4098
    dw $5068, $5080, $5098
    dw $6068, $6080, $6098
    dw $7068, $7080, $7098

SECTION "Title Menu Player Name Input 4", ROMX[$5B37], BANK[$4]
PhoneIME_InputProcessing::
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Right
    jr z, .checkLeftBtn
    
    ld a, $63
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PhoneIME_Button]
    cp M_PhoneIME_ButtonConfirm
    jr nz, .checkWraparoundRight
    xor a
    jr .saveNewButtonRight
    
.checkWraparoundRight
    cp M_PhoneIME_Button3
    jr z, .wraparoundPtRight
    cp M_PhoneIME_Button6
    jr z, .wraparoundPtRight
    cp M_PhoneIME_Button9
    jr z, .wraparoundPtRight
    cp M_PhoneIME_ButtonPound
    jr z, .wraparoundPtRight
    
    jr .incrementButtonRight
    
.wraparoundPtRight
    sub 3
    
.incrementButtonRight
    inc a
    
.saveNewButtonRight
    ld [W_PhoneIME_Button], a
    jp $5D40
    
.checkLeftBtn
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Left
    jr z, .checkUpBtn
    
    ld a, $63
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PhoneIME_Button]
    cp M_PhoneIME_ButtonNote
    jr nz, .checkWraparoundLeft
    
    ld a, M_PhoneIME_ButtonConfirm
    jr .saveNewButtonLeft
    
.checkWraparoundLeft
    cp M_PhoneIME_Button1
    jr z, .wraparoundPtLeft
    cp M_PhoneIME_Button4
    jr z, .wraparoundPtLeft
    cp M_PhoneIME_Button7
    jr z, .wraparoundPtLeft
    cp M_PhoneIME_ButtonStar
    jr z, .wraparoundPtLeft
    jr .decrementButtonLeft
    
.wraparoundPtLeft
    adc a, 3
    
.decrementButtonLeft
    dec a
    
.saveNewButtonLeft
    ld [W_PhoneIME_Button], a
    jp $5D40
    
.checkUpBtn
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Up
    jr z, .checkDownBtn
    
    ld a, $63
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PhoneIME_Button]
    cp M_PhoneIME_ButtonNote
    jr nz, .checkUpFromLeftKey
    ld a, M_PhoneIME_ButtonStar
    jr .saveButtonUp
    
.checkUpFromLeftKey
    cp M_PhoneIME_ButtonLeft
    jr nz, .checkUpFromRightKey
    ld a, M_PhoneIME_Button0
    jr .saveButtonUp
    
.checkUpFromRightKey
    cp M_PhoneIME_ButtonRight
    jr nz, .checkUpFromConfirmKey
    ld a, M_PhoneIME_Button0
    jr .saveButtonUp
    
.checkUpFromConfirmKey
    cp M_PhoneIME_ButtonConfirm
    jr nz, .checkUpFromOneKey
    ld a, M_PhoneIME_ButtonPound
    jr .saveButtonUp
    
.checkUpFromOneKey
    cp M_PhoneIME_Button1
    jr nz, .decrementButtonUp
    ld a, M_PhoneIME_ButtonNote
    jr .saveButtonUp
    
.decrementButtonUp
    sub 3
    and $F
    
.saveButtonUp
    ld [W_PhoneIME_Button], a
    jp $5D40

.checkDownBtn
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Down
    jr z, .return
    
    ld a, $63
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PhoneIME_Button]
    cp M_PhoneIME_ButtonNote
    jr nz, .checkDownFromLeftKey
    ld a, M_PhoneIME_Button1
    jr .saveButtonDown
    
.checkDownFromLeftKey
    cp M_PhoneIME_ButtonLeft
    jr nz, .checkDownFromRightKey
    ld a, M_PhoneIME_Button2
    jr .saveButtonDown
    
.checkDownFromRightKey
    cp M_PhoneIME_ButtonRight
    jr nz, .checkDownFromConfirmKey
    ld a, M_PhoneIME_Button2
    jr .saveButtonDown
    
.checkDownFromConfirmKey
    cp M_PhoneIME_ButtonConfirm
    jr nz, .checkDownFromPoundKey
    ld a, M_PhoneIME_Button3
    jr .saveButtonDown
    
.checkDownFromPoundKey
    cp M_PhoneIME_ButtonPound
    jr nz, .incrementButtonDown
    ld a, M_PhoneIME_ButtonConfirm
    jr .saveButtonDown
    
.incrementButtonDown
    adc a, 2
    and $F
    
.saveButtonDown
    ld [W_PhoneIME_Button], a
    jp $5D40
    
.return
    ret