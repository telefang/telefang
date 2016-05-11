SECTION "Main Script Patch Variables", WRAM0[$C7C1]
W_MainScript_VWFCurrentLetter:: ds 1
W_MainScript_VWFLetterShift:: ds 1
W_MainScript_VWFCompositeArea:: ds 2
W_MainScript_VWFOldTileMode:: ds 1
W_MainScript_VWFMainScriptHack:: ds 1
  ds 1
W_MainScript_VWFDisable:: ds 1

;Actual patches exist in their own files due to RGBDS limitations.
