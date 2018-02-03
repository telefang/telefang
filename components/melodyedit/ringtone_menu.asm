INCLUDE "telefang.inc"

SECTION "Melody Edit Spot Tilemaps", ROMX[$604E], BANK[$4]
MelodyEdit_DrawRingtoneMenuEntry::
    push de
    push bc
    push de
    
    ld hl, .spot_tilemap_table
    call PauseMenu_IndexPtrTable
    
    ld a, [hli]
    ld h, [hl]
    ld l, a
    pop de
    ld b, 5
    
.copy_loop
    di
    
    ld a, [hli]
    call YetAnotherWFB
    
    ld [de], a
    
    ei
    
    inc de
    dec b
    jr nz, .copy_loop
    
    pop bc
    
    ld a, c
    cp $47
    jr c, .no_sub
    
.sub
    sub $47
    
.no_sub
    inc a
    ld c, a
    call Status_DecimalizeStatValue
    
    pop de
    ld hl, 5
    add hl, de
    jp MelodyEdit_DrawDecodedIndicatorValue
    
.spot_tilemap_table
    dw .ringtone
    dw .original
    
.ringtone
    db $60, $61, $62, $63, $52
.original
    db $64, $65, $66, $67, $52