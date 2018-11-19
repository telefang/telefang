INCLUDE "telefang.inc"

SECTION "Summon Screen Advice Code", ROMX[$5060], BANK[$1]
Summon_ADVICE_ExitIntoSummonScreen::
    M_AdviceSetup

    ; Remove the habitat metasprite.
    ; This will be run when going from the encounter screen to the
    ; the summon screen too, which is superfluous, but no sprites
    ; carry over between the two screens - so it doesn't do any harm.
    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 5
    call LCDC_ClearSingleMetasprite
    
    ; Original replaced code (modified to use the
    ; AuxCodeJmp return address instead of a jp)
    ld a, [W_Encounter_AlreadyInitialized]
    or a
    jr z, .initializeEncounter

.doNotInitializeEncounter
    add sp, 2 * 4
    ld hl, Summon_StateFadeOutIntoSummonScreen.encounterInitialized
    push hl
    add sp, -(2 * 3)
.initializeEncounter

    M_AdviceTeardown
    ret
