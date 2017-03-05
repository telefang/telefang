;Malias compression is the compression used in numerous Natsume games, namely,
;at least Telefang and Medarot. It is a modified implementation of the LZ77
;algorithm, which works by referencing previously decompressed data using
;length-distance pairs.

;http://wiki.telefang.net/Wikifang:Telefang_1_Translation_Patch/Malias_compression

INCLUDE "registers.inc"

SECTION "Malias_WRAM1", WRAM0[$C402]
Malias_CopyHistoryLength: ds 1
Malias_BundleBitsCount: ds 1
Malias_CurBundleBits: ds 2
Malias_DecompressionHead: ds 2

SECTION "Malias_WRAM2", WRAM0[$C44E]
Malias_CmpSrcBank:: ds 1
W_GenericRegPreserve:: ds 1 ;heavily aliased in many places... :/
Malias_DeCmpDst:: ds 1 ;Aliased by LCDC_FadeColMathArena on the 2nd byte.

SECTION "Malias", ROM0[$0C36]
LoadMaliasGraphics::
	ld a, 6
	rst $10
	push bc
	pop de
	ld hl, $4000
	sla e
	rl d
	sla e
	rl d
	add hl, de
	ld a, [hli]
	;Fall through to MaliasDecompress

; Decompress graphics.
;
; A: The bank the compressed graphics are stored in.
; DE: An index into the table at $1DE1, which is a list
; of addresses compressed graphics are stored at.
; HL: Pointer to the memory address to write the
; decompressed graphics to.
MaliasDecompress::
	ld [Malias_CmpSrcBank], a
	ld a, [hli]
	ld [Malias_DeCmpDst], a
	ld a, [hl]
	ld [Malias_DeCmpDst + 1], a
	ld a, [Malias_CmpSrcBank]
	rst $10
	ld hl, $1DE1
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	pop de
	ld a, [Malias_DeCmpDst + 1]
	ld h, a
	ld a, [Malias_DeCmpDst]
	ld l, a ; HL = Decompression Head
	ld a, [de] ; DE = Compression Head
	inc de
	jp .maliasDecomp ; useless jmp

.maliasDecomp
	cp 0
	jp z, .decompressedOutput
	ld a, h
	ld [Malias_DecompressionHead], a
	ld a, l
	ld [Malias_DecompressionHead + 1], a
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	ld b, a
	inc de ; Read LeU16 (intended output size)

.beginBundle
	ld a, b
	or c
	jp z, .exit
	ld a, [de]
	ld [Malias_CurBundleBits + 1], a
	inc de
	ld a, [de]
	ld [Malias_CurBundleBits], a
	inc de
	ld a, $11
	ld [Malias_BundleBitsCount], a

.decodeBundleCommand
	ld a, b
	or c
	jp z, .exit
	ld a, [Malias_BundleBitsCount]
	dec a
	jp z, .beginBundle
	ld [Malias_BundleBitsCount], a
	push de
	ld a, [Malias_CurBundleBits]
	ld d, a
	ld a, [Malias_CurBundleBits + 1]
	ld e, a
	srl d
	ld a, d
	ld [Malias_CurBundleBits], a
	rr e
	ld a, e
	ld [Malias_CurBundleBits + 1], a
	jp c, .copyFromHistory ; Mode 1
	pop de ; Mode 0
	ld a, [Malias_DecompressionHead]
	ld h, a
	ld a, [Malias_DecompressionHead + 1]
	ld l, a
	di
	call YetAnotherWFB
	ld a, [de]
	call YetAnotherWFB
	ld [hli], a
	ei
	ld a, h
	ld [Malias_DecompressionHead], a
	ld a, l
	ld [Malias_DecompressionHead + 1], a
	dec bc
	inc de
	jp .decodeBundleCommand

.copyFromHistory
	pop de ; Mode 1
	push de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	and 7
	ld h, a
	ld a, [de]
	srl a
	srl a
	srl a
	and $1F
	add a, 3
	ld [Malias_CopyHistoryLength], a
	ld a, h
	cpl
	ld d, a
	ld a, l
	cpl
	ld e, a ; DE = -HL
	ld a, [Malias_DecompressionHead]
	ld h, a
	ld a, [Malias_DecompressionHead + 1]
	ld l, a
	add hl, de
	push hl
	pop de
	ld a, [Malias_DecompressionHead]
	ld h, a
	ld a, [Malias_DecompressionHead + 1]
	ld l, a

.copyByteToHead
	di
	call YetAnotherWFB
	ld a, [de]
	call YetAnotherWFB
	ld [hli], a
	ei
	dec bc
	inc de
	ld a, [Malias_CopyHistoryLength]
	dec a
	ld [Malias_CopyHistoryLength], a
	jp nz, .copyByteToHead
	ld a, h
	ld [Malias_DecompressionHead], a
	ld a, l
	ld [Malias_DecompressionHead + 1], a
	pop de
	inc de
	inc de
	jp .decodeBundleCommand
; ---------------------------------------------------------------------------

.decompressedOutput
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	ld b, a
	inc de

.decompressedByteCopy
	ld a, b
	or c
	jp z, .exit
	di
	call YetAnotherWFB
	ld a, [de]
	call YetAnotherWFB
	ld [hli], a
	ei
	inc de
	dec bc
	jp .decompressedByteCopy

.exit
	ret
