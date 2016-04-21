INCLUDE "components/LCDC/lcdc.inc"
INCLUDE "registers.inc"

;The "LCDC" component consists of parts of the game that manage the LCD
;Controller and it's associated registers.

;So-called "shadow" registers are temporary WRAM locations for storing what we
;want the contents of timing-specific registers to be. An interrupt or timed
;loop will later copy them into the appropriate registers.
SECTION "LCDC_BSS", BSS[$C3C2]
ShadowREG_SCX: ds 1
ShadowREG_SCY: ds 1
ShadowREG_WX: ds 1
ShadowREG_WY: ds 1
ShadowREG_BGP: ds 1
ShadowREG_OGP0: ds 1
ShadowREG_OGP1: ds 1
ShadowREG_LCDC: ds 1
ShadowREG_LYC: ds 1

SECTION "LCDC_HRAM", HRAM[$FF80]
ExecuteOAMDMA: ds $A

SECTION "LCDC_HRAM2", HRAM[$FF92]
VBlankCompleted: ds 1

SECTION "LCDC", ROM0[$0266]
SyncShadowRegs: ld a, [$C46C]
or      a
                jr      nz, .uselessJmp
                jr      .uselessJmp

.uselessJmp:                            ; CODE XREF: SyncShadowRegs+4;j
                ld      a, [ShadowREG_SCX]
                ld      [REG_SCX], a
                ld      a, [ShadowREG_SCY]
                ld      [REG_SCY], a
                ld      a, [ShadowREG_WX]
                ld      [REG_WX], a
                ld      a, [ShadowREG_WY]
                ld      [REG_WY], a
                ld      a, [ShadowREG_BGP]
                ld      [REG_BGP], a
                ld      a, [ShadowREG_OGP0]
                ld      [REG_OBP0], a
                ld      a, [ShadowREG_OGP1]
                ld      [REG_OBP1], a
                ld      a, [ShadowREG_LCDC]
                ld      [REG_LCDC], a
                ld      a, [ShadowREG_LYC]
                ld      [REG_LYC], a
                ld      b, 0
                ld      hl, $C464
                ld      de, $C460
                ld      a, [de]
                add     a, b
                ld      [hl+], a
                inc     de
                ld      a, [de]
                ld      [hl+], a
                inc     de
                ld      a, [de]
                ld      [hl+], a
                inc     de
                ld      a, [de]
                ld      [hl], a
                ld      a, [$C46C]
                ld      [$C469], a
                ld      a, 0
                ld      [HBlank_State], a
                ld      a, [HBlank_SCYIndexAndMode]
                cp      2
                jr      c, .return
                ld      a, 2
                ld      [HBlank_SCYIndexAndMode], a
                ld      a, [HBlank_SCYTableID]
                xor     1
                ld      [HBlank_SCYTableID], a
                ret

.return:                                ; CODE XREF: SyncShadowRegs+59;j
                ret

SECTION "LCDC again", ROM0[$02E7]
VBlankingIRQ: push    af
                push    bc
                push    de
                push    hl
                call    SyncShadowRegs
                ld      a, [VBlankCompleted]
                or      a
                jr      nz, .setCompletedFlag
                ld      a, [OAMDMAReady]
                or      a
                jr      z, .setCompletedFlag
                call    ExecuteOAMDMA        ; In-memory code: OAM DMA
                call    $3171        ; Looks like a crappy hack.
                xor     a
                ld      [$C430], a
                ld      [OAMDMAReady], a

.setCompletedFlag:                      ; CODE XREF: VBlankingIRQ+A;j
                                        ; VBlankingIRQ+10;j
                ld      a, 1
                ld      [VBlankCompleted], a
                ei
                call    $464
                call    $3442
                ld      a, [$CB3F]
                or      a
                jr      nz, .loc_31C
                call    $1F08
                jr      .loc_31F

.loc_31C:       call $1C9B
.loc_31F:       pop hl
                pop de
                pop bc
                pop af
                reti
                
LCDCIRQ:                                ; CODE XREF: ;j
                push    af
                ld      a, [HBlank_SCYIndexAndMode]
                cp      2
                jp      nc, .doHblankSCY
                push    bc              ; HBL either mode 0 or 1
                push    hl
                ld      a, [$C469]
                or      a
                jp      nz, .doOtherHblEffect
                call    ClearHBlankState
                jr      .ret_pop3


.doOtherHblEffect:                      ; CODE XREF: LCDCIRQ+F;j
                ld      a, [HBlank_SCYIndexAndMode]
                or      a
                jr      nz, .doHblEffect1
                ld      hl, $C464       ; HBL Effect 0
                                        ; Used for moving the window around.
                ld      a, [hl+]
                sub     4
                ld      b, a
                ld      a, [REG_LY]
                cp      b
                jr      nc, .notAtDesiredLine
                ld      a, [HBlank_State]
                or      a
                jr      nz, .ret_pop3
                ld      a, [hl+]
                ld      [REG_WX], a
                ld      a, [hl]
                ld      [REG_WY], a
                ld      a, b
                ld      [REG_LYC], a
                ld      a, 1
                ld      [HBlank_State], a
                jr      .ret_pop3


.notAtDesiredLine:                      ; CODE XREF: LCDCIRQ+27;j
                ld      a, b
                add     a, 4
                ld      b, a

.waitUntilLineReady:                    ; CODE XREF: LCDCIRQ+46j
                ld      a, [REG_LY]
                cp      b
                jr      c, .waitUntilLineReady

.clearScroll:                           ; CODE XREF: LCDCIRQ+6Dj
                xor     a
                ld      [REG_SCX], a
                ld      [REG_SCY], a

.setupScreen:                           ; CODE XREF: LCDCIRQ+DBj
                ld      [HBlank_State], a
                ld      a, 0
                ld      [REG_LYC], a
                ld      [ShadowREG_LYC], a
                ld      a, %10000011    ; Enable LCD, BG, and OBJ (and no others)
                ld      [REG_LCDC], a

.ret_pop3:                              ; CODE XREF: LCDCIRQ+15;j
                                        ; LCDCIRQ+2D;j ...
                pop     hl
                pop     bc
                pop     af
                reti


.doHblEffect1:                          ; CODE XREF: LCDCIRQ+1B;j
                ld      a, [SystemState]
                cp      4
                jr      z, .letterboxEffect
                ld      hl, $C467
                ld      a, [REG_LY]
                cp      $5F ; '_'
                jr      nc, .clearScroll
                ld      a, [HBlank_State]
                cp      1
                jr      z, .loc_3AE
                cp      0
                jr      nz, .ret_pop3
                xor     a
                ld      [REG_SCX], a
                ld      [REG_SCY], a
                ld      a, $27 ; '''
                ld      [REG_LYC], a
                ld      a, 1
                ld      [HBlank_State], a
                jr      .ret_pop3


.loc_3AE:                                ; CODE XREF: LCDCIRQ+74;j
                ld      a, [hl]
                ld      [REG_SCX], a
                ld      a, $5F ; '_'
                ld      [REG_LYC], a
                ld      a, 2
                ld      [HBlank_State], a
                jr      .ret_pop3


.letterboxEffect:                       ; CODE XREF: LCDCIRQ+64;j
                ld      a, [REG_LY]
                cp      $6C ; 'l'
                jr      nc, .insertBottomLetterbox
                ld      a, [HBlank_State]
                cp      1
                jr      z, .insertMiddleSection
                cp      0
                jr      nz, .ret_pop3
                ld      a, $7F ; ''
                ld      [REG_SCY], a
                ld      a, $14
                ld      [REG_LYC], a
                ld      a, 1
                ld      [HBlank_State], a
                jr      .ret_pop3


.insertMiddleSection:                   ; CODE XREF: LCDCIRQ+A3;j
                                        ; LCDCIRQ+BCj
                ld      a, [REG_LY]
                cp      $18
                jr      c, .insertMiddleSection
                ld      a, [HBlank_Scanline24Pos]
                ld      [REG_SCY], a
                ld      a, $6C ; 'l'
                ld      [REG_LYC], a
                ld      a, 2
                ld      [HBlank_State], a
                jr      .ret_pop3


.insertBottomLetterbox:                 ; CODE XREF: LCDCIRQ+9C;j
                                        ; LCDCIRQ+D2j
                ld      a, [REG_LY]
                cp      $70 ; 'p'
                jr      c, .insertBottomLetterbox
                ld      a, $10
                ld      [REG_SCY], a
                xor     a
                ld      [REG_SCX], a
                jp      .setupScreen


.doHblankSCY:                           ; CODE XREF: LCDCIRQ+6;j
                push    hl
                ld      hl, $C140
                ld      a, [HBlank_SCYTableID]
                or      a
                jr      nz, .copyToSCY
                ld      hl, $C0A0

.copyToSCY:                             ; CODE XREF: LCDCIRQ+E6;j
                ld      a, [HBlank_SCYIndexAndMode]
                add     a, l
                ld      l, a
                ld      a, 0
                adc     a, h
                ld      h, a
                ld      a, [hl]
                ld      [REG_SCY], a
                ld      a, [HBlank_SCYIndexAndMode]
                inc     a
                ld      [HBlank_SCYIndexAndMode], a
                pop     hl
                pop     af
                reti
; End of function LCDCIRQ

ClearHBlankState: xor a
                  ld [HBlank_State], a
                  ld hl, $C460
                  ld [hl+], a
                  ld [hl+], a
                  ld [hl+], a
                  ld [hl+], a
                  ret

SECTION "LCDC yetagain", ROM0[$079A]
InstallODMADriver:  ld c, $80
                    ld b, $A ;Length value.
                             ;I'm sure there's a way to calculate it with the
                             ;macrolanguage but I can't be arsed
                    ld hl, ODMADriver
.copyLoop:          ld a, [hl+]
                    ld [c], a
                    inc c
                    dec b
                    jr nz, .copyLoop
                    ret
                   
                    ;Not executed in place.
                    ;Is instead copied into HRAM where it is safe to run.
ODMADriver:         ld a, $C0
                    ld [REG_DMA], a
                    ld a, $28
.spinLock:          dec a
                    jr nz, .spinLock
                    ret