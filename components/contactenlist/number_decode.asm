INCLUDE "telefang.inc"

SECTION "Contact Enlist - Denjuu Phone Number Decoding RAM", WRAM0[$CA69]
W_ContactEnlist_CurrentPlacementEntry:: ds 1

SECTION "Contact Enlist - Denjuu Phone Number Decoding", ROMX[$4187], BANK[$29]

;Validate and decode a Denjuu's phone number.
;
;[HL] = Pointer to the phone number to decode.
;
;Returns:
; 
; ABCDE = 40-bit decoded Denjuu values.
;         Composed of Placement (A) and Seed (BCDE).
;         The Placement is formed from the placement of stars and hashtags
;         within the phone number. The seed is determined from the non-special
;         digits of the phone number.
;         
;         If the phone number is not valid, then this function returns 0.
ContactEnlist_DecodePhoneNumber::
    push hl
    call ContactEnlist_ValidateNumberFormat
    pop hl
    jr nz, .reject_invalid_number
    
    push hl
    call ContactEnlist_ExtractSymbolPlacement
    pop hl
    jr nz, .reject_invalid_number
    
    ld a, e
    ld [W_ContactEnlist_CurrentPlacementEntry], a
    call ContactEnlist_DecodePhoneSeed
    
    xor a
    ld a, [W_ContactEnlist_CurrentPlacementEntry]
    ret
    
.reject_invalid_number
    xor a
    ld e, a
    ld d, a
    ld c, a
    ld b, a
    ret
    
;Given a phone number at [HL], decode the digits into the 32-bit Seed value.
;
;[HL] = Pointer to phone number to decode.
;
;Returns:
; 
; BCDE = 32-bit decoded seed value
ContactEnlist_DecodePhoneSeed::
    inc hl
    ld a, 8
    ld [W_PauseMenu_CurrentItemGraphicBank], a
    
    ld b, 0
    ld c, 0
    ld d, 0
    ld e, 0
    
.digit_decode_loop
    ld a, [hli]
    cp M_ContactEnlist_PhoneSymbolHashtag
    jr nc, .digit_decode_loop
    
    push hl
    push bc
    push de
    
    ld b, a
    ld a, [W_PauseMenu_CurrentItemGraphicBank]
    cp 8
    jr nz, .decode
    
    ld a, b
    cp M_ContactEnlist_PhoneSymbol7
    jr nz, .decode
    
    ld b, M_ContactEnlist_PhoneSymbol5
    
.decode
    ld hl, ContactEnlist_SeedPatternMetatable
    ld a, [W_PauseMenu_CurrentItemGraphicBank]
    dec a
    add a, a
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, b
    sub M_ContactEnlist_PhoneSymbol0
    jr nz, .add_digit_factor
    
.zero_digit_factor
    pop de
    pop bc
    pop hl
    jr .move_to_next_digit
    
.add_digit_factor
    srl a
    dec a
    add a, a
    add a, a
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    
    pop de
    pop bc
    
    call ContactEnlist_32ConstantBy32Add
    
    pop hl
    
.move_to_next_digit
    ld a, [W_PauseMenu_CurrentItemGraphicBank]
    dec a
    ld [W_PauseMenu_CurrentItemGraphicBank], a
    jr nz, .digit_decode_loop
    
    ret
    
; Validates that a phone number matches the form:
; 
; 0BB-CCCC-DDDDD
; 
; where the B, C, and D blocks contain exactly one special * or # symbol each.
; 
; [HL] = Pointer to phone number
; 
; Returns:
; 
; F.Z if valid
; F.NZ if invalid
ContactEnlist_ValidateNumberFormat::
    ld a, [hli]
    cp M_ContactEnlist_PhoneSymbol0
    jr nz, .reject
    
    ld b, 2
    call ContactEnlist_ValidateNumberBlockSymbolCount
    jr nz, .reject
    
    inc hl
    ld b, 4
    call ContactEnlist_ValidateNumberBlockSymbolCount
    jr nz, .reject
    
    inc hl
    ld b, 5
    call ContactEnlist_ValidateNumberBlockSymbolCount
    jr nz, .reject
    ret
    
.reject
    ret
    
; Counts number of special symbols (star or pound) in a phone number.
; Validates that the special symbol count is equal to 1.
; 
; [HL] = Pointer to phone data
; B = Number of symbols within current phone number block
; 
; Returns
; [HL] = Pointer to last checked phone number digit
; C = Number of special symbols (star or pound) encountered
; F.Z if valid
; F.NZ if invalid
ContactEnlist_ValidateNumberBlockSymbolCount::
    ld c, 0
    
.symbol_counting_loop
    ld a, [hli]
    cp M_ContactEnlist_PhoneSymbolHashtag
    jr c, .not_special_symbol
    
.special_symbol
    inc c
    
.not_special_symbol
    dec b
    jr nz, .symbol_counting_loop
    
    ld a, c
    cp 1
    jr nz, .reject
    
.accept
    ret
    
.reject
    ret
    
; Extract symbol placements for numbers in the 0BB-CCCC-DDDDD format,
; validating that the number's symbol placements match the placement table.
; 
; For each of the B, C, and D blocks; it is decoded into two four-bit values.
; The low nybble indicates the kind of special symbol (0 for #, 1 for *) and the
; high nybble is the index of the digit it occurs in. These two values form what
; is called a placement byte.
; 
; For example:
; The phone number 05*-17#2-9927# has placement bytes $11, $20, and $40.
; 
; Once placement bytes are extracted, they are checked against the placement
; decoding table in order to produce the final decoded value from placements.
; Note that not all placements are valid (65 are not).
; 
; [HL] = Pointer to phone number
; 
; Returns:
; 
; A = 0, if phone number symbol placements are valid. Nonzero otherwise.
; B,C,D = The placement bytes for each respective block.
;         (e.g. Block B's placement byte is stored in register B.)
; E = Fully decoded placement value based on the placement lookup table.
ContactEnlist_ExtractSymbolPlacement::
    ld b, 0
    ld c, 0
    ld d, 0
    inc hl
    ld a, [hli]
    cp M_ContactEnlist_PhoneSymbolHashtag
    jr nc, .block_B_digit_in_position_2
    
.block_B_digit_in_position_3
    ld b, $10
    ld a, [hli]
    jr .determine_block_B_placement
    
.block_B_digit_in_position_2
    inc hl
    
.determine_block_B_placement
    cp M_ContactEnlist_PhoneSymbolHashtag
    jr z, .block_B_has_hashtag
    
.block_B_has_star
    inc b
    
.block_B_has_hashtag
    inc hl
    ld e, 4
    
.block_C_symbol_search
    ld a, [hli]
    cp M_ContactEnlist_PhoneSymbolHashtag
    jr nc, .block_C_position_found
    
    dec e
    jr z, .block_C_no_special
    
    ld a, c
    add a, $10
    ld c, a
    jr .block_C_symbol_search
    
.block_C_position_found
    push af
    
    ld a, e
    dec a
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    
    pop af
    
    cp M_ContactEnlist_PhoneSymbolHashtag
    jr z, .block_C_has_hashtag
    
.block_C_has_star
    inc c
    
.block_C_has_hashtag
    inc hl
    ld e, 5
    
.block_D_symbol_search
    ld a, [hli]
    cp M_ContactEnlist_PhoneSymbolHashtag
    jr nc, .block_D_position_found
    
    dec e
    jr z, .block_D_no_special
    
    ld a, d
    add a, $10
    ld d, a
    jr .block_D_symbol_search
    
.block_D_position_found
    push af
    
    ld a, e
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    
    pop af
    
    cp M_ContactEnlist_PhoneSymbolHashtag
    jr z, .block_D_has_hashtag
    
.block_D_has_star
    inc d
    
.block_D_has_hashtag
    ld e, 0
    ld hl, ContactEnlist_PlacementPatternTable
    
.placement_table_search
    ld a, [hli]
    cp b
    jr nz, .no_first_placement_match
    
    ld a, [hli]
    cp c
    jr nz, .no_second_placement_match
    
    ld a, [hli]
    cp d
    jr nz, .no_third_placement_match
    
    xor a
    ret
    
.no_first_placement_match
    inc hl
    
.no_second_placement_match
    inc hl
    
.no_third_placement_match
    inc e
    jr nz, .placement_table_search
    
.block_C_no_special
.block_D_no_special
    or 1
    ret