INCLUDE "telefang.inc"

SECTION "Status Screen Advice Code", ROMX[$4A40], BANK[$1]
;Synchronize already-loaded status screen palettes with SGB mode.
;Not bank safe on its own.
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

    ; Set up habitat metasprite
    ld bc, $49 ; "Habitat:"
    call Banked_LoadMaliasGraphics

    ; #178 in metasprite bank 8 is MetaSprite_zukan_denjuu_name.
    ld a, $80
    ld [W_LCDC_MetaspriteAnimationBank], a
    ld a, 178
    ld [W_LCDC_MetaspriteAnimationIndex], a
    ld a, 5
    ld [W_LCDC_NextMetaspriteSlot], a
    ld a, 11 * 8
    ld [W_LCDC_MetaspriteAnimationXOffsets + 5], a
    ld a, 5 * 8 + 4
    ld [W_LCDC_MetaspriteAnimationYOffsets + 5], a
    call LCDC_BeginMetaspriteAnimation

    ld a, 2 ; Object palette 0
    ld bc, 7 ; Palette 7
    call CGBLoadObjectPaletteBanked

    ld a, $20
    ld [W_LCDC_MetaspriteAnimationBank], a

    ;Original replaced code
    ld a, 4
    call Banked_LCDC_SetupPalswapAnimation
    
    M_AdviceTeardown
    ret

Status_ADVICE_StateSwitchDenjuu::
    M_AdviceSetup
    
    call Status_ADVICE_SyncUpSGBPalettes
    
    ; Original replaced code
    ld a, [W_Status_SelectedDenjuuPersonality]
    ld bc, $8D80
    ld de, StringTable_denjuu_personalities
    call MainScript_DrawCenteredName75

    ; Habitat string replaced with the right-aligned one.
    call Status_ADVICE_DrawRightAlignedHabitatNameInner
    
    M_AdviceTeardown
    ret

Status_ADVICE_DrawRightAlignedHabitatName::
    M_AdviceSetup

    ; Original replaced code
    ld a, [W_Status_SelectedDenjuuPersonality]
    call MainScript_DrawCenteredName75

    ; Habitat string replaced with the right-aligned one.
    call Status_ADVICE_DrawRightAlignedHabitatNameInner

    M_AdviceTeardown
    ret

Status_ADVICE_DrawRightAlignedHabitatNameInner::
    ; When using MainScript_ADVICE_DrawRightAlignedHabitatName,
    ; the habitat name index has to be gotten in advance.
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, $D
    call Banked_Battle_LoadSpeciesData
    xor a
    ld [W_MainScript_TextStyle], a
    ld a, [W_Battle_RetrSpeciesByte]
    ld [W_StringTable_ROMTblIndex], a

    ld a, [W_MainScript_VWFNewlineWidth]
    push af
    ld a, 7
    ld [W_MainScript_VWFNewlineWidth], a
    
    ld de, StringTable_denjuu_habitats
    ld bc, $8780
    ld a, BANK(MainScript_ADVICE_DrawRightAlignedHabitatName)
    ld hl, MainScript_ADVICE_DrawRightAlignedHabitatName
    rst $20 ; CallBankedFunction

    pop af
    ld [W_MainScript_VWFNewlineWidth], a
    call Zukan_ADVICE_CheckSGB
    ret z
    ld a, 3
    ld [W_MainScript_TextStyle], a
    ret

Status_ADVICE_StateExit::
    M_AdviceSetup

    ; This is called after fade-out on the status screen accessed from the
    ; pause menu, but before the fade-out when accessed from battle.
    ; In battle, the habitat sprite needs to be cleared elsewhere.
    ld a, [W_Status_CalledFromContactScreen]
    cp 0
    jr z, .doNotRemoveHabitatYet

    ld de, W_MetaSpriteConfig1 + M_MetaSpriteConfig_Size * 5
    call LCDC_ClearSingleMetasprite
.doNotRemoveHabitatYet

    ;Original replaced code
    xor a
    ld [W_Status_SubState], a
    ld [W_MetaSpriteConfig1], a
    ld [W_MainScript_TextStyle], a
    
    M_AdviceTeardown
    ret

SECTION "Status SGB Recolour Window Advice 1", ROMX[$54A0], BANK[$1]
Status_ADVICE_StateInitGraphics::
    M_AdviceSetup
    
    call Zukan_ADVICE_CheckSGB
    call nz, Status_ADVICE_SGBRedrawInit
    call Banked_Status_LoadPhoneDigits_NowWithSGBSupport
    ld c, 1
    ld de, $8800
    
    M_AdviceTeardown
	
	ld a, [W_Status_SelectedDenjuuSpecies]
    ret

Status_ADVICE_SGBRedrawInit::
    ; Numbers
    ld hl, $8F00
    ld b, $28
    call Zukan_ADVICE_TileLowByteBlanketFill
    
    ; Window
    ld hl, $9000
    ld b, $50
    call Zukan_ADVICE_TileLightColourReverse
    
    ; Icons (Exp,FD,etc)
    ld b, $30
    call Zukan_ADVICE_TileLowByteBlanketFill
    
    ; Bottom-right corner of tab
    ld l, $F0
    ld b, 8
    call Zukan_ADVICE_TileLightColourReverse
    
    ; Questionmark
    ld hl, $93E0
    ld b, 4
    call Zukan_ADVICE_TileLowByteBlanketFill
    
    ; "Speed"/"Attack"/"Defense"
    ld hl, $9400
    ld b, $30
    call Zukan_ADVICE_TileLowByteBlanketFill
    
    ; Related odds and ends
    ld hl, $9500
    ld b, $C
    call Zukan_ADVICE_TileLowByteBlanketFill
    
    ; "Denma"
    ld l, $D0
    ld b, $C
    call Zukan_ADVICE_TileLowByteBlanketFill
    
    call Zukan_ADVICE_FixPaletteForSGB
    
    ld a, 3
    ld [W_MainScript_TextStyle], a
    
    ret

SECTION "Status Screen Phone Number for Patch", ROMX[$796B], BANK[$29]
Status_DrawPhoneNumberForStatus::
    push hl
    call $42E5
    jp Status_DrawPhoneNumber_SkipLoadDigits

Status_LoadPhoneDigits_NowWithSGBSupport::
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    jp z, Status_LoadPhoneDigits
    ld a, [W_SGB_DetectSuccess]
    or a
    jp z, Status_LoadPhoneDigits
    ld hl, Status_PhoneDigits
    ld de, $9600
    ld b, $F0

.drawloop
    ld a, [hli]
    ld c, a
    inc de
    di

.wfb
    ld a, [REG_STAT]
    and 2
    jr nz, .wfb
    ld a, [hli]
    ld [de], a
    dec e
    xor c
    cpl
    ld [de], a
    ei
    inc de
    inc de
    dec b
    jr nz, .drawloop
    ret

SECTION "Status Screen Numerical Tiles Loader Advice Code", ROMX[$7D00], BANK[$38]
; This removes excess code from bank 0, optimises the loop, and adds logic for text style 3 (for coloured screens in SGB mode).
Status_ADVICE_ExpandNumericalTiles::
    ld a, [W_MainScript_TextStyle]
    cp 2
    jr z, .invertedTextLoop
    cp 3
    jr z, .lightBgTextLoop

.normalTextLoop
    di

.waitForBlankingNormal
    ld a, [REG_STAT]
    and 2
    jr nz, .waitForBlankingNormal

    ld a, [de]
    ld [hli], a
    ld [hli], a

    ei ; FB
    inc de
    dec b
    jr nz, .normalTextLoop
    ret

.invertedTextLoop
    di

.waitForBlankingInverted
    ld a, [REG_STAT]
    and 2
    jr nz, .waitForBlankingInverted

    ld a, [de]
    cpl
    ld [hli], a
    ld [hli], a

    ei
    inc de
    dec b
    jr nz, .invertedTextLoop
    ret

.lightBgTextLoop
    di

.waitForBlankingLightBg
    ld a, [REG_STAT]
    and 2
    jr nz, .waitForBlankingLightBg

    ld a, $FF
    ld [hli], a
    ld a, [de]
    ld [hli], a

    ei
    inc de
    dec b
    jr nz, .lightBgTextLoop
    ret
