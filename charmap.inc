; This is used to identify character sets used by different translations when trading.

; If your character encoding differs from the English translation then you need to add a new
; "DEF M_Charset_X EQU $XX" line below and set M_Trade_Charset accordingly.

; Submit an issue here asking for your character encoding index number to be added to
; charmap.inc in the English repo (to prevent other people from using your chosen index number): 
; https://github.com/telefang/telefang/issues

; "M_Trade_Charset" being set to "M_Charset_English" for instance means that this translation uses the
; same character encoding as the English patch, not that the language is English.

DEF M_Charset_English EQU 0
DEF M_Charset_Polish EQU 1

DEF M_Trade_Charset EQU M_Charset_English
