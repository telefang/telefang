INCLUDE "telefang.inc"

SECTION "CGB Background Palette Data", ROMX[$4000], BANK[$7]
LCDC_CGB_BGPaletteTable::
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $1, $1, $1, $1, $1, $1, $1, $1
    dpalette $39C, $39D, $39E, $39F, $3A0, $3A1, $3A2, $3A3
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $3A8, $3A9, $3AA, $3AB, $3AC, $3AD, $3AE, $3AF
    dpalette $F8, $F9, $FA, $FB, $FC, $FD, $24F, $8F
    dpalette $F0, $F1, $24F, $F3, $F4, $F5, $F6, $8F
    dpalette $8F, $45, $42, $1E0, $1E0, $1E0, $1E0, $47
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
    dpalette $13, $14, $15, $16, $17, $F, $0, $F
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $20, $21, $22, $23, $24, $25, $26, $27
    dpalette $50, $36, $52, $53, $54, $55, $56, $57
    dpalette $318, $319, $31A, $31B, $31C, $31D, $31E, $31F
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $36, $37, $38, $39, $3A, $3B, $3C, $3D
    dpalette $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
    dpalette $40, $36, $42, $43, $44, $45, $46, $47
;Save Corruption Error Screen
    dpalette $48, $49, $4A, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $2E0, $2E1, $2E2, $2E3, $2E4, $2E5, $2E6, $2E7
    dpalette $2E8, $2E9, $2EA, $2EB, $2EC, $2ED, $2EE, $2EF
    dpalette $2F0, $2F1, $2F2, $2F3, $2F4, $2F5, $2F6, $2F7
    dpalette $2F8, $2F9, $2FA, $2FB, $2FC, $2FD, $2FE, $2FF
    dpalette $300, $301, $302, $303, $304, $305, $306, $307
    dpalette $308, $309, $30A, $30B, $30C, $30D, $30E, $30F
    dpalette $310, $311, $312, $313, $314, $315, $316, $317
    dpalette $350, $351, $352, $353, $354, $355, $356, $357
    dpalette $358, $359, $35A, $35B, $35C, $35D, $35E, $35F
    dpalette $360, $361, $362, $363, $364, $365, $366, $367
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $330, $331, $332, $333, $334, $335, $336, $337
    dpalette $338, $339, $33A, $33B, $33C, $33D, $33E, $F
    dpalette $340, $341, $342, $343, $344, $345, $346, $347
    dpalette $348, $349, $34A, $34B, $34C, $34D, $34E, $34F
    dpalette $370, $371, $372, $373, $374, $375, $376, $377
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
    dpalette $80, $81, $82, $83, $84, $85, $86, $87
    dpalette $90, $91, $92, $93, $94, $95, $96, $97
    dpalette $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    dpalette $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7
    dpalette $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
    dpalette $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7
    dpalette $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
    dpalette $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7
    dpalette $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
    dpalette $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7
    dpalette $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
    dpalette $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7
    dpalette $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
    dpalette $70, $71, $72, $73, $74, $75, $76, $77
    dpalette $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
    dpalette $250, $251, $252, $253, $254, $8D, $8E, $8F
    dpalette $255, $256, $257, $258, $259, $8D, $8E, $8F
    dpalette $25A, $25B, $25C, $25D, $25E, $8D, $8E, $8F
    dpalette $25F, $260, $261, $262, $263, $8D, $8E, $8F
    dpalette $264, $265, $266, $267, $268, $8D, $8E, $8F
    dpalette $269, $26A, $26B, $26C, $26D, $8D, $8E, $8F
    dpalette $26E, $26F, $270, $271, $272, $8D, $8E, $8F
    dpalette $273, $274, $275, $276, $277, $8D, $8E, $8F
    dpalette $278, $279, $27A, $27B, $27C, $8D, $8E, $8F
    dpalette $27D, $27E, $27F, $280, $281, $8D, $8E, $8F
    dpalette $282, $283, $284, $285, $286, $8D, $8E, $8F
    dpalette $287, $288, $289, $28A, $28B, $8D, $8E, $8F
    dpalette $28C, $28D, $28E, $28F, $290, $8D, $8E, $8F
    dpalette $291, $292, $293, $294, $295, $8D, $8E, $8F
    dpalette $296, $297, $298, $299, $29A, $8D, $8E, $8F
    dpalette $29B, $29C, $29D, $29E, $29F, $8D, $8E, $8F
    dpalette $2A0, $2A1, $2A2, $2A3, $2A4, $8D, $8E, $8F
    dpalette $2A5, $2A6, $2A7, $2A8, $2A9, $8D, $8E, $8F
    dpalette $2AA, $2AB, $2AC, $2AD, $2AE, $8D, $8E, $8F
    dpalette $2AF, $2B0, $2B1, $2B2, $2B3, $8D, $8E, $8F
    dpalette $2B4, $2B5, $2B6, $2B7, $2B8, $8D, $8E, $8F
    dpalette $2B9, $2BA, $2BB, $2BC, $2BD, $8D, $8E, $8F
    dpalette $2BE, $2BF, $2C0, $2C1, $2C2, $8D, $8E, $8F
    dpalette $2C3, $2C4, $2C5, $2C6, $2C7, $8D, $8E, $8F
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0

SECTION "CGB Background Color Data", ROMX[$4000], BANK[$d]
LCDC_CGB_BGColorTable::
;Palette 0
    dcolor 31, 31, 31
    dcolor 31, 31, 31
    dcolor 31, 31, 31
    dcolor 31, 31, 31
;Palette 1
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 0, 31, 31
    dcolor 0, 0, 0
;Palette 3
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 31, 31, 0
    dcolor 0, 0, 0
;Palette 4
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 31, 0, 0
    dcolor 0, 0, 0
;Palette 5
    dcolor 31, 31, 31
    dcolor 31, 23, 10
    dcolor 31, 8, 6
    dcolor 24, 0, 0
;Palette 6
    dcolor 28, 28, 28
    dcolor 31, 29, 16
    dcolor 20, 4, 4
    dcolor 0, 0, 0
;Palette 7
    dcolor 28, 28, 28
    dcolor 4, 19, 5
    dcolor 20, 4, 4
    dcolor 0, 0, 0
;Palette 8
    dcolor 28, 28, 28
    dcolor 31, 29, 16
    dcolor 31, 18, 11
    dcolor 0, 0, 0
;Palette 9
    dcolor 28, 28, 28
    dcolor 17, 31, 17
    dcolor 0, 23, 0
    dcolor 0, 0, 0
;Palette A
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette B
    dcolor 31, 21, 4
    dcolor 30, 30, 30
    dcolor 31, 0, 0
    dcolor 0, 0, 0
;Palette C
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 10
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 11
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 12
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 13
    dcolor 31, 31, 31
    dcolor 24, 28, 31
    dcolor 17, 25, 31
    dcolor 10, 23, 31
;Palette 14
    dcolor 31, 31, 31
    dcolor 26, 12, 12
    dcolor 26, 2, 2
    dcolor 0, 0, 0
;Palette 15
    dcolor 31, 31, 31
    dcolor 28, 26, 23
    dcolor 25, 17, 13
    dcolor 2, 2, 2
;Palette 16
    dcolor 31, 31, 31
    dcolor 5, 18, 2
    dcolor 2, 13, 1
    dcolor 0, 8, 0
;Palette 17
    dcolor 31, 31, 31
    dcolor 22, 26, 21
    dcolor 13, 22, 11
    dcolor 5, 18, 2
;Palette 18
    dcolor 31, 21, 4
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 3, 3, 3
;Palette 19
    dcolor 31, 31, 31
    dcolor 25, 25, 25
    dcolor 31, 21, 11
    dcolor 0, 0, 0
;Palette 1A
    dcolor 20, 21, 14
    dcolor 25, 25, 30
    dcolor 10, 12, 22
    dcolor 0, 0, 0
;Palette 1B
    dcolor 31, 21, 11
    dcolor 17, 26, 20
    dcolor 12, 18, 9
    dcolor 0, 0, 0
;Palette 1C
    dcolor 31, 31, 31
    dcolor 31, 0, 31
    dcolor 0, 10, 31
    dcolor 0, 0, 0
;Palette 1D
    dcolor 31, 31, 31
    dcolor 19, 30, 22
    dcolor 7, 23, 9
    dcolor 0, 3, 2
;Palette 1E
    dcolor 0, 0, 0
    dcolor 0, 0, 31
    dcolor 0, 10, 31
    dcolor 0, 21, 31
;Palette 1F
    dcolor 0, 0, 0
    dcolor 0, 0, 31
    dcolor 0, 10, 31
    dcolor 0, 21, 31
;Palette 20
    dcolor 31, 31, 31
    dcolor 21, 21, 21
    dcolor 12, 12, 12
    dcolor 0, 0, 0
;Palette 21
    dcolor 31, 31, 31
    dcolor 31, 26, 26
    dcolor 31, 11, 11
    dcolor 31, 1, 1
;Palette 22
    dcolor 31, 31, 31
    dcolor 31, 20, 0
    dcolor 31, 8, 0
    dcolor 18, 2, 0
;Palette 23
    dcolor 31, 31, 31
    dcolor 18, 29, 29
    dcolor 9, 25, 25
    dcolor 0, 22, 22
;Palette 24
    dcolor 31, 31, 31
    dcolor 22, 28, 30
    dcolor 11, 24, 28
    dcolor 0, 17, 26
;Palette 25
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 26
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 27
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 28
    dcolor 30, 30, 30
    dcolor 22, 22, 22
    dcolor 14, 14, 14
    dcolor 4, 4, 4
;Palette 29
    dcolor 31, 31, 31
    dcolor 20, 21, 14
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 2A
    dcolor 8, 24, 15
    dcolor 8, 19, 16
    dcolor 8, 12, 5
    dcolor 0, 0, 0
;Palette 2B
    dcolor 26, 21, 18
    dcolor 20, 18, 16
    dcolor 12, 10, 8
    dcolor 0, 0, 0
;Palette 2C
    dcolor 29, 29, 17
    dcolor 10, 20, 2
    dcolor 0, 15, 18
    dcolor 2, 7, 4
;Palette 2D
    dcolor 24, 31, 31
    dcolor 0, 15, 18
    dcolor 5, 9, 12
    dcolor 0, 0, 0
;Palette 2E
    dcolor 29, 29, 17
    dcolor 23, 10, 9
    dcolor 15, 6, 5
    dcolor 0, 0, 0
;Palette 2F
    dcolor 2, 9, 2
    dcolor 5, 19, 4
    dcolor 30, 30, 17
    dcolor 0, 0, 0
;Palette 30
    dcolor 31, 31, 31
    dcolor 31, 25, 17
    dcolor 27, 14, 0
    dcolor 8, 2, 0
;Palette 31
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 20, 13, 0
    dcolor 8, 4, 0
;Palette 32
    dcolor 31, 31, 31
    dcolor 31, 26, 12
    dcolor 28, 18, 2
    dcolor 9, 2, 0
;Palette 33
    dcolor 31, 31, 31
    dcolor 25, 27, 31
    dcolor 18, 23, 31
    dcolor 4, 13, 5
;Palette 34
    dcolor 31, 31, 31
    dcolor 20, 31, 24
    dcolor 28, 28, 11
    dcolor 10, 23, 17
;Palette 35
    dcolor 31, 31, 31
    dcolor 27, 26, 27
    dcolor 20, 21, 14
    dcolor 4, 4, 4
;Palette 36
    dcolor 31, 31, 31
    dcolor 22, 26, 26
    dcolor 17, 18, 23
    dcolor 2, 2, 2
;Palette 37
    dcolor 30, 30, 30
    dcolor 26, 22, 31
    dcolor 20, 15, 21
    dcolor 4, 4, 4
;Palette 38
    dcolor 31, 31, 31
    dcolor 31, 31, 31
    dcolor 31, 31, 31
    dcolor 0, 0, 0
;Palette 39
    dcolor 31, 31, 31
    dcolor 31, 24, 5
    dcolor 0, 1, 31
    dcolor 0, 0, 0
;Palette 3A
    dcolor 31, 31, 31
    dcolor 0, 0, 31
    dcolor 31, 31, 31
    dcolor 0, 0, 0
;Palette 3B
    dcolor 31, 31, 31
    dcolor 31, 27, 9
    dcolor 31, 21, 4
    dcolor 13, 3, 1
;Palette 3C
    dcolor 31, 31, 31
    dcolor 21, 27, 31
    dcolor 11, 15, 26
    dcolor 2, 3, 22
;Palette 3D
    dcolor 28, 0, 0
    dcolor 0, 26, 0
    dcolor 31, 25, 31
    dcolor 0, 0, 0
;Palette 3E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 3F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 40
    dcolor 31, 31, 31
    dcolor 31, 0, 0
    dcolor 31, 16, 31
    dcolor 0, 0, 0
;Palette 41
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 0, 31, 31
    dcolor 0, 0, 0
;Palette 42
    dcolor 31, 31, 31
    dcolor 31, 26, 12
    dcolor 0, 31, 31
    dcolor 0, 0, 0
;Palette 43
    dcolor 31, 31, 31
    dcolor 25, 27, 31
    dcolor 18, 23, 31
    dcolor 0, 0, 0
;Palette 44
    dcolor 31, 31, 31
    dcolor 20, 31, 24
    dcolor 0, 29, 29
    dcolor 0, 0, 0
;Palette 45
    dcolor 31, 21, 4
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 3, 3, 3
;Palette 46
    dcolor 31, 14, 31
    dcolor 31, 25, 17
    dcolor 27, 14, 0
    dcolor 8, 2, 0
;Palette 47
    dcolor 14, 14, 31
    dcolor 25, 27, 31
    dcolor 18, 23, 31
    dcolor 0, 0, 1
;Palette 48 - Save Corruption Error Screen
    dcolor 31, 29, 16
    dcolor 20, 4, 4
    dcolor 4, 19, 5
    dcolor 0, 0, 0
;Palette 49 - Save Corruption Error Screen
    dcolor 31, 29, 16
    dcolor 31, 18, 11
    dcolor 20, 4, 4
    dcolor 0, 0, 0
;Palette 4A - Save Corruption Error Screen
    dcolor 31, 31, 31
    dcolor 20, 4, 4
    dcolor 8, 2, 2
    dcolor 0, 0, 0
;Palette 4B
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4C
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 50
    dcolor 31, 31, 31
    dcolor 31, 25, 17
    dcolor 27, 14, 0
    dcolor 8, 2, 0
;Palette 51
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 20, 13, 0
    dcolor 8, 4, 0
;Palette 52
    dcolor 31, 31, 31
    dcolor 31, 26, 12
    dcolor 28, 18, 2
    dcolor 9, 2, 0
;Palette 53
    dcolor 31, 31, 31
    dcolor 25, 27, 31
    dcolor 18, 23, 31
    dcolor 4, 13, 5
;Palette 54
    dcolor 31, 31, 31
    dcolor 20, 31, 24
    dcolor 28, 28, 11
    dcolor 10, 23, 17
;Palette 55
    dcolor 31, 21, 4
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 0, 0, 0
;Palette 56
    dcolor 31, 14, 31
    dcolor 31, 25, 17
    dcolor 27, 14, 0
    dcolor 8, 2, 0
;Palette 57
    dcolor 14, 14, 31
    dcolor 25, 27, 31
    dcolor 18, 23, 31
    dcolor 0, 0, 1
;Palette 58
    dcolor 31, 31, 31
    dcolor 31, 25, 17
    dcolor 27, 14, 0
    dcolor 8, 2, 0
;Palette 59
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 20, 13, 0
    dcolor 8, 4, 0
;Palette 5A
    dcolor 31, 31, 31
    dcolor 31, 26, 12
    dcolor 28, 18, 2
    dcolor 9, 2, 0
;Palette 5B
    dcolor 31, 31, 31
    dcolor 25, 27, 31
    dcolor 18, 23, 31
    dcolor 4, 13, 5
;Palette 5C
    dcolor 31, 31, 31
    dcolor 31, 31, 20
    dcolor 21, 31, 19
    dcolor 9, 26, 8
;Palette 5D
    dcolor 31, 14, 0
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 0, 0, 0
;Palette 5E
    dcolor 31, 14, 31
    dcolor 31, 25, 17
    dcolor 27, 14, 0
    dcolor 8, 2, 0
;Palette 5F
    dcolor 14, 14, 31
    dcolor 25, 27, 31
    dcolor 18, 23, 31
    dcolor 0, 0, 1
;Palette 60
    dcolor 31, 31, 31
    dcolor 25, 27, 31
    dcolor 18, 23, 31
    dcolor 4, 13, 5
;Palette 61
    dcolor 31, 31, 31
    dcolor 20, 31, 24
    dcolor 28, 28, 11
    dcolor 10, 23, 17
;Palette 62
    dcolor 31, 31, 31
    dcolor 1, 11, 7
    dcolor 1, 7, 4
    dcolor 2, 4, 1
;Palette 63
    dcolor 31, 31, 31
    dcolor 28, 22, 8
    dcolor 9, 20, 12
    dcolor 4, 11, 6
;Palette 64
    dcolor 31, 31, 31
    dcolor 1, 11, 7
    dcolor 1, 7, 4
    dcolor 2, 4, 1
;Palette 65
    dcolor 31, 31, 31
    dcolor 16, 20, 31
    dcolor 9, 12, 19
    dcolor 3, 4, 8
;Palette 66
    dcolor 31, 31, 31
    dcolor 1, 11, 7
    dcolor 1, 7, 4
    dcolor 2, 4, 1
;Palette 67
    dcolor 31, 31, 31
    dcolor 16, 20, 31
    dcolor 9, 12, 19
    dcolor 3, 4, 8
;Palette 68
    dcolor 31, 31, 31
    dcolor 22, 23, 23
    dcolor 13, 16, 15
    dcolor 4, 9, 8
;Palette 69
    dcolor 31, 31, 31
    dcolor 18, 23, 23
    dcolor 4, 11, 12
    dcolor 2, 4, 7
;Palette 6A
    dcolor 31, 31, 31
    dcolor 23, 26, 30
    dcolor 15, 21, 29
    dcolor 8, 17, 29
;Palette 6B
    dcolor 31, 31, 31
    dcolor 24, 29, 27
    dcolor 17, 28, 23
    dcolor 10, 27, 20
;Palette 6C
    dcolor 31, 31, 31
    dcolor 23, 25, 29
    dcolor 15, 19, 27
    dcolor 7, 14, 26
;Palette 6D
    dcolor 31, 31, 31
    dcolor 28, 26, 23
    dcolor 26, 22, 16
    dcolor 24, 18, 9
;Palette 6E
    dcolor 31, 31, 31
    dcolor 23, 25, 29
    dcolor 15, 19, 27
    dcolor 7, 14, 26
;Palette 6F
    dcolor 31, 31, 31
    dcolor 28, 26, 23
    dcolor 26, 22, 16
    dcolor 24, 18, 9
;Palette 70
    dcolor 30, 22, 20
    dcolor 27, 13, 6
    dcolor 8, 4, 0
    dcolor 0, 0, 0
;Palette 71
    dcolor 31, 31, 18
    dcolor 25, 22, 12
    dcolor 21, 12, 7
    dcolor 7, 1, 0
;Palette 72
    dcolor 21, 23, 31
    dcolor 4, 8, 27
    dcolor 5, 1, 16
    dcolor 0, 0, 7
;Palette 73
    dcolor 26, 27, 19
    dcolor 17, 15, 4
    dcolor 8, 7, 0
    dcolor 0, 0, 0
;Palette 74
    dcolor 24, 31, 31
    dcolor 15, 23, 23
    dcolor 8, 15, 15
    dcolor 0, 8, 8
;Palette 75
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette 76
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette 77
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 78
    dcolor 24, 31, 19
    dcolor 15, 23, 12
    dcolor 8, 15, 3
    dcolor 0, 0, 0
;Palette 79
    dcolor 24, 15, 2
    dcolor 17, 7, 2
    dcolor 7, 2, 0
    dcolor 4, 1, 0
;Palette 7A
    dcolor 30, 8, 7
    dcolor 28, 3, 3
    dcolor 15, 1, 1
    dcolor 0, 0, 1
;Palette 7B
    dcolor 26, 27, 19
    dcolor 17, 15, 4
    dcolor 8, 7, 0
    dcolor 0, 0, 0
;Palette 7C
    dcolor 24, 31, 31
    dcolor 12, 24, 31
    dcolor 8, 5, 18
    dcolor 0, 2, 10
;Palette 7D
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette 7E
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette 7F
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 80
    dcolor 30, 30, 30
    dcolor 22, 22, 22
    dcolor 14, 14, 14
    dcolor 0, 0, 0
;Palette 81
    dcolor 2, 9, 2
    dcolor 5, 19, 4
    dcolor 30, 30, 17
    dcolor 0, 0, 0
;Palette 82
    dcolor 8, 24, 15
    dcolor 8, 19, 16
    dcolor 8, 12, 5
    dcolor 0, 0, 0
;Palette 83
    dcolor 26, 21, 18
    dcolor 20, 18, 16
    dcolor 12, 10, 8
    dcolor 0, 0, 0
;Palette 84
    dcolor 29, 29, 17
    dcolor 10, 20, 2
    dcolor 0, 15, 18
    dcolor 2, 7, 4
;Palette 85
    dcolor 24, 31, 31
    dcolor 0, 15, 18
    dcolor 5, 9, 12
    dcolor 0, 0, 0
;Palette 86
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette 87
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 88
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette 89
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 6, 0, 0
;Palette 8A
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 6, 0, 0
;Palette 8B
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 6, 0, 0
;Palette 8C
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 6, 0, 0
;Palette 8D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 8E
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette 8F
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 90
    dcolor 31, 31, 17
    dcolor 31, 22, 0
    dcolor 18, 10, 0
    dcolor 0, 0, 0
;Palette 91
    dcolor 4, 21, 16
    dcolor 4, 16, 14
    dcolor 4, 12, 14
    dcolor 2, 5, 11
;Palette 92
    dcolor 4, 21, 16
    dcolor 4, 14, 10
    dcolor 5, 7, 5
    dcolor 6, 0, 0
;Palette 93
    dcolor 18, 21, 31
    dcolor 5, 11, 20
    dcolor 0, 2, 8
    dcolor 0, 0, 0
;Palette 94
    dcolor 31, 23, 21
    dcolor 20, 6, 0
    dcolor 9, 0, 0
    dcolor 0, 0, 0
;Palette 95
    dcolor 24, 31, 31
    dcolor 0, 15, 18
    dcolor 5, 9, 12
    dcolor 0, 0, 0
;Palette 96
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette 97
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 98
    dcolor 31, 29, 19
    dcolor 30, 23, 7
    dcolor 23, 10, 1
    dcolor 0, 0, 0
;Palette 99
    dcolor 31, 26, 15
    dcolor 20, 13, 5
    dcolor 10, 6, 0
    dcolor 0, 0, 0
;Palette 9A
    dcolor 21, 31, 31
    dcolor 10, 17, 31
    dcolor 0, 3, 18
    dcolor 0, 0, 0
;Palette 9B
    dcolor 21, 31, 31
    dcolor 16, 26, 31
    dcolor 4, 10, 31
    dcolor 0, 0, 0
;Palette 9C
    dcolor 31, 23, 20
    dcolor 29, 12, 10
    dcolor 14, 1, 0
    dcolor 0, 0, 0
;Palette 9D
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette 9E
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette 9F
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette A0
    dcolor 19, 27, 31
    dcolor 9, 13, 23
    dcolor 2, 5, 13
    dcolor 0, 0, 0
;Palette A1
    dcolor 28, 29, 19
    dcolor 17, 18, 4
    dcolor 10, 11, 0
    dcolor 0, 0, 0
;Palette A2
    dcolor 31, 31, 18
    dcolor 25, 22, 12
    dcolor 21, 12, 7
    dcolor 7, 1, 0
;Palette A3
    dcolor 31, 23, 19
    dcolor 27, 8, 0
    dcolor 15, 1, 0
    dcolor 0, 0, 0
;Palette A4
    dcolor 25, 19, 2
    dcolor 19, 14, 0
    dcolor 12, 10, 0
    dcolor 4, 0, 0
;Palette A5
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette A6
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette A7
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette A8
    dcolor 24, 27, 31
    dcolor 7, 17, 26
    dcolor 0, 7, 16
    dcolor 0, 0, 0
;Palette A9
    dcolor 31, 31, 18
    dcolor 25, 22, 12
    dcolor 21, 12, 7
    dcolor 7, 1, 0
;Palette AA
    dcolor 31, 23, 19
    dcolor 27, 8, 0
    dcolor 15, 1, 0
    dcolor 0, 0, 0
;Palette AB
    dcolor 26, 27, 19
    dcolor 17, 15, 4
    dcolor 8, 7, 0
    dcolor 0, 0, 0
;Palette AC
    dcolor 24, 31, 19
    dcolor 15, 23, 12
    dcolor 8, 15, 3
    dcolor 0, 8, 0
;Palette AD
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette AE
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette AF
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette B0
    dcolor 31, 31, 31
    dcolor 20, 20, 20
    dcolor 10, 10, 10
    dcolor 0, 0, 0
;Palette B1
    dcolor 21, 26, 31
    dcolor 9, 13, 20
    dcolor 0, 5, 11
    dcolor 0, 0, 0
;Palette B2
    dcolor 31, 31, 26
    dcolor 27, 27, 18
    dcolor 20, 20, 10
    dcolor 12, 12, 4
;Palette B3
    dcolor 31, 21, 14
    dcolor 22, 8, 0
    dcolor 15, 3, 0
    dcolor 0, 0, 0
;Palette B4
    dcolor 24, 31, 16
    dcolor 14, 20, 7
    dcolor 6, 13, 0
    dcolor 0, 8, 0
;Palette B5
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette B6
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette B7
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette B8
    dcolor 31, 31, 31
    dcolor 20, 20, 20
    dcolor 10, 10, 10
    dcolor 0, 0, 0
;Palette B9
    dcolor 31, 31, 15
    dcolor 12, 25, 6
    dcolor 5, 15, 2
    dcolor 3, 7, 0
;Palette BA
    dcolor 31, 31, 15
    dcolor 22, 15, 9
    dcolor 13, 6, 1
    dcolor 6, 1, 0
;Palette BB
    dcolor 19, 27, 31
    dcolor 9, 13, 23
    dcolor 2, 5, 13
    dcolor 0, 0, 0
;Palette BC
    dcolor 31, 31, 18
    dcolor 23, 5, 0
    dcolor 13, 3, 0
    dcolor 7, 0, 0
;Palette BD
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette BE
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette BF
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette C0
    dcolor 31, 24, 21
    dcolor 22, 9, 1
    dcolor 12, 3, 0
    dcolor 0, 0, 0
;Palette C1
    dcolor 21, 26, 31
    dcolor 9, 13, 20
    dcolor 0, 5, 11
    dcolor 0, 0, 0
;Palette C2
    dcolor 31, 31, 26
    dcolor 27, 27, 18
    dcolor 20, 20, 10
    dcolor 12, 12, 4
;Palette C3
    dcolor 31, 31, 7
    dcolor 27, 17, 3
    dcolor 15, 3, 0
    dcolor 8, 0, 0
;Palette C4
    dcolor 24, 31, 16
    dcolor 14, 20, 7
    dcolor 6, 13, 0
    dcolor 0, 8, 0
;Palette C5
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette C6
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette C7
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette C8
    dcolor 31, 20, 19
    dcolor 26, 12, 7
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette C9
    dcolor 16, 18, 31
    dcolor 12, 16, 25
    dcolor 3, 2, 13
    dcolor 6, 0, 0
;Palette CA
    dcolor 27, 30, 31
    dcolor 18, 22, 25
    dcolor 0, 7, 11
    dcolor 0, 2, 6
;Palette CB
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 6, 0, 0
;Palette CC
    dcolor 31, 28, 12
    dcolor 5, 19, 10
    dcolor 5, 11, 5
    dcolor 1, 7, 0
;Palette CD
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette CE
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette CF
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette D0
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette D1
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 6, 0, 0
;Palette D2
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 6, 0, 0
;Palette D3
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 6, 0, 0
;Palette D4
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 6, 0, 0
;Palette D5
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette D6
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette D7
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette D8
    dcolor 31, 31, 31
    dcolor 20, 20, 20
    dcolor 10, 10, 10
    dcolor 0, 0, 0
;Palette D9
    dcolor 20, 27, 31
    dcolor 4, 19, 23
    dcolor 3, 7, 17
    dcolor 0, 4, 11
;Palette DA
    dcolor 31, 28, 18
    dcolor 19, 12, 6
    dcolor 12, 6, 0
    dcolor 0, 0, 0
;Palette DB
    dcolor 31, 21, 18
    dcolor 20, 8, 0
    dcolor 10, 5, 0
    dcolor 5, 0, 0
;Palette DC
    dcolor 31, 31, 16
    dcolor 17, 26, 8
    dcolor 9, 14, 0
    dcolor 0, 7, 0
;Palette DD
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette DE
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette DF
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette E0
    dcolor 30, 27, 24
    dcolor 27, 17, 6
    dcolor 16, 7, 0
    dcolor 0, 0, 0
;Palette E1
    dcolor 31, 31, 18
    dcolor 25, 22, 12
    dcolor 21, 12, 7
    dcolor 7, 1, 0
;Palette E2
    dcolor 18, 23, 31
    dcolor 0, 8, 27
    dcolor 0, 1, 15
    dcolor 0, 0, 1
;Palette E3
    dcolor 26, 27, 19
    dcolor 17, 15, 4
    dcolor 8, 7, 0
    dcolor 0, 0, 0
;Palette E4
    dcolor 24, 31, 19
    dcolor 15, 23, 12
    dcolor 8, 15, 3
    dcolor 0, 8, 0
;Palette E5
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette E6
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette E7
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette E8
    dcolor 24, 31, 19
    dcolor 15, 23, 12
    dcolor 8, 15, 3
    dcolor 0, 0, 0
;Palette E9
    dcolor 31, 31, 18
    dcolor 25, 22, 12
    dcolor 21, 12, 7
    dcolor 7, 1, 0
;Palette EA
    dcolor 31, 23, 30
    dcolor 9, 16, 22
    dcolor 0, 1, 15
    dcolor 0, 0, 5
;Palette EB
    dcolor 26, 27, 19
    dcolor 17, 15, 4
    dcolor 8, 7, 0
    dcolor 0, 0, 0
;Palette EC
    dcolor 31, 23, 19
    dcolor 27, 8, 0
    dcolor 15, 1, 0
    dcolor 0, 0, 0
;Palette ED
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette EE
    dcolor 31, 31, 31
    dcolor 20, 21, 29
    dcolor 14, 14, 19
    dcolor 4, 4, 4
;Palette EF
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette F0
    dcolor 26, 15, 17
    dcolor 13, 18, 26
    dcolor 28, 22, 0
    dcolor 8, 25, 14
;Palette F1
    dcolor 0, 0, 0
    dcolor 0, 8, 31
    dcolor 0, 0, 17
    dcolor 15, 25, 31
;Palette F2
    dcolor 7, 20, 31
    dcolor 9, 15, 31
    dcolor 27, 15, 5
    dcolor 3, 6, 16
;Palette F3
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F4
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F5
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F6
    dcolor 0, 0, 0
    dcolor 23, 23, 31
    dcolor 15, 15, 20
    dcolor 11, 11, 11
;Palette F7
    dcolor 0, 0, 0
    dcolor 0, 26, 0
    dcolor 20, 10, 9
    dcolor 11, 11, 11
;Palette F8
    dcolor 31, 31, 19
    dcolor 18, 14, 7
    dcolor 14, 6, 0
    dcolor 0, 0, 0
;Palette F9
    dcolor 31, 31, 19
    dcolor 18, 14, 7
    dcolor 3, 22, 2
    dcolor 0, 0, 0
;Palette FA
    dcolor 31, 31, 19
    dcolor 18, 14, 7
    dcolor 14, 9, 20
    dcolor 0, 0, 0
;Palette FB
    dcolor 31, 31, 19
    dcolor 6, 12, 31
    dcolor 0, 0, 18
    dcolor 0, 0, 0
;Palette FC
    dcolor 31, 31, 19
    dcolor 6, 12, 31
    dcolor 3, 22, 2
    dcolor 0, 0, 0
;Palette FD
    dcolor 31, 31, 19
    dcolor 6, 12, 31
    dcolor 14, 6, 0
    dcolor 0, 0, 0
;Palette FE
    dcolor 0, 0, 0
    dcolor 23, 23, 31
    dcolor 15, 15, 20
    dcolor 11, 11, 11
;Palette FF
    dcolor 0, 0, 0
    dcolor 0, 26, 0
    dcolor 20, 10, 9
    dcolor 11, 11, 11

; In this hole right here, the Denjuu palettes are stored.
; Check gfx/denjuu.asm for those.

SECTION "CGB Background Color Data Part 2", ROMX[$4D78], BANK[$0D]
;Palette 1AF
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1B0
    dcolor 31, 31, 31
    dcolor 31, 23, 18
    dcolor 30, 4, 0
    dcolor 11, 2, 2
;Palette 1B1
    dcolor 31, 31, 31
    dcolor 31, 16, 13
    dcolor 0, 11, 29
    dcolor 4, 3, 7
;Palette 1B2
    dcolor 31, 31, 31
    dcolor 30, 22, 16
    dcolor 26, 15, 15
    dcolor 10, 2, 0
;Palette 1B3
    dcolor 31, 31, 31
    dcolor 30, 23, 18
    dcolor 24, 11, 22
    dcolor 12, 0, 6
;Palette 1B4
    dcolor 31, 31, 31
    dcolor 30, 22, 14
    dcolor 6, 14, 24
    dcolor 0, 2, 15
;Palette 1B5
    dcolor 31, 31, 31
    dcolor 31, 25, 11
    dcolor 31, 16, 3
    dcolor 13, 3, 0
;Palette 1B6
    dcolor 31, 31, 31
    dcolor 31, 23, 11
    dcolor 12, 19, 31
    dcolor 2, 5, 14
;Palette 1B7
    dcolor 31, 31, 31
    dcolor 30, 23, 15
    dcolor 22, 15, 12
    dcolor 13, 4, 0
;Palette 1B8
    dcolor 31, 31, 31
    dcolor 31, 24, 15
    dcolor 31, 17, 0
    dcolor 10, 4, 0
;Palette 1B9
    dcolor 31, 31, 31
    dcolor 31, 22, 19
    dcolor 7, 22, 8
    dcolor 4, 9, 0
;Palette 1BA
    dcolor 31, 31, 31
    dcolor 31, 22, 13
    dcolor 28, 14, 1
    dcolor 11, 4, 2
;Palette 1BB
    dcolor 31, 31, 31
    dcolor 31, 20, 11
    dcolor 3, 4, 26
    dcolor 0, 0, 12
;Palette 1BC
    dcolor 31, 31, 31
    dcolor 31, 20, 16
    dcolor 31, 4, 5
    dcolor 14, 0, 0
;Palette 1BD
    dcolor 31, 31, 31
    dcolor 20, 31, 31
    dcolor 25, 15, 17
    dcolor 0, 0, 12
;Palette 1BE
    dcolor 31, 31, 31
    dcolor 30, 4, 0
    dcolor 31, 23, 18
    dcolor 11, 2, 2
;Palette 1BF
    dcolor 31, 31, 31
    dcolor 13, 26, 31
    dcolor 31, 16, 0
    dcolor 3, 0, 10
;Palette 1C0
    dcolor 31, 31, 31
    dcolor 23, 9, 4
    dcolor 6, 9, 2
    dcolor 10, 0, 0
;Palette 1C1
    dcolor 31, 31, 31
    dcolor 31, 20, 18
    dcolor 27, 4, 4
    dcolor 4, 0, 0
;Palette 1C2
    dcolor 31, 31, 31
    dcolor 26, 20, 13
    dcolor 16, 12, 11
    dcolor 9, 0, 0
;Palette 1C3
    dcolor 31, 31, 31
    dcolor 29, 23, 2
    dcolor 29, 12, 5
    dcolor 5, 2, 0
;Palette 1C4
    dcolor 31, 31, 31
    dcolor 30, 15, 22
    dcolor 31, 21, 12
    dcolor 13, 0, 0
;Palette 1C5
    dcolor 31, 31, 31
    dcolor 27, 17, 9
    dcolor 12, 21, 12
    dcolor 9, 0, 0
;Palette 1C6
    dcolor 31, 31, 31
    dcolor 5, 12, 14
    dcolor 19, 6, 5
    dcolor 3, 4, 3
;Palette 1C7
    dcolor 31, 31, 31
    dcolor 26, 25, 18
    dcolor 4, 11, 21
    dcolor 2, 3, 10
;Palette 1C8
    dcolor 31, 31, 31
    dcolor 31, 30, 21
    dcolor 23, 17, 2
    dcolor 2, 5, 1
;Palette 1C9
    dcolor 31, 31, 31
    dcolor 29, 22, 14
    dcolor 5, 11, 11
    dcolor 5, 0, 0
;Palette 1CA
    dcolor 31, 31, 31
    dcolor 15, 25, 31
    dcolor 8, 14, 26
    dcolor 2, 4, 9
;Palette 1CB
    dcolor 31, 31, 31
    dcolor 31, 24, 16
    dcolor 31, 18, 12
    dcolor 7, 3, 0
;Palette 1CC
    dcolor 31, 31, 31
    dcolor 28, 23, 13
    dcolor 16, 4, 6
    dcolor 8, 0, 0
;Palette 1CD
    dcolor 31, 31, 31
    dcolor 31, 24, 15
    dcolor 4, 10, 19
    dcolor 9, 0, 0
;Palette 1CE
    dcolor 31, 31, 31
    dcolor 31, 10, 5
    dcolor 16, 6, 4
    dcolor 5, 0, 0
;Palette 1CF
    dcolor 31, 31, 31
    dcolor 18, 26, 31
    dcolor 31, 21, 4
    dcolor 12, 1, 0
;Palette 1D0
    dcolor 31, 31, 31
    dcolor 30, 27, 18
    dcolor 30, 18, 21
    dcolor 14, 0, 0
;Palette 1D1
    dcolor 31, 31, 31
    dcolor 30, 22, 14
    dcolor 23, 8, 5
    dcolor 11, 0, 0
;Palette 1D2
    dcolor 31, 31, 31
    dcolor 31, 25, 21
    dcolor 24, 19, 12
    dcolor 12, 3, 0
;Palette 1D3
    dcolor 31, 31, 31
    dcolor 29, 23, 11
    dcolor 27, 9, 6
    dcolor 11, 4, 3
;Palette 1D4
    dcolor 31, 31, 31
    dcolor 31, 21, 11
    dcolor 8, 16, 21
    dcolor 0, 3, 9
;Palette 1D5
    dcolor 31, 31, 31
    dcolor 31, 24, 9
    dcolor 22, 16, 6
    dcolor 11, 6, 2
;Palette 1D6
    dcolor 31, 31, 31
    dcolor 31, 25, 13
    dcolor 28, 18, 5
    dcolor 10, 3, 0
;Palette 1D7
    dcolor 31, 31, 31
    dcolor 31, 21, 6
    dcolor 0, 22, 29
    dcolor 0, 8, 14
;Palette 1D8
    dcolor 31, 31, 31
    dcolor 31, 27, 17
    dcolor 17, 11, 1
    dcolor 8, 0, 0
;Palette 1D9
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1DA
    dcolor 20, 21, 14
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 1DB
    dcolor 31, 31, 31
    dcolor 31, 12, 11
    dcolor 31, 8, 6
    dcolor 31, 0, 0
;Palette 1DC
    dcolor 31, 31, 31
    dcolor 15, 27, 15
    dcolor 0, 21, 0
    dcolor 0, 11, 0
;Palette 1DD
    dcolor 31, 31, 31
    dcolor 10, 24, 31
    dcolor 3, 13, 31
    dcolor 15, 30, 20
;Palette 1DE
    dcolor 31, 31, 31
    dcolor 16, 23, 31
    dcolor 9, 19, 31
    dcolor 23, 27, 31
;Palette 1DF
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1E0
    dcolor 31, 31, 31
    dcolor 27, 15, 23
    dcolor 31, 0, 0
    dcolor 0, 0, 0
;Palette 1E1
    dcolor 31, 31, 31
    dcolor 9, 22, 28
    dcolor 4, 11, 21
    dcolor 2, 3, 10
;Palette 1E2
    dcolor 31, 31, 31
    dcolor 12, 18, 31
    dcolor 8, 8, 23
    dcolor 0, 0, 0
;Palette 1E3
    dcolor 31, 31, 31
    dcolor 4, 17, 5
    dcolor 1, 6, 3
    dcolor 1, 3, 1
;Palette 1E4
    dcolor 31, 31, 31
    dcolor 1, 14, 6
    dcolor 0, 7, 3
    dcolor 0, 0, 0
;Palette 1E5
    dcolor 31, 31, 31
    dcolor 26, 29, 28
    dcolor 14, 18, 26
    dcolor 1, 3, 1
;Palette 1E6
    dcolor 31, 31, 31
    dcolor 18, 23, 31
    dcolor 4, 11, 21
    dcolor 2, 3, 10
;Palette 1E7
    dcolor 31, 31, 31
    dcolor 31, 21, 10
    dcolor 31, 8, 4
    dcolor 14, 1, 1
;Palette 1E8
    dcolor 31, 31, 31
    dcolor 25, 31, 31
    dcolor 14, 20, 31
    dcolor 2, 3, 10
;Palette 1E9
    dcolor 31, 31, 31
    dcolor 15, 24, 31
    dcolor 12, 15, 31
    dcolor 2, 3, 10
;Palette 1EA
    dcolor 31, 31, 31
    dcolor 19, 28, 31
    dcolor 12, 15, 31
    dcolor 2, 3, 10
;Palette 1EB
    dcolor 31, 31, 31
    dcolor 18, 20, 30
    dcolor 12, 15, 31
    dcolor 3, 2, 5
;Palette 1EC
    dcolor 31, 31, 31
    dcolor 12, 15, 31
    dcolor 11, 7, 14
    dcolor 3, 2, 5
;Palette 1ED
    dcolor 31, 31, 31
    dcolor 31, 29, 28
    dcolor 26, 15, 21
    dcolor 3, 2, 5
;Palette 1EE
    dcolor 31, 31, 31
    dcolor 5, 21, 29
    dcolor 0, 3, 21
    dcolor 5, 0, 5
;Palette 1EF
    dcolor 31, 31, 31
    dcolor 31, 31, 23
    dcolor 21, 24, 10
    dcolor 3, 2, 5
;Palette 1F0
    dcolor 31, 31, 31
    dcolor 21, 24, 31
    dcolor 31, 8, 6
    dcolor 3, 2, 5
;Palette 1F1
    dcolor 31, 31, 31
    dcolor 21, 24, 31
    dcolor 12, 13, 28
    dcolor 3, 2, 5
;Palette 1F2
    dcolor 31, 31, 31
    dcolor 9, 20, 31
    dcolor 4, 7, 31
    dcolor 3, 2, 5
;Palette 1F3
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 4, 18, 31
    dcolor 3, 2, 5
;Palette 1F4
    dcolor 31, 31, 31
    dcolor 14, 27, 31
    dcolor 4, 18, 31
    dcolor 3, 2, 5
;Palette 1F5
    dcolor 31, 31, 31
    dcolor 20, 28, 31
    dcolor 31, 8, 6
    dcolor 3, 2, 5
;Palette 1F6
    dcolor 31, 31, 31
    dcolor 19, 26, 31
    dcolor 27, 4, 0
    dcolor 7, 1, 3
;Palette 1F7
    dcolor 31, 31, 31
    dcolor 25, 31, 23
    dcolor 7, 23, 4
    dcolor 1, 6, 1
;Palette 1F8
    dcolor 31, 31, 31
    dcolor 15, 19, 31
    dcolor 31, 8, 6
    dcolor 3, 2, 5
;Palette 1F9
    dcolor 31, 31, 31
    dcolor 27, 14, 0
    dcolor 21, 3, 0
    dcolor 3, 2, 5
;Palette 1FA
    dcolor 31, 31, 31
    dcolor 30, 26, 14
    dcolor 30, 19, 0
    dcolor 3, 2, 5
;Palette 1FB
    dcolor 31, 31, 31
    dcolor 30, 25, 0
    dcolor 30, 14, 0
    dcolor 3, 2, 5
;Palette 1FC
    dcolor 31, 31, 31
    dcolor 31, 29, 15
    dcolor 30, 21, 0
    dcolor 3, 2, 5
;Palette 1FD
    dcolor 31, 31, 31
    dcolor 31, 21, 7
    dcolor 3, 21, 8
    dcolor 3, 2, 5
;Palette 1FE
    dcolor 31, 31, 31
    dcolor 30, 21, 0
    dcolor 31, 8, 6
    dcolor 3, 2, 5
;Palette 1FF
    dcolor 31, 31, 31
    dcolor 31, 27, 12
    dcolor 30, 17, 0
    dcolor 3, 2, 5
;Palette 200
    dcolor 31, 31, 31
    dcolor 23, 25, 31
    dcolor 1, 8, 26
    dcolor 0, 1, 11
;Palette 201
    dcolor 31, 31, 31
    dcolor 23, 25, 31
    dcolor 9, 6, 8
    dcolor 3, 2, 5
;Palette 202
    dcolor 31, 31, 31
    dcolor 28, 28, 31
    dcolor 24, 22, 30
    dcolor 3, 2, 5
;Palette 203
    dcolor 31, 31, 31
    dcolor 31, 26, 20
    dcolor 28, 13, 2
    dcolor 9, 2, 0
;Palette 204
    dcolor 31, 31, 31
    dcolor 23, 20, 31
    dcolor 16, 7, 15
    dcolor 7, 1, 3
;Palette 205
    dcolor 31, 31, 31
    dcolor 22, 25, 29
    dcolor 3, 14, 8
    dcolor 3, 6, 1
;Palette 206
    dcolor 31, 31, 31
    dcolor 22, 25, 31
    dcolor 2, 13, 13
    dcolor 5, 1, 6
;Palette 207
    dcolor 31, 31, 31
    dcolor 23, 26, 28
    dcolor 0, 5, 19
    dcolor 0, 1, 4
;Palette 208
    dcolor 31, 31, 31
    dcolor 29, 26, 22
    dcolor 12, 5, 0
    dcolor 3, 1, 1
;Palette 209
    dcolor 31, 31, 31
    dcolor 30, 27, 16
    dcolor 3, 21, 8
    dcolor 3, 2, 5
;Palette 20A
    dcolor 31, 31, 31
    dcolor 18, 22, 28
    dcolor 9, 12, 18
    dcolor 3, 2, 5
;Palette 20B
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 27, 3, 0
    dcolor 7, 1, 0
;Palette 20C
    dcolor 31, 31, 31
    dcolor 23, 25, 31
    dcolor 4, 7, 31
    dcolor 0, 1, 5
;Palette 20D
    dcolor 31, 31, 31
    dcolor 24, 28, 31
    dcolor 13, 15, 18
    dcolor 3, 2, 5
;Palette 20E
    dcolor 31, 31, 31
    dcolor 28, 25, 23
    dcolor 31, 5, 1
    dcolor 3, 1, 1
;Palette 20F
    dcolor 31, 31, 31
    dcolor 26, 28, 31
    dcolor 18, 22, 28
    dcolor 3, 2, 5
;Palette 210
    dcolor 31, 31, 31
    dcolor 30, 14, 0
    dcolor 23, 9, 0
    dcolor 3, 2, 5
;Palette 211
    dcolor 31, 31, 31
    dcolor 30, 14, 0
    dcolor 23, 9, 0
    dcolor 3, 2, 5
;Palette 212
    dcolor 31, 31, 31
    dcolor 31, 28, 23
    dcolor 28, 8, 19
    dcolor 5, 1, 1
;Palette 213
    dcolor 31, 31, 31
    dcolor 30, 25, 0
    dcolor 28, 16, 0
    dcolor 3, 2, 5
;Palette 214
    dcolor 31, 31, 31
    dcolor 24, 24, 28
    dcolor 6, 12, 21
    dcolor 3, 2, 5
;Palette 215
    dcolor 31, 31, 31
    dcolor 30, 24, 0
    dcolor 28, 7, 0
    dcolor 7, 2, 2
;Palette 216
    dcolor 31, 31, 31
    dcolor 18, 27, 25
    dcolor 6, 9, 21
    dcolor 3, 2, 5
;Palette 217
    dcolor 31, 31, 31
    dcolor 25, 26, 31
    dcolor 1, 13, 21
    dcolor 1, 8, 16
;Palette 218
    dcolor 31, 31, 31
    dcolor 30, 26, 0
    dcolor 31, 9, 0
    dcolor 3, 2, 5
;Palette 219
    dcolor 31, 31, 31
    dcolor 30, 23, 31
    dcolor 23, 9, 21
    dcolor 5, 0, 8
;Palette 21A
    dcolor 31, 31, 31
    dcolor 30, 28, 24
    dcolor 30, 9, 0
    dcolor 3, 2, 5
;Palette 21B
    dcolor 31, 31, 31
    dcolor 30, 28, 24
    dcolor 30, 9, 0
    dcolor 3, 2, 5
;Palette 21C
    dcolor 31, 31, 31
    dcolor 30, 28, 24
    dcolor 30, 9, 0
    dcolor 3, 2, 5
;Palette 21D
    dcolor 31, 31, 31
    dcolor 30, 28, 24
    dcolor 30, 9, 0
    dcolor 3, 2, 5
;Palette 21E
    dcolor 31, 31, 31
    dcolor 30, 28, 24
    dcolor 30, 9, 0
    dcolor 3, 2, 5
;Palette 21F
    dcolor 31, 31, 31
    dcolor 30, 28, 24
    dcolor 30, 9, 0
    dcolor 3, 2, 5
;Palette 220
    dcolor 31, 31, 31
    dcolor 21, 27, 29
    dcolor 6, 17, 0
    dcolor 3, 6, 0
;Palette 221
    dcolor 31, 31, 31
    dcolor 29, 27, 21
    dcolor 17, 6, 0
    dcolor 3, 6, 0
;Palette 222
    dcolor 31, 31, 31
    dcolor 27, 23, 27
    dcolor 19, 9, 19
    dcolor 3, 6, 0
;Palette 223
    dcolor 31, 31, 31
    dcolor 31, 15, 12
    dcolor 31, 8, 6
    dcolor 31, 1, 1
;Palette 224
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 225
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 226
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 0, 12, 8
    dcolor 0, 0, 18
;Palette 227
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
;Palette 228
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 0, 0, 18
    dcolor 0, 0, 0
;Palette 229
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 0, 12, 8
    dcolor 0, 0, 18
;Palette 22A
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
;Palette 22B
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 1, 1, 1
;Palette 22C
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 1, 1, 1
;Palette 22D
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 1, 1, 1
;Palette 22E
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 1, 1, 1
;Palette 22F
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 1, 1, 1
;Palette 230
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
;Palette 231
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 1, 1, 1
;Palette 232
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 1, 1, 1
;Palette 233
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 1, 1, 1
;Palette 234
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 18
    dcolor 0, 0, 0
;Palette 235
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 17
;Palette 236
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 17
;Palette 237
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 17
;Palette 238
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 17
;Palette 239
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 17
;Palette 23A
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 17
;Palette 23B
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 17
;Palette 23C
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 27, 1, 0
    dcolor 0, 0, 17
;Palette 23D
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 23E
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 23F
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 240
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 241
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 242
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 243
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 244
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 245
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 31, 0, 0
    dcolor 0, 0, 19
;Palette 246
    dcolor 23, 4, 26
    dcolor 27, 31, 22
    dcolor 31, 2, 2
    dcolor 13, 7, 5
;Palette 247
    dcolor 23, 4, 26
    dcolor 27, 31, 22
    dcolor 31, 2, 2
    dcolor 13, 7, 5
;Palette 248
    dcolor 23, 4, 26
    dcolor 27, 31, 22
    dcolor 31, 2, 2
    dcolor 13, 7, 5
;Palette 249
    dcolor 23, 4, 26
    dcolor 27, 31, 22
    dcolor 31, 2, 2
    dcolor 13, 7, 5
;Palette 24A
    dcolor 23, 4, 26
    dcolor 27, 31, 22
    dcolor 31, 2, 2
    dcolor 13, 7, 5
;Palette 24B
    dcolor 23, 4, 26
    dcolor 27, 31, 22
    dcolor 31, 2, 2
    dcolor 13, 7, 5
;Palette 24C
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 0, 12, 8
    dcolor 0, 0, 18
;Palette 24D
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 0, 12, 8
    dcolor 0, 0, 18
;Palette 24E
    dcolor 31, 31, 31
    dcolor 6, 19, 12
    dcolor 0, 12, 8
    dcolor 0, 0, 18
;Palette 24F
    dcolor 31, 22, 22
    dcolor 25, 16, 18
    dcolor 20, 14, 16
    dcolor 0, 4, 21
;Palette 250
    dcolor 13, 13, 26
    dcolor 9, 7, 21
    dcolor 3, 0, 11
    dcolor 0, 0, 0
;Palette 251
    dcolor 13, 13, 26
    dcolor 7, 7, 15
    dcolor 2, 2, 6
    dcolor 0, 0, 0
;Palette 252
    dcolor 13, 13, 26
    dcolor 5, 5, 25
    dcolor 1, 1, 10
    dcolor 0, 0, 0
;Palette 253
    dcolor 13, 13, 26
    dcolor 0, 13, 14
    dcolor 0, 8, 9
    dcolor 0, 0, 0
;Palette 254
    dcolor 13, 13, 26
    dcolor 15, 11, 20
    dcolor 9, 7, 14
    dcolor 0, 0, 0
;Palette 255
    dcolor 13, 13, 26
    dcolor 9, 7, 21
    dcolor 3, 0, 11
    dcolor 0, 0, 0
;Palette 256
    dcolor 13, 13, 26
    dcolor 7, 7, 15
    dcolor 2, 2, 6
    dcolor 0, 0, 0
;Palette 257
    dcolor 13, 13, 26
    dcolor 5, 5, 25
    dcolor 1, 1, 10
    dcolor 0, 0, 0
;Palette 258
    dcolor 13, 13, 26
    dcolor 0, 13, 14
    dcolor 0, 8, 9
    dcolor 0, 0, 0
;Palette 259
    dcolor 13, 13, 26
    dcolor 15, 11, 20
    dcolor 9, 7, 14
    dcolor 0, 0, 0
;Palette 25A
    dcolor 13, 13, 26
    dcolor 9, 7, 21
    dcolor 3, 0, 11
    dcolor 0, 0, 0
;Palette 25B
    dcolor 13, 13, 26
    dcolor 7, 7, 15
    dcolor 2, 2, 6
    dcolor 0, 0, 0
;Palette 25C
    dcolor 13, 13, 26
    dcolor 5, 5, 25
    dcolor 1, 1, 10
    dcolor 0, 0, 0
;Palette 25D
    dcolor 13, 13, 26
    dcolor 0, 13, 14
    dcolor 0, 8, 9
    dcolor 0, 0, 0
;Palette 25E
    dcolor 13, 13, 26
    dcolor 15, 11, 20
    dcolor 9, 7, 14
    dcolor 0, 0, 0
;Palette 25F
    dcolor 13, 13, 26
    dcolor 9, 7, 21
    dcolor 3, 0, 11
    dcolor 0, 0, 0
;Palette 260
    dcolor 13, 13, 26
    dcolor 7, 7, 15
    dcolor 2, 2, 6
    dcolor 0, 0, 0
;Palette 261
    dcolor 13, 13, 26
    dcolor 5, 5, 25
    dcolor 1, 1, 10
    dcolor 0, 0, 0
;Palette 262
    dcolor 13, 13, 26
    dcolor 0, 13, 14
    dcolor 0, 8, 9
    dcolor 0, 0, 0
;Palette 263
    dcolor 13, 13, 26
    dcolor 15, 11, 20
    dcolor 9, 7, 14
    dcolor 0, 0, 0
;Palette 264
    dcolor 18, 18, 24
    dcolor 13, 9, 18
    dcolor 7, 3, 10
    dcolor 0, 0, 0
;Palette 265
    dcolor 18, 18, 24
    dcolor 11, 10, 14
    dcolor 4, 3, 6
    dcolor 0, 0, 0
;Palette 266
    dcolor 16, 17, 27
    dcolor 6, 7, 24
    dcolor 0, 1, 9
    dcolor 0, 0, 0
;Palette 267
    dcolor 18, 18, 24
    dcolor 5, 16, 13
    dcolor 3, 9, 8
    dcolor 0, 0, 0
;Palette 268
    dcolor 18, 17, 27
    dcolor 16, 12, 19
    dcolor 10, 8, 13
    dcolor 0, 0, 0
;Palette 269
    dcolor 24, 23, 23
    dcolor 18, 12, 16
    dcolor 11, 7, 10
    dcolor 0, 0, 0
;Palette 26A
    dcolor 24, 23, 23
    dcolor 15, 13, 13
    dcolor 7, 5, 6
    dcolor 0, 0, 0
;Palette 26B
    dcolor 19, 22, 29
    dcolor 8, 10, 24
    dcolor 0, 1, 9
    dcolor 0, 0, 0
;Palette 26C
    dcolor 24, 23, 23
    dcolor 11, 19, 13
    dcolor 6, 11, 7
    dcolor 0, 0, 0
;Palette 26D
    dcolor 24, 22, 29
    dcolor 18, 13, 19
    dcolor 12, 9, 13
    dcolor 0, 0, 0
;Palette 26E
    dcolor 31, 29, 23
    dcolor 23, 16, 14
    dcolor 15, 11, 10
    dcolor 0, 0, 0
;Palette 26F
    dcolor 31, 29, 23
    dcolor 20, 17, 12
    dcolor 10, 8, 6
    dcolor 0, 0, 0
;Palette 270
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 0, 0, 0
;Palette 271
    dcolor 31, 29, 23
    dcolor 17, 23, 13
    dcolor 9, 14, 6
    dcolor 0, 0, 0
;Palette 272
    dcolor 31, 27, 31
    dcolor 20, 15, 20
    dcolor 14, 11, 14
    dcolor 0, 0, 0
;Palette 273
    dcolor 30, 27, 15
    dcolor 21, 14, 10
    dcolor 13, 8, 6
    dcolor 0, 0, 0
;Palette 274
    dcolor 30, 28, 19
    dcolor 19, 16, 9
    dcolor 9, 7, 4
    dcolor 0, 0, 0
;Palette 275
    dcolor 22, 27, 30
    dcolor 10, 12, 24
    dcolor 0, 1, 9
    dcolor 0, 0, 0
;Palette 276
    dcolor 30, 28, 19
    dcolor 14, 22, 9
    dcolor 6, 13, 4
    dcolor 0, 0, 0
;Palette 277
    dcolor 30, 27, 30
    dcolor 19, 13, 19
    dcolor 13, 9, 13
    dcolor 0, 0, 0
;Palette 278
    dcolor 30, 25, 7
    dcolor 20, 12, 7
    dcolor 11, 6, 3
    dcolor 0, 0, 0
;Palette 279
    dcolor 30, 28, 15
    dcolor 19, 16, 7
    dcolor 9, 7, 2
    dcolor 0, 0, 0
;Palette 27A
    dcolor 22, 27, 30
    dcolor 10, 12, 24
    dcolor 0, 1, 9
    dcolor 0, 0, 0
;Palette 27B
    dcolor 30, 28, 15
    dcolor 12, 22, 5
    dcolor 4, 13, 2
    dcolor 0, 0, 0
;Palette 27C
    dcolor 30, 27, 30
    dcolor 19, 12, 19
    dcolor 13, 8, 13
    dcolor 0, 0, 0
;Palette 27D
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette 27E
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 0, 0, 0
;Palette 27F
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 0, 0, 0
;Palette 280
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 0, 0, 0
;Palette 281
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 282
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette 283
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 0, 0, 0
;Palette 284
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 0, 0, 0
;Palette 285
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 0, 0, 0
;Palette 286
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 287
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette 288
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 0, 0, 0
;Palette 289
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 0, 0, 0
;Palette 28A
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 0, 0, 0
;Palette 28B
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 28C
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette 28D
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 0, 0, 0
;Palette 28E
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 0, 0, 0
;Palette 28F
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 0, 0, 0
;Palette 290
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 291
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette 292
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 0, 0, 0
;Palette 293
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 0, 0, 0
;Palette 294
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 0, 0, 0
;Palette 295
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 296
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette 297
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 0, 0, 0
;Palette 298
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 0, 0, 0
;Palette 299
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 0, 0, 0
;Palette 29A
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 29B
    dcolor 31, 24, 0
    dcolor 20, 11, 4
    dcolor 10, 4, 0
    dcolor 0, 0, 0
;Palette 29C
    dcolor 31, 28, 12
    dcolor 20, 17, 5
    dcolor 10, 7, 1
    dcolor 0, 0, 0
;Palette 29D
    dcolor 23, 27, 31
    dcolor 11, 13, 25
    dcolor 0, 2, 10
    dcolor 0, 0, 0
;Palette 29E
    dcolor 31, 28, 12
    dcolor 11, 22, 2
    dcolor 2, 14, 0
    dcolor 0, 0, 0
;Palette 29F
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 2A0
    dcolor 30, 22, 4
    dcolor 19, 9, 4
    dcolor 9, 3, 1
    dcolor 0, 0, 0
;Palette 2A1
    dcolor 30, 25, 12
    dcolor 19, 15, 6
    dcolor 9, 6, 1
    dcolor 0, 0, 0
;Palette 2A2
    dcolor 24, 26, 27
    dcolor 13, 12, 24
    dcolor 4, 1, 9
    dcolor 0, 0, 0
;Palette 2A3
    dcolor 30, 26, 12
    dcolor 11, 20, 2
    dcolor 4, 14, 1
    dcolor 0, 0, 0
;Palette 2A4
    dcolor 30, 27, 30
    dcolor 19, 10, 19
    dcolor 13, 6, 13
    dcolor 0, 0, 0
;Palette 2A5
    dcolor 30, 20, 8
    dcolor 19, 8, 5
    dcolor 9, 3, 2
    dcolor 0, 0, 0
;Palette 2A6
    dcolor 30, 23, 12
    dcolor 19, 14, 8
    dcolor 9, 5, 2
    dcolor 0, 0, 0
;Palette 2A7
    dcolor 26, 25, 23
    dcolor 16, 12, 24
    dcolor 9, 1, 9
    dcolor 0, 0, 0
;Palette 2A8
    dcolor 30, 25, 12
    dcolor 12, 19, 3
    dcolor 7, 14, 3
    dcolor 0, 0, 0
;Palette 2A9
    dcolor 30, 27, 30
    dcolor 19, 10, 19
    dcolor 13, 6, 13
    dcolor 0, 0, 0
;Palette 2AA
    dcolor 31, 19, 13
    dcolor 20, 8, 6
    dcolor 10, 3, 4
    dcolor 0, 0, 0
;Palette 2AB
    dcolor 31, 22, 13
    dcolor 20, 13, 10
    dcolor 10, 5, 4
    dcolor 0, 0, 0
;Palette 2AC
    dcolor 28, 25, 20
    dcolor 19, 13, 25
    dcolor 14, 2, 10
    dcolor 0, 0, 0
;Palette 2AD
    dcolor 31, 25, 13
    dcolor 14, 19, 4
    dcolor 10, 15, 5
    dcolor 0, 0, 0
;Palette 2AE
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 2AF
    dcolor 31, 19, 13
    dcolor 20, 8, 6
    dcolor 10, 3, 4
    dcolor 0, 0, 0
;Palette 2B0
    dcolor 31, 22, 13
    dcolor 20, 13, 10
    dcolor 10, 5, 4
    dcolor 0, 0, 0
;Palette 2B1
    dcolor 28, 25, 20
    dcolor 19, 13, 25
    dcolor 14, 2, 10
    dcolor 0, 0, 0
;Palette 2B2
    dcolor 31, 25, 13
    dcolor 14, 19, 4
    dcolor 10, 15, 5
    dcolor 0, 0, 0
;Palette 2B3
    dcolor 31, 27, 31
    dcolor 20, 11, 20
    dcolor 14, 7, 14
    dcolor 0, 0, 0
;Palette 2B4
    dcolor 24, 16, 17
    dcolor 16, 7, 11
    dcolor 7, 2, 6
    dcolor 0, 0, 0
;Palette 2B5
    dcolor 24, 18, 17
    dcolor 15, 10, 11
    dcolor 7, 3, 4
    dcolor 0, 0, 0
;Palette 2B6
    dcolor 22, 20, 21
    dcolor 14, 10, 24
    dcolor 9, 1, 9
    dcolor 0, 0, 0
;Palette 2B7
    dcolor 24, 20, 17
    dcolor 9, 16, 7
    dcolor 6, 12, 6
    dcolor 0, 0, 0
;Palette 2B8
    dcolor 24, 22, 29
    dcolor 18, 10, 19
    dcolor 12, 6, 13
    dcolor 0, 0, 0
;Palette 2B9
    dcolor 18, 14, 21
    dcolor 12, 7, 16
    dcolor 5, 1, 8
    dcolor 0, 0, 0
;Palette 2BA
    dcolor 18, 15, 21
    dcolor 11, 8, 13
    dcolor 4, 2, 5
    dcolor 0, 0, 0
;Palette 2BB
    dcolor 17, 16, 23
    dcolor 9, 7, 24
    dcolor 5, 1, 9
    dcolor 0, 0, 0
;Palette 2BC
    dcolor 18, 16, 21
    dcolor 4, 14, 10
    dcolor 3, 10, 7
    dcolor 0, 0, 0
;Palette 2BD
    dcolor 18, 17, 27
    dcolor 16, 10, 19
    dcolor 10, 6, 13
    dcolor 0, 0, 0
;Palette 2BE
    dcolor 13, 13, 26
    dcolor 9, 7, 21
    dcolor 3, 0, 11
    dcolor 0, 0, 0
;Palette 2BF
    dcolor 13, 13, 26
    dcolor 7, 7, 15
    dcolor 2, 2, 6
    dcolor 0, 0, 0
;Palette 2C0
    dcolor 13, 13, 26
    dcolor 5, 5, 25
    dcolor 1, 1, 10
    dcolor 0, 0, 0
;Palette 2C1
    dcolor 13, 13, 26
    dcolor 0, 13, 14
    dcolor 0, 8, 9
    dcolor 0, 0, 0
;Palette 2C2
    dcolor 13, 13, 26
    dcolor 15, 11, 20
    dcolor 9, 7, 14
    dcolor 0, 0, 0
;Palette 2C3
    dcolor 13, 13, 26
    dcolor 9, 7, 21
    dcolor 3, 0, 11
    dcolor 0, 0, 0
;Palette 2C4
    dcolor 13, 13, 26
    dcolor 7, 7, 15
    dcolor 2, 2, 6
    dcolor 0, 0, 0
;Palette 2C5
    dcolor 13, 13, 26
    dcolor 5, 5, 25
    dcolor 1, 1, 10
    dcolor 0, 0, 0
;Palette 2C6
    dcolor 13, 13, 26
    dcolor 0, 13, 14
    dcolor 0, 8, 9
    dcolor 0, 0, 0
;Palette 2C7
    dcolor 13, 13, 26
    dcolor 15, 11, 20
    dcolor 9, 7, 14
    dcolor 0, 0, 0
;Palette 2C8
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2C9
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2CA
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2CB
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2CC
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2CD
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2CE
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2CF
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2D0
    dcolor 31, 31, 31
    dcolor 18, 28, 31
    dcolor 4, 12, 31
    dcolor 0, 2, 6
;Palette 2D1
    dcolor 31, 31, 31
    dcolor 31, 20, 20
    dcolor 31, 7, 10
    dcolor 19, 7, 7
;Palette 2D2
    dcolor 31, 31, 31
    dcolor 31, 27, 0
    dcolor 31, 14, 0
    dcolor 15, 11, 0
;Palette 2D3
    dcolor 31, 31, 31
    dcolor 17, 28, 17
    dcolor 0, 19, 4
    dcolor 3, 9, 6
;Palette 2D4
    dcolor 31, 31, 31
    dcolor 25, 22, 29
    dcolor 19, 8, 20
    dcolor 6, 3, 5
;Palette 2D5
    dcolor 31, 31, 31
    dcolor 31, 21, 27
    dcolor 31, 12, 24
    dcolor 8, 1, 4
;Palette 2D6
    dcolor 31, 31, 31
    dcolor 18, 28, 31
    dcolor 4, 12, 31
    dcolor 0, 2, 6
;Palette 2D7
    dcolor 31, 31, 31
    dcolor 31, 20, 20
    dcolor 31, 7, 10
    dcolor 19, 7, 7
;Palette 2D8
    dcolor 31, 31, 31
    dcolor 31, 27, 0
    dcolor 31, 14, 0
    dcolor 15, 11, 0
;Palette 2D9
    dcolor 31, 31, 31
    dcolor 17, 28, 17
    dcolor 0, 19, 4
    dcolor 3, 9, 6
;Palette 2DA
    dcolor 31, 31, 31
    dcolor 25, 22, 29
    dcolor 19, 8, 20
    dcolor 6, 3, 5
;Palette 2DB
    dcolor 31, 31, 31
    dcolor 31, 21, 27
    dcolor 31, 12, 24
    dcolor 8, 1, 4
;Palette 2DC
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2DD
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2DE
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2DF
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2E0
    dcolor 31, 31, 31
    dcolor 20, 20, 20
    dcolor 10, 10, 10
    dcolor 0, 0, 0
;Palette 2E1
    dcolor 31, 31, 31
    dcolor 12, 20, 21
    dcolor 0, 7, 15
    dcolor 0, 2, 6
;Palette 2E2
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2E3
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2E4
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2E5
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2E6
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2E7
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2E8
    dcolor 31, 31, 31
    dcolor 31, 21, 14
    dcolor 18, 10, 9
    dcolor 0, 0, 4
;Palette 2E9
    dcolor 31, 31, 31
    dcolor 15, 15, 21
    dcolor 0, 0, 11
    dcolor 0, 0, 4
;Palette 2EA
    dcolor 31, 31, 31
    dcolor 31, 21, 14
    dcolor 0, 0, 11
    dcolor 0, 0, 4
;Palette 2EB
    dcolor 31, 31, 31
    dcolor 31, 21, 14
    dcolor 26, 2, 1
    dcolor 0, 0, 4
;Palette 2EC
    dcolor 31, 31, 31
    dcolor 31, 26, 0
    dcolor 7, 18, 27
    dcolor 0, 0, 4
;Palette 2ED
    dcolor 31, 31, 31
    dcolor 15, 18, 30
    dcolor 26, 2, 1
    dcolor 0, 0, 4
;Palette 2EE
    dcolor 31, 31, 31
    dcolor 31, 21, 14
    dcolor 7, 18, 27
    dcolor 0, 0, 4
;Palette 2EF
    dcolor 31, 31, 31
    dcolor 31, 24, 28
    dcolor 19, 14, 21
    dcolor 0, 0, 0
;Palette 2F0
    dcolor 28, 31, 24
    dcolor 19, 28, 16
    dcolor 0, 15, 0
    dcolor 4, 0, 0
;Palette 2F1
    dcolor 31, 21, 13
    dcolor 19, 11, 0
    dcolor 10, 4, 0
    dcolor 4, 0, 0
;Palette 2F2
    dcolor 31, 21, 13
    dcolor 19, 11, 0
    dcolor 10, 4, 0
    dcolor 4, 0, 0
;Palette 2F3
    dcolor 23, 31, 19
    dcolor 11, 23, 9
    dcolor 0, 15, 0
    dcolor 4, 0, 0
;Palette 2F4
    dcolor 23, 31, 19
    dcolor 11, 23, 9
    dcolor 0, 15, 0
    dcolor 4, 0, 0
;Palette 2F5
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2F6
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2F7
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 2F8
    dcolor 31, 31, 31
    dcolor 31, 23, 12
    dcolor 19, 11, 6
    dcolor 7, 0, 0
;Palette 2F9
    dcolor 31, 31, 31
    dcolor 31, 23, 12
    dcolor 26, 2, 1
    dcolor 7, 0, 0
;Palette 2FA
    dcolor 31, 31, 31
    dcolor 11, 14, 24
    dcolor 26, 2, 1
    dcolor 7, 0, 0
;Palette 2FB
    dcolor 31, 31, 31
    dcolor 11, 14, 24
    dcolor 0, 0, 14
    dcolor 7, 0, 0
;Palette 2FC
    dcolor 31, 31, 31
    dcolor 14, 19, 23
    dcolor 8, 13, 18
    dcolor 0, 6, 11
;Palette 2FD
    dcolor 31, 31, 31
    dcolor 27, 19, 18
    dcolor 24, 8, 6
    dcolor 7, 0, 0
;Palette 2FE
    dcolor 31, 31, 31
    dcolor 31, 23, 7
    dcolor 24, 8, 6
    dcolor 7, 0, 0
;Palette 2FF
    dcolor 31, 31, 31
    dcolor 6, 20, 4
    dcolor 0, 8, 0
    dcolor 0, 0, 0
;Palette 300
    dcolor 31, 31, 31
    dcolor 13, 17, 18
    dcolor 5, 8, 9
    dcolor 0, 0, 0
;Palette 301
    dcolor 31, 31, 31
    dcolor 1, 9, 22
    dcolor 0, 3, 11
    dcolor 0, 0, 0
;Palette 302
    dcolor 31, 31, 31
    dcolor 1, 9, 22
    dcolor 5, 8, 9
    dcolor 0, 0, 0
;Palette 303
    dcolor 31, 31, 31
    dcolor 13, 17, 18
    dcolor 0, 3, 11
    dcolor 0, 0, 0
;Palette 304
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 305
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 306
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 307
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 308
    dcolor 31, 31, 31
    dcolor 31, 23, 9
    dcolor 27, 15, 0
    dcolor 0, 0, 0
;Palette 309
    dcolor 31, 31, 31
    dcolor 9, 20, 9
    dcolor 2, 10, 2
    dcolor 0, 0, 0
;Palette 30A
    dcolor 31, 31, 31
    dcolor 9, 20, 9
    dcolor 8, 3, 3
    dcolor 0, 0, 0
;Palette 30B
    dcolor 31, 31, 31
    dcolor 31, 23, 9
    dcolor 26, 0, 0
    dcolor 0, 0, 0
;Palette 30C
    dcolor 31, 31, 31
    dcolor 31, 23, 9
    dcolor 2, 10, 2
    dcolor 0, 0, 0
;Palette 30D
    dcolor 31, 31, 31
    dcolor 15, 7, 7
    dcolor 8, 3, 3
    dcolor 0, 0, 0
;Palette 30E
    dcolor 31, 31, 31
    dcolor 31, 23, 9
    dcolor 8, 3, 3
    dcolor 0, 0, 0
;Palette 30F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 310
    dcolor 31, 31, 31
    dcolor 30, 23, 25
    dcolor 24, 8, 20
    dcolor 7, 0, 7
;Palette 311
    dcolor 31, 31, 31
    dcolor 12, 23, 31
    dcolor 4, 8, 23
    dcolor 7, 0, 7
;Palette 312
    dcolor 31, 31, 31
    dcolor 12, 23, 31
    dcolor 24, 8, 20
    dcolor 7, 0, 7
;Palette 313
    dcolor 31, 31, 31
    dcolor 30, 23, 25
    dcolor 4, 8, 23
    dcolor 7, 0, 7
;Palette 314
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 315
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 316
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 317
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 318
    dcolor 31, 31, 31
    dcolor 31, 28, 16
    dcolor 30, 19, 10
    dcolor 0, 0, 0
;Palette 319
    dcolor 31, 31, 31
    dcolor 18, 14, 12
    dcolor 15, 9, 8
    dcolor 0, 0, 0
;Palette 31A
    dcolor 31, 31, 31
    dcolor 31, 28, 16
    dcolor 0, 0, 0
    dcolor 31, 0, 0
;Palette 31B
    dcolor 31, 31, 31
    dcolor 0, 19, 10
    dcolor 0, 11, 6
    dcolor 0, 0, 0
;Palette 31C
    dcolor 31, 31, 31
    dcolor 13, 16, 18
    dcolor 6, 9, 11
    dcolor 0, 0, 0
;Palette 31D
    dcolor 31, 31, 31
    dcolor 31, 28, 16
    dcolor 15, 9, 8
    dcolor 0, 0, 0
;Palette 31E
    dcolor 31, 31, 31
    dcolor 0, 20, 28
    dcolor 31, 0, 0
    dcolor 0, 0, 0
;Palette 31F
    dcolor 31, 31, 31
    dcolor 31, 30, 4
    dcolor 27, 12, 2
    dcolor 0, 0, 0
;Palette 320
    dcolor 31, 31, 31
    dcolor 31, 31, 16
    dcolor 31, 31, 0
    dcolor 0, 0, 0
;Palette 321
    dcolor 31, 31, 31
    dcolor 16, 16, 31
    dcolor 0, 24, 31
    dcolor 0, 0, 0
;Palette 322
    dcolor 31, 31, 31
    dcolor 31, 16, 16
    dcolor 31, 16, 31
    dcolor 0, 0, 0
;Palette 323
    dcolor 31, 31, 31
    dcolor 16, 31, 16
    dcolor 6, 31, 6
    dcolor 0, 0, 0
;Palette 324
    dcolor 31, 31, 0
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 0, 0, 0
;Palette 325
    dcolor 0, 24, 31
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 0, 0, 0
;Palette 326
    dcolor 31, 16, 31
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 0, 0, 0
;Palette 327
    dcolor 6, 31, 6
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 0, 0, 0
;Palette 328
    dcolor 31, 31, 0
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 329
    dcolor 0, 24, 31
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 32A
    dcolor 31, 16, 31
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 32B
    dcolor 6, 31, 6
    dcolor 31, 31, 31
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 32C
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 32D
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 32E
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 32F
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 330
    dcolor 31, 31, 31
    dcolor 22, 28, 31
    dcolor 0, 13, 0
    dcolor 0, 6, 0
;Palette 331
    dcolor 26, 21, 13
    dcolor 20, 13, 0
    dcolor 12, 6, 0
    dcolor 6, 2, 0
;Palette 332
    dcolor 26, 21, 13
    dcolor 20, 13, 0
    dcolor 12, 6, 0
    dcolor 0, 6, 0
;Palette 333
    dcolor 31, 31, 31
    dcolor 0, 22, 0
    dcolor 0, 13, 0
    dcolor 6, 2, 0
;Palette 334
    dcolor 26, 21, 13
    dcolor 20, 13, 0
    dcolor 0, 13, 0
    dcolor 6, 2, 0
;Palette 335
    dcolor 26, 21, 13
    dcolor 22, 28, 31
    dcolor 12, 6, 0
    dcolor 6, 2, 0
;Palette 336
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 337
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 338
    dcolor 31, 29, 25
    dcolor 31, 23, 13
    dcolor 19, 12, 3
    dcolor 2, 1, 0
;Palette 339
    dcolor 31, 31, 31
    dcolor 31, 23, 13
    dcolor 22, 4, 4
    dcolor 4, 2, 2
;Palette 33A
    dcolor 31, 31, 31
    dcolor 13, 7, 3
    dcolor 19, 12, 3
    dcolor 2, 1, 0
;Palette 33B
    dcolor 28, 30, 31
    dcolor 31, 23, 13
    dcolor 4, 9, 20
    dcolor 2, 1, 0
;Palette 33C
    dcolor 8, 14, 27
    dcolor 4, 9, 22
    dcolor 5, 5, 13
    dcolor 2, 1, 0
;Palette 33D
    dcolor 31, 30, 26
    dcolor 31, 29, 1
    dcolor 31, 16, 2
    dcolor 2, 1, 0
;Palette 33E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 33F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 340
    dcolor 22, 28, 31
    dcolor 13, 18, 23
    dcolor 12, 12, 15
    dcolor 12, 7, 8
;Palette 341
    dcolor 22, 28, 31
    dcolor 0, 24, 13
    dcolor 0, 17, 13
    dcolor 0, 4, 0
;Palette 342
    dcolor 26, 17, 10
    dcolor 18, 11, 6
    dcolor 11, 5, 2
    dcolor 0, 4, 0
;Palette 343
    dcolor 26, 17, 10
    dcolor 18, 11, 6
    dcolor 0, 17, 13
    dcolor 0, 4, 0
;Palette 344
    dcolor 31, 30, 0
    dcolor 31, 20, 0
    dcolor 0, 17, 13
    dcolor 0, 4, 0
;Palette 345
    dcolor 4, 13, 20
    dcolor 4, 8, 14
    dcolor 2, 6, 7
    dcolor 0, 4, 0
;Palette 346
    dcolor 4, 13, 20
    dcolor 4, 8, 14
    dcolor 0, 17, 13
    dcolor 0, 4, 0
;Palette 347
    dcolor 6, 28, 20
    dcolor 0, 24, 13
    dcolor 0, 17, 13
    dcolor 0, 0, 0
;Palette 348
    dcolor 31, 31, 31
    dcolor 20, 21, 14
    dcolor 17, 17, 17
    dcolor 4, 4, 4
;Palette 349
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 34A
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 34B
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 34C
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 34D
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 34E
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 34F
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 350
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 19, 11, 6
    dcolor 7, 4, 0
;Palette 351
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 1, 10, 27
    dcolor 7, 4, 0
;Palette 352
    dcolor 29, 26, 23
    dcolor 27, 22, 15
    dcolor 19, 11, 6
    dcolor 7, 4, 0
;Palette 353
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 15, 3, 28
    dcolor 7, 4, 0
;Palette 354
    dcolor 31, 31, 31
    dcolor 21, 25, 31
    dcolor 13, 15, 25
    dcolor 7, 4, 0
;Palette 355
    dcolor 31, 31, 31
    dcolor 21, 25, 31
    dcolor 19, 11, 6
    dcolor 7, 4, 0
;Palette 356
    dcolor 24, 30, 31
    dcolor 16, 20, 31
    dcolor 8, 10, 31
    dcolor 0, 0, 15
;Palette 357
    dcolor 31, 31, 31
    dcolor 31, 31, 31
    dcolor 31, 31, 31
    dcolor 0, 0, 0
;Palette 358
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 20, 14, 10
    dcolor 7, 0, 0
;Palette 359
    dcolor 31, 31, 31
    dcolor 18, 15, 26
    dcolor 8, 6, 16
    dcolor 7, 0, 0
;Palette 35A
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 8, 6, 16
    dcolor 7, 0, 0
;Palette 35B
    dcolor 31, 27, 23
    dcolor 27, 22, 15
    dcolor 20, 14, 10
    dcolor 7, 0, 0
;Palette 35C
    dcolor 31, 31, 31
    dcolor 18, 15, 26
    dcolor 19, 11, 6
    dcolor 0, 0, 0
;Palette 35D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 35E
    dcolor 31, 31, 31
    dcolor 14, 19, 23
    dcolor 8, 13, 18
    dcolor 0, 6, 11
;Palette 35F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 360
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 20, 14, 10
    dcolor 7, 0, 0
;Palette 361
    dcolor 31, 31, 31
    dcolor 23, 17, 29
    dcolor 15, 3, 28
    dcolor 7, 0, 0
;Palette 362
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 15, 3, 28
    dcolor 7, 0, 0
;Palette 363
    dcolor 31, 27, 23
    dcolor 27, 22, 15
    dcolor 20, 14, 10
    dcolor 7, 0, 0
;Palette 364
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 365
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 366
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 367
    dcolor 31, 31, 31
    dcolor 31, 22, 22
    dcolor 31, 1, 6
    dcolor 0, 0, 0
;Palette 368
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 369
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 36A
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 36B
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 36C
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 36D
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 36E
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 36F
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 370
    dcolor 19, 28, 31
    dcolor 19, 18, 20
    dcolor 20, 9, 10
    dcolor 21, 0, 0
;Palette 371
    dcolor 19, 28, 31
    dcolor 12, 20, 24
    dcolor 6, 12, 17
    dcolor 0, 4, 11
;Palette 372
    dcolor 19, 28, 31
    dcolor 22, 31, 16
    dcolor 6, 20, 8
    dcolor 0, 4, 11
;Palette 373
    dcolor 19, 28, 31
    dcolor 22, 31, 16
    dcolor 31, 20, 0
    dcolor 0, 4, 11
;Palette 374
    dcolor 19, 28, 31
    dcolor 12, 20, 24
    dcolor 6, 20, 8
    dcolor 0, 4, 11
;Palette 375
    dcolor 19, 28, 31
    dcolor 31, 31, 0
    dcolor 31, 20, 1
    dcolor 0, 4, 11
;Palette 376
    dcolor 31, 12, 0
    dcolor 22, 31, 16
    dcolor 6, 20, 8
    dcolor 0, 4, 11
;Palette 377
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 378
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 379
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 37A
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 37B
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 37C
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 37D
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 37E
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 37F
    dcolor 31, 31, 31
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 380
    dcolor 31, 31, 31
    dcolor 12, 12, 12
    dcolor 4, 4, 5
    dcolor 2, 8, 2
;Palette 381
    dcolor 31, 31, 31
    dcolor 6, 10, 9
    dcolor 14, 14, 11
    dcolor 10, 11, 17
;Palette 382
    dcolor 31, 31, 31
    dcolor 31, 25, 17
    dcolor 27, 14, 0
    dcolor 8, 2, 0
;Palette 383
    dcolor 31, 31, 31
    dcolor 28, 25, 8
    dcolor 20, 13, 0
    dcolor 8, 4, 0
;Palette 384
    dcolor 31, 31, 31
    dcolor 1, 11, 7
    dcolor 1, 7, 4
    dcolor 2, 4, 1
;Palette 385
    dcolor 31, 31, 31
    dcolor 16, 20, 31
    dcolor 9, 12, 19
    dcolor 3, 4, 8
;Palette 386
    dcolor 31, 31, 31
    dcolor 1, 11, 7
    dcolor 1, 7, 4
    dcolor 2, 4, 1
;Palette 387
    dcolor 31, 31, 31
    dcolor 16, 20, 31
    dcolor 9, 12, 19
    dcolor 3, 4, 8
;Palette 388
    dcolor 31, 31, 31
    dcolor 22, 23, 23
    dcolor 13, 16, 15
    dcolor 4, 9, 8
;Palette 389
    dcolor 31, 31, 31
    dcolor 18, 23, 23
    dcolor 4, 11, 12
    dcolor 2, 4, 7
;Palette 38A
    dcolor 31, 31, 31
    dcolor 13, 16, 20
    dcolor 5, 12, 20
    dcolor 4, 8, 14
;Palette 38B
    dcolor 31, 31, 31
    dcolor 14, 21, 23
    dcolor 8, 16, 17
    dcolor 5, 11, 12
;Palette 38C
    dcolor 31, 31, 31
    dcolor 10, 14, 26
    dcolor 4, 9, 17
    dcolor 2, 5, 13
;Palette 38D
    dcolor 31, 31, 31
    dcolor 21, 15, 16
    dcolor 17, 12, 13
    dcolor 13, 7, 9
;Palette 38E
    dcolor 31, 31, 31
    dcolor 10, 14, 26
    dcolor 4, 9, 17
    dcolor 2, 5, 13
;Palette 38F
    dcolor 31, 31, 31
    dcolor 21, 15, 16
    dcolor 17, 12, 13
    dcolor 13, 7, 9
;Palette 390
    dcolor 31, 31, 31
    dcolor 22, 26, 26
    dcolor 17, 18, 23
    dcolor 2, 2, 2
;Palette 391
    dcolor 31, 31, 31
    dcolor 27, 23, 27
    dcolor 23, 14, 23
    dcolor 2, 2, 2
;Palette 392
    dcolor 31, 31, 31
    dcolor 23, 27, 23
    dcolor 14, 23, 14
    dcolor 2, 2, 2
;Palette 393
    dcolor 31, 27, 19
    dcolor 29, 21, 13
    dcolor 24, 14, 5
    dcolor 2, 2, 2
;Palette 394
    dcolor 31, 27, 31
    dcolor 31, 20, 23
    dcolor 28, 15, 17
    dcolor 2, 2, 2
;Palette 395
    dcolor 27, 27, 31
    dcolor 23, 20, 31
    dcolor 17, 15, 28
    dcolor 2, 2, 2
;Palette 396
    dcolor 31, 31, 31
    dcolor 16, 18, 27
    dcolor 0, 0, 23
    dcolor 2, 2, 2
;Palette 397
    dcolor 31, 31, 31
    dcolor 31, 20, 15
    dcolor 23, 6, 0
    dcolor 2, 2, 2
;Palette 398
    dcolor 31, 31, 31
    dcolor 31, 31, 15
    dcolor 31, 23, 0
    dcolor 2, 2, 2
;Palette 399
    dcolor 31, 31, 31
    dcolor 15, 17, 18
    dcolor 6, 7, 9
    dcolor 2, 2, 3
;Palette 39A
    dcolor 31, 31, 31
    dcolor 20, 23, 18
    dcolor 9, 13, 5
    dcolor 2, 3, 2
;Palette 39B
    dcolor 31, 31, 31
    dcolor 30, 29, 25
    dcolor 24, 22, 10
    dcolor 2, 2, 2
;Palette 39C
    dcolor 31, 31, 0
    dcolor 23, 17, 0
    dcolor 15, 3, 0
    dcolor 0, 0, 0
;Palette 39D
    dcolor 31, 31, 0
    dcolor 26, 16, 0
    dcolor 10, 2, 0
    dcolor 0, 0, 0
;Palette 39E
    dcolor 12, 26, 31
    dcolor 5, 13, 20
    dcolor 0, 5, 10
    dcolor 0, 0, 0
;Palette 39F
    dcolor 31, 23, 23
    dcolor 31, 17, 17
    dcolor 31, 5, 5
    dcolor 0, 0, 0
;Palette 3A0
    dcolor 21, 31, 21
    dcolor 15, 31, 15
    dcolor 0, 31, 0
    dcolor 0, 0, 0
;Palette 3A1
    dcolor 31, 23, 31
    dcolor 31, 14, 31
    dcolor 27, 0, 27
    dcolor 0, 0, 0
;Palette 3A2
    dcolor 21, 31, 31
    dcolor 9, 31, 31
    dcolor 0, 22, 22
    dcolor 0, 0, 0
;Palette 3A3
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 3A4
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 3A5
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 3A6
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 3A7
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 3A8
    dcolor 31, 31, 3
    dcolor 21, 21, 29
    dcolor 0, 0, 28
    dcolor 0, 0, 0
;Palette 3A9
    dcolor 31, 31, 31
    dcolor 16, 9, 9
    dcolor 11, 4, 4
    dcolor 0, 0, 0
;Palette 3AA
    dcolor 31, 31, 31
    dcolor 31, 18, 11
    dcolor 4, 19, 5
    dcolor 0, 0, 0
;Palette 3AB
    dcolor 31, 31, 31
    dcolor 31, 18, 11
    dcolor 11, 4, 4
    dcolor 0, 0, 0
;Palette 3AC
    dcolor 31, 31, 31
    dcolor 31, 18, 11
    dcolor 25, 12, 5
    dcolor 0, 0, 0
;Palette 3AD
    dcolor 31, 31, 31
    dcolor 4, 19, 5
    dcolor 11, 4, 4
    dcolor 0, 0, 0
;Palette 3AE
    dcolor 31, 31, 31
    dcolor 21, 21, 21
    dcolor 10, 10, 10
    dcolor 0, 0, 0

SECTION "CGB Object Palette Data", ROMX[$4000], BANK[$e]
LCDC_CGB_OBPaletteTable::
    dpalette $10, $11, $12, $13, $14, $15, $16, $17
    dpalette $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
    dpalette $30, $31, $32, $33, $34, $35, $36, $37
    dpalette $1, $2, $7, $0, $0, $0, $0, $0 ; Field Guide
    dpalette $0, $0, $0, $3, $0, $0, $0, $0
    dpalette $20, $21, $22, $23, $24, $0, $0, $0
    dpalette $25, $26, $0, $0, $0, $0, $0, $0
    dpalette $27, $28, $29, $2A, $0, $0, $0, $0
    dpalette $2B, $2C, $0, $0, $0, $0, $0, $0
    dpalette $2D, $2E, $0, $0, $0, $0, $0, $0
    dpalette $3D, $3E, $3F, $40, $41, $0, $0, $0
    dpalette $2F, $30, $31, $32, $33, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $0, $0, $0, $0, $0, $0, $0, $0
    dpalette $5, $5, $5, $5, $5, $5, $5, $5
    dpalette $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
    dpalette $1FC, $1FD, $0, $0, $0, $0, $0, $0

SECTION "CGB Object Color Data", ROMX[$5d80], BANK[$d]
LCDC_CGB_OBColorTable::
;Palette 0
    dcolor 31, 31, 31
    dcolor 8, 31, 8
    dcolor 20, 8, 20
    dcolor 4, 0, 8
;Palette 1
    dcolor 0, 31, 3
    dcolor 31, 29, 14
    dcolor 30, 16, 6
    dcolor 4, 4, 4
;Palette 2
    dcolor 31, 31, 31
    dcolor 6, 26, 31
    dcolor 17, 18, 23
    dcolor 0, 0, 0
;Palette 3
    dcolor 31, 31, 31
    dcolor 31, 15, 12
    dcolor 31, 8, 6
    dcolor 31, 1, 1
;Palette 4
    dcolor 0, 0, 0
    dcolor 31, 31, 31
    dcolor 31, 0, 0
    dcolor 0, 0, 0
;Palette 5
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 6
    dcolor 0, 0, 0
    dcolor 31, 31, 31
    dcolor 23, 23, 23
    dcolor 15, 15, 15
;Palette 7
;Changed. Used to be all 0, now it's used for
;sprite text on the Field Guide and status screens.
    dcolor 31, 21, 4
    dcolor 30, 30, 30
    dcolor 15, 15, 15
    dcolor 3, 3, 3
;Palette 8
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 9
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette A
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette B
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette C
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 10
    dcolor 20, 13, 5
    dcolor 30, 17, 7
    dcolor 20, 7, 1
    dcolor 0, 0, 0
;Palette 11
    dcolor 31, 31, 31
    dcolor 31, 20, 12
    dcolor 0, 23, 0
    dcolor 0, 0, 8
;Palette 12
    dcolor 31, 31, 31
    dcolor 31, 18, 0
    dcolor 31, 3, 12
    dcolor 0, 0, 8
;Palette 13
    dcolor 31, 31, 31
    dcolor 31, 21, 7
    dcolor 26, 2, 2
    dcolor 0, 0, 0
;Palette 14
    dcolor 31, 31, 31
    dcolor 30, 26, 19
    dcolor 31, 5, 4
    dcolor 2, 2, 2
;Palette 15
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 12, 20, 31
    dcolor 4, 10, 26
;Palette 16
    dcolor 31, 31, 31
    dcolor 31, 31, 19
    dcolor 23, 23, 16
    dcolor 18, 18, 15
;Palette 17
    dcolor 31, 31, 31
    dcolor 8, 21, 31
    dcolor 0, 0, 24
    dcolor 0, 0, 10
;Palette 18
    dcolor 0, 0, 0
    dcolor 31, 31, 31
    dcolor 31, 4, 4
    dcolor 20, 0, 0
;Palette 19
    dcolor 31, 31, 31
    dcolor 31, 20, 12
    dcolor 0, 23, 0
    dcolor 0, 0, 8
;Palette 1A
    dcolor 31, 31, 31
    dcolor 31, 18, 0
    dcolor 31, 3, 12
    dcolor 0, 0, 8
;Palette 1B
    dcolor 31, 31, 31
    dcolor 31, 21, 7
    dcolor 26, 2, 2
    dcolor 0, 0, 0
;Palette 1C
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 12, 20, 31
    dcolor 4, 10, 26
;Palette 1D
    dcolor 31, 31, 31
    dcolor 31, 26, 11
    dcolor 29, 21, 6
    dcolor 28, 18, 5
;Palette 1E
    dcolor 0, 0, 0
    dcolor 31, 31, 22
    dcolor 30, 30, 13
    dcolor 23, 23, 4
;Palette 1F
    dcolor 31, 31, 31
    dcolor 8, 21, 31
    dcolor 0, 0, 24
    dcolor 0, 0, 10
;Palette 20
    dcolor 31, 31, 31
    dcolor 31, 23, 12
    dcolor 26, 2, 1
    dcolor 7, 0, 0
;Palette 21
    dcolor 31, 31, 31
    dcolor 11, 14, 24
    dcolor 0, 0, 14
    dcolor 7, 0, 0
;Palette 22
    dcolor 31, 31, 31
    dcolor 31, 22, 0
    dcolor 11, 14, 24
    dcolor 7, 0, 0
;Palette 23
    dcolor 31, 31, 31
    dcolor 11, 14, 24
    dcolor 26, 2, 1
    dcolor 7, 0, 0
;Palette 24
    dcolor 31, 31, 31
    dcolor 16, 6, 2
    dcolor 26, 2, 1
    dcolor 7, 0, 0
;Palette 25
    dcolor 31, 31, 31
    dcolor 16, 6, 2
    dcolor 26, 2, 1
    dcolor 7, 0, 0
;Palette 26
    dcolor 31, 31, 31
    dcolor 31, 31, 31
    dcolor 26, 2, 1
    dcolor 2, 0, 0
;Palette 27
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 19, 11, 6
    dcolor 7, 4, 0
;Palette 28
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 0, 9, 23
    dcolor 7, 4, 0
;Palette 29
    dcolor 31, 31, 31
    dcolor 27, 22, 15
    dcolor 15, 20, 28
    dcolor 7, 4, 0
;Palette 2A
    dcolor 31, 31, 31
    dcolor 16, 18, 25
    dcolor 7, 10, 15
    dcolor 7, 4, 0
;Palette 2B
    dcolor 31, 31, 31
    dcolor 31, 23, 12
    dcolor 26, 2, 1
    dcolor 7, 0, 0
;Palette 2C
    dcolor 31, 31, 31
    dcolor 11, 14, 24
    dcolor 0, 0, 14
    dcolor 7, 0, 0
;Palette 2D
    dcolor 31, 31, 31
    dcolor 22, 19, 11
    dcolor 15, 12, 7
    dcolor 7, 0, 0
;Palette 2E
    dcolor 31, 31, 31
    dcolor 5, 14, 29
    dcolor 6, 6, 16
    dcolor 7, 0, 0
;Palette 2F
    dcolor 31, 31, 31
    dcolor 27, 19, 18
    dcolor 24, 8, 6
    dcolor 7, 0, 0
;Palette 30
    dcolor 31, 31, 31
    dcolor 31, 23, 7
    dcolor 26, 13, 0
    dcolor 7, 0, 0
;Palette 31
    dcolor 31, 31, 31
    dcolor 31, 23, 7
    dcolor 31, 0, 0
    dcolor 7, 0, 0
;Palette 32
    dcolor 31, 31, 31
    dcolor 31, 23, 7
    dcolor 24, 8, 6
    dcolor 7, 0, 0
;Palette 33
    dcolor 31, 31, 31
    dcolor 25, 27, 30
    dcolor 24, 8, 6
    dcolor 7, 0, 0
;Palette 34
    dcolor 31, 31, 31
    dcolor 31, 23, 12
    dcolor 19, 11, 6
    dcolor 7, 0, 0
;Palette 35
    dcolor 31, 31, 31
    dcolor 29, 29, 31
    dcolor 0, 0, 14
    dcolor 7, 0, 0
;Palette 36
    dcolor 31, 31, 31
    dcolor 31, 23, 0
    dcolor 11, 14, 24
    dcolor 7, 0, 0
;Palette 37
    dcolor 31, 31, 31
    dcolor 13, 22, 31
    dcolor 0, 12, 31
    dcolor 0, 0, 0
;Palette 38
    dcolor 31, 31, 31
    dcolor 27, 19, 18
    dcolor 24, 8, 6
    dcolor 7, 0, 0
;Palette 39
    dcolor 31, 31, 31
    dcolor 31, 23, 7
    dcolor 24, 8, 6
    dcolor 7, 0, 0
;Palette 3A
    dcolor 31, 31, 31
    dcolor 31, 23, 7
    dcolor 26, 13, 0
    dcolor 7, 0, 0
;Palette 3B
    dcolor 31, 31, 31
    dcolor 6, 20, 4
    dcolor 24, 8, 6
    dcolor 0, 4, 0
;Palette 3C
    dcolor 31, 31, 31
    dcolor 31, 23, 7
    dcolor 31, 0, 0
    dcolor 7, 0, 0
;Palette 3D
    dcolor 31, 31, 31
    dcolor 31, 30, 4
    dcolor 27, 12, 2
    dcolor 0, 0, 0
;Palette 3E
    dcolor 31, 31, 31
    dcolor 0, 20, 28
    dcolor 0, 8, 31
    dcolor 31, 0, 0
;Palette 3F
    dcolor 31, 31, 31
    dcolor 31, 20, 20
    dcolor 31, 10, 10
    dcolor 31, 0, 0
;Palette 40
    dcolor 0, 31, 31
    dcolor 31, 31, 31
    dcolor 31, 16, 16
    dcolor 31, 0, 0
;Palette 41
    dcolor 31, 31, 31
    dcolor 20, 20, 31
    dcolor 10, 10, 31
    dcolor 0, 0, 31
;Palette 42
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 43
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 44
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 45
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 46
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 47
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 48
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 49
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4A
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4B
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4C
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 4F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 50
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 51
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 52
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 53
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 54
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 55
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 56
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 57
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 58
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 59
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 5A
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 5B
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 5C
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 5D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 5E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 5F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 60
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 61
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 62
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 63
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 64
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 65
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 66
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 67
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 68
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 69
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 6A
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 6B
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 6C
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 6D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 6E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 6F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 70
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 71
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 72
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 73
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 74
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 75
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 76
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 77
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 78
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 79
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 7A
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 7B
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 7C
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 7D
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 7E
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 7F
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 80
    dcolor 31, 31, 31
    dcolor 30, 13, 9
    dcolor 29, 15, 6
    dcolor 30, 23, 5
;Palette 81
    dcolor 31, 31, 31
    dcolor 30, 13, 9
    dcolor 29, 15, 6
    dcolor 30, 23, 5
;Palette 82
    dcolor 31, 31, 31
    dcolor 7, 13, 30
    dcolor 0, 7, 20
    dcolor 2, 7, 19
;Palette 83
    dcolor 31, 31, 31
    dcolor 7, 31, 14
    dcolor 0, 24, 17
    dcolor 2, 20, 11
;Palette 84
    dcolor 31, 31, 31
    dcolor 31, 31, 14
    dcolor 24, 20, 7
    dcolor 20, 8, 3
;Palette 85
    dcolor 31, 31, 31
    dcolor 31, 15, 2
    dcolor 31, 20, 7
    dcolor 28, 28, 3
;Palette 86
    dcolor 31, 31, 31
    dcolor 31, 15, 2
    dcolor 31, 20, 7
    dcolor 28, 28, 3
;Palette 87
    dcolor 31, 31, 31
    dcolor 31, 21, 2
    dcolor 24, 14, 0
    dcolor 21, 7, 0
;Palette 88
    dcolor 31, 31, 31
    dcolor 31, 21, 2
    dcolor 24, 14, 0
    dcolor 21, 7, 0
;Palette 89
    dcolor 31, 31, 31
    dcolor 31, 21, 30
    dcolor 24, 14, 26
    dcolor 21, 7, 22
;Palette 8A
    dcolor 31, 31, 31
    dcolor 31, 21, 30
    dcolor 24, 14, 26
    dcolor 21, 7, 22
;Palette 8B
    dcolor 31, 31, 31
    dcolor 31, 21, 30
    dcolor 24, 14, 26
    dcolor 21, 7, 22
;Palette 8C
    dcolor 31, 31, 31
    dcolor 0, 10, 27
    dcolor 0, 14, 25
    dcolor 6, 22, 30
;Palette 8D
    dcolor 31, 31, 31
    dcolor 25, 28, 27
    dcolor 0, 24, 25
    dcolor 1, 1, 8
;Palette 8E
    dcolor 31, 31, 31
    dcolor 27, 26, 30
    dcolor 25, 22, 29
    dcolor 8, 5, 8
;Palette 8F
    dcolor 31, 31, 31
    dcolor 27, 26, 30
    dcolor 25, 22, 29
    dcolor 8, 5, 8
;Palette 90
    dcolor 31, 31, 31
    dcolor 30, 11, 11
    dcolor 26, 6, 6
    dcolor 8, 1, 1
;Palette 91
    dcolor 31, 31, 31
    dcolor 8, 27, 30
    dcolor 12, 20, 31
    dcolor 0, 1, 10
;Palette 92
    dcolor 31, 31, 31
    dcolor 8, 27, 30
    dcolor 12, 20, 31
    dcolor 0, 1, 10
;Palette 93
    dcolor 31, 31, 31
    dcolor 7, 31, 14
    dcolor 0, 24, 17
    dcolor 2, 20, 11
;Palette 94
    dcolor 31, 31, 31
    dcolor 7, 31, 14
    dcolor 0, 24, 17
    dcolor 2, 20, 11
;Palette 95
    dcolor 31, 31, 31
    dcolor 7, 31, 14
    dcolor 0, 24, 17
    dcolor 2, 20, 11
;Palette 96
    dcolor 31, 31, 31
    dcolor 30, 13, 9
    dcolor 29, 15, 6
    dcolor 30, 23, 5
;Palette 97
    dcolor 31, 31, 31
    dcolor 30, 29, 9
    dcolor 29, 15, 6
    dcolor 30, 9, 5
;Palette 98
    dcolor 31, 31, 31
    dcolor 30, 29, 9
    dcolor 29, 15, 6
    dcolor 30, 9, 5
;Palette 99
    dcolor 31, 31, 31
    dcolor 11, 29, 30
    dcolor 8, 15, 29
    dcolor 3, 9, 30
;Palette 9A
    dcolor 31, 31, 31
    dcolor 11, 29, 30
    dcolor 8, 15, 29
    dcolor 3, 9, 30
;Palette 9B
    dcolor 31, 31, 31
    dcolor 11, 29, 30
    dcolor 8, 15, 29
    dcolor 3, 9, 30
;Palette 9C
    dcolor 31, 31, 31
    dcolor 29, 29, 6
    dcolor 26, 15, 1
    dcolor 28, 9, 3
;Palette 9D
    dcolor 31, 31, 31
    dcolor 23, 25, 28
    dcolor 11, 15, 28
    dcolor 3, 1, 8
;Palette 9E
    dcolor 31, 31, 31
    dcolor 23, 25, 28
    dcolor 11, 15, 28
    dcolor 3, 1, 8
;Palette 9F
    dcolor 31, 31, 31
    dcolor 23, 29, 26
    dcolor 11, 28, 14
    dcolor 3, 13, 8
;Palette A0
    dcolor 31, 31, 31
    dcolor 30, 26, 29
    dcolor 30, 12, 14
    dcolor 12, 2, 8
;Palette A1
    dcolor 31, 31, 31
    dcolor 30, 15, 29
    dcolor 21, 12, 22
    dcolor 12, 2, 8
;Palette A2
    dcolor 31, 31, 31
    dcolor 30, 25, 27
    dcolor 21, 12, 29
    dcolor 4, 2, 11
;Palette A3
    dcolor 31, 31, 31
    dcolor 25, 21, 12
    dcolor 20, 15, 8
    dcolor 11, 2, 1
;Palette A4
    dcolor 31, 31, 31
    dcolor 30, 30, 13
    dcolor 30, 17, 4
    dcolor 23, 10, 0
;Palette A5
    dcolor 31, 31, 31
    dcolor 30, 30, 13
    dcolor 30, 17, 4
    dcolor 23, 10, 0
;Palette A6
    dcolor 31, 31, 31
    dcolor 30, 30, 13
    dcolor 30, 17, 4
    dcolor 23, 10, 0
;Palette A7
    dcolor 31, 31, 31
    dcolor 30, 6, 0
    dcolor 24, 2, 12
    dcolor 16, 4, 0
;Palette A8
    dcolor 31, 31, 31
    dcolor 30, 6, 0
    dcolor 24, 2, 12
    dcolor 16, 4, 0
;Palette A9
    dcolor 31, 31, 31
    dcolor 30, 25, 0
    dcolor 31, 16, 3
    dcolor 26, 3, 0
;Palette AA
    dcolor 31, 31, 31
    dcolor 0, 25, 30
    dcolor 0, 16, 31
    dcolor 0, 3, 30
;Palette AB
    dcolor 31, 31, 31
    dcolor 0, 25, 30
    dcolor 0, 16, 31
    dcolor 0, 3, 30
;Palette AC
    dcolor 31, 31, 31
    dcolor 0, 25, 30
    dcolor 0, 16, 31
    dcolor 0, 3, 30
;Palette AD
    dcolor 31, 31, 31
    dcolor 0, 25, 30
    dcolor 0, 16, 31
    dcolor 0, 3, 30
;Palette AE
    dcolor 31, 31, 31
    dcolor 31, 25, 10
    dcolor 0, 16, 6
    dcolor 6, 3, 16
;Palette AF
    dcolor 31, 31, 31
    dcolor 3, 29, 27
    dcolor 2, 22, 22
    dcolor 2, 12, 10
;Palette B0
    dcolor 31, 31, 31
    dcolor 3, 23, 31
    dcolor 2, 8, 30
    dcolor 1, 3, 13
;Palette B1
    dcolor 31, 31, 31
    dcolor 30, 31, 9
    dcolor 29, 21, 0
    dcolor 30, 13, 5
;Palette B2
    dcolor 31, 31, 31
    dcolor 4, 21, 31
    dcolor 0, 11, 27
    dcolor 0, 13, 21
;Palette B3
    dcolor 31, 31, 31
    dcolor 25, 21, 12
    dcolor 20, 15, 8
    dcolor 11, 2, 1
;Palette B4
    dcolor 31, 31, 31
    dcolor 25, 21, 12
    dcolor 20, 15, 8
    dcolor 11, 2, 1
;Palette B5
    dcolor 31, 31, 31
    dcolor 25, 21, 12
    dcolor 20, 15, 8
    dcolor 11, 2, 1
;Palette B6
    dcolor 31, 31, 31
    dcolor 25, 21, 12
    dcolor 20, 15, 8
    dcolor 11, 2, 1
;Palette B7
    dcolor 31, 31, 31
    dcolor 31, 15, 2
    dcolor 31, 20, 7
    dcolor 28, 28, 3
;Palette B8
    dcolor 31, 31, 31
    dcolor 31, 15, 2
    dcolor 31, 20, 7
    dcolor 28, 28, 3
;Palette B9
    dcolor 31, 31, 31
    dcolor 31, 15, 2
    dcolor 31, 20, 7
    dcolor 28, 28, 3
;Palette BA
    dcolor 31, 31, 31
    dcolor 31, 23, 2
    dcolor 31, 27, 7
    dcolor 28, 28, 3
;Palette BB
    dcolor 31, 31, 31
    dcolor 31, 23, 2
    dcolor 31, 27, 7
    dcolor 28, 28, 3
;Palette BC
    dcolor 31, 31, 31
    dcolor 31, 5, 0
    dcolor 31, 1, 0
    dcolor 6, 1, 1
;Palette BD
    dcolor 31, 31, 31
    dcolor 31, 5, 0
    dcolor 31, 1, 0
    dcolor 6, 1, 1
;Palette BE
    dcolor 31, 31, 31
    dcolor 31, 5, 0
    dcolor 31, 1, 0
    dcolor 6, 1, 1
;Palette BF
    dcolor 31, 31, 31
    dcolor 19, 23, 31
    dcolor 27, 19, 31
    dcolor 18, 9, 30
;Palette C0
    dcolor 31, 31, 31
    dcolor 19, 31, 19
    dcolor 13, 26, 20
    dcolor 6, 14, 30
;Palette C1
    dcolor 31, 31, 31
    dcolor 31, 31, 9
    dcolor 31, 20, 5
    dcolor 31, 11, 0
;Palette C2
    dcolor 31, 31, 31
    dcolor 31, 31, 9
    dcolor 31, 20, 5
    dcolor 31, 11, 0
;Palette C3
    dcolor 31, 31, 31
    dcolor 31, 11, 28
    dcolor 31, 6, 29
    dcolor 13, 6, 21
;Palette C4
    dcolor 31, 31, 31
    dcolor 31, 12, 28
    dcolor 31, 6, 29
    dcolor 13, 6, 21
;Palette C5
    dcolor 31, 31, 31
    dcolor 31, 12, 28
    dcolor 31, 6, 29
    dcolor 13, 6, 21
;Palette C6
    dcolor 31, 31, 31
    dcolor 12, 12, 28
    dcolor 7, 10, 29
    dcolor 3, 5, 21
;Palette C7
    dcolor 31, 31, 31
    dcolor 12, 28, 28
    dcolor 7, 10, 29
    dcolor 3, 5, 21
;Palette C8
    dcolor 31, 31, 31
    dcolor 22, 19, 28
    dcolor 19, 6, 29
    dcolor 1, 4, 12
;Palette C9
    dcolor 31, 31, 31
    dcolor 23, 23, 23
    dcolor 17, 17, 16
    dcolor 8, 8, 8
;Palette CA
    dcolor 31, 31, 31
    dcolor 7, 31, 17
    dcolor 7, 17, 1
    dcolor 2, 11, 0
;Palette CB
    dcolor 31, 31, 31
    dcolor 31, 30, 19
    dcolor 29, 19, 8
    dcolor 28, 4, 12
;Palette CC
    dcolor 31, 31, 31
    dcolor 31, 30, 19
    dcolor 29, 19, 8
    dcolor 28, 4, 12
;Palette CD
    dcolor 31, 31, 31
    dcolor 31, 30, 19
    dcolor 29, 19, 8
    dcolor 28, 4, 12
;Palette CE
    dcolor 31, 31, 31
    dcolor 31, 30, 19
    dcolor 29, 19, 8
    dcolor 28, 4, 12
;Palette CF
    dcolor 31, 31, 31
    dcolor 19, 30, 19
    dcolor 6, 21, 7
    dcolor 3, 13, 6
;Palette D0
    dcolor 31, 31, 31
    dcolor 19, 30, 19
    dcolor 6, 21, 7
    dcolor 7, 0, 31
;Palette D1
    dcolor 31, 31, 31
    dcolor 20, 27, 30
    dcolor 10, 23, 30
    dcolor 0, 20, 30
;Palette D2
    dcolor 31, 31, 31
    dcolor 31, 22, 25
    dcolor 31, 15, 18
    dcolor 28, 8, 6
;Palette D3
    dcolor 31, 31, 31
    dcolor 8, 25, 31
    dcolor 2, 18, 26
    dcolor 0, 13, 21
;Palette D4
    dcolor 31, 31, 31
    dcolor 6, 31, 6
    dcolor 0, 24, 0
    dcolor 0, 19, 0
;Palette D5
    dcolor 31, 31, 31
    dcolor 8, 25, 31
    dcolor 2, 18, 26
    dcolor 0, 13, 21
;Palette D6
    dcolor 31, 31, 31
    dcolor 30, 13, 9
    dcolor 29, 15, 6
    dcolor 30, 23, 5
;Palette D7
    dcolor 31, 31, 31
    dcolor 0, 25, 30
    dcolor 0, 16, 31
    dcolor 0, 3, 30
;Palette D8
    dcolor 31, 31, 31
    dcolor 31, 22, 19
    dcolor 31, 25, 21
    dcolor 31, 0, 0
;Palette D9
    dcolor 31, 31, 31
    dcolor 0, 12, 31
    dcolor 0, 23, 28
    dcolor 15, 31, 31
;Palette DA
    dcolor 31, 31, 31
    dcolor 30, 13, 9
    dcolor 29, 15, 6
    dcolor 30, 23, 5
;Palette DB
    dcolor 31, 31, 31
    dcolor 31, 20, 8
    dcolor 31, 13, 5
    dcolor 24, 7, 1
;Palette DC
    dcolor 31, 31, 31
    dcolor 31, 20, 20
    dcolor 31, 9, 9
    dcolor 24, 5, 5
;Palette DD
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette DE
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette DF
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E1
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E2
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E3
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E4
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E5
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E6
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E7
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E8
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette E9
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette EA
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette EB
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette EC
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette ED
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette EE
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette EF
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F1
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F2
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F3
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F4
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F5
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F6
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F7
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F8
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette F9
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette FA
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette FB
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette FC
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette FD
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette FE
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette FF
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 100
    dcolor 31, 31, 31
    dcolor 15, 12, 12
    dcolor 7, 4, 4
    dcolor 0, 0, 0
;Palette 101
    dcolor 31, 31, 31
    dcolor 26, 24, 26
    dcolor 20, 19, 21
    dcolor 0, 0, 0
;Palette 102
    dcolor 31, 31, 31
    dcolor 30, 19, 16
    dcolor 26, 12, 10
    dcolor 0, 0, 0
;Palette 103
    dcolor 31, 31, 31
    dcolor 17, 21, 17
    dcolor 13, 16, 13
    dcolor 0, 0, 0
;Palette 104
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 0, 0, 0
;Palette 105
    dcolor 31, 31, 31
    dcolor 3, 21, 22
    dcolor 0, 15, 15
    dcolor 0, 0, 0
;Palette 106
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 0, 0, 0
;Palette 107
    dcolor 31, 31, 31
    dcolor 30, 19, 18
    dcolor 27, 6, 5
    dcolor 0, 0, 0
;Palette 108
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 0, 0, 0
;Palette 109
    dcolor 31, 31, 31
    dcolor 26, 20, 24
    dcolor 19, 11, 19
    dcolor 0, 0, 0
;Palette 10A
    dcolor 31, 31, 31
    dcolor 31, 29, 26
    dcolor 4, 11, 20
    dcolor 0, 0, 0
;Palette 10B
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 28, 17, 6
    dcolor 0, 0, 0
;Palette 10C
    dcolor 31, 31, 31
    dcolor 30, 22, 11
    dcolor 18, 6, 7
    dcolor 0, 0, 0
;Palette 10D
    dcolor 31, 31, 31
    dcolor 15, 17, 25
    dcolor 31, 4, 4
    dcolor 0, 0, 0
;Palette 10E
    dcolor 31, 31, 31
    dcolor 30, 23, 21
    dcolor 27, 18, 17
    dcolor 0, 0, 0
;Palette 10F
    dcolor 31, 31, 31
    dcolor 8, 22, 19
    dcolor 28, 6, 8
    dcolor 0, 0, 0
;Palette 110
    dcolor 31, 31, 31
    dcolor 26, 20, 16
    dcolor 8, 11, 17
    dcolor 0, 0, 0
;Palette 111
    dcolor 31, 31, 31
    dcolor 10, 21, 18
    dcolor 18, 7, 9
    dcolor 0, 0, 0
;Palette 112
    dcolor 31, 31, 31
    dcolor 18, 16, 31
    dcolor 20, 0, 7
    dcolor 0, 0, 0
;Palette 113
    dcolor 31, 31, 31
    dcolor 29, 16, 10
    dcolor 25, 9, 7
    dcolor 0, 0, 0
;Palette 114
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 0, 0, 0
;Palette 115
    dcolor 31, 31, 31
    dcolor 29, 20, 0
    dcolor 5, 9, 15
    dcolor 0, 0, 0
;Palette 116
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 0, 0, 0
;Palette 117
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 0, 0, 0
;Palette 118
    dcolor 31, 31, 31
    dcolor 16, 21, 22
    dcolor 4, 11, 14
    dcolor 0, 0, 0
;Palette 119
    dcolor 31, 31, 31
    dcolor 26, 24, 22
    dcolor 28, 10, 9
    dcolor 0, 0, 0
;Palette 11A
    dcolor 31, 31, 31
    dcolor 23, 20, 24
    dcolor 16, 15, 21
    dcolor 0, 0, 0
;Palette 11B
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 17, 25, 30
    dcolor 0, 0, 0
;Palette 11C
    dcolor 31, 31, 31
    dcolor 13, 24, 27
    dcolor 14, 6, 14
    dcolor 0, 0, 0
;Palette 11D
    dcolor 31, 31, 31
    dcolor 30, 23, 8
    dcolor 0, 17, 10
    dcolor 0, 0, 0
;Palette 11E
    dcolor 31, 31, 31
    dcolor 29, 21, 13
    dcolor 8, 22, 19
    dcolor 0, 0, 0
;Palette 11F
    dcolor 31, 31, 31
    dcolor 29, 19, 5
    dcolor 21, 11, 10
    dcolor 0, 0, 0
;Palette 120
    dcolor 31, 31, 31
    dcolor 18, 16, 22
    dcolor 8, 13, 15
    dcolor 0, 0, 0
;Palette 121
    dcolor 31, 31, 31
    dcolor 20, 26, 19
    dcolor 7, 22, 14
    dcolor 0, 0, 0
;Palette 122
    dcolor 31, 31, 31
    dcolor 31, 27, 15
    dcolor 19, 9, 10
    dcolor 0, 0, 0
;Palette 123
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 28, 17, 6
    dcolor 0, 0, 0
;Palette 124
    dcolor 31, 31, 31
    dcolor 26, 24, 26
    dcolor 20, 19, 21
    dcolor 0, 0, 0
;Palette 125
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 0, 0, 0
;Palette 126
    dcolor 31, 31, 31
    dcolor 17, 21, 17
    dcolor 13, 16, 13
    dcolor 0, 0, 0
;Palette 127
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 0, 0, 0
;Palette 128
    dcolor 31, 31, 31
    dcolor 3, 21, 22
    dcolor 0, 15, 15
    dcolor 0, 0, 0
;Palette 129
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 0, 0, 0
;Palette 12A
    dcolor 31, 31, 31
    dcolor 30, 19, 18
    dcolor 27, 6, 5
    dcolor 0, 0, 0
;Palette 12B
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 0, 0, 0
;Palette 12C
    dcolor 31, 31, 31
    dcolor 26, 20, 24
    dcolor 19, 11, 19
    dcolor 0, 0, 0
;Palette 12D
    dcolor 31, 31, 31
    dcolor 20, 22, 27
    dcolor 15, 17, 24
    dcolor 0, 0, 0
;Palette 12E
    dcolor 31, 31, 31
    dcolor 30, 19, 10
    dcolor 28, 13, 9
    dcolor 0, 0, 0
;Palette 12F
    dcolor 31, 31, 31
    dcolor 16, 23, 13
    dcolor 3, 11, 5
    dcolor 0, 0, 0
;Palette 130
    dcolor 31, 31, 31
    dcolor 29, 26, 16
    dcolor 23, 16, 8
    dcolor 0, 0, 0
;Palette 131
    dcolor 31, 31, 31
    dcolor 18, 14, 3
    dcolor 6, 4, 3
    dcolor 0, 0, 0
;Palette 132
    dcolor 31, 31, 31
    dcolor 3, 21, 28
    dcolor 19, 13, 7
    dcolor 0, 0, 0
;Palette 133
    dcolor 31, 31, 31
    dcolor 30, 20, 10
    dcolor 20, 22, 17
    dcolor 0, 0, 0
;Palette 134
    dcolor 31, 31, 31
    dcolor 31, 6, 6
    dcolor 9, 12, 19
    dcolor 0, 0, 0
;Palette 135
    dcolor 31, 31, 31
    dcolor 29, 20, 12
    dcolor 29, 14, 9
    dcolor 0, 0, 0
;Palette 136
    dcolor 31, 31, 31
    dcolor 29, 19, 10
    dcolor 5, 22, 21
    dcolor 0, 0, 0
;Palette 137
    dcolor 31, 31, 31
    dcolor 15, 12, 12
    dcolor 7, 4, 4
    dcolor 0, 0, 0
;Palette 138
    dcolor 31, 31, 31
    dcolor 26, 24, 26
    dcolor 20, 19, 21
    dcolor 0, 0, 0
;Palette 139
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 0, 0, 0
;Palette 13A
    dcolor 31, 31, 31
    dcolor 17, 21, 17
    dcolor 13, 16, 13
    dcolor 0, 0, 0
;Palette 13B
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 0, 0, 0
;Palette 13C
    dcolor 31, 31, 31
    dcolor 3, 21, 22
    dcolor 0, 15, 15
    dcolor 0, 0, 0
;Palette 13D
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 0, 0, 0
;Palette 13E
    dcolor 31, 31, 31
    dcolor 30, 19, 18
    dcolor 27, 6, 5
    dcolor 0, 0, 0
;Palette 13F
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 0, 0, 0
;Palette 140
    dcolor 31, 31, 31
    dcolor 26, 20, 24
    dcolor 19, 11, 19
    dcolor 0, 0, 0
;Palette 141
    dcolor 31, 31, 31
    dcolor 31, 29, 26
    dcolor 4, 11, 20
    dcolor 0, 0, 0
;Palette 142
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 28, 17, 6
    dcolor 0, 0, 0
;Palette 143
    dcolor 31, 31, 31
    dcolor 30, 22, 11
    dcolor 18, 6, 7
    dcolor 0, 0, 0
;Palette 144
    dcolor 31, 31, 31
    dcolor 31, 7, 7
    dcolor 10, 13, 21
    dcolor 0, 0, 0
;Palette 145
    dcolor 31, 31, 31
    dcolor 30, 23, 21
    dcolor 27, 18, 17
    dcolor 0, 0, 0
;Palette 146
    dcolor 31, 31, 31
    dcolor 8, 22, 19
    dcolor 28, 6, 8
    dcolor 0, 0, 0
;Palette 147
    dcolor 31, 31, 31
    dcolor 26, 20, 16
    dcolor 8, 11, 17
    dcolor 0, 0, 0
;Palette 148
    dcolor 31, 31, 31
    dcolor 10, 21, 18
    dcolor 18, 7, 9
    dcolor 0, 0, 0
;Palette 149
    dcolor 31, 31, 31
    dcolor 26, 18, 22
    dcolor 20, 0, 7
    dcolor 0, 0, 0
;Palette 14A
    dcolor 31, 31, 31
    dcolor 29, 16, 10
    dcolor 25, 9, 7
    dcolor 0, 0, 0
;Palette 14B
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 0, 0, 0
;Palette 14C
    dcolor 31, 31, 31
    dcolor 29, 20, 0
    dcolor 5, 9, 15
    dcolor 0, 0, 0
;Palette 14D
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 0, 0, 0
;Palette 14E
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 0, 0, 0
;Palette 14F
    dcolor 31, 31, 31
    dcolor 16, 21, 22
    dcolor 4, 11, 14
    dcolor 0, 0, 0
;Palette 150
    dcolor 31, 31, 31
    dcolor 26, 24, 22
    dcolor 28, 10, 9
    dcolor 0, 0, 0
;Palette 151
    dcolor 31, 31, 31
    dcolor 23, 20, 24
    dcolor 16, 15, 21
    dcolor 0, 0, 0
;Palette 152
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 7, 23, 29
    dcolor 0, 0, 0
;Palette 153
    dcolor 31, 31, 31
    dcolor 13, 24, 27
    dcolor 0, 21, 23
    dcolor 0, 0, 0
;Palette 154
    dcolor 31, 31, 31
    dcolor 30, 23, 8
    dcolor 0, 17, 10
    dcolor 0, 0, 0
;Palette 155
    dcolor 31, 31, 31
    dcolor 29, 21, 13
    dcolor 8, 22, 19
    dcolor 0, 0, 0
;Palette 156
    dcolor 31, 31, 31
    dcolor 29, 19, 5
    dcolor 21, 11, 10
    dcolor 0, 0, 0
;Palette 157
    dcolor 31, 31, 31
    dcolor 18, 16, 22
    dcolor 13, 10, 19
    dcolor 0, 0, 0
;Palette 158
    dcolor 31, 31, 31
    dcolor 20, 26, 19
    dcolor 7, 21, 14
    dcolor 0, 0, 0
;Palette 159
    dcolor 31, 31, 31
    dcolor 28, 14, 8
    dcolor 19, 9, 10
    dcolor 0, 0, 0
;Palette 15A
    dcolor 31, 31, 31
    dcolor 29, 21, 13
    dcolor 8, 22, 19
    dcolor 0, 0, 0
;Palette 15B
    dcolor 31, 31, 31
    dcolor 29, 12, 0
    dcolor 5, 9, 15
    dcolor 0, 0, 0
;Palette 15C
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 0, 0, 0
;Palette 15D
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 0, 0, 0
;Palette 15E
    dcolor 31, 31, 31
    dcolor 31, 9, 7
    dcolor 4, 11, 14
    dcolor 0, 0, 0
;Palette 15F
    dcolor 31, 31, 31
    dcolor 26, 24, 22
    dcolor 10, 10, 19
    dcolor 0, 0, 0
;Palette 160
    dcolor 31, 31, 31
    dcolor 30, 22, 10
    dcolor 16, 15, 22
    dcolor 0, 0, 0
;Palette 161
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 7, 23, 29
    dcolor 0, 0, 0
;Palette 162
    dcolor 31, 31, 31
    dcolor 13, 24, 27
    dcolor 2, 10, 16
    dcolor 0, 0, 0
;Palette 163
    dcolor 31, 31, 31
    dcolor 30, 23, 8
    dcolor 0, 17, 10
    dcolor 0, 0, 0
;Palette 164
    dcolor 31, 31, 31
    dcolor 28, 24, 13
    dcolor 25, 19, 12
    dcolor 0, 0, 0
;Palette 165
    dcolor 31, 31, 31
    dcolor 18, 21, 30
    dcolor 18, 6, 14
    dcolor 0, 0, 0
;Palette 166
    dcolor 31, 31, 31
    dcolor 10, 14, 22
    dcolor 7, 10, 16
    dcolor 0, 0, 0
;Palette 167
    dcolor 31, 31, 31
    dcolor 17, 7, 11
    dcolor 9, 21, 7
    dcolor 0, 0, 0
;Palette 168
    dcolor 31, 31, 31
    dcolor 30, 25, 9
    dcolor 29, 14, 11
    dcolor 0, 0, 0
;Palette 169
    dcolor 31, 31, 31
    dcolor 13, 10, 13
    dcolor 8, 6, 8
    dcolor 0, 0, 0
;Palette 16A
    dcolor 31, 31, 31
    dcolor 28, 25, 14
    dcolor 18, 16, 10
    dcolor 0, 0, 0
;Palette 16B
    dcolor 31, 31, 31
    dcolor 30, 24, 8
    dcolor 23, 12, 3
    dcolor 0, 0, 0
;Palette 16C
    dcolor 31, 31, 31
    dcolor 22, 29, 30
    dcolor 14, 19, 24
    dcolor 0, 0, 0
;Palette 16D
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 0, 0, 0
;Palette 16E
    dcolor 31, 31, 31
    dcolor 17, 16, 17
    dcolor 12, 10, 14
    dcolor 0, 0, 0
;Palette 16F
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 0, 0, 0
;Palette 170
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 0, 0, 0
;Palette 171
    dcolor 31, 31, 31
    dcolor 9, 12, 31
    dcolor 18, 11, 7
    dcolor 0, 0, 0
;Palette 172
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 0, 0, 0
;Palette 173
    dcolor 31, 31, 31
    dcolor 31, 29, 26
    dcolor 4, 11, 20
    dcolor 0, 0, 0
;Palette 174
    dcolor 31, 31, 31
    dcolor 30, 22, 11
    dcolor 18, 19, 23
    dcolor 0, 0, 0
;Palette 175
    dcolor 31, 31, 31
    dcolor 30, 23, 21
    dcolor 27, 18, 17
    dcolor 0, 0, 0
;Palette 176
    dcolor 31, 31, 31
    dcolor 26, 20, 16
    dcolor 8, 11, 17
    dcolor 0, 0, 0
;Palette 177
    dcolor 31, 31, 31
    dcolor 5, 11, 22
    dcolor 20, 0, 7
    dcolor 0, 0, 0
;Palette 178
    dcolor 31, 31, 31
    dcolor 15, 12, 12
    dcolor 7, 4, 4
    dcolor 0, 0, 0
;Palette 179
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 0, 0, 0
;Palette 17A
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 0, 0, 0
;Palette 17B
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 0, 0, 0
;Palette 17C
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 0, 0, 0
;Palette 17D
    dcolor 31, 31, 31
    dcolor 31, 29, 26
    dcolor 4, 11, 20
    dcolor 0, 0, 0
;Palette 17E
    dcolor 31, 31, 31
    dcolor 30, 22, 11
    dcolor 18, 6, 7
    dcolor 0, 0, 0
;Palette 17F
    dcolor 31, 31, 31
    dcolor 30, 23, 21
    dcolor 27, 18, 17
    dcolor 0, 0, 0
;Palette 180
    dcolor 31, 31, 31
    dcolor 26, 20, 16
    dcolor 8, 11, 17
    dcolor 0, 0, 0
;Palette 181
    dcolor 31, 31, 31
    dcolor 13, 8, 23
    dcolor 20, 0, 7
    dcolor 0, 0, 0
;Palette 182
    dcolor 31, 31, 31
    dcolor 3, 16, 9
    dcolor 12, 10, 14
    dcolor 0, 0, 0
;Palette 183
    dcolor 31, 31, 31
    dcolor 30, 22, 13
    dcolor 29, 17, 8
    dcolor 0, 0, 0
;Palette 184
    dcolor 31, 31, 31
    dcolor 18, 18, 24
    dcolor 13, 12, 16
    dcolor 0, 0, 0
;Palette 185
    dcolor 31, 31, 31
    dcolor 31, 30, 19
    dcolor 21, 19, 11
    dcolor 0, 0, 0
;Palette 186
    dcolor 31, 31, 31
    dcolor 12, 21, 12
    dcolor 25, 12, 5
    dcolor 0, 0, 0
;Palette 187
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 0, 0, 0
;Palette 188
    dcolor 31, 31, 31
    dcolor 29, 12, 0
    dcolor 5, 9, 15
    dcolor 0, 0, 0
;Palette 189
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 0, 0, 0
;Palette 18A
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 0, 0, 0
;Palette 18B
    dcolor 31, 31, 31
    dcolor 30, 15, 0
    dcolor 4, 11, 14
    dcolor 0, 0, 0
;Palette 18C
    dcolor 31, 31, 31
    dcolor 26, 24, 22
    dcolor 20, 0, 6
    dcolor 0, 0, 0
;Palette 18D
    dcolor 31, 31, 31
    dcolor 23, 20, 24
    dcolor 0, 16, 14
    dcolor 0, 0, 0
;Palette 18E
    dcolor 31, 31, 31
    dcolor 22, 27, 31
    dcolor 20, 3, 12
    dcolor 0, 0, 0
;Palette 18F
    dcolor 31, 31, 31
    dcolor 13, 24, 28
    dcolor 1, 21, 24
    dcolor 0, 0, 0
;Palette 190
    dcolor 31, 31, 31
    dcolor 30, 23, 8
    dcolor 0, 17, 10
    dcolor 0, 0, 0
;Palette 191
    dcolor 31, 31, 31
    dcolor 31, 28, 19
    dcolor 5, 20, 13
    dcolor 0, 0, 0
;Palette 192
    dcolor 31, 31, 31
    dcolor 10, 19, 26
    dcolor 6, 11, 17
    dcolor 0, 0, 0
;Palette 193
    dcolor 31, 31, 31
    dcolor 24, 26, 25
    dcolor 10, 20, 20
    dcolor 0, 0, 0
;Palette 194
    dcolor 31, 31, 31
    dcolor 17, 16, 21
    dcolor 11, 11, 15
    dcolor 0, 0, 0
;Palette 195
    dcolor 31, 31, 31
    dcolor 0, 22, 19
    dcolor 0, 16, 13
    dcolor 0, 0, 0
;Palette 196
    dcolor 31, 31, 31
    dcolor 13, 16, 17
    dcolor 8, 10, 26
    dcolor 0, 0, 0
;Palette 197
    dcolor 31, 31, 31
    dcolor 29, 23, 0
    dcolor 5, 9, 15
    dcolor 0, 0, 0
;Palette 198
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 0, 0, 0
;Palette 199
    dcolor 31, 31, 31
    dcolor 22, 16, 21
    dcolor 1, 21, 23
    dcolor 0, 0, 0
;Palette 19A
    dcolor 31, 31, 31
    dcolor 10, 19, 26
    dcolor 27, 14, 3
    dcolor 0, 0, 0
;Palette 19B
    dcolor 31, 31, 31
    dcolor 31, 3, 3
    dcolor 8, 5, 4
    dcolor 0, 0, 0
;Palette 19C
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 0, 0, 0
;Palette 19D
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 0, 0, 0
;Palette 19E
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 0, 0, 0
;Palette 19F
    dcolor 31, 31, 31
    dcolor 29, 29, 28
    dcolor 14, 23, 28
    dcolor 0, 0, 0
;Palette 1A0
    dcolor 31, 31, 31
    dcolor 13, 16, 17
    dcolor 8, 10, 26
    dcolor 0, 0, 0
;Palette 1A1
    dcolor 31, 31, 31
    dcolor 29, 23, 0
    dcolor 5, 9, 15
    dcolor 0, 0, 0
;Palette 1A2
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 0, 0, 0
;Palette 1A3
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 0, 0, 0
;Palette 1A4
    dcolor 31, 31, 31
    dcolor 31, 27, 13
    dcolor 26, 16, 5
    dcolor 0, 0, 0
;Palette 1A5
    dcolor 31, 31, 31
    dcolor 24, 24, 27
    dcolor 13, 19, 26
    dcolor 0, 0, 0
;Palette 1A6
    dcolor 31, 31, 31
    dcolor 26, 14, 9
    dcolor 19, 7, 5
    dcolor 0, 0, 0
;Palette 1A7
    dcolor 31, 31, 31
    dcolor 29, 19, 8
    dcolor 24, 9, 6
    dcolor 0, 0, 0
;Palette 1A8
    dcolor 31, 31, 31
    dcolor 19, 14, 12
    dcolor 25, 1, 5
    dcolor 0, 0, 0
;Palette 1A9
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 0, 0, 0
;Palette 1AA
    dcolor 31, 31, 31
    dcolor 29, 21, 0
    dcolor 5, 9, 15
    dcolor 0, 0, 0
;Palette 1AB
    dcolor 31, 31, 31
    dcolor 20, 13, 10
    dcolor 25, 3, 5
    dcolor 0, 0, 0
;Palette 1AC
    dcolor 31, 31, 31
    dcolor 12, 23, 30
    dcolor 4, 10, 22
    dcolor 0, 0, 0
;Palette 1AD
    dcolor 31, 31, 31
    dcolor 31, 23, 0
    dcolor 27, 3, 2
    dcolor 0, 0, 0
;Palette 1AE
    dcolor 31, 31, 31
    dcolor 4, 10, 22
    dcolor 12, 23, 30
    dcolor 0, 0, 0
;Palette 1AF
    dcolor 31, 31, 31
    dcolor 27, 3, 2
    dcolor 31, 23, 0
    dcolor 0, 0, 0
;Palette 1B0
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1B1
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1B2
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1B3
    dcolor 0, 0, 0
    dcolor 31, 24, 0
    dcolor 31, 19, 8
    dcolor 31, 0, 9
;Palette 1B4
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1B5
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1B6
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1B7
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1B8
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1B9
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1BA
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1BB
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1BC
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1BD
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1BE
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1BF
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C0
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C1
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C2
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C3
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C4
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C5
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C6
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C7
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C8
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1C9
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1CA
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1CB
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1CC
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1CD
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1CE
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1CF
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D0
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D1
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D2
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D3
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D4
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D5
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D6
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D7
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D8
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1D9
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1DA
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1DB
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1DC
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1DD
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1DE
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1DF
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E0
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E1
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E2
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E3
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E4
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E5
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E6
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E7
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E8
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1E9
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1EA
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1EB
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1EC
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1ED
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1EE
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1EF
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1F0
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1F1
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1F2
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1F3
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1F4
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1F5
    dcolor 31, 31, 31
    dcolor 31, 31, 17
    dcolor 29, 18, 8
    dcolor 31, 12, 0
;Palette 1F6
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1F7
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1F8
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1F9
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1FA
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1FB
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
    dcolor 0, 0, 0
;Palette 1FC
    dcolor 31, 31, 31
    dcolor 31, 10, 12
    dcolor 31, 10, 12
    dcolor 31, 10, 12
