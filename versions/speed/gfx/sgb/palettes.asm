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

    ;Tree Swoosh
    dSGB_Palette $7FFF, $4311, $1625, $488 ; 27
    dSGB_Palette $7FFF, $4B35, $1E2B, $488 ; 28
    dSGB_Palette $7FFF, $5359, $2631, $488 ; 29
    dSGB_Palette $7FFF, $5B5E, $3218, $488 ; 2A

    ;Shigeki Cave
    dSGB_Palette $7FFF, $6F53, $51E5, $24C1 ; 2B
    dSGB_Palette $7FFF, $72F2, $5164, $24C1 ; 2C
    dSGB_Palette $7FFF, $535E, $1D3D, $24C1 ; 2D
    dSGB_Palette $7FFF, $72F2, $1D3D, $24C1 ; 2E

    ;BomBom Logo
    dSGB_Palette $7FFF, $29F, $11F,  $52 ; 2F

    ;Corruption Screen
    dSGB_Palette $7FFF, $631D, $463B, 0 ; 30
    dSGB_Palette $7FFF, $5B3C, $42B8, 0 ; 31
    dSGB_Palette $7FFF, $6650, $42B8, 0 ; 32
    dSGB_Palette $7FFF, $5B3C, $6650, 0 ; 33

    ;Shigeki Talking on Phone
    dSGB_Palette $7FFF, $6AF5, $4123, $1881 ; 34
    dSGB_Palette $7FFF, $573E, $4123, $1881 ; 35
    dSGB_Palette $7FFF, $573E, $1D3C, $1881 ; 36
    dSGB_Palette $7FFF, $573E, $772E, $1881 ; 37

    ;Shigeki and Fungus
    dSGB_Palette $7FFF, $72F2, $4D64, $C6B ; 38
    dSGB_Palette $7FFF, $5B5D, $4279, $C6B ; 39
    dSGB_Palette $7FFF, $5B5D, $1D3C, $C6B ; 3A
    dSGB_Palette $7FFF, $5B5D, $55ED, 0 ; 3B

    ;Fungus (Intro Scene 6)
    dSGB_Palette $7FFF, $4AFB, $3635, $C6B ; 3C
    dSGB_Palette $7FFF, $4AFB, $55EB, $C6B ; 3D
    dSGB_Palette $7FFF, $76EB, $55EB, $C6B ; 3E
    dSGB_Palette $7FFF, $4AFB, $1919, $C6B ; 3F
	
    dSGB_Palette $7FFF, $4AFB, $4211, $C6B ; 40
    dSGB_Palette $7FFF, $5A56, $4211, $C6B ; 41
    dSGB_Palette $7FFF, $4AFB, $29B6, $C6B ; 42
	
    dSGB_Palette $7FFF, $4AFB, $49EE, $C6B ; 43
    dSGB_Palette $7FFF, $6AF0, $49EE, $C6B ; 44
    dSGB_Palette $7FFF, $4AFB, $2177, $C6B ; 45

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