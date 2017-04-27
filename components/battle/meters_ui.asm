INCLUDE "telefang.inc"

;For some reason, half of the battle meter code is in HOME, even though it's
;only called by Bank 5 code.
SECTION "Battle Meters UI HOME", ROM0[$3957]
Battle_DrawMeter::
    ld b, M_Battle_MeterLength
    ld [W_System_GenericCounter], a
    
.drawTile
    sub 8
    jr c, .drawPartialTile
    ld [W_System_GenericCounter], a
    
    push af
    ld a, M_Battle_MeterIncrement
    call Battle_DrawMeterTile
    
    pop af
    dec b
    jp nz, .drawTile
    
    ret
    
.drawPartialTile
    ld a, [W_System_GenericCounter]
    call Battle_DrawMeterTile
    dec b
    ret z

;As far as I can tell, this code is unused.
.drawBlankTile
    xor a
    call Battle_DrawMeterTile
    dec b
    jp nz, .drawBlankTile
    
    ret
    
Battle_CalculateMeterFraction::
    cp e
    jr z, .meterFull
    
    push af
    ld bc, $3000
    ld d, 0
    call $628 ;A banksafe caller to some divisor code I'm not going to fiddle with yet
    
    pop af
    ld d, 0
    ld e, a
    call System_Multiply16
    ld a, d
    ret
    
.meterFull
    ld a, M_Battle_MeterLength * M_Battle_MeterIncrement
    ret
    
Battle_LoadMeterPalette::
    cp $D
    jr c, .criticalPalette
    cp $15
    jr c, .lowPalette
    
    ld bc, 2
    jr .loadChosenPalette
    
.lowPalette
    ld bc, 3
    jr .loadChosenPalette
    
.criticalPalette
    ld bc, 4
    
.loadChosenPalette
    ld a, d
    call CGBLoadBackgroundPaletteBanked
    
    ld a, 1
    ld [W_CGBPaletteStagedBGP], a
    
    ret
    
;The health bars in this game are drawn with a set of 8-wide tiles.
;This code sets each 8-wide portion of the bar to it's appropriate
;level of filled-ness.
;
;Since opponent meters fill "backwards" we have a separate set of
;"backwards" tiles for them.
Battle_DrawMeterTile::
    push bc
    push hl
    bit 0, c
    jr nz, .drawMeterBackwards
    
    ld hl, .forwardsMeterTiles
    jp .drawTile
    
.drawMeterBackwards
    ld hl, .backwardsMeterTiles

.drawTile
    ld d, 0
    ld e, a
    add hl, de
    
    ld a, [hl]
    
    pop hl
    push hl
    call vmempoke
    pop hl
    pop bc
    
    bit 0, c
    jr nz, .nextTileBackwards
    
.nextTileForwards
    inc hl
    ret
    
.nextTileBackwards
    dec hl
    ret
    
.forwardsMeterTiles
    db $3E, $30, $31, $32, $33, $34, $35, $36, $3F
.backwardsMeterTiles
    db $3E, $37, $38, $39, $3A, $3B, $3C, $3D, $3F

SECTION "Battle Meters UI", ROMX[$404A], BANK[$5]
Battle_DrawPartnerUI::
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    call Battle_StagePartnerStats
    call Battle_DrawPartnerHPMeter
    
    ld a, [W_Battle_PartnerDenjuuTurnOrder]
    call Battle_DrawPartnerDPMeter
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantContactID]
    ld hl, $9200
    jp Battle_DrawSpecifiedDenjuuNickname
    
Battle_DrawOpponentUI::
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    call Battle_StageOpponentStats
    call Battle_DrawOpponentHPMeter
    
    ld a, [W_Battle_OpponentDenjuuTurnOrder]
    call Battle_DrawOpponentDPMeter
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantSpecies]
    ld de, StringTable_denjuu_species
    ld bc, $9280
    jp Banked_MainScript_DrawName75
    
Battle_DrawPartnerHPMeter::
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantMaxHP]
    ld e, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantHP]
    call Battle_CalculateMeterFraction
    
    ld [W_Battle_PartnerMeterFraction], a
    or a
    jr nz, .drawMeter
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantHP]
    or a
    jr z, .drawMeter
    
    ld a, 1
    ld [W_Battle_PartnerMeterFraction], a
    
.drawMeter
    ld d, 1
    ld a, [W_Battle_PartnerMeterFraction]
    call Battle_LoadMeterPalette
    
    ld a, [W_Battle_PartnerMeterFraction]
    ld c, M_Battle_MeterForward
    ld hl, $9843
    jp Battle_DrawMeter
    
Battle_DrawOpponentHPMeter::
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantMaxHP]
    ld e, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantHP]
    call Battle_CalculateMeterFraction
    
    ld [W_Battle_OpponentMeterFraction], a
    or a
    jr nz, .drawMeter
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantHP]
    or a
    jr z, .drawMeter
    
    ld a, 1
    ld [W_Battle_OpponentMeterFraction], a
    
.drawMeter
    ld d, 2
    ld a, [W_Battle_OpponentMeterFraction]
    call Battle_LoadMeterPalette
    
    ld a, [W_Battle_OpponentMeterFraction]
    ld c, M_Battle_MeterBackward
    ld hl, $9D46
    jp Battle_DrawMeter
    
Battle_DrawPartnerDPMeter::
    call Battle_StagePartnerStats
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantMaxDP]
    ld e, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantDP]
    call Battle_CalculateMeterFraction
    
    ld [W_Battle_PartnerMeterFraction], a
    or a
    jr nz, .drawMeter
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantDP]
    or a
    jr z, .drawMeter
    
    ld a, 1
    ld [W_Battle_PartnerMeterFraction], a
    
.drawMeter
    ld a, [W_Battle_PartnerMeterFraction]
    ld c, M_Battle_MeterForward
    ld hl, $9863
    jp Battle_DrawMeter
    
Battle_DrawOpponentDPMeter::
    call Battle_StageOpponentStats
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantMaxDP]
    ld e, a
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantDP]
    call Battle_CalculateMeterFraction
    
    ld [W_Battle_OpponentMeterFraction], a
    or a
    jr nz, .drawMeter
    
    ld a, [W_Battle_CurrentParticipant + M_Battle_ParticipantDP]
    or a
    jr z, .drawMeter
    
    ld a, 1
    ld [W_Battle_OpponentMeterFraction], a
    
.drawMeter
    ld a, [W_Battle_OpponentMeterFraction]
    ld c, M_Battle_MeterBackward
    ld hl, $9D66
    jp Battle_DrawMeter