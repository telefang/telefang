INCLUDE "telefang.inc"

SECTION "Pause Menu Indicator Sprites", ROMX[$56E7], BANK[$4]
PauseMenu_DrawClockSprites::
    ld a, [W_Status_CalledFromContactScreen]
    cp 0
    ret nz
    call PauseMenu_DriveColonTickAnimation
    
    ld a, [W_SaveClock_RealTimeHours]
    call Status_DecimalizeStatValue
    
    ld a, [W_GenericRegPreserve]
    swap a
    and $F
    add a, $20
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $10 + M_LCDC_MetaSpriteConfig_Index], a
    
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $20
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $11 + M_LCDC_MetaSpriteConfig_Index], a
    
    ld a, [W_SaveClock_RealTimeMinutes]
    call Status_DecimalizeStatValue
    
    ld a, [W_GenericRegPreserve]
    swap a
    and $F
    add a, $20
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $12 + M_LCDC_MetaSpriteConfig_Index], a
    
    ld a, [W_GenericRegPreserve]
    and $F
    add a, $20
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $13 + M_LCDC_MetaSpriteConfig_Index], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $10
    ld bc, $2020
    call PauseMenu_PositionCursor
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $11
    ld bc, $2820
    call PauseMenu_PositionCursor
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $12
    ld bc, $3820
    call PauseMenu_PositionCursor
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $13
    ld bc, $4020
    call PauseMenu_PositionCursor
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $14
    ld bc, $3020
    call PauseMenu_PositionCursor
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    jp PauseMenu_DrawSignalIndicator
    
PauseMenu_ClearClockSprites::
    xor a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $10 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $11 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $12 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $13 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $14 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret

PauseMenu_DriveColonTickAnimation::
    call TitleMenu_LoadRTCValues
    
    ld a, [W_SaveClock_RealTimeSeconds]
    and 1
    add a, $2A
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $14 + M_LCDC_MetaSpriteConfig_Index], a
    ret
    
SECTION "Pause Menu Indicator Sprites 2", ROMX[$6BAA], BANK[$4]
PauseMenu_DrawSignalIndicator::
    ld a, [W_Overworld_SignalStrength]
    dec a
    add a, $2F
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $F + M_LCDC_MetaSpriteConfig_Index], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * $F
    ld bc, $1028
    jp PauseMenu_PositionCursor