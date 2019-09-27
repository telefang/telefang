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

    ;Tree Swoosh
    dSGB_Palette $7FFF, $4311, $1625, $86A ; 27
    dSGB_Palette $7FFF, $4315, $1A2C, $86A ; 28
    dSGB_Palette $7FFF, $4319, $1E33, $86A ; 29
    dSGB_Palette $7FFF, $3F3F, $1E3C, $86A ; 2A

    ;Shigeki Cave
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

    ;Shigeki Talking on Phone
    dSGB_Palette $7FFF, $6AF5, $4123, $1881 ; 34
    dSGB_Palette $7FFF, $573E, $4123, $1881 ; 35
    dSGB_Palette $7FFF, $573E, $1D3C, $1881 ; 36
    dSGB_Palette $7FFF, $573E, $772E, $1881 ; 37

    ;Shigeki and Crypto
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

    ;unused?
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