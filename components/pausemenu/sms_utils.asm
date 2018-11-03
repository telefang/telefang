INCLUDE "telefang.inc"

SECTION "Pause Menu SMS Arena", WRAM0[$CD90]
W_PauseMenu_SMSArena:: ds M_PauseMenu_SMSArenaSize

SECTION "Pause Menu SMS Utils", ROMX[$7028], BANK[$4]
PauseMenu_SMSListingInputHandler::
    ld a, [H_JPInput_Changed]
    and M_JPInput_A
    jr z, .checkBBtn
    
.selectSMSText
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    call PauseMenu_ClearArrowMetasprites
    
    ld hl, $9400
    ld b, $20
    call PauseMenu_ClearInputTiles
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, $85
    ld [W_MainScript_WindowBorderAttribs], a
    call PauseMenu_SelectTextStyle
    
    ld a, $40
    ld [W_MainScript_TileBaseIdx], a
    call PauseMenu_DrawSMSFromMessages
    
    jp System_ScheduleNextSubSubState
    
.checkBBtn
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .listingNavCheck
    
.dismissMenu
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    xor a
    ld [W_MainScript_TextStyle], a
    
    ld a, 7
    ld [W_SystemSubSubState], a
    
    ret

.listingNavCheck
    ld a, [W_MelodyEdit_DataCount]
    cp 1
    ret z
    
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Right
    jr z, .prevTraverseCheck
    
.moveToNext
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    dec a
    ld b, a
    
    ld a, [W_MelodyEdit_DataCurrent]
    cp b
    jr nz, .noLoadFF
    
    ld a, $FF
.noLoadFF
    inc a
    ld [W_MelodyEdit_DataCurrent], a
    jp PauseMenu_DrawSMSListingEntry
    
.prevTraverseCheck
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Left
    jr z, .idle
    
.moveToPrev
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_MelodyEdit_DataCount]
    dec a
    ld b, a
    
    ld a, [W_MelodyEdit_DataCurrent]
    cp 0
    jr nz, .noLoadEnd
    
    ld a, [W_MelodyEdit_DataCount]
.noLoadEnd
    dec a
    ld [W_MelodyEdit_DataCurrent], a
    jp PauseMenu_DrawSMSListingEntry

.idle
    ret

PauseMenu_DrawSMSListingEntry::
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
    ld hl, W_PauseMenu_SMSArena
    add hl, de
    
    ld a, [hli]
    dec a
    ld c, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld e, a
    
    push de
    call PauseMenu_CallsMenuDrawDenjuuNickname
    pop de
    push de
    
    ld a, d
    call Status_DecimalizeStatValue
    
    ld hl, $9962
    call PauseMenu_DrawTwoDigits
    
    pop de
    ld a, e
    call Status_DecimalizeStatValue
    
    ld hl, $9965
    call PauseMenu_DrawTwoDigits
    
    ld a, [W_MelodyEdit_DataCurrent]
    inc a
    call Status_DecimalizeStatValue
    
    ld hl, $99E2
    call PauseMenu_DrawTwoDigits
    
    ld a, [W_MelodyEdit_DataCount]
    call Status_DecimalizeStatValue
    
    ld hl, $99E5
    jp PauseMenu_DrawTwoDigits

SECTION "Pause Menu SMS Utils 2", ROMX[$6F31], BANK[$4]
PauseMenu_DrawSMSMessageCount::
    ld a, [W_MelodyEdit_DataCount]
    ld hl, $9942
    jp PauseMenu_DecimalizeAndDrawTwoDigits
    
PauseMenu_CountActiveSMS::
    xor a
    ld [W_MelodyEdit_DataCount], a
    
    ld hl, W_PauseMenu_SMSArena
    ld de, M_PauseMenu_SMSDataSize
    ld b, M_PauseMenu_SMSDataCount
    
.countLoop
    push hl
    ldi a, [hl]
    
    cp 0
    jr z, .nullEntry
    
    ld a, [W_MelodyEdit_DataCount]
    inc a
    ld [W_MelodyEdit_DataCount], a
    
.nullEntry
    pop hl
    add hl, de
    dec b
    jr nz, .countLoop
    ret

SECTION "Pause Menu SMS Utils 3", ROMX[$7798], BANK[$4]
PauseMenu_InitMultiMetaspriteField::
    ld [hl], a
    ld de, M_MetaSpriteConfig_Size
    add hl, de
    dec b
    jr nz, PauseMenu_InitMultiMetaspriteField
    ret

PauseMenu_LoadMsgsGraphic::
    ld hl, PhoneScreenNewTextsGfx
    ld de, $9400
    ld bc, PhoneScreenNewTextsGfx_END - PhoneScreenNewTextsGfx
    ld a, BANK(PhoneScreenNewTextsGfx)
    jp Banked_LCDC_LoadGraphicIntoVRAM
    
PauseMenu_DrawSMSFromMessages::
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
    ld hl, W_PauseMenu_SMSArena
    add hl, de
    
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld c, a
    ld b, 1
    ld d, $C
    call Banked_MainScript_InitializeMenuText
    call Banked_MainScriptMachine
    jp Banked_MainScriptMachine

SECTION "Pause Menu SMS Utils 4", ROMX[$5B21], BANK[$4]
PauseMenu_ExitToCentralMenu::
    call PauseMenu_LoadMainGraphics
    jp System_ScheduleNextSubSubState
    
PauseMenu_ExitToCentralMenu2::
    call $7E37
    call $59CD
    
    ld a, 5
    ld [W_SystemSubState], a
    
    xor a
    ld [W_SystemSubSubState], a
    
    ret