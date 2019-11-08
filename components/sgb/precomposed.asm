INCLUDE "telefang.inc"

SECTION "SGB Spot Palette Memory", WRAM0[$CC00]
W_SGB_SpotPalette:: ds M_SGB_PacketSize

SECTION "SGB Precomposed Packet Sequences", ROMX[$4000], BANK[$3]
SGB_InstallBorderAndHotpatches::
    ld bc, $20
    call SGB_AdjustableWait
    
    ld hl, SGB_PacketFreezeScreen
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    
    ;Install a hotpatch into SFC $00:0810.
    ;
    ;The uploaded code appears to be a bugfix for old SGB cartridge revisions.
    ;Most games upload the same code. The official Nintendo documentation
    ;vaguely refers to this as "initialization" data.
    ;
    ;More info: https://forums.nesdev.com/viewtopic.php?f=12&t=16610
    ld hl, SGB_PacketHotfix + M_SGB_PacketSize * 0
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    ld hl, SGB_PacketHotfix + M_SGB_PacketSize * 1
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    ld hl, SGB_PacketHotfix + M_SGB_PacketSize * 2
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    ld hl, SGB_PacketHotfix + M_SGB_PacketSize * 3
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    ld hl, SGB_PacketHotfix + M_SGB_PacketSize * 4
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    ld hl, SGB_PacketHotfix + M_SGB_PacketSize * 5
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    ld hl, SGB_PacketHotfix + M_SGB_PacketSize * 6
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    ld hl, SGB_PacketHotfix + M_SGB_PacketSize * 7
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    
    ld hl, SGB_PaletteData
    ld de, SGB_PacketPaletteTransfer
    call SGB_SendPacketsWithVRAM
    
    ld hl, SGB_AttrFileData
    ld de, SGB_PacketAttrTransfer
    call Banked_SGB_ADVICE_SendATFPacketsWithVRAM
    
    ld hl, SGB_BorderTileData
    ld de, SGB_PacketTileTransferLow
    call SGB_SendPacketsWithVRAM
    
    ld hl, SGB_BorderTileData + $1000
    ld de, SGB_PacketTileTransferHigh
    call SGB_SendPacketsWithVRAM
    
    ld hl, SGB_BorderTmapPalData
    ld de, SGB_PacketBorderTmapTransfer
    call SGB_SendPacketsWithVRAM
    
    ld hl, SGB_PacketUnfreezeScreen
    call SGB_SendPackets
    
    ld bc, $40
    call SGB_AdjustableWait

    xor a
    ld b, a
    ld c, a
    ld d, a
    ld e, a
    call SGB_ConstructPaletteSetPacket
    jp Banked_SGB_SendICONENPacket
    nop
    nop
    
SGB_ReinstallBorder::
    ld hl, SGB_PacketFreezeScreen
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    
    ld hl, SGB_BorderTileData
    ld de, SGB_PacketTileTransferLow
    call SGB_SendPacketsWithVRAM
    
    ld hl, SGB_BorderTileData + $1000
    ld de, SGB_PacketTileTransferHigh
    call SGB_SendPacketsWithVRAM
    
    ld hl, SGB_BorderTmapPalData
    ld de, SGB_PacketBorderTmapTransfer
    call SGB_SendPacketsWithVRAM
    
    ld hl, SGB_PacketUnfreezeScreen
    call SGB_SendPackets
    ld bc, $20
    call SGB_AdjustableWait
    
    ret
    
SGB_EnableDefaultScreenAttributes::
    ld hl, SGB_PacketFreezeScreen
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    
    ld hl, SGB_PacketSetDefaultPaletteAttrs
    call SGB_SendPackets
    ld bc, 4
    call SGB_AdjustableWait
    
    ret
    
SGB_SendConstructedPaletteSetPacket::
    ld hl, W_SGB_SpotPalette
    call SGB_SendPackets
    ld bc, 3
    call SGB_AdjustableWait
    ret
    
SGB_PacketSetDefaultPaletteAttrs::
    db $51          ;PAL_SET
    dw 0,0,0,0      ;Use all palette 0
    db $C2          ;Use attribute file $2, unfreeze screen
    db 0,0,0,0,0,0

SECTION "SGB Precomposed Packet Sequences Data", ROMX[$4230], BANK[$3]
SGB_PacketPaletteTransfer::
    db $59
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

SGB_PacketTileTransferLow::
    db $99
    db 0
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0

SGB_PacketTileTransferHigh::
    db $99
    db 1
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    
SGB_PacketBorderTmapTransfer::
    db $A1
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    
SGB_PacketAttrTransfer::
    db $A9
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    
SGB_PacketUnfreezeScreen::
    db $B9
    db 0
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0

SGB_PacketFreezeScreen::
    db $B9
    db 1
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    
SGB_PacketHotfix
    db $79
    dw $085D
    db 0
    db $B
    db $8C, $D0, $F4, $60, 0, 0, 0, 0, 0, 0, 0
    
    db $79
    dw $0852
    db 0
    db $B
    db $A9, $E7, $9F, $01, $C0, $7E, $E8, $E8, $E8, $E8, $E0
    
    db $79
    dw $0847
    db 0
    db $B
    db $C4, $D0, $16, $A5, $CB, $C9, $05, $D0, $10, $A2, $28
    
    db $79
    dw $083C
    db 0
    db $B
    db $F0, $12, $A5, $C9, $C9, $C8, $D0, $1C, $A5, $CA, $C9
    
    db $79
    dw $0831
    db 0
    db $B
    db $0C, $A5, $CA, $C9, $7E, $D0, $06, $A5, $CB, $C9, $7E
    
    db $79
    dw $0826
    db 0
    db $B
    db $39, $CD, $48, $0C, $D0, $34, $A5, $C9, $C9, $80, $D0
    
    db $79
    dw $081B
    db 0
    db $B
    db $EA, $EA, $EA, $EA, $EA, $A9, $01, $CD, $4F, $0C, $D0
    
    db $79
    dw $0810
    db 0
    db $B
    db $4C, $20, $08, $EA, $EA, $EA, $EA, $EA, $60, $EA, $EA
    
SGB_ConstructPaletteSetPacket::
    push af
    ld a, [W_SGB_DetectSuccess]
    or a
    jp nz, .constructPacket
    
.noSgb
    pop af
    ret
    
.constructPacket
    pop af
    add a, $C0
    ld [W_SGB_SpotPalette + M_SGB_PalTrnAttribSel], a
    ld a, b
    ld [W_SGB_SpotPalette + M_SGB_PalTrnSelect0], a
    ld a, c
    ld [W_SGB_SpotPalette + M_SGB_PalTrnSelect1], a
    ld a, d
    ld [W_SGB_SpotPalette + M_SGB_PalTrnSelect2], a
    ld a, e
    ld [W_SGB_SpotPalette + M_SGB_PalTrnSelect3], a
    ld a, $51 ;PAL_SET
    ld [W_SGB_SpotPalette + M_SGB_PalTrnCommand], a
    
    xor a
    ld [W_SGB_SpotPalette + $02], a
    ld [W_SGB_SpotPalette + $04], a
    ld [W_SGB_SpotPalette + $06], a
    ld [W_SGB_SpotPalette + $08], a
    xor a
    ld [W_SGB_SpotPalette + $0A], a
    ld [W_SGB_SpotPalette + $0B], a
    ld [W_SGB_SpotPalette + $0C], a
    ld [W_SGB_SpotPalette + $0D], a
    ld [W_SGB_SpotPalette + $0E], a
    ld [W_SGB_SpotPalette + $0F], a
    jp SGB_SendConstructedPaletteSetPacket

SECTION "SGB Precomposed ICON_EN for Patch", ROMX[$7DA0], BANK[$3]
SGB_PacketICONEN::
    db $71
    db 1
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
