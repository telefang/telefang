INCLUDE "telefang.inc"

SECTION "Pause Menu Phone IME Number Utilities RAM", WRAMX[$D200], BANK[1]
W_PauseMenu_PhoneIMEDisplayedNumber:: ds M_PauseMenu_PhoneIMEDisplayedNumberSize

SECTION "Pause Menu Phone IME Number Utilities", ROMX[$7474], BANK[$4]
PauseMenu_PhoneIMEStoreNumber::
    ld a, [W_PauseMenu_ScrollAnimationTimer]
    cp $D
    ret z
    
    ld a, [W_PauseMenu_PhoneIMEButton]
    cp M_PhoneMenu_Button1
    ret c
    
    sub M_PhoneMenu_Button1
    ld e, a
    ld d, 0
    ld hl, PauseMenu_PhoneIMEDigitCharsMapping
    add hl, de
    ld a, [hl]
    ld b, a
    ld hl, PauseMenu_PhoneIMEDigitSpriteMapping
    add hl, de
    ld a, [hl]
    ld c, a
    ld a, [W_PauseMenu_ScrollAnimationTimer]
    ld e, a
    ld d, 0
    ld hl, $D000
    add hl, de
    ld a, b
    ld [hl], a
    
    ld hl, W_PauseMenu_PhoneIMEDisplayedNumber
    add hl, de
    ld a, c
    ld [hl], a
    
    ld a, [W_PauseMenu_ScrollAnimationTimer]
    inc a
    ld [W_PauseMenu_ScrollAnimationTimer], a
    
PauseMenu_PhoneIMEDrawNumber::
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    xor a
    ld b, M_PauseMenu_PhoneIMEDisplayedSpriteCount
    ld hl, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call PauseMenu_InitMultiMetaspriteField
    
    ld a, [W_PauseMenu_ScrollAnimationTimer]
    cp 0
    ret z
    
    dec a
    ld b, a
    ld a, M_PauseMenu_PhoneIMEDisplayedSpriteCount
    sub b
    ld c, a
    ld b, 0
    ld de, M_MetaSpriteConfig_Size
    call System_Multiply16
    
    ld hl, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 0
    add hl, de
    ld a, [W_PauseMenu_ScrollAnimationTimer]
    ld b, a
    xor a
    ld [W_PauseMenu_PhoneDigitIterator], a
    
.sprite_config_loop
    push bc
    push hl
    push hl
    
    ld de, 0
    add hl, de
    ld a, 1
    ld [hl], a
    
    pop hl
    
    ld de, 2
    add hl, de
    
    push hl
    
    ld hl, W_PauseMenu_PhoneIMEDisplayedNumber
    ld a, [W_PauseMenu_PhoneDigitIterator]
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    
    pop hl
    
    ld [hl], a
    
    pop hl
    
    ld de, M_MetaSpriteConfig_Size
    add hl, de
    ld a, [W_PauseMenu_PhoneDigitIterator]
    inc a
    ld [W_PauseMenu_PhoneDigitIterator], a
    
    pop bc
    dec b
    jr nz, .sprite_config_loop
    
    ld a, $50
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    add a, $10
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 4 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 5 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 6 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 7 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    add a, $10
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 8 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 9 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 10 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 11 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 12 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, $10
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $18
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_XOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 4 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $20
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 3 + M_LCDC_MetaSpriteConfig_XOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 5 + M_LCDC_MetaSpriteConfig_XOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 8 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $28
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 6 + M_LCDC_MetaSpriteConfig_XOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 9 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $30
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 7 + M_LCDC_MetaSpriteConfig_XOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 10 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $38
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 11 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $40
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 12 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, 0
    ld b, M_PauseMenu_PhoneIMEDisplayedSpriteCount
    ld hl, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_Bank
    call PauseMenu_InitMultiMetaspriteField
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld a, [W_PauseMenu_ScrollAnimationTimer]
    cp $C
    jp z, .timer_expired
    ret
    
.timer_expired
    call PauseMenu_StoreDialedContact
    ld a, $10
    ld [W_System_CountdownTimer], a
    jp System_ScheduleNextSubState
    
PauseMenu_PhoneIMEDigitCharsMapping:
    db $62, $64, $66, $68, $6A, $6C, $6E, $70, $72, $7C, $60, $78
PauseMenu_PhoneIMEDigitSpriteMapping:
    db $21, $22, $23, $24, $25, $26, $27, $28, $29, $2E, $20, $2C
    
PauseMenu_ReformatEnteredPhoneNumber::
    ld a, [$D000 + 0]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 0], a
    ld a, [$D000 + 1]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 1], a
    ld a, [$D000 + 2]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 2], a
    ld a, $7A
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 3], a
    ld a, [$D000 + 3]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 4], a
    ld a, [$D000 + 4]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 5], a
    ld a, [$D000 + 5]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 6], a
    ld a, [$D000 + 6]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 7], a
    ld a, $7A
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 8], a
    ld a, [$D000 + 7]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 9], a
    ld a, [$D000 + 8]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 10], a
    ld a, [$D000 + 9]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 11], a
    ld a, [$D000 + 10]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 12], a
    ld a, [$D000 + 11]
    ld [W_PauseMenu_PhoneIMEDisplayedNumber + 13], a
    ret

PauseMenu_PositionPhoneIMECursor::
    ld b, M_PauseMenu_PhoneIMEDisplayedSpriteCount
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    
.cursor_position_loop
    push bc
    push de
    
    call LCDC_ClearSingleMetasprite
    
    pop de
    
    ld hl, M_MetaSpriteConfig_Size
    add hl, de
    
    push hl
    pop de
    pop bc
    
    dec b
    jr nz, .cursor_position_loop
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret

PauseMenu_StoreDialedContact::
    xor a
    ld [W_PauseMenu_NumberCallStatus], a
    ld [$CB03], a
    ld [W_PauseMenu_PhoneDigitIterator], a
    call PauseMenu_ReformatEnteredPhoneNumber
    
    ld hl, W_PauseMenu_PhoneIMEDisplayedNumber
    call Banked_ContactEnlist_DecodePhoneNumber
    
    ;TODO: Disassemble this last bit