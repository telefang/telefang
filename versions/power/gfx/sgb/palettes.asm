INCLUDE "components/sgb/palettes.inc"

SECTION "SGB Palette Table", ROMX[$6BC8], BANK[3]
SGB_PaletteData::

	;Default
    dSGB_Palette $7FFF, $4A52, $2522, 0 ; 00
    
    ;Title Screen
    dSGB_Palette $7FFF, $3F9F, $223E, 0 ; 01
    dSGB_Palette $7FFF, $4256, $2571, 0 ; 02
    dSGB_Palette $7FFF, $66F4, $4A0D, 0 ; 03
    dSGB_Palette $7FFF, $529F, $295F, $001F ; 04

	;Antenna Tree Cutscene
    dSGB_Palette $7FFF, $1619, $116D, $100 ; 05
    dSGB_Palette $7FFF, $1619, $116D, $E5 ; 06
    dSGB_Palette $7FFF, $26E, $1E0, $100 ; 07
    dSGB_Palette $7FFF, $26E, $1E0, $E5 ; 08
    
    ;We Are Connected Cutscene
    dSGB_Palette $7FFF, $A45, $5A2, $2ECD ; 09
    dSGB_Palette $7FFF, $A45, $5A2, $100 ; 0A
    dSGB_Palette $7FFF, $A45, $5A2, 0 ; 0B
    dSGB_Palette $7FFF, $319A, $85A, 0 ; 0C
    dSGB_Palette $7FFF, $299F, $299F, 0 ; 0D
    dSGB_Palette $7FFF, $7E86, $7E86, 0 ; 0E

    ;One Of My Soldiers Cutscene
    dSGB_Palette $7FFF, $275E, $1E9F, $22 ; 0F
	
    dSGB_Palette $7FFF, $190A, $8A8, $22 ; 10
    dSGB_Palette $7FFF, $190A, $24C3, $22 ; 11
    dSGB_Palette $7FFF, $24C3, $1880, $22 ; 12
	
    dSGB_Palette $7FFF, $3214, $1150, $22 ; 13
    dSGB_Palette $7FFF, $3214, $4986, $22 ; 14
    dSGB_Palette $7FFF, $4986, $3100, $22 ; 15
	
    dSGB_Palette $7FFF, $535F, $1A18, $22 ; 16
    dSGB_Palette $7FFF, $535F, $7649, $22 ; 17
    dSGB_Palette $7FFF, $7649, $5180, $22 ; 18

    ;Game Over
    dSGB_Palette $7FFF, $275F, $7E0B, 0 ; 19
    dSGB_Palette $7FFF, $3E9D, $2573, 0 ; 1A
    dSGB_Palette $7FFF, $3E9D, $22A5, 0 ; 1B
    dSGB_Palette $7FFF, $22A5, $2573, 0 ; 1C

    ;Zukan Completion Cert
    dSGB_Palette $7FF9, $6B39, $421A, $10DB ; 1D
    dSGB_Palette $7FF9, $7753, $5EC6, $4141 ; 1E
    dSGB_Palette $7FF9, $57BB, $36CA, $4141 ; 1F
    dSGB_Palette $7FF9, $57BB, $1EDF, $4141 ; 20

    ;Link Menu
    dSGB_Palette $7FFF, $275E, $1E9D, 0 ; 21
    dSGB_Palette $7FFF, $7FB1, $6AA8, $3944 ; 22
    dSGB_Palette $7FFF, $6AA8, $3944, 0 ; 23
    dSGB_Palette $7FFF, $631F, $299E, 0 ; 24
    dSGB_Palette $7FFF, $5795, $320,  0 ; 25
    dSGB_Palette $7FFF, $773F, $7E7D, 0 ; 26

    ;Tree Swoosh (Intro Scene 3)
    dSGB_Palette $7FFF, $4311, $1625, $86A ; 27
    dSGB_Palette $7FFF, $4315, $1A2C, $86A ; 28
    dSGB_Palette $7FFF, $4319, $1E33, $86A ; 29
    dSGB_Palette $7FFF, $3F3F, $1E3C, $86A ; 2A

    ;Shigeki Cave (Intro Scene 1)
    dSGB_Palette $7FFF, $6F53, $51E5, $24C1 ; 2B
    dSGB_Palette $7FFF, $72F2, $5164, $24C1 ; 2C
    dSGB_Palette $7FFF, $535E, $1D3D, $24C1 ; 2D
    dSGB_Palette $7FFF, $72F2, $1D3D, $24C1 ; 2E

    ;BomBom Logo
    dSGB_Palette $7FFF, $29F, $11F,  $52 ; 2F

    ;Corruption Screen
    dSGB_Palette $7FFF, $2559, $2A89, 0 ; 30
    dSGB_Palette $7FFF, $4AFE, $2559, 0 ; 31
    dSGB_Palette $7FFF, $2559, $C8C, 0 ; 32
    dSGB_Palette $7FFF, $63BF, $4AFE, 0 ; 33

    ;Shigeki Talking on Phone (Intro Scene 2)
    dSGB_Palette $7FFF, $6AF5, $4123, $1881 ; 34
    dSGB_Palette $7FFF, $573E, $4123, $1881 ; 35
    dSGB_Palette $7FFF, $573E, $1D3C, $1881 ; 36
    dSGB_Palette $7FFF, $573E, $772E, $1881 ; 37

    ;Shigeki and Crypto (Intro Scene 4)
    dSGB_Palette $7FFF, $72F2, $4D64, $C6B ; 38
    dSGB_Palette $7FFF, $3B3E, $31DB, $C6B ; 39
    dSGB_Palette $7FFF, $3B3E, $1D3C, $C6B ; 3A
    dSGB_Palette $7FFF, $26AB, $D43, 0 ; 3B

    ;Crypto (Intro Scene 6)
    dSGB_Palette $7FFF, $433E, $1D5C, $C68 ; 3C
    dSGB_Palette $7FFF, $3ECF, $1184, $C68 ; 3D
    dSGB_Palette $7FFF, $433E, $1184, $C68 ; 3E
    dSGB_Palette $7FFF, $31B4, $14CC, $C68 ; 3F
	
    dSGB_Palette $7FFF, $4319, $1974, $C68 ; 40
    dSGB_Palette $7FFF, $433E, $1974, $C68 ; 41
    dSGB_Palette $7FFF, $3EBB, $1937, $C68 ; 42
	
    dSGB_Palette $7FFF, $3EF4, $158C, $C68 ; 43
    dSGB_Palette $7FFF, $433E, $158C, $C68 ; 44
    dSGB_Palette $7FFF, $3638, $18F2, $C68 ; 45

    ;Angios (Intro Scene 5)
    dSGB_Palette $7FFF, $62F3, $39A9, 0 ; 46
    dSGB_Palette $7FFF, $62F3, $39A9, $28C2 ; 47
    dSGB_Palette $7FFF, $62F3, $6A47, $28C2 ; 48
    dSGB_Palette $7FFF, $6A47, $39A9, $28C2 ; 49

    ;Fade General
    dSGB_Palette 0, 0, 0, 0 ; 4A
    dSGB_Palette $7FFF, $7FFF, $7FFF, $7FFF ; 4B

	;Shigeki Cave (Intro Scene 1) Fade
    dSGB_Palette $7FFF, $7BBB, $6F56, $62F5 ; 4C
    dSGB_Palette $7FFF, $7B9B, $6F16, $62F5 ; 4D
    dSGB_Palette $7FFF, $6FBF, $5F1E, $62F5 ; 4E
    dSGB_Palette $7FFF, $7B9B, $5F1E, $62F5 ; 4F

    dSGB_Palette $7FFF, $7397, $628E, $41CB ; 50
    dSGB_Palette $7FFF, $7756, $624D, $41CB ; 51
    dSGB_Palette $7FFF, $639E, $3E1E, $41CB ; 52
    dSGB_Palette $7FFF, $7756, $3E1E, $41CB ; 53

    ;Tree Swoosh (Intro Scene 3) Fade
    dSGB_Palette $7FFF, $6BBA, $5B56, $56D8 ; 54
    dSGB_Palette $7FFF, $6BBC, $5F59, $56D8 ; 55
    dSGB_Palette $7FFF, $6BBD, $5F5B, $56D8 ; 56
    dSGB_Palette $7FFF, $6BBF, $5F5E, $56D8 ; 57

    dSGB_Palette $7FFF, $5756, $3ACE, $3191 ; 58
    dSGB_Palette $7FFF, $5758, $3AD2, $3191 ; 59
    dSGB_Palette $7FFF, $575B, $3ED7, $3191 ; 5A
    dSGB_Palette $7FFF, $537F, $3EDD, $3191 ; 5B

    ;Shigeki Talking on Phone (Intro Scene 2) Fade
    dSGB_Palette $7FFF, $779C, $6B16, $5ED5 ; 5C
    dSGB_Palette $7FFF, $73BF, $6B16, $5ED5 ; 5D
    dSGB_Palette $7FFF, $73BF, $5F1E, $5ED5 ; 5E
    dSGB_Palette $7FFF, $73BF, $7BB9, $5ED5 ; 5F

    dSGB_Palette $7FFF, $7358, $560C, $39AB ; 60
    dSGB_Palette $7FFF, $637E, $560C, $39AB ; 61
    dSGB_Palette $7FFF, $637E, $3E1D, $39AB ; 62
    dSGB_Palette $7FFF, $637E, $7B74, $39AB ; 63

    ;Shigeki and Crypto (Intro Scene 4) Fade
    dSGB_Palette $7FFF, $7B9B, $6F16, $5AD8 ; 64
    dSGB_Palette $7FFF, $67BF, $673E, $5AD8 ; 65
    dSGB_Palette $7FFF, $67BF, $5F1E, $5AD8 ; 66
    dSGB_Palette $7FFF, $6398, $5B16, $56B5 ; 67

    dSGB_Palette $7FFF, $7756, $5E4D, $3192 ; 68
    dSGB_Palette $7FFF, $537E, $4A9C, $3192 ; 69
    dSGB_Palette $7FFF, $537E, $3E1D, $3192 ; 6A
    dSGB_Palette $7FFF, $4312, $322C, $294A ; 6B

    ;Crypto (Intro Scene 6) Fade
    dSGB_Palette $7FFF, $6BBF, $5F1E, $5AD7 ; 6C
    dSGB_Palette $7FFF, $6B9A, $5B36, $5AD7 ; 6D
    dSGB_Palette $7FFF, $6BBF, $5B36, $5AD7 ; 6E
    dSGB_Palette $7FFF, $673B, $5AF9, $5AD7 ; 6F

    dSGB_Palette $7FFF, $577E, $3E3D, $3190 ; 70
    dSGB_Palette $7FFF, $5334, $364D, $3190 ; 71
    dSGB_Palette $7FFF, $577E, $364D, $3190 ; 72
    dSGB_Palette $7FFF, $4A78, $39D2, $3190 ; 73

    ;Angios (Intro Scene 5) Fade
    dSGB_Palette $7FFF, $779B, $6738, $56B5 ; 74
    dSGB_Palette $7FFF, $779B, $6738, $62F5 ; 75
    dSGB_Palette $7FFF, $779B, $7777, $62F5 ; 76
    dSGB_Palette $7FFF, $7777, $6738, $62F5 ; 77

    dSGB_Palette $7FFF, $6B57, $5270, $294A ; 78
    dSGB_Palette $7FFF, $6B57, $5270, $45CC ; 79
    dSGB_Palette $7FFF, $6B57, $72CF, $45CC ; 7A
    dSGB_Palette $7FFF, $72CF, $5270, $45CC ; 7B

    ;Unused
    dSGB_Palette 0, 0, 0, 0 ; 7C
    dSGB_Palette 0, 0, 0, 0 ; 7D
    dSGB_Palette 0, 0, 0, 0 ; 7E
    dSGB_Palette 0, 0, 0, 0 ; 7F
    dSGB_Palette 0, 0, 0, 0 ; 80
    dSGB_Palette 0, 0, 0, 0 ; 81
    dSGB_Palette 0, 0, 0, 0 ; 82
    dSGB_Palette 0, 0, 0, 0 ; 83
    dSGB_Palette 0, 0, 0, 0 ; 84
    dSGB_Palette 0, 0, 0, 0 ; 85
    dSGB_Palette 0, 0, 0, 0 ; 86
    dSGB_Palette 0, 0, 0, 0 ; 87
    dSGB_Palette 0, 0, 0, 0 ; 88
    dSGB_Palette 0, 0, 0, 0 ; 89
    dSGB_Palette 0, 0, 0, 0 ; 8A
    dSGB_Palette 0, 0, 0, 0 ; 8B
    dSGB_Palette 0, 0, 0, 0 ; 8C
    dSGB_Palette 0, 0, 0, 0 ; 8D
    dSGB_Palette 0, 0, 0, 0 ; 8E
    dSGB_Palette 0, 0, 0, 0 ; 8F
    dSGB_Palette 0, 0, 0, 0 ; 90
    dSGB_Palette 0, 0, 0, 0 ; 91
    dSGB_Palette 0, 0, 0, 0 ; 92
    dSGB_Palette 0, 0, 0, 0 ; 93
    dSGB_Palette 0, 0, 0, 0 ; 94
    dSGB_Palette 0, 0, 0, 0 ; 95
    dSGB_Palette 0, 0, 0, 0 ; 96
    dSGB_Palette 0, 0, 0, 0 ; 97
    dSGB_Palette 0, 0, 0, 0 ; 98
    dSGB_Palette 0, 0, 0, 0 ; 99
    dSGB_Palette 0, 0, 0, 0 ; 9A
    dSGB_Palette 0, 0, 0, 0 ; 9B
    dSGB_Palette 0, 0, 0, 0 ; 9C
    dSGB_Palette 0, 0, 0, 0 ; 9D
    dSGB_Palette 0, 0, 0, 0 ; 9E
    dSGB_Palette 0, 0, 0, 0 ; 9F
    dSGB_Palette 0, 0, 0, 0 ; A0
    dSGB_Palette 0, 0, 0, 0 ; A1
    dSGB_Palette 0, 0, 0, 0 ; A2
    dSGB_Palette 0, 0, 0, 0 ; A3
    dSGB_Palette 0, 0, 0, 0 ; A4
    dSGB_Palette 0, 0, 0, 0 ; A5
    dSGB_Palette 0, 0, 0, 0 ; A6
    dSGB_Palette 0, 0, 0, 0 ; A7
    dSGB_Palette 0, 0, 0, 0 ; A8
    dSGB_Palette 0, 0, 0, 0 ; A9
    dSGB_Palette 0, 0, 0, 0 ; AA
    dSGB_Palette 0, 0, 0, 0 ; AB
    dSGB_Palette 0, 0, 0, 0 ; AC
    dSGB_Palette 0, 0, 0, 0 ; AD
    dSGB_Palette 0, 0, 0, 0 ; AE
    dSGB_Palette 0, 0, 0, 0 ; AF
    dSGB_Palette 0, 0, 0, 0 ; B0
    dSGB_Palette 0, 0, 0, 0 ; B1
    dSGB_Palette 0, 0, 0, 0 ; B2
    dSGB_Palette 0, 0, 0, 0 ; B3
    dSGB_Palette 0, 0, 0, 0 ; B4
    dSGB_Palette 0, 0, 0, 0 ; B5
    dSGB_Palette 0, 0, 0, 0 ; B6
    dSGB_Palette 0, 0, 0, 0 ; B7
    dSGB_Palette 0, 0, 0, 0 ; B8
    dSGB_Palette 0, 0, 0, 0 ; B9
    dSGB_Palette 0, 0, 0, 0 ; BA
    dSGB_Palette 0, 0, 0, 0 ; BB
    dSGB_Palette 0, 0, 0, 0 ; BC
    dSGB_Palette 0, 0, 0, 0 ; BD
    dSGB_Palette 0, 0, 0, 0 ; BE
    dSGB_Palette 0, 0, 0, 0 ; BF
    dSGB_Palette 0, 0, 0, 0 ; C0
    dSGB_Palette 0, 0, 0, 0 ; C1
    dSGB_Palette 0, 0, 0, 0 ; C2
    dSGB_Palette 0, 0, 0, 0 ; C3
    dSGB_Palette 0, 0, 0, 0 ; C4
    dSGB_Palette 0, 0, 0, 0 ; C5
    dSGB_Palette 0, 0, 0, 0 ; C6
    dSGB_Palette 0, 0, 0, 0 ; C7
    dSGB_Palette 0, 0, 0, 0 ; C8
    dSGB_Palette 0, 0, 0, 0 ; C9
    dSGB_Palette 0, 0, 0, 0 ; CA
    dSGB_Palette 0, 0, 0, 0 ; CB
    dSGB_Palette 0, 0, 0, 0 ; CC
    dSGB_Palette 0, 0, 0, 0 ; CD
    dSGB_Palette 0, 0, 0, 0 ; CE
    dSGB_Palette 0, 0, 0, 0 ; CF
    dSGB_Palette 0, 0, 0, 0 ; D0
    dSGB_Palette 0, 0, 0, 0 ; D1
    dSGB_Palette 0, 0, 0, 0 ; D2
    dSGB_Palette 0, 0, 0, 0 ; D3
    dSGB_Palette 0, 0, 0, 0 ; D4
    dSGB_Palette 0, 0, 0, 0 ; D5
    dSGB_Palette 0, 0, 0, 0 ; D6
    dSGB_Palette 0, 0, 0, 0 ; D7
    dSGB_Palette 0, 0, 0, 0 ; D8
    dSGB_Palette 0, 0, 0, 0 ; D9
    dSGB_Palette 0, 0, 0, 0 ; DA
    dSGB_Palette 0, 0, 0, 0 ; DB
    dSGB_Palette 0, 0, 0, 0 ; DC
    dSGB_Palette 0, 0, 0, 0 ; DD
    dSGB_Palette 0, 0, 0, 0 ; DE
    dSGB_Palette 0, 0, 0, 0 ; DF
    dSGB_Palette 0, 0, 0, 0 ; E0
    dSGB_Palette 0, 0, 0, 0 ; E1
    dSGB_Palette 0, 0, 0, 0 ; E2
    dSGB_Palette 0, 0, 0, 0 ; E3
    dSGB_Palette 0, 0, 0, 0 ; E4
    dSGB_Palette 0, 0, 0, 0 ; E5
    dSGB_Palette 0, 0, 0, 0 ; E6
    dSGB_Palette 0, 0, 0, 0 ; E7
    dSGB_Palette 0, 0, 0, 0 ; E8
    dSGB_Palette 0, 0, 0, 0 ; E9
    dSGB_Palette 0, 0, 0, 0 ; EA
    dSGB_Palette 0, 0, 0, 0 ; EB
    dSGB_Palette 0, 0, 0, 0 ; EC
    dSGB_Palette 0, 0, 0, 0 ; ED
    dSGB_Palette 0, 0, 0, 0 ; EE
    dSGB_Palette 0, 0, 0, 0 ; EF
    dSGB_Palette 0, 0, 0, 0 ; F0
    dSGB_Palette 0, 0, 0, 0 ; F1
    dSGB_Palette 0, 0, 0, 0 ; F2
    dSGB_Palette 0, 0, 0, 0 ; F3
    dSGB_Palette 0, 0, 0, 0 ; F4
    dSGB_Palette 0, 0, 0, 0 ; F5
    dSGB_Palette 0, 0, 0, 0 ; F6
    dSGB_Palette 0, 0, 0, 0 ; F7
    dSGB_Palette 0, 0, 0, 0 ; F8
    dSGB_Palette 0, 0, 0, 0 ; F9
    dSGB_Palette 0, 0, 0, 0 ; FA
    dSGB_Palette 0, 0, 0, 0 ; FB
    dSGB_Palette 0, 0, 0, 0 ; FC
    dSGB_Palette 0, 0, 0, 0 ; FD
    dSGB_Palette 0, 0, 0, 0 ; FE
    dSGB_Palette 0, 0, 0, 0 ; FF
