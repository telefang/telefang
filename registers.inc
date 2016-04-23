;Locations and names for common hardware registers.
;These are macros rather than labels since their location should never change
;The names for the registers were pulled from PANDOCS which is why they're shit

REG_IF EQU $FF0F
REG_LCDC EQU $FF40
REG_STAT EQU $FF41
REG_SCY EQU $FF42
REG_SCX EQU $FF43
REG_LY EQU $FF44
REG_LYC EQU $FF45
REG_BGP EQU $FF47
REG_OBP0 EQU $FF48
REG_OBP1 EQU $FF49
REG_WY EQU $FF4A
REG_WX EQU $FF4B
REG_KEY1 EQU $FF4D
REG_VBK EQU $FF4F
REG_RP EQU $FF56
REG_SVBK EQU $FF70
REG_IE EQU $FFFF

;Locations and names for MBC3-specific registers

REG_MBC3_SRAMENABLE EQU $0000
REG_MBC3_ROMBANK EQU $2000
REG_MBC3_SRAMBANK EQU $4000
REG_MBC3_RTCLATCH EQU $6000