INCLUDE "telefang.inc"

SECTION "Title Menu Player Name WRAM", WRAM0[$C3A9]
W_TitleMenu_NameBuffer:: ds M_MainScript_PlayerNameSize + 1

SECTION "Title Menu Player Name Input", ROMX[$68FF], BANK[$4]
TitleMenu_PositionNameCursor::
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    ld hl, .cursorPositionList
    add hl, de
    ld a, [hl]
    
    ld b, a
    ld c, $68
    ld de, $C0C0 ;TODO: This is the cursor structure
    call PauseMenu_PositionCursor
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret
    
.cursorPositionList
    db $08
    db $10
    db $18
    db $20
    db $28
    db $30
    db $38
    db $40
    
;Nearly identical function to the above...
;It doesn't use a lookup table, but instead calculates the X coordinate in the
;same way, all for an 8 pixel offset...
;Anyway, it's called by state 03 20, which I -think- has something to do with
;nicknaming denjuu obtained through link communications.
TitleMenu_PositionNicknameCursor::
    ld a, [W_PauseMenu_SelectedMenuItem]
    sla a
    sla a
    sla a
    add a, $10
    ld b, a
    ld c, $70
    ld de, $C0C0 ;TODO: Cursor structure
    call PauseMenu_PositionCursor
    ld a, 1
    ld [W_OAM_SpritesReady], a
    ret

SECTION "Title Menu Player Name Input 2", ROMX[$6488], BANK[$4]
TitleMenu_ClearCharaName::
    push af
    push hl
    ld a, 4
    call PatchUtils_AuxCodeJmp
    pop hl
    pop af
    ret

SECTION "Title Menu Player Name Input 3", ROMX[$64A9], BANK[$4]
TitleMenu_NameInputImpl::
    call TitleMenu_NameInputProcessing
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .extraInputProcessingICantDisasmRightNow
    
;This code runs if A or B was pressed.
    ld a, $FF
    ld [$CB66], a
    
    xor a
    ld [W_PauseMenu_PhoneIMEPressCount], a
    
    ld hl, $9780
    ld b, M_MainScript_PlayerNameSize
    call PauseMenu_ClearInputTiles
    
    ld hl, W_TitleMenu_NameBuffer
    ld a, [W_PauseMenu_SelectedMenuItem]
    ld e, a
    ld d, 0
    add hl, de
    ld [hl], 0
    
    call $6794
    call PauseMenu_DrawCenteredNameBuffer
    
    ld a, [W_PauseMenu_SelectedMenuItem]
    cp 0
    ret z
    
    dec a
    ld [W_PauseMenu_SelectedMenuItem], a
    ld a, 4
    ld [byte_FFA1], a
    ret
    
.extraInputProcessingICantDisasmRightNow
    ;TODO: Disasm
    
SECTION "Title Menu Player Name Input 4", ROMX[$5B37], BANK[$4]
TitleMenu_NameInputProcessing::
    ;TODO: Disasm
