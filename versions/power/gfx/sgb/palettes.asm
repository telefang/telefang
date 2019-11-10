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

    ;Antenna Tree Cutscene Fade
    dSGB_Palette $7FFF, $5B5D, $5B19, $56F5 ; 7C
    dSGB_Palette $7FFF, $5B5D, $5B19, $56F6 ; 7D
    dSGB_Palette $7FFF, $5779, $5755, $56F5 ; 7E
    dSGB_Palette $7FFF, $5779, $5755, $56F6 ; 7F

    dSGB_Palette $7FFF, $3ABB, $3653, $2A0A ; 80
    dSGB_Palette $7FFF, $3ABB, $3653, $29EE ; 81
    dSGB_Palette $7FFF, $2AF4, $2A8A, $2A0A ; 82
    dSGB_Palette $7FFF, $2AF4, $2A8A, $29EE ; 83

    ;We Are Connected Cutscene Fade In (From White)
    dSGB_Palette $7FFF, $5776, $5735, $6399 ; 84
    dSGB_Palette $7FFF, $5776, $5735, $56F5 ; 85
    dSGB_Palette $7FFF, $5776, $5735, $56B5 ; 86
    dSGB_Palette $7FFF, $673D, $56BD, $56B5 ; 87

    dSGB_Palette $7FFF, $32CE, $2E6C, $4B33 ; 88
    dSGB_Palette $7FFF, $32CE, $2E6C, $2A0A ; 89
    dSGB_Palette $7FFF, $32CE, $2E6C, $294A ; 8A
    dSGB_Palette $7FFF, $4A5C, $319C, $294A ; 8B

    ;We Are Connected Cutscene Fade Out (To Black)
    dSGB_Palette $294A, $4C2, $81, $10E4 ; 8C
    dSGB_Palette $294A, $4C2, $81, $60 ; 8D
    dSGB_Palette $294A, $4C2, $81, 0 ; 8E
    dSGB_Palette $294A, $1089, $429, 0 ; 8F

    dSGB_Palette $56B5, $583, $521, $1DE9 ; 90
    dSGB_Palette $56B5, $583, $521, $A0 ; 91
    dSGB_Palette $56B5, $583, $521, 0 ; 92
    dSGB_Palette $56B5, $2111, $431, 0 ; 93

    ;One Of My Soldiers Cutscene Fade
    dSGB_Palette $7FFF, $63BF, $5F7F, $56B5 ; 94
    dSGB_Palette $7FFF, $6FBF, $5F5D, $56B5 ; 95
    dSGB_Palette $7FFF, $6FBF, $7B78, $56B5 ; 96
    dSGB_Palette $7FFF, $7B78, $6F35, $56B5 ; 97

    dSGB_Palette $7FFF, $439E, $3F1F, $296C ; 98
    dSGB_Palette $7FFF, $639F, $3ABA, $296C ; 99
    dSGB_Palette $7FFF, $639F, $7AD0, $296C ; 9A
    dSGB_Palette $7FFF, $7AD0, $624A, $296C ; 9B

    ;Title Screen Fade Out
    dSGB_Palette $7FFF, $6BDF, $5F5F, $56B5 ; 9C
    dSGB_Palette $7FFF, $6B7C, $631A, $56B5 ; 9D
    dSGB_Palette $7FFF, $779B, $6F59, $56B5 ; 9E
    dSGB_Palette $7FFF, $6F7F, $631F, $56BF ; 9F

    dSGB_Palette $7FFF, $53BF, $42DE, $294A ; A0
    dSGB_Palette $7FFF, $56D9, $4256, $294A ; A1
    dSGB_Palette $7FFF, $6F58, $5AB3, $294A ; A2
    dSGB_Palette $7FFF, $631F, $463F, $295F ; A3

    ;Title Screen Fade In
    dSGB_Palette $294A, $152A, $CCA, 0 ; A4
    dSGB_Palette $294A, $14C7, $C86, 0 ; A5
    dSGB_Palette $294A, $2107, $18A4, 0 ; A6
    dSGB_Palette $294A, $1CEA, $C6A, $A ; A7

    dSGB_Palette $56B5, $2A75, $1574, 0 ; A8
    dSGB_Palette $56B5, $2D8F, $18EB, 0 ; A9
    dSGB_Palette $56B5, $45ED, $3169, 0 ; AA
    dSGB_Palette $56B5, $35B5, $1CF5, $15 ; AB

    ;Game Over Fade Out
    dSGB_Palette $7FFF, $63BF, $7F58, $56B5 ; AC
    dSGB_Palette $7FFF, $6B7E, $631B, $56B5 ; AD
    dSGB_Palette $7FFF, $6B7E, $5F96, $56B5 ; AE
    dSGB_Palette $7FFF, $5F96, $631B, $56B5 ; AF

    dSGB_Palette $7FFF, $439F, $7EB2, $294A ; B0
    dSGB_Palette $7FFF, $531E, $4257, $294A ; B1
    dSGB_Palette $7FFF, $531E, $430E, $294A ; B2
    dSGB_Palette $7FFF, $430E, $4257, $294A ; B3

    ;Game Over Fade In
    dSGB_Palette $294A, $D2A, $28A4, 0 ; B4
    dSGB_Palette $294A, $14EA, $C86, 0 ; B5
    dSGB_Palette $294A, $14EA, $CE2, 0 ; B6
    dSGB_Palette $294A, $CE2, $C86, 0 ; B7

    dSGB_Palette $56B5, $1A35, $5567, 0 ; B8
    dSGB_Palette $56B5, $29B3, $18ED, 0 ; B9
    dSGB_Palette $56B5, $29B3, $15C3, 0 ; BA
    dSGB_Palette $56B5, $15C3, $18ED, 0 ; BB

    ;Corruption Screen Fade Out
    dSGB_Palette $7FFF, $631D, $6378, $56B5 ; BC
    dSGB_Palette $7FFF, $6F9F, $631D, $56B5 ; BD
    dSGB_Palette $7FFF, $631D, $5AD9, $56B5 ; BE
    dSGB_Palette $7FFF, $77DF, $6F9F, $56B5 ; BF

    dSGB_Palette $7FFF, $423B, $4710, $294A ; C0
    dSGB_Palette $7FFF, $5B5E, $423B, $294A ; C1
    dSGB_Palette $7FFF, $423B, $31B2, $294A ; C2
    dSGB_Palette $7FFF, $6BDF, $5B5E, $294A ; C3

    ;Corruption Screen Fade In
    dSGB_Palette $294A, $C68, $CE3, 0 ; C4
    dSGB_Palette $294A, $190A, $C68, 0 ; C5
    dSGB_Palette $294A, $C68, $424, 0 ; C6
    dSGB_Palette $294A, $214A, $190A, 0 ; C7

    dSGB_Palette $56B5, $18F1, $1DA6, 0 ; C8
    dSGB_Palette $56B5, $31F4, $18F1, 0 ; C9
    dSGB_Palette $56B5, $18F1, $868, 0 ; CA
    dSGB_Palette $56B5, $4275, $31F4, 0 ; CB

    ;Link Menu Fade
    dSGB_Palette $7FFF, $63BF, $5F7E, $56B5 ; CC
    dSGB_Palette $7FFF, $7FDA, $7797, $6716 ; CD
    dSGB_Palette $7FFF, $7797, $6716, $56B5 ; CE
    dSGB_Palette $7FFF, $77BF, $633F, $56B5 ; CF
    dSGB_Palette $7FFF, $73DC, $57B5, $56B5 ; D0
    dSGB_Palette $7FFF, $7BBF, $7F7E, $56B7 ; D1

    dSGB_Palette $7FFF, $439E, $3F1E, $294A ; D2
    dSGB_Palette $7FFF, $7FD6, $7310, $522D ; D3
    dSGB_Palette $7FFF, $7310, $522D, $294A ; D4
    dSGB_Palette $7FFF, $6B5F, $465E, $294A ; D5
    dSGB_Palette $7FFF, $63B8, $2B6A, $294A ; D6
    dSGB_Palette $7FFF, $7B7F, $7EFE, $296E ; D7

    ;Unused
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
