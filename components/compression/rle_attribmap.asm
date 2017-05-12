INCLUDE "registers.inc"

SECTION "RLE Attribmap Vars", WRAMX[$DD06], BANK[$1]
W_RLEAttribMapsEnabled:: ds 1

SECTION "RLE Attribmap Decompress", ROM0[$0B1A]
RLEDecompressAttribsTMAP0::
	push af
	ld a, [W_RLEAttribMapsEnabled]
	or a
	jp z, RLEEarlyExit
	ld a, [W_GameboyType]
	cp $11
	jp nz, RLEEarlyExit
	ld hl, VRAM_TMAP0
	xor a
	ld [W_RLETilemap_CurrentTilemap], a
	jr RLEDecompressAttribs

RLEDecompressAttribsTMAP1::
	push af
	ld a, [W_RLEAttribMapsEnabled]
	or a
	jp z, RLEEarlyExit
	ld a, [W_GameboyType]
	cp $11
	jp nz, RLEEarlyExit
	ld hl, VRAM_TMAP1
	ld a, 1
	ld [W_RLETilemap_CurrentTilemap], a

;Decompress an attributemap in the RLEAttribmap table.
;Uses an identical format to RLE Tilemaps, which is kind of disappointing.
; A: RLEAttribmap bank to index
;    NOTE: This will be read from stack; the wrapper functions take A directly.
; B: Tilemap row to decompress to
; C: Tilemap column to decompress to
; E: Index of attribmap
; HL: Address of tilemap to decompress into.
;     Does not strictly need to be VRAM.
;		NOTE: The wrapper functions fill this in for you.
RLEDecompressAttribs::
	ld a, 1
	ld [REG_VBK], a
	pop af
	push hl
	push de
	ld hl, RLEAttribmapBanks
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	rst $10
	pop de
	pop hl
	push de
	ld a, b
	and $1F
	ld b, a
	ld a, c
	and $1F
	ld c, a
	ld d, 0
	ld e, c
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	ld c, b
	ld b, 0
	add hl, bc
	add hl, de
	pop de
	push hl
	ld hl, $4000
	ld d, 0
	sla e
	rl d
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld b, h
	ld c, l
	ld a, [de]
	cp $FF
	ret z ;WTF: Early bailout fails to reset REG_VBK!!!
	and 3
	jr z, RLEEarlyExit.copyLinesMode ;If first byte's lower bits are 0, data is uncompressed
	jr RLEEarlyExit.rllDecompressMode ;Otherwise use the full decompression engine
	
RLEEarlyExit:
	pop af
	ret
	
.copyLinesMode
	inc de
	ld a, [de]
	cp $FF
	jp z, .cleanUpAndExit
	cp $FE
	jr z, .newLine
	call vmempoke
	ld a, [W_RLETilemap_CurrentTilemap]
	call TMAPWrapToLine
	jr .copyLinesMode
	
	;Executed when we encounter an $FE in the bytestream.
	;Moves the tilemap output to the next 32-byte row.
.newLine
	push de
	ld de, $20
	ld h, b
	ld l, c
	add hl, de
	ld a, [W_RLETilemap_CurrentTilemap]
	call TMAPWrapToTilemap
	ld b, h
	ld c, l
	pop de
	jr .copyLinesMode
	
	;The actual RLL compression mode.
.rllDecompressMode
	inc de
	ld a, [de]
	cp $ff
	jp z, .cleanUpAndExit
	ld a, [de] ; WTF: Useless read.
	and $C0
	cp $C0
	jp z, .cmd3
	cp $80
	jp z, .cmd2
	cp $40
	jp z, .cmd1
	
	;Command 0: CopyBytes
	;
	;Copy up to 64 bytes following the command.
	;(Lower bits of command byte are count minus 1)
	push bc
	ld a, [de]
	inc a
	ld b, a
	
.cmd0Loop
	inc de
	ld a, [de]
	call vmempoke
	dec b
	jp nz, .cmd0Loop
	pop bc
	jp .rllDecompressMode
	
	;Command 1: RepeatBytes
	;
	;Repeat the following byte upto 65 times.
	;(Lower 6 bits of command are count minus 2)
.cmd1
	push bc
	ld a, [de]
	and $3F
	add a, 2
	ld b, a
	inc de
	ld a, [de]
	
.cmd1Repeat
	call vmempoke
	dec b
	jp nz, .cmd1Repeat
	pop bc
	jp .rllDecompressMode
	
	;Command 2: IncBytes
	;
	;Write a sequence of up to 65 increasing bytes,
	;starting from the following byte.
	;(Lower 6 bits of command are count minus 2.)
.cmd2
	push bc
	ld a, [de]
	and $3F
	add a, 2
	ld b, a
	inc de
	ld a, [de]
	
.cmd2RepeatAndIncrement
	call vmempoke
	inc a
	dec b
	jp nz, .cmd2RepeatAndIncrement
	pop bc
	jp .rllDecompressMode
	
	;Command 3: DecBytes
	;
	;Write a sequence of up to 65 decreasing bytes,
	;starting from the following byte.
	;(Lower 6 bits of command are count minus 2.)
.cmd3
	push bc
	ld a, [de]
	and $3F
	add a, 2
	ld b, a
	inc de
	ld a, [de]
	
.cmd3RepeatAndDecrement
	call vmempoke
	dec a
	dec b
	jp nz, .cmd3RepeatAndDecrement
	pop bc
	jp .rllDecompressMode
	
.cleanUpAndExit
	xor a
	ld [REG_VBK], a
	ret
