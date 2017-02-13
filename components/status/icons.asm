INCLUDE "gfx/denjuu_stages.inc"

SECTION "Status Screen Icon Loading", ROM0[$18E6]
Status_LoadDenjuuEvolutionIndicator::
    push de
    and $F
    swap a
    ld e, a
    ld a, BANK(DenjuuStageGfx)
    rst $10
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    push de
    sla e
    rl d
    pop hl
    add hl, de
    ld de, DenjuuStageGfx
    add hl, de
    pop de
    ld bc, M_DenjuuStageGfx_Stride
    jp LCDC_LoadFromMetatable_copyLoop
    
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
    jp LCDC_LoadFromMetatable_copyLoop

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