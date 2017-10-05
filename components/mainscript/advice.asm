SECTION "Main Script Patch Variables", WRAM0[$C7C1]
W_MainScript_VWFCurrentLetter:: ds 1
W_MainScript_VWFLetterShift:: ds 1
W_MainScript_VWFCompositeArea:: ds 2
W_MainScript_VWFOldTileMode:: ds 1
W_MainScript_VWFMainScriptHack:: ds 1
W_MainScript_VWFDisable:: ds 1
W_MainScript_VWFNewlineWidth:: ds 1
W_MainScript_VWFWindowHeight:: ds 1

;Actual patches exist in their own files due to RGBDS limitations.
;Here have some trashbytes instead

SECTION "MainScript ADVICE Trash Bytes", ROMX[$79BC], BANK[$B]
;This points to somewhere inside of StoreCurrentLetter and I don't know why.
    jp $7C12
    
SECTION "MainScript ADVICE Endless Trash", ROMX[$7CD7], BANK[$B]
;I have no idea and bgb's access breakpoints never trip on these bytes.
    REPT 9
    db $FF
    ENDR
    
    REPT 7
    db $00
    ENDR
    
    REPT 21
    db $FF
    ENDR