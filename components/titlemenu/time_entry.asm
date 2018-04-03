INCLUDE "telefang.inc"

SECTION "Title Menu Time Entry", ROMX[$57EF], BANK[$4]
TitleMenu_TimeEntryProcessing::
    call TitleMenu_DrawSelectedTimeFieldBlinking
    
    ld a, [H_JPInput_Changed]
    and M_JPInput_A
    jr z, .checkBButton
    
.aButton
    ld a, 3
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp 0
    jr z, .gotoNextField
    
.confirmTimeInput
    ld bc, $104
    ld e, $5B
    call PauseMenu_LoadMap0
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size
    call LCDC_ClearSingleMetasprite
    jp System_ScheduleNextSubState
    
.gotoNextField
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    inc a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    jp TitleMenu_DrawSelectedTimeFieldSolid
    
.checkBButton
    ld a, [H_JPInput_Changed]
    and M_JPInput_B
    jr z, .checkUpButton
    
.bButton
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp 0
    ret z
    
    ld a, 4
    ld [W_Sound_NextSFXSelect], a
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    jp TitleMenu_DrawSelectedTimeFieldSolid
    
.checkUpButton
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Up
    jr z, .checkDownButton
    
.upButton
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp 1
    jr z, .minutesFieldIncrement
    
.hoursFieldIncrement
    ld a, [W_SaveClock_RealTimeHours]
    cp 23
    jr nz, .noHoursOverflow
    
.hoursOverflow
    ld a, $FF
    
.noHoursOverflow
    inc a
    ld [W_SaveClock_RealTimeHours], a
    jp TitleMenu_DrawRTCHour
    
.minutesFieldIncrement
    ld a, [W_SaveClock_RealTimeMinutes]
    cp 59
    jr nz, .noMinutesOverflow
    
.minutesOverflow
    ld a, $FF
    
.noMinutesOverflow
    inc a
    ld [W_SaveClock_RealTimeMinutes], a
    jp TitleMenu_DrawRTCMinute
    
.checkDownButton
    ld a, [W_JPInput_TypematicBtns]
    and M_JPInput_Down
    jr z, .noInput
    
.downButton
    ld a, 2
    ld [W_Sound_NextSFXSelect], a
    
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp 1
    jr z, .minutesFieldDecrement
    
.hoursFieldDecrement
    ld a, [W_SaveClock_RealTimeHours]
    cp 0
    jr nz, .noHoursUnderflow
    
.hoursUnderflow
    ld a, 24
    
.noHoursUnderflow
    dec a
    ld [W_SaveClock_RealTimeHours], a
    jp TitleMenu_DrawRTCHour
    
.minutesFieldDecrement
    ld a, [W_SaveClock_RealTimeMinutes]
    cp 0
    jr nz, .noMinutesUnderflow
    
.minutesUnderflow
    ld a, 60
    
.noMinutesUnderflow
    dec a
    ld [W_SaveClock_RealTimeMinutes], a
    jp TitleMenu_DrawRTCMinute
    
.noInput
    ret
    
TitleMenu_DrawTimeSetWidget::
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    call TitleMenu_DrawRTCHour
    call TitleMenu_DrawRTCMinute
    jp TitleMenu_DrawTimeSetCursor
    
TitleMenu_DrawRTCHour::
    ld a, [W_SaveClock_RealTimeHours]
    call Status_DecimalizeStatValue
    
    ld hl, $99A2
    jp PauseMenu_DrawTwoDigits
    
TitleMenu_DrawRTCMinute::
    ld a, [W_SaveClock_RealTimeMinutes]
    call Status_DecimalizeStatValue
    
    ld hl, $99A5
    jp PauseMenu_DrawTwoDigits
    
TitleMenu_DrawTimeSetCursor::
    ld b, $15
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp 0
    jr z, .cursorIsAtHours
    
.cursorIsAtMinutes
    ld b, $2D
    
.cursorIsAtHours
    ld c, $68
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size
    call PauseMenu_PositionCursor
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ret
    
TitleMenu_DrawSelectedTimeFieldBlinking::
    ld a, [W_FrameCounter]
    and $F
    ret nz
    
    ld a, [W_PauseMenu_CursorBlinkState]
    xor 1
    ld [W_PauseMenu_CursorBlinkState], a
    
    cp 1
    jr z, .makeInputHidden
    
.makeInputVisible
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp 0
    jr nz, .makeMinutesVisible
    
.makeHoursVisible
    jp TitleMenu_DrawRTCHour
    
.makeMinutesVisible
    jp TitleMenu_DrawRTCMinute
    
.makeInputHidden
    ld bc, $20D
    ld a, [W_PauseMenu_PhoneIMEPressCount]
    cp 0
    jr z, .makeHoursHidden
    
.makeMinutesHidden
    ld bc, $50D
    
.makeHoursHidden
    ld e, $23
    ld a, 0
    jp Banked_RLEDecompressTMAP0
    
;I don't know why this thunk exists, I assume it was supposed to redraw the
;just-unfocused field in case it was hidden by blinking, but they just decided
;to call the function that draws everything...
TitleMenu_DrawSelectedTimeFieldSolid::
    jp TitleMenu_DrawTimeSetWidget