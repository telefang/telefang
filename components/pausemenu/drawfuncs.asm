INCLUDE "telefang.inc"

SECTION "Pause Menu Draw Functions", ROMX[$6492], BANK[$4]
PauseMenu_DrawCenteredNameBufferNoVWF::
    ld b, 0
    ld c, $D0
    jp PauseMenu_DrawCenteredNameBuffer.selectTargetTile
    
    nop
    
PauseMenu_DrawCenteredNameBuffer::
    ld b, 0
    ld c, $30
    
.selectTargetTile
    ld d, $C
    call Banked_MainScript_InitializeMenuText

.draw
    call Banked_MainScriptMachine
    jp Banked_MainScriptMachine
    
SECTION "Pause Menu Draw Functions 2", ROMX[$7EF6], BANK[$4]
PauseMenu_CallsMenuDrawDenjuuNickname::
    M_PrepAuxJmp Banked_PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname
    jp PatchUtils_AuxCodeJmp
    
PauseMenu_DrawCenteredNameBufferNoVWFWithOffset::
    ld bc, $D0
    ld d, $C
    call Banked_MainScript_InitializeMenuText
    ld a, 2
    ld [W_MainScript_VWFLetterShift], a
    jp PauseMenu_DrawCenteredNameBuffer.draw
    nop
    nop
    nop
    nop

PauseMenu_CenterPreppedNameForNicknameScreen::
    ld hl, $9700
    jp PauseMenu_CenterPreppedName_skipHL

PauseMenu_ContactsMenuDrawDenjuuNickname::
    call PauseMenu_IndexContactArray
    
PauseMenu_ContactsMenuDrawSelectedDenjuu::
    ld c, a
    call Banked_SaveClock_LoadDenjuuNicknameByIndex
    
    ld hl, W_SaveClock_NicknameStaging
    ld de, W_MainScript_CenteredNameBuffer
    call Banked_StringTable_ADVICE_PadCopyBuffer
    
    ld hl, $9780
    ld b, 6
    call PauseMenu_ClearScreenTiles
    
    ld bc, W_SaveClock_NicknameStaging
    ld d, M_StringTable_Load8AreaSize
    ld hl, $9780
    jp MainScript_DrawCenteredStagedString

SECTION "Pause Menu Draw Functions 3", ROMX[$79F9], BANK[$4]
PauseMenu_DrawTwoDigits::
    ld a, [W_GenericRegPreserve]
    swap a
    and $F
    call PauseMenu_DrawDigit
    
    ld a, [W_GenericRegPreserve]
    and $F
    jp PauseMenu_DrawDigit

SECTION "Pause Menu Draw Functions 4", ROMX[$715B], BANK[$4]
PauseMenu_DrawDecimalizedValue::
    push hl
    call Status_DecimalizeStatValue
    pop hl
    
    ld a, [Malias_CmpSrcBank]
    and $F
    add a, $E0
    di
    call YetAnotherWFB
    ld [hli], a
    ei
    
PauseMenu_DrawBothDigits::
    ld a, [W_GenericRegPreserve]
    and $F0
    swap a
    add a, $E0
    
    di
    
    call YetAnotherWFB
    ld [hli], a
    
    ei
    
    ld a, [W_GenericRegPreserve]
    and $F
    
PauseMenu_DrawDigit::
    add a, $E0
    di
    call YetAnotherWFB
    ld [hli], a
    ei
    ret

SECTION "Pause Menu Draw Functions 5", ROMX[$67DA], BANK[$4]
PauseMenu_DrawInventorySlotQuantity::
    ld a, [W_PauseMenu_CurrentInventorySlot]
    call PauseMenu_ReadInventorySlotData
    ld hl, $9A06
    
PauseMenu_DecimalizeAndDrawBothDigits::
    push hl
    call Status_DecimalizeStatValue
    pop hl
    jp PauseMenu_DrawBothDigits
    
PauseMenu_DecimalizeAndDrawTwoDigits::
    push hl
    call Status_DecimalizeStatValue
    
    pop hl
    ld a, [W_GenericRegPreserve]
    and $F0
    swap a
    add a, $F0
    
    di
    call YetAnotherWFB
    ld [hli], a
    ei
    
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $F0
    
    di
    call YetAnotherWFB
    ld [hl], a
    ei
    
    ret
    
SECTION "Pause Menu Draw Functions 6 Memory", WRAM0[$CA6B]
W_PauseMenu_CurrentItemGraphicBank:: ds 1
    
SECTION "Pause Menu Draw Functions 6", ROMX[$4D20], BANK[$2A]
PauseMenu_LoadItemGraphic::
    push hl
    
    ld d, $2B
    ld a, c
    cp $22
    jr c, .branch1
    
    inc d
    sub $22
    
.branch1
    ld e, a
    ld a, d
    ld [W_PauseMenu_CurrentItemGraphicBank], a
    
    ld d, 0
    ld bc, $1E0
    call System_Multiply16
    
    ld hl, $4000
    add hl, de
    
    ld d, h
    ld e, l
    
    pop hl
    
    ld a, [W_PauseMenu_CurrentItemGraphicBank]
    ld bc, $1E0
    jp Banked_LCDC_LoadTiles

SECTION "Pause Menu Draw Functions AuxCode ADVICE", ROMX[$4900], BANK[$1]
PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname::
    M_AdviceSetup

; Fetch Denjuu nickname.

    call Banked_SaveClock_LoadDenjuuNicknameByIndex

; Remap border tiles to prevent flicker.

    ld de, $D4D5
    call PauseMenu_ADVICE_CallsMenuBorderPreserver

; Clear Denjuu nickname.

    ld hl, $9400
    ld b, $40

    call TitleMenu_ADVICE_CanUseCGBTiles_Alt
    jr z, .cgbBg

.dmgBg
    ld de, $FF00
    jr .clearloop

.cgbBg
    ld de, $FF

.clearloop
    di

.wfb
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfb

    ld a, d
    ld [hli], a
    ld a, e
    ld [hli], a
    ei

    dec b
    jr nz, .clearloop

; Clear some stuff to prevent possible rendering issues.
	
    call PauseMenu_ADVICE_SMSResetLine
	
; Nicknames should in this case autocondense if they are wider than 7 tiles.
; However, the names are being centred on an 8-tile region.
; This requires that the autocondense logic be done separately.

    ld a, 7
    ld [W_MainScript_VWFNewlineWidth], a
    ld bc, W_SaveClock_NicknameStaging
    call MainScript_ADVICE_CondenseStagedTableStringLong_CommonLogic
	
; That last call clobbered W_PreviousBank, so lets fix that.

    di
    ld a, BANK(PauseMenu_ADVICE_CallsMenuDrawDenjuuNickname)
    ld [W_PreviousBank], a
    ei

; Draw Denjuu nickname.

    ld a, 8
    ld [W_MainScript_VWFNewlineWidth], a

    ld hl, $9400
    ld bc, W_SaveClock_NicknameStaging
    ld d, M_StringTable_Load8AreaSize
    call MainScript_DrawCenteredStagedString_skipCondenseLogic

    ld a, M_MainScript_UndefinedWindowWidth
    ld [W_MainScript_VWFNewlineWidth], a

; Draw borders.

    di

.wfbB
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfbB

    ld a, [$8D40]
    and $E0
    ld d, a
    ld a, [$8D41]
    ei
    and $E0
    ld e, a

    ld l, 0
    ld bc, $81F

    call PauseMenu_ADVICE_CallsMenuNameBorder

    di

.wfbC
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfbC

    ld a, [$8D50]
    and 7
    ld d, a
    ld a, [$8D51]
    ei
    and 7
    ld e, a

    ld bc, $8F8
    ld l, $70
    call PauseMenu_ADVICE_CallsMenuNameBorder

; Restore border tiles to display long names.

    ld de, $4047
    call PauseMenu_ADVICE_CallsMenuBorderPreserver

    M_AdviceTeardown
    ret

PauseMenu_ADVICE_CallsMenuBorderPreserver::
    ld hl, $99A1
    ld b, $A8
    di

.wfb
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfb

    ld [hl], d
    ld l, b
    ld [hl], e
    ei
    ret

PauseMenu_ADVICE_CallsMenuNameBorder::
    di

.wfbA
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfbA

    ld a, [hl]
    and c
    or d
    ld [hli], a
    ei

; Just in case nop.

    nop

    di

.wfbB
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfbB

    ld a, [hl]
    and c
    or e
    ld [hli], a
    ei

    dec b
    jr nz, PauseMenu_ADVICE_CallsMenuNameBorder
    ret