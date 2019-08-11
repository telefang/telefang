INCLUDE "components/sgb/palettes.inc"

SECTION "SGB Palette Table", ROMX[$6BC8], BANK[3]
SGB_PaletteData::

	;Default
    dSGB_Palette $7FFF, $4A52, $2522, 0 ; 00
    
    ;Title Screen
    dSGB_Palette $7FFF, $3F9F, $223E, 0 ; 01
    dSGB_Palette $7FFF, $3ADB, $25D2, 0 ; 02
    dSGB_Palette $7FFF, $02BE, $01D6, 0 ; 03
    dSGB_Palette $7FFF, $624A, $5186, 0 ; 04

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
    dSGB_Palette $7FFF, $4F5E, $10BF, 0 ; 0D
    dSGB_Palette $7FFF, $4B1F, $7D40, 0 ; 0E

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
    dSGB_Palette $7FFF, $573B, $3EB8, 0 ; 1A
    dSGB_Palette $7FFF, $573B, $7631, 0 ; 1B
    dSGB_Palette $7FFF, $7EF6, $3EB8, 0 ; 1C

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

    ;unused?
    dSGB_Palette $7FFF, $427B, $1D77, $889 ; 27
    dSGB_Palette $7FFF, $726E, $6564, $2881 ; 28
    dSGB_Palette $7FFF, $628C, $45A0, $18A0 ; 29
    dSGB_Palette $7FFF, $4E19, $28D4, $1048 ; 2A
    dSGB_Palette $7FFF, $23F, $5484, 0 ; 2B
    dSGB_Palette $7FFF, $5A73, $109F, 0 ; 2C
    dSGB_Palette $7FFF, $5A73, $3D6B, 0 ; 2D
    dSGB_Palette $7FFF, $7E31, $5484, 0 ; 2E

    ;BomBom Logo
    dSGB_Palette $7FFF, $29F, $11F,  $52 ; 2F

    ;unused?
    dSGB_Palette $7FFF, $421F, $18D8,  $10 ; 30
    dSGB_Palette $7FFF, $7E4C, $60E4, $4040 ; 31
    dSGB_Palette $7FFF, $239F, $273, $108 ; 32
    dSGB_Palette $7FFF, $3391, $E63, $160 ; 33
    dSGB_Palette $7FFF, $2E7D, $577,  $CC ; 34
    dSGB_Palette $7FFF, $6DFB, $40F0, $2048 ; 35
    dSGB_Palette $7FFF, $7EE4, $61C0, $3CE0 ; 36
    dSGB_Palette $7FFF, $56B5, $318C, $14A5 ; 37
    dSGB_Palette $7FFF, $6A7F, $2CD8, $142A ; 38
    dSGB_Palette $7FFF, $4AFF, $21FF, $10CC ; 39
    dSGB_Palette $7FFF, $5703, $29C5, $1100 ; 3A
    dSGB_Palette $7FFF, $31F, $215,  $C8 ; 3B
    dSGB_Palette $7FFF, $121F, $119,  $8B ; 3C
    dSGB_Palette $7FFF, $56F2, $31CA, $1904 ; 3D
    dSGB_Palette $7FFF, $5A52, $354A, $20A5 ; 3E
    dSGB_Palette $7FFF, $4A56, $294D, $14A8 ; 3F
    dSGB_Palette $7FFF, $211F,  $12, 0 ; 40
    dSGB_Palette $7FFF, $3908, $2063, 0 ; 41
    dSGB_Palette $7FFF, $351, $1C1F, 0 ; 42
    dSGB_Palette $7FFF, $25F,  $18, 0 ; 43
    dSGB_Palette $7FFF, $6B1F, $361F, 0 ; 44
    dSGB_Palette $7FFF, $7FB4, $7E80, 0 ; 45
    dSGB_Palette $7FFF, $53FF, $339, 0 ; 46
    dSGB_Palette $7FFF, $63ED, $4B20, 0 ; 47
    dSGB_Palette $7FFF, $5B7F, $2E56, 0 ; 48
    dSGB_Palette $7FFF, $7F3C, $61B4, 0 ; 49
    dSGB_Palette $7FFF, $473F, $4A3F, 0 ; 4A
    dSGB_Palette $7FFF, $5FDC, $5294, 0 ; 4B
    dSGB_Palette $7FFF, $63DB, $5692, 0 ; 4C
    dSGB_Palette $7FFF, $67DA, $5A90, 0 ; 4D
    dSGB_Palette $7FFF, $67DA, $5E6E, 0 ; 4E
    dSGB_Palette $7FFF, $6BD9, $626C, 0 ; 4F
    dSGB_Palette $7FFF, $6FD9, $666A, 0 ; 50
    dSGB_Palette $7FFF, $73D8, $6A68, 0 ; 51
    dSGB_Palette $7FFF, $73D7, $6E46, 0 ; 52
    dSGB_Palette $7FFF, $77D7, $7244, 0 ; 53
    dSGB_Palette $7FFF, $7BD6, $7642, 0 ; 54
    dSGB_Palette $7FFF, $7FF6, $7A40, 0 ; 55
    dSGB_Palette $7FFF, $7BF6, $7240, 0 ; 56
    dSGB_Palette $7FFF, $77F6, $6A41, 0 ; 57
    dSGB_Palette $7FFF, $73F6, $6242, 0 ; 58
    dSGB_Palette $7FFF, $6FF6, $5A63, 0 ; 59
    dSGB_Palette $7FFF, $6FF6, $5263, 0 ; 5A
    dSGB_Palette $7FFF, $6BF6, $4A64, 0 ; 5B
    dSGB_Palette $7FFF, $67F6, $4265, 0 ; 5C
    dSGB_Palette $7FFF, $63F6, $3A86, 0 ; 5D
    dSGB_Palette $7FFF, $5FF6, $3287, 0 ; 5E
    dSGB_Palette $7FFF, $35BB, $295B,  $1B ; 5F
    dSGB_Palette $7FFF, $628F, $3125, 0 ; 60
    dSGB_Palette $7FFF, $61D3, $40AB, 0 ; 61