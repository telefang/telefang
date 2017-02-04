SECTION "Pause Menu Contacts", ROMX[$4A49], BANK[$4]
PauseMenu_ContactSubstate::
    call $56E7 ;TODO: What do you do?
    ld a, [W_SystemSubSubState]
    ld hl, PauseMenu_ContactSubstateMachine
    call System_IndexWordList
    jp [hl]

PauseMenu_ContactSubstateMachine:
;TODO: Symbolize once we figure out what each subsubstate does
    dw $4A86,$4A9C,$4AD6,$4AFC,$4B92,$4BBD,$4BC0,$4BCE
    dw $4BF3,$4C47,$7F47,$7F4E,$4C4A,$4C90,$4CB4,$4CC9
    dw $4D30,$4D86,$4DD3,$4DEC,$4E37,$4E45,$4E59,$4E5A

sub_10A86:
    call $636B
    ld bc, $12
    ld a, [W_GameboyType]
    cp $11
    jr z, .useColorGraphic
    ld bc, $57
    
.useColorGraphic
    call Banked_LoadMaliasGraphics
    jp System_ScheduleNextSubSubState

sub_10A9C:
    ld a, [$CD24]
    ld b, a
    ld a, [$CB72]
    dec a
    cp b
    jr nc, .skipdecCD24
    ld a, [$CD24]
    dec a
    ld [$CD24], a
    
.skipdecCD24
    ld a, [$CD24]
    call $6473
    ld c, 0
    ld de, $9400
    call $516
    ld a, [$CD24]
    call $6473
    call $1764
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    ld a, [$CD24]
    call $6473
    call PauseMenu_ContactPrepName
    jp System_ScheduleNextSubSubState
