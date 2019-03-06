INCLUDE "telefang.inc"

SECTION "Link Trades - Loss States", ROMX[$7011], BANK[$1F]
LinkTrade_LossStateMachine::
    ld a, [W_Battle_4thOrderSubState]
    ld hl, .stateTbl
    call System_IndexWordList
    jp hl
    
.stateTbl
    dw LinkTrade_SubStateInitLossScreen
    dw LinkTrade_SubStateFadeInLossScreen
    dw LinkTrade_SubStateLossScreenMessage
    dw LinkTrade_SubStateFadeOutLossScreen
    
;State 0F 02 02 00
LinkTrade_SubStateInitLossScreen::
    ld bc, $16
    call Banked_LoadMaliasGraphics
    
    ld bc, $9
    call Banked_LoadMaliasGraphics
    
    ld bc, $E
    call Banked_CGBLoadBackgroundPalette
    
    ld a, $28
    call PauseMenu_CGBStageFlavorPalette
    
    ld bc, 0
    ld e, $70
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, 0
    ld e, $70
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld bc, $605
    ld e, $91
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, $605
    ld e, $8B
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ld a, 0
    ld [W_PauseMenu_CurrentContact], a
    ld a, [W_Victory_DefectedContactSpecies]
    ld de, $9100
    call Status_LoadEvolutionIndicatorBySpecies
    
    ld a, [W_Victory_DefectedContactSpecies]
    push af
    ld c, 0
    ld de, $8800
    call Banked_Battle_LoadDenjuuPortrait
    
    pop af
    call Battle_LoadDenjuuPaletteOpponent
    
    ld c, M_Battle_MessageDenjuuDefected
    call Battle_QueueMessage
    
    ld a, [W_Victory_DefectedContactLevel]
    ld hl, $984A
    ld c, 1
    call Encounter_DrawTileDigits
    
    ld a, $2E
    call Sound_IndexMusicSetBySong
    ld [W_Sound_NextBGMSelect], a
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    jp SerIO_Increment4thOrderSubState
    
;State 0F 02 02 01
LinkTrade_SubStateFadeInLossScreen::
    ld a, M_LCDC_FadeRevealWhite
    call Banked_LCDC_PaletteFade
    or a
    ret z
    
    jp SerIO_Increment4thOrderSubState
    
;State 0F 02 02 02
LinkTrade_SubStateLossScreenMessage::
    call Banked_MainScriptMachine
    ld a, [W_MainScript_State]
    cp M_MainScript_StateTerminated
    ret nz
    
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    jp SerIO_Increment4thOrderSubState

;State 0F 02 02 03
LinkTrade_SubStateFadeOutLossScreen::
    ld a, M_LCDC_FadeToWhite
    call Banked_LCDC_PaletteFade
    or a
    ret z
    
    xor a
    ld [W_Battle_4thOrderSubState], a
    jp Battle_IncrementSubSubState