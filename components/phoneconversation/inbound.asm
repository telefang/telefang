INCLUDE "telefang.inc"

SECTION "Phone Conversation Incoming Caller States", ROMX[$5572], BANK[$29]
PhoneConversation_StateDrawIncomingCallScreen::
    ld a, BANK(PhoneConversation_StateDrawIncomingCallScreen)
    ld [W_PreviousBank], a
    call Banked_PhoneConversation_DetermineSceneryType
    
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, 2
    ld [REG_MBC3_SRAMBANK], a
    
    ld hl, S_SaveClock_StatisticsArray
    ld a, [W_SaveClock_SelectedDenjuu]
    
    ld c, a
    ld b, 0
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    
    ld a, [hli]
    ld b, a
    inc hl
    ld a, [hl]
    ld [W_PhoneConversation_IncomingCallerFD], a
    
    ld a, 0
    ld [REG_MBC3_SRAMENABLE], a
    
    ld a, b
    call PhoneConversation_DrawInboundCallScreen
    
    ld a, 0
    ld [W_PhoneConversation_IncomingCallerFDOffset], a
    ld a, 0
    ld [$C20F], a
    ld a, 0
    ld [W_PhoneConversation_IncomingCallerName + 6], a
    
    ld a, $38
    ld hl, $8F00
    ld de, $4D28
    ld bc, $F0
    call Banked_LCDC_LoadTiles
    
    ld a, BANK(PhoneConversation_StateDrawIncomingCallScreen)
    ld [W_PreviousBank], a
    
    ;TODO: I don't know what this code is
    ld a, $29
    ld hl, $4CFD
    call CallBankedFunction_int
    
    call Status_ExpandNumericalTiles
    
    ld d, 6
    ld bc, $14
    ld hl, $9980
    ld a, 5
    call LCDC_InitAttributesSquare
    
    ld d, 1
    ld bc, 8
    ld hl, $9966
    ld a, 1
    call LCDC_InitAttributesSquare
    
    ld de, $5D29
    ld hl, $8A00
    ld bc, $E0
    call LCDC_LoadTiles
    
    call PhoneConversation_DrawFDDisplay
    call PhoneConversation_DrawIncomingCallerName
    jp System_ScheduleNextSubState

PhoneConversation_DrawIncomingCallerName::
    ld a, [W_SaveClock_SelectedDenjuu]
    ld c, a
    ld a, BANK(SaveClock_LoadDenjuuNicknameByIndex)
    ld hl, SaveClock_LoadDenjuuNicknameByIndex
    call CallBankedFunction_int
    
    ld hl, $8B00
    ld b, 8
    call PhoneConversation_ADVICE_ClearInputTiles
    
    ld hl, W_SaveClock_NicknameStaging
    ld de, W_MainScript_CenteredNameBuffer
    call Banked_StringTable_ADVICE_PadCopyBuffer
    
    ld b, 8
    ld c, $B0
    ld hl, $9866
    
.allocateTextArea
    di
    call WaitForBlanking
    ld a, c
    ld [hli], a
    ei
    
    inc c
    dec b
    jr nz, .allocateTextArea
    
    ld b, M_StringTable_Load8AreaSize + 1
    ld hl, $8B00
    ld de, W_MainScript_CenteredNameBuffer
    
.letterDrawingLoop
    ld a, [de]
    cp $E0
    jr nz, .noTerminate
    
.terminate
    ld a, 0
    
.noTerminate
    jp PhoneConversation_ADVICE_DrawIncomingCallerName
    
.adviceComefrom
    ld d, 1
    ld bc, 8
    ld hl, $9866
    ld a, 1
    call PhoneConversation_ADVICE_DrawIncomingCallerName_ResetVWFVariables
    
    ret
    
PhoneConversation_DrawFDDisplay::
    di
    
    call WaitForBlanking
    ld a, $AA
    ld [$9966], a
    
    call WaitForBlanking
    ld a, $AB
    ld [$9967], a
    
    ei
    
    ld a, [W_PhoneConversation_IncomingCallerFD]
    call Status_DecimalizeStatValue
    
    ld hl, $9968
    
    di
    call PhoneConversation_DrawFDBaseValue
    ei
    
    ld c, $AC
    ld a, [W_PhoneConversation_IncomingCallerFDOffset]
    
    bit 7, a
    jr z, .drawInfixSign
.negativeOffset
    ld c, $AD
    cpl
    inc a
    
.drawInfixSign
    ld b, a
    
    di
    call WaitForBlanking
    ld a, c
    ld [hli], a
    ei
    
    ld a, b
    call Status_DecimalizeStatValue
    
    di
    call PhoneConversation_DrawFDOffsetValue
    ei
    
    ret
    
PhoneConversation_DrawFDBaseValue::
    ld a, [Malias_CmpSrcBank]
    and $F
    add a, $A0
    ld c, a
    call WaitForBlanking
    ld a, c
    ld [hli], a
    
PhoneConversation_DrawFDOffsetValue::
    ld a, [W_GenericRegPreserve]
    swap a
    and $F
    add a, $A0
    ld c, a
    
    call WaitForBlanking
    ld a, c
    ld [hli], a
    
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $A0
    ld c, a
    
    call WaitForBlanking
    ld a, c
    ld [hli], a
    
    ret
    
SECTION "Phone Conversation Inbound 2", ROMX[$576C], BANK[$29]
PhoneConversation_DrawInboundCallScreen::
    push af
    call Banked_PhoneConversation_LoadPhoneFrameTiles
    
    ld a, [W_Encounter_SceneryType]
    call Banked_PhoneConversation_LoadSceneryTiles
    
    pop af
    push af
    ld c, 0
    ld de, $9400
    call Banked_Battle_LoadDenjuuPortrait
    
    ld hl, $695F
    ld de, $8800
    ld bc, $100
    ld a, $37
    call Banked_LCDC_LoadGraphicIntoVRAM
    
    ld a, [W_Encounter_SceneryType]
    add a, $50
    ld e, a
    push de
    ld bc, 0
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    pop de
    ld bc, 0
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld bc, $C
    ld e, $1A
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, $C
    ld e, $1A
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    pop af
    call Battle_LoadDenjuuPalettePartner
    
    ld hl, $60
    ld a, [W_Overworld_CurrentTimeHours]
    cp $14
    jr nc, .selectDifferentBase
    cp 4
    jr nc, .selectFirstBase
    
.selectDifferentBase
    ld hl, $380
    
.selectFirstBase
    ld a, [W_Encounter_SceneryType]
    ld e, a
    ld d, 0
    sla e
    rl d
    add hl, de
    
    push hl
    pop bc
    push bc
    ld a, 3
    call CGBLoadBackgroundPaletteBanked
    
    pop bc
    inc bc
    ld a, 4
    call CGBLoadBackgroundPaletteBanked
    
    ld bc, $36
    ld a, 1
    call CGBLoadBackgroundPaletteBanked
    
    ld bc, $55
    ld a, 5
    call CGBLoadBackgroundPaletteBanked
    
    ld a, [W_PauseMenu_PhoneState]
    ld e, a
    ld d, 0
    ld hl, $390
    add hl, de
    push hl
    pop bc
    xor a
    call CGBLoadBackgroundPaletteBanked
    
    ld a, 1
    ld [W_RLEAttribMapsEnabled], a
    ld b, 5
    call $33AF
    
    ret
    
SECTION "PhoneConversation Incoming Caller Name Draw Advice", ROMX[$786A], BANK[$29]
PhoneConversation_ADVICE_DrawIncomingCallerName::
    inc de
    push bc
    push de
    push hl
    call Banked_MainScript_DrawLetter
    pop hl
    pop de
    pop bc
    
    ld a, [W_MainScript_VWFOldTileMode]
    dec a
    jr nz, .noAdjustment
    
.adjustment
    push de
    
    ld d, 0
    ld e, $10
    add hl, de
    
    pop de
    
    dec b

.noAdjustment
    jp nz, PhoneConversation_DrawIncomingCallerName.letterDrawingLoop
    jp PhoneConversation_DrawIncomingCallerName.adviceComefrom
PhoneConversation_ADVICE_DrawIncomingCallerName_END::

PhoneConversation_ADVICE_ClearInputTiles::
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jr nz, .dmgClear
    jp .cgbClear
    
.dmgClear
    ld d, $FF
    ld e, 0
    jr .clearLoop
    
.cgbClear
    ld d, 0
    ld e, $FF
    
.clearLoop
    push bc
    ld c, 8
    
.innerLoop
    call YetAnotherWFB
    ld a, d
    ld [hli], a
    ld a, e
    call YetAnotherWFB
    ld [hli], a
    dec c
    jr nz, .innerLoop
    
    pop bc
    dec b
    jr nz, .clearLoop
    
    ret
PhoneConversation_ADVICE_ClearInputTiles_END

SECTION "PhoneConversation Incoming Caller Name Draw Advice 2", ROMX[$7A00], BANK[$29]
PhoneConversation_ADVICE_DrawIncomingCallerName_ResetVWFVariables::
	call LCDC_InitAttributesSquare
	call PhoneConversation_ADVICE_ResetVWFVariables
	ret

PhoneConversation_ADVICE_ResetVWFVariables::
	xor  a
	ld [W_MainScript_TilesDrawn], a
	ld [W_MainScript_VWFLetterShift], a
	ld [W_MainScript_VWFCurrentLetter], a
	ld [W_MainScript_NumNewlines], a
	ld [W_MainScript_VWFMainScriptHack], a

.clearCompositeArea
	push hl
	ld hl, $CFD0
	push bc
	ld b, $10

.clearCompositeAreaLoop
	ldi [hl], a
	dec b
	jr nz, .clearCompositeAreaLoop
	pop bc
	pop hl
	ret
