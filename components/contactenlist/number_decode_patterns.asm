SECTION "Contact Enlist Number Decode Patterns", ROMX[$4588], BANK[$29]
;This pattern table lists all the valid placements of special symbols (* and #)
;within a Denjuu's phone number. Each table entry is three bytes long, and each
;byte (called a placement byte) specifies the position and type of the special
;character within each block of the phone number. The blocks, from left-to-right
;in memory are named B, C, and D and correspond to the first, second, and third
;bank of digits and symbols within a phone number.
;
;See ContactEnlist_ExtractSymbolPlacement for the explanation of the meaning of
;each byte in the table.
;
;TODO: Convert this to a machine-readable CSV to allow automated parsing and
;tools built to decode Denjuu phone numbers.
ContactEnlist_PlacementPatternTable::
    db  $11,   1, $31
    db  $10, $21, $41
    db    1, $10, $40
    db  $10, $21, $20
    db  $11, $11, $10
    db    1, $20,   1
    db    0,   0, $30
    db    0, $10, $30
    db    1,   0, $30
    db    1, $21, $41
    db    0, $20,   0
    db    0, $31, $41
    db  $11, $30,   1
    db  $11,   1, $10
    db    0, $11,   0
    db  $11, $20,   0
    db    1,   0, $31
    db  $10,   1,   1
    db    0,   0, $20
    db  $11, $30, $31
    db  $11, $21, $30
    db    1, $30, $40
    db    1, $31, $20
    db    0,   1, $40
    db    1,   1, $41
    db    1, $10, $11
    db    0, $11, $30
    db    0, $31, $10
    db  $11, $31, $40
    db    1, $30, $41
    db  $10, $31, $30
    db    0,   0, $40
    db    1, $21, $21
    db  $10,   0, $41
    db    1, $10,   1
    db    1, $11, $40
    db    1, $21, $20
    db  $10,   1, $11
    db    0, $21, $20
    db    0, $20, $20
    db  $11, $10, $31
    db    0,   1, $11
    db    1, $31,   1
    db    1, $11, $21
    db    1, $10,   0
    db  $11, $31, $31
    db    0, $21, $11
    db    0, $31, $21
    db  $10, $30, $31
    db  $11, $11, $30
    db  $10, $10,   0
    db    0, $21,   1
    db    0, $31,   1
    db    0, $30, $20
    db    0,   0, $10
    db    0, $20, $40
    db  $11,   0, $11
    db  $11, $21,   0
    db  $10,   1, $30
    db    0, $31, $11
    db  $10,   1, $31
    db  $11, $10, $10
    db  $11,   1, $40
    db    1,   0, $11
    db  $11, $30, $30
    db  $11, $21, $40
    db  $10, $21, $31
    db  $11, $30, $21
    db  $10, $31, $40
    db  $11, $21,   1
    db    0, $30, $10
    db    1, $21,   1
    db  $10, $31, $21
    db    0, $10, $11
    db    0, $30,   0
    db    1,   1, $40
    db    1, $21, $31
    db    0,   1,   1
    db    1,   1,   1
    db  $10, $10, $30
    db    0, $21, $40
    db    0, $10, $21
    db  $10, $20, $21
    db  $11, $20, $10
    db    0, $30,   1
    db    0, $30, $41
    db  $11, $21, $21
    db  $10,   1, $40
    db  $11, $30, $10
    db  $11, $31,   0
    db    1, $20, $40
    db  $10, $20, $31
    db  $11, $11, $41
    db  $10, $21, $10
    db    0, $31, $31
    db  $10, $11,   1
    db  $11, $11, $11
    db    0, $10,   1
    db    1, $10, $30
    db    0, $30, $21
    db  $11, $20, $20
    db  $10, $31, $31
    db  $10, $10, $10
    db    0, $31, $20
    db    1, $31,   0
    db    1, $20, $10
    db  $10, $30, $30
    db  $10, $31, $41
    db    0, $21, $31
    db    0, $11, $41
    db    0, $11, $20
    db    1, $31, $31
    db    0, $11, $31
    db    1, $21, $30
    db  $10, $30, $20
    db    1,   1, $20
    db  $10, $21,   1
    db    0,   1, $40
    db  $10,   0, $20
    db  $11,   1,   0
    db    0, $20, $30
    db  $11,   0,   0
    db  $11, $21, $10
    db    1, $21, $10
    db    0, $30, $30
    db  $10, $10, $21
    db    0, $11, $10
    db    1, $21, $40
    db    0, $30, $31
    db    0, $21, $10
    db    0, $31, $30
    db    1, $31, $41
    db  $11,   0, $31
    db    0, $30, $40
    db  $10, $11, $40
    db    1, $20,   0
    db  $10, $20,   0
    db    1, $11, $41
    db  $10, $20, $30
    db  $10, $10, $40
    db  $11, $31, $20
    db    1, $30, $20
    db  $10, $21, $30
    db  $10, $20, $40
    db  $11, $31, $30
    db  $10, $31, $20
    db    1, $11, $10
    db  $11, $10, $41
    db    0, $10, $41
    db    1, $10, $10
    db    1, $20, $11
    db    1, $20, $41
    db  $10, $10, $41
    db  $11, $21, $41
    db  $10, $11, $21
    db  $11, $20,   1
    db    0,   0,   0
    db  $10,   1, $10
    db  $11,   1, $21
    db    1,   1, $11
    db    1, $21, $11
    db    0, $10, $20
    db  $11, $21, $31
    db  $11, $31, $10
    db  $11,   1, $41
    db    0,   1, $30
    db    0, $31,   0
    db    0, $11, $40
    db  $11,   1, $11
    db  $11,   0,   1
    db  $10,   0, $21
    db  $11,   0, $20
    db    0, $11,   1
    db  $11, $21, $20
    db  $11, $30, $11
    db    0, $30, $11
    db    1, $30, $21
    db  $11, $10, $40
    db  $10,   1, $41
    db  $11, $31, $11
    db  $11,   1, $20
    db    0,   1,   0
    db    1, $20, $31
    db    1, $31, $40
    db  $10,   1, $21
    db    0,   0, $11
    db  $10, $30,   1
    db    1,   0, $41
    db    0,   0, $21
    db    1, $10, $41
    db    1, $20, $20
    db  $11, $10,   1
    db    1, $30,   0
    db    1, $30, $11
    db  $10, $30, $41
    db  $10, $11,   0
    db  $11,   1, $30
    db  $11, $30, $40
    db    0,   1, $31
    db  $10,   1,   0
    db  $10,   0, $10
    db    1, $11,   1
    db    1, $11, $20
    db    1, $10, $21
    db  $10,   0, $40
    db  $10, $31,   0
    db    0, $10,   0
    db  $11, $11, $20
    db    1, $31, $11
    db    1,   1, $10
    db  $11, $11,   1
    db  $10,   0, $31
    db    1, $21,   0
    db  $11, $10, $21
    db    0, $11, $21
    db  $10,   1, $20
    db    0,   1, $10
    db  $11,   0, $21
    db  $10, $30, $40
    db    1, $10, $20
    db    1,   0, $20
    db  $10, $10, $31
    db    0, $10, $10
    db  $11, $21, $11
    db    1, $11, $31
    db  $11, $11,   0
    db    1, $11, $11
    db  $10, $30, $21
    db  $11,   1,   1
    db  $11, $20, $31
    db    0, $10, $31
    db  $10, $11, $11
    db  $11, $30, $20
    db    1, $20, $30
    db    0, $20, $10
    db  $11, $30,   0
    db    1, $30, $31
    db    0, $20,   1
    db    1,   1, $21
    db    0,   0,   1
    db  $10, $31, $10
    db  $10, $20, $41
    db  $10, $30, $10
    db  $11, $10, $30
    db    1,   0, $10
    db  $10, $21, $21
    db  $11, $20, $30
    db    0,   0, $31
    db  $10, $21, $11
    db  $10, $30, $11
    db    0, $31, $40
    db  $10, $11, $20
    db  $10, $11, $30
    db  $11, $31, $41
    db    1, $20, $21
    db    1, $31, $30

;This look-up table is used to decode all non-special digits of the phone number
;into a 32-bit value called the seed. Each entry within the metatable
;corresponds to the nth digit within the phone number (not counting special
;digits like *, #, or spacers like -.) It points to a 10-entry table of LE32-bit
;values, one for each possible digit from zero to nine. Each digit's table value
;is added together to produce the final result.
ContactEnlist_SeedPatternMetatable::
    dw .table_digit0
    dw .table_digit1
    dw .table_digit2
    dw .table_digit3
    dw .table_digit4
    dw .table_digit5
    dw .table_digit6
    dw .table_digit7
    
.table_digit0
    dl 1, 2, 3, 4, 5, 6, 7, 8, 9
    
.table_digit1
    dl $A, $14, $1E, $28, $32, $3C, $46, $50, $5A
    
.table_digit2
    dl $64, $C8, $12C, $190, $1F4, $258, $2BC, $320, $384
    
.table_digit3
    dl $3E8, $7D0, $BB8, $FA0, $1388, $1770, $1B58, $1F40, $2328
    
.table_digit4
    dl $2710, $4E20, $7530, $9C40, $C350, $EA60, $11170, $13880, $15F90

.table_digit5
    dl $186A0, $30D40, $493E0, $61A80, $7A120, $927C0, $AAE60, $C3500, $DBBA0
    
.table_digit6
    dl $F4240, $1E8480, $2DC6C0, $3D0900, $4C4B40, $5B8D80, $6ACFC0, $7A1200, $895440
    
.table_digit7
    dl $989680, $1312D00, $1C9C380, $2625A00, $2FAF080, $3938700, $42C1D80, $4C4B400, $55D4A80