INCLUDE "telefang.inc"

SECTION "Status Screen SGB Hotpatches", ROMX[$4800], BANK[$1]
;Synchronize already-loaded status screen palettes with SGB mode.
;Not bank safe on it's own.
Status_ADVICE_SyncUpSGBPalettes::
    ld a, M_SGB_Pal01 << 3 + 1
    ld b, 0
    ld c, 1
    call PatchUtils_CommitStagedCGBToSGB
    
    ld a, M_SGB_Pal23 << 3 + 1
    ld b, 5
    ld c, 6
    call PatchUtils_CommitStagedCGBToSGB
    ret
    
Status_ADVICE_StateInitTilemaps::
    M_AdviceSetup
    
    ld bc, 0
    ld e, 1
    ld a, 0
    call Banked_RLEDecompressTMAP0
    ld bc, 0
    ld e, 1
    ld a, 0
    call Banked_RLEDecompressAttribsTMAP0
    
    ;Load SGB ATF.
    ;We don't convert colors until after the denjuu is in place, so we just want
    ;to get the status screen attributes in place.
    ld a, 4
    ld b, 0
    ld c, 0
    ld d, 0
    ld e, 0
    call Banked_SGB_ConstructPaletteSetPacket
    
    M_AdviceTeardown
    ret

Status_ADVICE_StateDrawDenjuu::
    M_AdviceSetup
    
    call Status_ADVICE_SyncUpSGBPalettes
    
    ;Original replaced code
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    M_AdviceTeardown
    ret

Status_ADVICE_StateSwitchDenjuu::
    M_AdviceSetup
    
    call Status_ADVICE_SyncUpSGBPalettes
    
    ;Original replaced code
    ld a, [W_Status_SelectedDenjuuPersonality]
    ld bc, $8D80
    ld de, StringTable_denjuu_personalities
    call MainScript_DrawCenteredName75
    
    M_AdviceTeardown
    ret
    
Status_ADVICE_StateExit::
    M_AdviceSetup
    
    ;Load neutral/grayscale ATF
    ld a, 4
    ld b, 0
    ld c, 0
    ld d, 0
    ld e, 0
    call Banked_SGB_ConstructPaletteSetPacket
    
    ;Original replaced code
    xor a
    ld [W_Status_SubState], a
    xor a
    ld [W_MetaSpriteConfig1], a
    
    M_AdviceTeardown
    ret