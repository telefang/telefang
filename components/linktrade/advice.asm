INCLUDE "telefang.inc"

SECTION "Extended Nicknames for Link Operations Variables", WRAM0[$C7E2]
W_SerIO_WaitForPatchExtension:: ds 1

SECTION "Extended Nicknames for Link Operations Bank Calls", ROM0[$3E6B]
Banked_SerIO_ADVICE_BufferDenjuuInfoForTrade::
	ld a, [W_CurrentBank]
	push af
	ld a, BANK(SerIO_ADVICE_BufferDenjuuInfoForTrade)
	rst $10
	jp SerIO_ADVICE_BufferDenjuuInfoForTrade

Banked_SerIO_ADVICE_WaitForTradedDenjuu::
	ld a, [W_CurrentBank]
	push af
	ld a, BANK(SerIO_ADVICE_WaitForTradedDenjuu)
	rst $10
	jp SerIO_ADVICE_WaitForTradedDenjuu

Banked_SerIO_ADVICE_SaveTradedDenjuuInfo::
	ld a, [W_CurrentBank]
	push af
	ld a, BANK(SerIO_ADVICE_SaveTradedDenjuuInfo)
	rst $10
	jp SerIO_ADVICE_SaveTradedDenjuuInfo

;NOTE: Free Space

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

SECTION "Extended Nicknames for Link Operations", ROMX[$7000], BANK[$34]
SerIO_ADVICE_BufferDenjuuInfoForTrade::

	;Buffer stats.

	call SaveClock_EnterSRAM2
	ld hl, S_SaveClock_StatisticsArray
	ld a, [W_Victory_DefectedContact]
	call Battle_IndexStatisticsArray
	ld de, $DC60
	ld bc, $10
	call memcpy

	;Buffer first 6 characters of nickname.

	call SaveClock_EnterSRAM2
	ld a, [W_Victory_DefectedContact]
	call SerIO_ADVICE_GetNicknameSRAMAddress
	ld de, $DC77
	ld bc, 6
	call memcpy

	;Check if the nickname has a 4-char extension.

	ld h, S_SaveClock_NicknameExtensionIndicatorArray >> 8
	ld a, [W_Victory_DefectedContact]
	ld l, a
	ld a, [hl]
	or a
	jr z, .padExtension

	;Buffer remaining 4 chars from the nickname extension table.

	ld a, [W_Victory_DefectedContact]
	call SerIO_ADVICE_GetNicknameExtensionSRAMAddress
	ld de, $DC7D
	ld bc, 4
	call memcpy
	jr .getSpeciesName

.padExtension

	;Buffer an empty extension.

	ld hl, $DC7D
	ld a, $E0
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a

.getSpeciesName
	ld a, [$DC60]
	cp $61
	jr nz, .notNoisy
	ld hl, $DC77
	ld de, SerIO_ADVICE_NoisyEnglish
	ld b, 6
	call SerIO_ADVICE_CompareNicknames
	jr nz, .notNoisy

.isNoisy

	;Special-case Noisy's nickname.

	ld hl, SerIO_ADVICE_NoisyJapanese
	ld de, $DC70
	ld bc, 6
	call memcpy
	jr .extraData

.notNoisy

	;Load a species nickname for Japanese versions of the game to read.

	call SaveClock_ExitSRAM
	ld a, [$DC60]
	ld l, a
	ld h, 0
	add hl, hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, de
	ld de, StringTable_japanese_species_nicknames
	add hl, de
	ld de, $DC70
	ld bc, 6
	call memcpy

.extraData

	;This is for fooling link battle recruitment code in the Japanese version.

	ld a, $ED
	ld [$DC76], a

	;Reserve 1 byte for possible future use, such as maybe tracking language variations of the patch.

	ld a, M_Trade_Charset
	ld [$DC81], a
	jp Banked_SGB_ConstructATTRBLKPacket_return

SerIO_ADVICE_CompareNicknames::
	ld a, [de]
	inc de
	ld c, a
	ld a, [hli]
	cp c
	ret nz
	dec b
	jr nz, SerIO_ADVICE_CompareNicknames
	ret

SerIO_ADVICE_NoisyEnglish::
	db $4E,$6F,$69,$73,$79,$E0

SerIO_ADVICE_NoisyJapanese::
	db $19,$02,$73,$CD,$E0,$E0

SerIO_ADVICE_WaitForTradedDenjuu::

	;Set W_SerIO_WaitForPatchExtension to something higher than 0 before the state that calls this.

	ld hl, W_SerIO_RecvBuffer
	ld a, [W_Battle_NextSerIOByteIn]
	add $16
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld d, a
	or a
	jr z, .nextFrame

	;If W_SerIO_WaitForPatchExtension hits 0 before the patch-specific data has been transmitted then we will assume that we are receiving from the Japanese game.

	ld bc, $C
	add hl, bc
	ld a, [hl]
	or a
	jr nz, .exit

	ld a, [W_SerIO_WaitForPatchExtension]
	dec a
	ld [W_SerIO_WaitForPatchExtension], a
	or a
	jr nz, .nextFrame

.exit
	ld d, 1
	jp Banked_SGB_ConstructATTRBLKPacket_return

.nextFrame
	ld d, 0
	jp Banked_SGB_ConstructATTRBLKPacket_return

SerIO_ADVICE_GetNicknameSRAMAddress::
	ld l, a
	ld h, 0
	add hl, hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, de
	ld de, S_SaveClock_NicknameArray
	add hl, de
	ret

SerIO_ADVICE_GetNicknameExtensionSRAMAddress::
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, S_SaveClock_NicknameExtensionArray
	add hl, de
	ret

SerIO_ADVICE_SaveTradedDenjuuInfo::

	;Store basic Denjuu stats.

	ld a, [$D4A7]
	ld hl, S_SaveClock_StatisticsArray
	call Battle_IndexStatisticsArray
	ld d, h
	ld e, l
	ld hl, $DC60
	ld bc, $10
	call memcpy

	;Store nickname extension indicator.

	ld h, S_SaveClock_NicknameExtensionIndicatorArray >> 8
	ld a, [$D4A7]
	ld l, a
	ld [hl], 1

	;Is this from a patched game or the Japanese original?

	ld a, [W_SerIO_WaitForPatchExtension]
	or a
	jr z, .useDefault

.copyNickname

	;Use the default name instead if the charset doesn't match.

	ld a, [$DC81]
	cp M_Trade_Charset
	jr nz, .notNoisy

	;Store the 6-char nickname.

	ld a, [$D4A7]
	call SerIO_ADVICE_GetNicknameSRAMAddress
	ld d, h
	ld e, l
	ld hl, $DC77
	ld bc, 6
	call memcpy

	;Store the 4-char nickname extension.

	ld a, [$D4A7]
	call SerIO_ADVICE_GetNicknameExtensionSRAMAddress
	ld d, h
	ld e, l
	ld hl, $DC7D
	ld bc, 4
	call memcpy

	jp Banked_SGB_ConstructATTRBLKPacket_return

.useDefault
	ld a, [$DC60]
	cp $61
	jr nz, .notNoisy
	ld hl, $DC70
	ld de, SerIO_ADVICE_NoisyJapanese
	ld b, 5
	call SerIO_ADVICE_CompareNicknames
	jr nz, .notNoisy

.isNoisy

	;Special-case Noisy's nickname.

	ld a, [$D4A7]
	call SerIO_ADVICE_GetNicknameSRAMAddress
	ld d, h
	ld e, l
	ld hl, SerIO_ADVICE_NoisyEnglish
	ld bc, 6
	call memcpy
	jr .useDefaultExtension

.notNoisy

	;Store the 6-char default nickname.

	ld a, [$D4A7]
	call SerIO_ADVICE_GetNicknameSRAMAddress
	ld a, $E6
	ld [hli], a
	ld a, $E0
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a

.useDefaultExtension

	;Store an empty nickname extension.

	ld a, [$D4A7]
	call SerIO_ADVICE_GetNicknameExtensionSRAMAddress
	ld a, $E0
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a

	jp Banked_SGB_ConstructATTRBLKPacket_return
