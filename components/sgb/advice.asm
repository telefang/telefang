INCLUDE "telefang.inc"

SECTION "SGB Packet Advice 1", ROM0[$3E4A]
Banked_SGB_ADVICE_SendATFPacketsWithVRAM::
    push de
    ld a, [W_CurrentBank]
    push af
    ld a, BANK(SGB_ADVICE_SendATFPacketsWithVRAM)
    rst $10
    jp SGB_ADVICE_SendATFPacketsWithVRAM

SECTION "SGB Packet Advice 2", ROM0[$3DFA]
Banked_SGB_ADVICE_SendATFPacketsWithVRAM_Exit::
    ld [REG_MBC3_ROMBANK], a
    jp SGB_SendPacketsWithVRAM_externalEntry

SECTION "SGB Packet Advice 3", ROMX[$4000], BANK[$77]
SGB_ADVICE_SendATFPacketsWithVRAM::
    di
    call LCDC_DisableLCD
    ld a, $E4
    ld [REG_BGP], a
    ld de, $8800
    ld bc, $1000

.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .copyLoop

    pop af
    ld [W_CurrentBank], a
    jp Banked_SGB_ADVICE_SendATFPacketsWithVRAM_Exit

SECTION "SGB Old Attribute Data Zerofill", ROMX[$6ED8], BANK[$3]
SGB_ClearOldAttrFileData::
	
;NOTE: Free Space

    REPT $5DD
    nop
    ENDR

SECTION "SGB Packet Advice 4", ROMX[$74C4], BANK[$3]
SGB_ConstructATTRBLKPacket::
; Assigns attributes to a rectangular region.
; b = x position (from the top-left)
; c = y position (from the top-left), fetched from W_MainScript_WindowLocation if set to $E0
; d = width of box
; e = height of box
; h = palette number, populates all other variables from SGB_ConstructATTRBLKPacket_PrecomposedTable

    ld a, [W_SGB_DetectSuccess]
    or a
    ret z

    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret z

    ld a, h
    and $FC
    jr z, .notPrecomposed
    ld a, h
    ld hl, SGB_ConstructATTRBLKPacket_PrecomposedTable
    sub 4
    ld b, a
    add a
    add a
    add b
    add l
    jr nc, .noOverflow
    inc h

.noOverflow
    ld l, a
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld h, a

.notPrecomposed
    ld a, c
    and $80
    jr z, .noAutoYPos
    ld a, [W_MainScript_WindowLocation]
	add c
	add $20
    ld c, a

.noAutoYPos
    push hl
    ld a, $21 ;ATTR_BLK
    ld hl, W_SGB_SpotPalette
    ld [hli], a
    ld a, 1
    ld [hli], a
    inc a
    inc a
    ld [hli], a
    pop af
    push bc
    ld c, a
    add a
    add a
    add c
    pop bc
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, c
    ld [hli], a
    ld a, d
    add b
    dec a
    ld [hli], a
    ld a, e
    add c
    dec a
    ld [hli], a
    jp SGB_SendConstructedPaletteSetPacket

SGB_ConstructATFSetPacket::
    ld a, [W_SGB_DetectSuccess]
    or a
    jr nz, .constructPacket

.noSgb
    ret

.constructPacket
    ld a, $B1 ;ATTR_SET
    ld hl, W_SGB_SpotPalette
    ld [hli], a
    ld a, c
    add a, $40
    ld [hli], a
    jp SGB_SendConstructedPaletteSetPacket

SGB_ConstructATTRBLKPacket_PrecomposedTable::
    db  1, $E0, $12, 6, 3 ; 04 Overworld Message Box Open
    db  1, $E0, $12, 4, 3 ; 05 Overworld Message Box 2/3 Open
    db  1, $E0, $12, 2, 3 ; 06 Overworld Message Box 1/3 Open
    db  1, $E0, $12, 6, 0 ; 07 Overworld Message Box Closed
    db  0, $E0, $14, 2, 3 ; 08 Hud Open
    db  0,   0, $14, 2, 0 ; 09 Top Hud Closed
    db  0,  $E, $14, 2, 3 ; 0A (Unused)
    db  0,  $E, $14, 2, 0 ; 0B Bottom Hud Closed
    db  1, $E0, $12, 3, 3 ; 0C Location Window Open
    db  0,   0,  $A, 4, 3 ; 0D Shop Window Open
    db $C,   0,   8, 3, 3 ; 0E Secondary Shop Window Open
    db $C,   0,   8, 3, 0 ; 0F Secondary Shop Window Closed
    db  0,   0, $14, 9, 0 ; 10 (Unused)
    db  0,   0, $14, 9, 0 ; 11 (Unused)
    db  0,   0, $14, 9, 0 ; 12 (Unused)
    db  0,   0, $14, 9, 0 ; 13 (Unused)
    db  0,   0, $14, 9, 0 ; 14 (Unused)

SECTION "SGB Packet Advice 5", ROM0[$3DF2]
Banked_SGB_ConstructATFSetPacket::
    ld a, BANK(SGB_ConstructATFSetPacket)
    rst $10
    call SGB_ConstructATFSetPacket
    rst $18
    ret

SECTION "SGB Packet Advice 6", ROM0[$3DCF]
Banked_SGB_ConstructATTRBLKPacket::
    ld a, [W_CurrentBank]
    push af
    ld a, BANK(SGB_ConstructATTRBLKPacket)
    rst $10
    call SGB_ConstructATTRBLKPacket
    pop af
    rst $10
    ret
