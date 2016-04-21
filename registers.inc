;Locations and names for common hardware registers.
;These are macros rather than labels since their location should never change
;The names for the registers were pulled from PANDOCS which is why they're shit

REG_IF              EQU $FF0F
REG_STAT            EQU $FF41
REG_KEY1            EQU $FF4D
REG_VBK             EQU $FF4F
REG_RP              EQU $FF56
REG_SVBK            EQU $FF70
REG_IE              EQU $FFFF

;Locations and names for MBC3-specific registers

REG_MBC3_SRAMENABLE EQU $0000
REG_MBC3_ROMBANK    EQU $2000
REG_MBC3_SRAMBANK   EQU $4000
REG_MBC3_RTCLATCH   EQU $6000