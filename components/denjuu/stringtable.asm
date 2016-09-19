;TODO: Symbolize the WRAM/VRAM references

SECTION "Denjuu Related String Table Load n Draw Functions", ROM0[$3B22]
Denjuu_DrawHabitatString:
    ld a, [$D497]
    ld c, $D
    call $58D
    ld a, [$D45F]
    ld de, MainScript_denjuu_habitats
    ld bc, $9380
    jp MainScript_DrawShortName
    
Denjuu_DrawStatusEffectString:
    push hl
    ld a, b
    ld de, MainScript_denjuu_statuses
    pop bc
    jp MainScript_DrawShortName