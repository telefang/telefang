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

    REPT $68B
    nop
    ENDR

SECTION "SGB Packet Advice 4", ROMX[$7572], BANK[$3]
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

SECTION "SGB Packet Advice 5", ROM0[$3DF2]
Banked_SGB_ConstructATFSetPacket::
	
    ld a, BANK(SGB_ConstructATFSetPacket)
    rst $10
    call SGB_ConstructATFSetPacket
    rst $18
    ret
