INCLUDE "telefang.inc"

SECTION "Pause Menu Contacts", ROMX[$4A49], BANK[$4]
ContactMenu_StateMachine::
    call PauseMenu_DrawClockSprites
    ld a, [W_SystemSubSubState]
    ld hl, .state_table
    call System_IndexWordList
    jp [hl]

.state_table
    dw sub_10A86,sub_10A9C,$4AD6,$4AFC
    dw $4B92,$4BBD,$4BC0,$4BCE
    dw $4BF3,$4C47,$7F47,$7F4E
    dw PhoneConversation_SubStateCallOutDrawScreen
    dw PhoneConversation_SubStateCallOutFadeScreenIn
    dw PhoneConversation_SubStateCallOutConvoScriptProcessing
    dw PhoneConversation_SubStateCallOutSwitchScriptProcessing
    dw $4D30,$4D86,$4DD3,$4DEC
    dw $4E37,$4E45,$4E59,$4E5A

sub_10A86:
    call $636B
    ld bc, $12
    nop
    nop
    call TitleMenu_ADVICE_CanUseCGBTiles
    jr z, .use_cgb_graphic
    
.use_dmg_graphic
    ld bc, $57
    
.use_cgb_graphic
    call Banked_LoadMaliasGraphics
    jp System_ScheduleNextSubSubState

sub_10A9C:
    ld a, [W_PauseMenu_CurrentContact]
    ld b, a
    ld a, [$CB72]
    dec a
    cp b
    jr nc, .skipdecCD24
    ld a, [W_PauseMenu_CurrentContact]
    dec a
    ld [W_PauseMenu_CurrentContact], a
    
.skipdecCD24
    ld a, [W_PauseMenu_CurrentContact]
    call PauseMenu_IndexedContactArrayLoad
    ld c, 0
    ld de, $9400
    call Banked_Battle_LoadDenjuuPortrait
    ld a, [W_PauseMenu_CurrentContact]
    call PauseMenu_IndexedContactArrayLoad
    call Battle_LoadDenjuuPaletteOpponent
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld a, [W_PauseMenu_CurrentContact]
    call PauseMenu_IndexedContactArrayLoad
    call PauseMenu_ContactPrepName
    jp System_ScheduleNextSubSubState