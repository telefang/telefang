INCLUDE "telefang.inc"

SECTION "Pause Menu Cursor Memory Stuff", WRAMX[$D411], BANK[1]
W_PauseMenu_SelectedCursorType:: ds 1

SECTION "Pause Menu Cursor Stuff", ROM0[$0D97]
;TODO: Is this even PauseMenu exclusive or is it it's own resource type used
;elsewhere?
PauseMenu_InitializeCursor::
    ld hl, 6 ;TODO: What is this offset?
    add hl, de
    ld [hl], 1
    
    ld hl, M_PauseMenu_CursorAnimSetId
    add hl, de
    ld [hl], a
    
    ld hl, M_PauseMenu_CursorAnimCounter
    add hl, de
    ld [hl], 0
    
    ld hl, M_PauseMenu_CursorAnimKeyframe
    add hl, de
    ld [hl], 0
    
    ld hl, M_PauseMenu_CursorAnimStart
    add hl, de
    ld [hl], 0
    
    ld hl, M_PauseMenu_CursorTable
    add hl, de
    ld a, [hl]
    and $F
    push af
    
    ;Read the first metasprite ID to animate to...
    ld hl, .cursorMetatableBanks
    ld b, 0
    ld c, a
    add hl, bc
    ld a, [hl]
    rst $10
    
    pop af
    ld hl, .cursorMetatablePtrs
    ld b, 0
    ld c, a
    sla c
    rl b
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    push hl
    
    ld hl, M_PauseMenu_CursorAnimSetId
    add hl, de
    ld a, [hl]
    
    pop hl
    ld b, 0
    ld c, a
    sla c
    rl b
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    
    inc hl
    ld a, [hl]
    
    ld hl, M_PauseMenu_CursorMetasprite
    add hl, de
    ld [hl], a
    
    ret
    
.cursorMetatableBanks ;DEE
    db BANK(PauseMenu_CursorAnimData)
    db BANK(PauseMenu_CursorAnimData)
    db BANK(PauseMenu_CursorAnimData)
    
.cursorMetatablePtrs ;DF1
    dw PauseMenu_CursorAnimData
    dw PauseMenu_CursorAnimData
    dw PauseMenu_CursorAnimData
    
PauseMenu_IterateCursorAnimation::
    ld hl, M_PauseMenu_CursorTable
    add hl, de
    ld a, [hl]
    and $F
    
    ld hl, PauseMenu_InitializeCursor.cursorMetatableBanks
    ld b, 0
    ld c, a
    add hl, bc
    ld a, [hl]
    rst $10
    
    ld hl, 6 ;TODO: What does this offset mean
    add hl, de
    ld a, [hl]
    or a
    jp nz, .zeroChoiceJmp
    
.zeroChoiceJmp
    ld hl, M_PauseMenu_CursorAnimStart
    add hl, de
    ld a, [hl]
    cp M_PauseMenu_CursorFinished
    ret z   ;Early-exit if the animation finished...
    
    ld hl, M_PauseMenu_CursorAnimCounter
    add hl, de
    ld a, [hl]
    or a
    jr z, .progressToNextKeyframe
    dec a
    ld [hl], a
    ret     ;Count down to the next keyframe
    
.progressToNextKeyframe
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld hl, M_PauseMenu_CursorTable
    add hl, de
    ld a, [hl]
    and $F
    
    ld hl, PauseMenu_InitializeCursor.cursorMetatablePtrs
    ld b, 0
    ld c, a
    sla c
    rl b
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    push hl
    
    ld hl, M_PauseMenu_CursorAnimSetId
    add hl, de
    ld a, [hl]
    pop hl
    ld c, a
    ld b, 0
    sla c
    rl b
    add hl, bc
    
    ld a, [hli]
    ld b, [hl]
    ld c, a     ;Get a ptr to the current animation set data
    
.parseLoop
    ld hl, M_PauseMenu_CursorAnimKeyframe
    add hl, de
    ld a, [hl]
    ld h, 0
    ld l, a
    add hl, bc  ;Index the animation set to the current keyframe byte
    
    ld a, [hl]
    cp M_PauseMenu_CursorReset
    jr z, .reset
    cp M_PauseMenu_CursorFinished
    jr z, .stop
    jp .nextFrame
    
.stop
    ld hl, M_PauseMenu_CursorAnimStart
    add hl, de
    ld [hl], M_PauseMenu_CursorFinished
    
    ld hl, 6
    add hl, de
    ld [hl], 0
    ret
    
.reset
    inc hl
    ld a, [hl]
    sla a
    sla a
    
    ld hl, M_PauseMenu_CursorAnimKeyframe
    add hl, de
    ld [hl], a
    jp .parseLoop
    
.nextFrame:
    ld a, [hli]
    dec a
    push hl
    ld hl, M_PauseMenu_CursorAnimCounter
    add hl, de
    ld [hl], a  ;Reset the animation counter with the next keyframe delay value.
    pop hl
    
    ld a, [hl]
    ld hl, M_PauseMenu_CursorMetasprite
    add hl, de
    ld [hl], a  ;Set the current metasprite to the new keyframe value.
    
    ld hl, M_PauseMenu_CursorAnimKeyframe
    add hl, de
    ld a, [hl]
    add a, 2
    ld [hl], a  ;Prepare the pointer to the next keyframe.
    ret

SECTION "Pause Menu Cursor Animation Data", ROMX[$7AC4], BANK[$C]
PauseMenu_CursorAnimData::
    ;This data is not yet extracted.

SECTION "Pause Menu Cursor Stuff 2", ROMX[$5781], BANK[$4]
PauseMenu_PositionClearedCursor::
    ld hl, 0
    add hl, de
    inc hl
    jp PauseMenu_PositionCursor.after_setting_index
    
PauseMenu_PositionCursor::
    ld hl, 0 ;TODO: What does this offset do?
    add hl, de
    ld a, 1
    ld [hli], a
    
.after_setting_index
    ld a, 0
    ld [hli], a
    inc hl
    ld a, b
    ld [hli], a
    ld a, c
    ld [hli], a
    ret
    
SECTION "Pause Menu Predefined Cursor Utils", ROMX[$7312], BANK[$4]
PauseMenu_UpdateZukanOverviewCursorAnimations::
    ld a, $40
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, 8
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $60
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, 0
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_Bank], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_Bank], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    jp Banked_PauseMenu_IterateCursorAnimation
    
PauseMenu_UpdateZukanPageCursorAnimations::
    ld a, $90
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, 8
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $60
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, 0
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_Bank], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_Bank], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    jp Banked_PauseMenu_IterateCursorAnimation

PauseMenu_UpdateItemScreenCursorAnimations::
    ld a, $40
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, 8
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_XOffset], a
    
    ld a, $50
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_YOffset], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_YOffset], a
    
    ld a, 1
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, [W_PauseMenu_ActiveInventoryCount]
    dec a
    cp 0
    jr nz, .dontRemoveSprites
    
.removeSprites
    xor a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
.dontRemoveSprites
    ld a, 0
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1 + M_LCDC_MetaSpriteConfig_Bank], a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2 + M_LCDC_MetaSpriteConfig_Bank], a
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 1
    call Banked_PauseMenu_IterateCursorAnimation
    
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 2
    jp Banked_PauseMenu_IterateCursorAnimation