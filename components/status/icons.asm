INCLUDE "telefang.inc"

SECTION "Status Screen Icon Loading", ROM0[$18E6]
Status_LoadDenjuuEvolutionIndicator::
    push de
    call Status_LoadDenjuuEvolutionIndicatorCommon
    jp Status_LoadDenjuuEvolutionIndicatorOffload

Status_LoadDenjuuEvolutionIndicatorCommon::
    and $F
    swap a
    ld e, a
    ld a, BANK(DenjuuStageGfx)
    rst $10
    ret
    nop
    
SECTION "Status Screen Icon Loading 2", ROM0[$190B]
Status_LoadDenjuuTypeIcon::
    and $F
    swap a
    ld e, a
    ld a, BANK(DenjuuTypeGfx)
    rst $10
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    ld hl, DenjuuTypeGfx
    add hl, de
    ld de, $92C0
    ld bc, M_DenjuuTypeGfx_Stride
    jp LCDC_LoadGraphicIntoVRAM

Status_LoadDenjuuTypeIconPalette::
    ld e, a
    ld d, 0
    ld hl, $2D0
    add hl, de
    push hl
    pop bc
    ld a, 1
    call CGBLoadBackgroundPaletteBanked
    ret

SECTION "Status Screen Evolution Indicator", ROMX[$5E78], BANK[$7D]
Status_LoadDenjuuEvolutionIndicatorOffload::
    ld bc, M_Status_DenjuuStageGfx_NumTiles * 16
    call Status_LoadDenjuuEvolutionIndicatorOffloadMultiply
    ld de, DenjuuStageGfx
    jr Status_LoadDenjuuEvolutionIndicatorOffloadCommon

Status_LoadDenjuuEvolutionIndicatorOffloadZukan::
    ld bc, M_Zukan_DenjuuStageGfx_NumTiles * 16
    call Status_LoadDenjuuEvolutionIndicatorOffloadMultiply
    ld de, DenjuuStageZukanGfx
	
Status_LoadDenjuuEvolutionIndicatorOffloadCommon::
    add hl, de
    pop de
    jp LCDC_LoadGraphicIntoVRAM

Status_LoadDenjuuEvolutionIndicatorOffloadMultiply::
    ld hl, 0
    ld a, e
    swap a ; Because for some reason, the index is in the upper nibble.
    cp 0
    ret z

.nextStageGraphicLoop
    add hl, bc
    dec a
    jr nz, .nextStageGraphicLoop
    
    ret
    nop

SECTION "Status Screen Zukan Evolution Indicator for SGB", ROMX[$5F1A], BANK[$7D]
Status_LoadDenjuuEvolutionIndicatorOffloadZukan_NowWithSGBSupport::
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jp z, Status_LoadDenjuuEvolutionIndicatorOffloadZukan
    ld a, [W_SGB_DetectSuccess]
    or a
    jp z, Status_LoadDenjuuEvolutionIndicatorOffloadZukan
    ld bc, M_Zukan_DenjuuStageGfx_NumTiles * 16
    call Status_LoadDenjuuEvolutionIndicatorOffloadMultiply
    ld b, $90
    ld de, DenjuuStageZukanGfx
    add hl, de
    pop de

Status_LoadDenjuuEvolutionIndicatorOffloadZukan_NowWithSGBSupport_DrawLoop::
    ld a, [hli]
    ld c, a
    inc de
    di

.wfb
    ldh a, [REG_STAT]
    and 2
    jr nz, .wfb
    ld a, [hli]
    ld [de], a
    dec e
    xor c
    cpl
    ld [de], a
    ei
    inc de
    inc de
    dec b
    jr nz, Status_LoadDenjuuEvolutionIndicatorOffloadZukan_NowWithSGBSupport_DrawLoop
    ret
