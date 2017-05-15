INCLUDE "telefang.inc"

SECTION "Victory After-Battle Natural Evolution States", ROMX[$4E64], BANK[$1D]
;State 08 00 00 14
Victory_SubStateNaturalEvoQuestion::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    ret nz
    
    ld c, $8D
    call Battle_QueueMessage
    
    xor a
    ld [W_Victory_UserSelection], a
    
    call Victory_PlaceChoiceCursor
    
    ld a, 0
    ld [W_PauseMenu_SelectedCursorType], a
    call LCDC_BeginAnimationComplex
    
    ld a, [W_Battle_4thOrderSubState]
    inc a
    ld [W_Battle_4thOrderSubState], a
    ret
    
;State 08 00 00 15
Victory_SubStateNaturalEvoInput::
    call LCDC_IterateAnimationComplex
    call Banked_MainScriptMachine
    
.checkLeft
    ld a, [H_JPInput_Changed]
    and $20
    jr z, .checkRight
    
    ld a, [W_Victory_UserSelection]
    cp 0
    jr z, .checkRight
    
    ld a, 0
    ld [W_Victory_UserSelection], a
    jr .repositionCursor
    
.checkRight
    ld a, [H_JPInput_Changed]
    and $10
    jr z, .checkBButton
    
    ld a, [W_Victory_UserSelection]
    cp 1
    jr z, .checkBButton
    
    ld a, 1
    ld [W_Victory_UserSelection], a
    
.repositionCursor
    ld a, 2
    ld [byte_FFA1], a
    jp Victory_PlaceChoiceCursor

.checkBButton
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .checkAButton
    
    ld a, 3
    ld [byte_FFA1], a
    jr .evolveCancelled
    
.checkAButton
    ld a, [H_JPInput_Changed]
    and 1
    ret z
    
    ld a, 3
    ld [byte_FFA1], a
    
    ld a, [W_Victory_UserSelection]
    cp 0
    jr z, .evolveApproved
    
.evolveCancelled
    ld a, [W_Victory_LeveledUpParticipant]
    cp 0
    jr z, .noEvolveFirst
    
    cp 1
    jr z, .noEvolveSecond
    jr .noEvolveThird
    
.noEvolveFirst
    ld a, 3
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 0 + M_Battle_ParticipantLocation], a
    jr .queueCancelMessage
    
.noEvolveSecond
    ld a, 3
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 1 + M_Battle_ParticipantLocation], a
    jr .queueCancelMessage
    
.noEvolveThird
    ld a, 3
    ld [W_Battle_PartnerParticipants + M_Battle_ParticipantSize * 2 + M_Battle_ParticipantLocation], a

.queueCancelMessage
    ld c, M_Battle_MessageNaturalEvoCancel
    call Battle_QueueMessage
    
    xor a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 0 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld a, [W_Battle_4thOrderSubState]
    inc a
    ld [W_Battle_4thOrderSubState], a
    
    ret
    
.evolveApproved
    xor a
    ld [W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 0 + M_LCDC_MetaSpriteConfig_HiAttribs], a
    
    ld a, 1
    ld [W_OAM_SpritesReady], a
    
    ld a, [W_Victory_LeveledUpParticipant]
    inc a
    ld [W_Victory_LeveledUpParticipant], a
    
    ld a, $13
    ld [W_Battle_4thOrderSubState], a
    
    ret
    
;State 08 00 00 16
Victory_SubStateNaturalEvoCancel::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    ret nz
    
    ld a, [W_Victory_LeveledUpParticipant]
    inc a
    ld [W_Victory_LeveledUpParticipant], a
    
    ld a, $13
    ld [W_Battle_4thOrderSubState], a
    
    ret