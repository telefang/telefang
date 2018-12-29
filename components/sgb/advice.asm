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

    REPT $6AE
    nop
    ENDR
