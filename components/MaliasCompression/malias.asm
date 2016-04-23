;Malias compression is the compression used in numerous Natsume games, namely,
;at least Telefang and Medarot. It is a modified implementation of the LZ77
;algorithm, which works by referencing previously decompressed data using
;length-distance pairs.

;http://wiki.telefang.net/Wikifang:Telefang_1_Translation_Patch/Malias_compression

INCLUDE "components/MaliasCompression/malias.inc"
INCLUDE "registers.inc"

SECTION "Malias_BSS", BSS[$C402]
Malias_CopyHistoryLength:   ds 1
Malias_BundleBitsCount:     ds 1
Malias_CurBundleBits:       ds 2
Malias_DecompressionHead:   ds 2

SECTION "Malias_BSS2", BSS[$C44E]
Malias_CmpSrcBank:          ds 1

SECTION "Malias_BSS3", BSS[$C450]
Malias_DeCmpDst:            ds 2

; As far as I can tell this wait-for-blank is only called by MaliasDecompress
SECTION "Malias_WFB", ROM0[$09AA]
YetAnotherWFB: push af
.loop:

; Decompress graphics.
;
;  A: The bank the compressed graphics are stored in.
; DE: An index into the table at $1DE1, which is a list
;     of addresses compressed graphics are stored at.
; HL: Pointer to the memory address to write the
;     decompressed graphics to.

SECTION "Malias", ROM0[$0C48]
MaliasDecompress: ld      [Malias_CmpSrcBank], a
                ld      a, [hl+]
                ld      [Malias_DeCmpDst], a
                ld      a, [hl]
                ld      [Malias_DeCmpDst + 1], a
                ld      a, [Malias_CmpSrcBank]
                rst     $10
                ld      hl, $1DE1
                sla     c
                rl      b
                add     hl, bc
                ld      a, [hl+]
                ld      h, [hl]
                ld      l, a
                push    hl
                pop     de
                ld      a, [Malias_DeCmpDst + 1]
                ld      h, a
                ld      a, [Malias_DeCmpDst]
                ld      l, a            ; HL = Decompression Head
                ld      a, [de]         ; DE = Compression Head
                inc     de
                jp      .maliasDecomp   ; useless jmp

.maliasDecomp:
                cp      0
                jp      z, .decompressedOutput
                ld      a, h
                ld      [Malias_DecompressionHead], a
                ld      a, l
                ld      [Malias_DecompressionHead + 1], a
                ld      a, [de]
                ld      c, a
                inc     de
                ld      a, [de]
                ld      b, a
                inc     de              ; Read LeU16 (intended output size)

.beginBundle:                           ; CODE XREF: MaliasDecompress+59.j
                ld      a, b
                or      c
                jp      z, .exit
                ld      a, [de]
                ld      [Malias_CurBundleBits + 1], a
                inc     de
                ld      a, [de]
                ld      [Malias_CurBundleBits], a
                inc     de
                ld      a, $11
                ld      [Malias_BundleBitsCount], a

.decodeBundleCommand:                   ; CODE XREF: MaliasDecompress+94.j
                                        ; MaliasDecompress+E8.j
                ld      a, b
                or      c
                jp      z, .exit
                ld      a, [Malias_BundleBitsCount]
                dec     a
                jp      z, .beginBundle
                ld      [Malias_BundleBitsCount], a
                push    de
                ld      a, [Malias_CurBundleBits]
                ld      d, a
                ld      a, [Malias_CurBundleBits + 1]
                ld      e, a
                srl     d
                ld      a, d
                ld      [Malias_CurBundleBits], a
                rr      e
                ld      a, e
                ld      [Malias_CurBundleBits + 1], a
                jp      c, .copyFromHistory ; Mode 1
                pop     de              ; Mode 0
                ld      a, [Malias_DecompressionHead]
                ld      h, a
                ld      a, [Malias_DecompressionHead + 1]
                ld      l, a
                di
                call    YetAnotherWFB
                ld      a, [de]
                call    YetAnotherWFB
                ld      [hl+], a
                ei
                ld      a, h
                ld      [Malias_DecompressionHead], a
                ld      a, l
                ld      [Malias_DecompressionHead + 1], a
                dec     bc
                inc     de
                jp      .decodeBundleCommand
; ---------------------------------------------------------------------------

.copyFromHistory:                       ; CODE XREF: MaliasDecompress+74j
                pop     de              ; Mode 1
                push    de
                ld      a, [de]
                ld      l, a
                inc     de
                ld      a, [de]
                and     7
                ld      h, a
                ld      a, [de]
                srl     a
                srl     a
                srl     a
                and     $1F
                add     a, 3
                ld      [Malias_CopyHistoryLength], a
                ld      a, h
                cpl
                ld      d, a
                ld      a, l
                cpl
                ld      e, a            ; DE = -HL
                ld      a, [Malias_DecompressionHead]
                ld      h, a
                ld      a, [Malias_DecompressionHead + 1]
                ld      l, a
                add     hl, de
                push    hl
                pop     de
                ld      a, [Malias_DecompressionHead]
                ld      h, a
                ld      a, [Malias_DecompressionHead + 1]
                ld      l, a

.copyByteToHead:                        ; CODE XREF: MaliasDecompress+DA.j
                di
                call    YetAnotherWFB
                ld      a, [de]
                call    YetAnotherWFB
                ld      [hl+], a
                ei
                dec     bc
                inc     de
                ld      a, [Malias_CopyHistoryLength]
                dec     a
                ld      [Malias_CopyHistoryLength], a
                jp      nz, .copyByteToHead
                ld      a, h
                ld      [Malias_DecompressionHead], a
                ld      a, l
                ld      [Malias_DecompressionHead + 1], a
                pop     de
                inc     de
                inc     de
                jp      .decodeBundleCommand
; ---------------------------------------------------------------------------

.decompressedOutput:                    ; CODE XREF: MaliasDecompress+2Bj
                ld      a, [de]
                ld      c, a
                inc     de
                ld      a, [de]
                ld      b, a
                inc     de

.decompressedByteCopy:                  ; CODE XREF: MaliasDecompress+102.j
                ld      a, b
                or      c
                jp      z, .exit
                di
                call    YetAnotherWFB
                ld      a, [de]
                call    YetAnotherWFB
                ld      [hl+], a
                ei
                inc     de
                dec     bc
                jp      .decompressedByteCopy
; ---------------------------------------------------------------------------

.exit:                                  ; CODE XREF: MaliasDecompress+3Ej
                                        ; MaliasDecompress+52j ...
                ret
