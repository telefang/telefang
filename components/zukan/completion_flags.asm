INCLUDE "telefang.inc"

SECTION "Zukan Completion Flag Utils", ROMX[$7A3A], BANK[$4]
Zukan_CheckEntryObtained::
    ld e, a
    ld d, 0
    ld hl, M_Zukan_BaseEntryObtainedFlag
    jr Zukan_CheckSpeciesKnown.readflag
    
Zukan_CheckSpeciesKnown::
    ld e, a
    ld d, 0
    ld hl, M_Zukan_BaseSpeciesKnownFlag
    
.readflag
    add hl, de
    ld b, h
    ld c, l
    jp Overworld_CheckFlagValue
    
Zukan_CalculateTotals::
    ld hl, W_Overworld_EventFlagBitfield
    ld bc, M_Zukan_BaseEntryObtainedFlag
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    add hl, bc
    ld de, M_Zukan_FlagBitfieldPartitionSize
    add hl, de
    ld c, M_Zukan_FlagBitfieldPartitionSize
    
.find_last_obtained_species
    ld a, [hld]
    cp 0
    jr nz, .decode_obtained_bitfield
    
    dec c
    jr .find_last_obtained_species
    
.decode_obtained_bitfield
    sla c
    sla c
    sla c
    ld b, 8
    bit 7, a
    jr nz, .write_last_known_species_obtained
    
    ld b, 7
    bit 6, a
    jr nz, .write_last_known_species_obtained
    
    ld b, 6
    bit 5, a
    jr nz, .write_last_known_species_obtained
    
    ld b, 5
    bit 4, a
    jr nz, .write_last_known_species_obtained
    
    ld b, 4
    bit 3, a
    jr nz, .write_last_known_species_obtained
    
    ld b, 3
    bit 2, a
    jr nz, .write_last_known_species_obtained
    
    ld b, 2
    bit 1, a
    jr nz, .write_last_known_species_obtained
    
    ld b, 1
    
.write_last_known_species_obtained
    ld a, c
    add a, b
    dec a
    ld [W_Zukan_LastKnownSpecies], a
    
    ld hl, W_Overworld_EventFlagBitfield
    ld bc, M_Zukan_BaseSpeciesKnownFlag
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    add hl, bc
    ld de, M_Zukan_FlagBitfieldPartitionSize
    add hl, de
    ld c, M_Zukan_FlagBitfieldPartitionSize
    
.find_last_known_species
    ld a, [hld]
    cp 0
    jr nz, .decode_known_bitfield
    
    dec c
    jr .find_last_known_species
    
.decode_known_bitfield
    sla c
    sla c
    sla c
    ld b, 8
    bit 7, a
    jr nz, .write_last_known_species_known
    
    ld b, 7
    bit 6, a
    jr nz, .write_last_known_species_known
    
    ld b, 6
    bit 5, a
    jr nz, .write_last_known_species_known
    
    ld b, 5
    bit 4, a
    jr nz, .write_last_known_species_known
    
    ld b, 4
    bit 3, a
    jr nz, .write_last_known_species_known
    
    ld b, 3
    bit 2, a
    jr nz, .write_last_known_species_known
    
    ld b, 2
    bit 1, a
    jr nz, .write_last_known_species_known
    
    ld b, 1
    
.write_last_known_species_known
    ld a, c
    add a, b
    dec a
    ld b, a
    ld a, [W_Zukan_LastKnownSpecies]
    cp b
    jr nc, .count_obtained
    ld a, b
    ld [W_Zukan_LastKnownSpecies], a
    
.count_obtained
    xor a
    ld [W_Zukan_ObtainedEntriesCount], a
    
    ld hl, W_Overworld_EventFlagBitfield
    ld bc, M_Zukan_BaseSpeciesKnownFlag
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    add hl, bc
    ld b, M_Zukan_FlagBitfieldPartitionSize
    
.bitfield_counting_loop
    ld c, 8
    ld a, [hli]
    
.bit_counting_loop
    bit 0, a
    jr z, .count_next_bit
    
    push af
    
    ld a, [W_Zukan_ObtainedEntriesCount]
    inc a
    ld [W_Zukan_ObtainedEntriesCount], a
    
    pop af
    
.count_next_bit
    srl a
    dec c
    jr nz, .bit_counting_loop
    
    dec b
    jr nz, .bitfield_counting_loop
    
    ret