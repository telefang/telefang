INCLUDE "registers.inc"
INCLUDE "components/serio/driver.inc"

SECTION "SerIO Other Vars", WRAM0[$CB3F]
W_SerIO_ConnectionState:: ds 1

;TODO: Do any of these unknown bytes do anything?, slash
;NOTE: If you are getting a conflict for a WRAMX section in the $DC00-$DC43
;area, it's probably this section that needs to be split!
;(Though according to SerIO_ResetConnection the entire $DC00 page is ours)
SECTION "SerIO Driver Variables", WRAMX[$DA00], BANK[1]
W_SerIO_SendBuffer:: ds $100
W_SerIO_RecvBuffer:: ds $100
W_SerIO_PacketType:: ds 1
W_SerIO_SentMysteryPacket:: ds 1
	ds 2
W_SerIO_DoingXfer:: ds 1
W_SerIO_State:: ds 1
W_ShadowREG_SB:: ds 1
W_SerIO_IdleCounter:: ds 1
	ds 9
W_SerIO_DriverInByte:: ds 1
	ds $15
W_SerIO_DriverOutByte:: ds 1
	ds 6
W_SerIO_ProcessInByte:: ds 1
	ds 5
W_SerIO_ProcessOutByte:: ds 1
	ds 5
W_SerIO_SendBufferWrite:: ds 1
	ds 1
W_SerIO_SendBufferRead:: ds 1
	ds 1
W_SerIO_SendBufferReady:: ds 1
W_SerIO_RecvBufferWrite:: ds 1
	ds 1
W_SerIO_RecvBufferRead:: ds 1
	ds 1
W_SerIO_RecvBufferReady:: ds 1

SECTION "SerIO Driver", ROM0[$1C9B]

;Switch to the internal clock for serial transfers.
;
;Will do nothing in the following cases:
;
;1. We aren't already exchanging data.
;2. We are in the middle of SerIO_IRQ.packetXfrMode
;3. The last recieved data isn't M_SerIO_ConnectByte
;4. See check #2 (yes it's checked twice)
SerIO_SwitchToInternalClock::
	ld a, [W_SerIO_State]
	and a
	ret z
	ld a, [W_SerIO_DoingXfer]
	and a
	ret nz
	ld a, [W_SerIO_PacketType]
	and a
	ret z
	ld a, [W_SerIO_DoingXfer]
	and a
	ret nz
	ld a, $81
	ldh [REG_SC], a
	ret
	
SerIO_IRQ::
	push af
	push bc
	push de
	push hl
	xor a
	ld [W_SerIO_IdleCounter], a
	ld a, [W_SerIO_State]
	cp 2
	jr z, .packetXfrMode
	ldh a, [REG_SB]
	cp M_SerIO_ConnectByte
	jr z, .gotConnectPacket
	cp M_SerIO_MysteryByte
	jr z, .gotMysteryPacket
	xor a
	ld [W_SerIO_PacketType], a
	ld a, M_SerIO_PresenceByte
	ldh [REG_SB], a
	ld a, $80
	ldh [REG_SC], a
	jp .return
	
.gotConnectPacket
	ld a, 2
	ld [W_SerIO_State], a
	ld a, 1
	ld [W_SerIO_PacketType], a
	jr .sendNull
	
.gotMysteryPacket
	ld a, 2
	ld [W_SerIO_State], a
	xor a
	ld [W_SerIO_PacketType], a
	
.sendNull
	xor a
	ldh [REG_SB], a
	ld a, $80
	ldh [REG_SC], a
	jp .return
	
.packetXfrMode
	ld a, 1
	ld [W_SerIO_DoingXfer], a
	ldh a, [REG_SB]
	ld [W_SerIO_DriverInByte], a
	ld a, [W_SerIO_DriverOutByte]
	ldh [REG_SB], a
	ld bc, $20
	call SerIO_Wait
	ld a, $80
	ldh [REG_SC], a
	xor a
	ld [W_SerIO_DoingXfer], a
	call SerIO_RecvBufferPush
	call SerIO_SendBufferPull
	
.return
	pop hl
	pop de
	pop bc
	pop af
	reti
	
SerIO_ResetConnection::
	ld hl, W_SerIO_SendBuffer
	ld bc, $300 ;TODO: Calculate actual size of SerIO area
	call memclr
	ld a, M_SerIO_PresenceByte
	ldh [REG_SB], a
	ld [W_ShadowREG_SB], a
	ld a, $80
	ldh [REG_SC], a
	ret
	
SerIO_SendMysteryPacket:
	ld a, 1
	ld [W_SerIO_SentMysteryPacket], a
	ld a, M_SerIO_MysteryByte
	ldh [REG_SB], a
	ld a, $81
	ldh [REG_SC], a
	ret
	
SerIO_SendConnectPacket::
	ld a, [W_SerIO_State]
	and a
	ret nz
	ld a, M_SerIO_ConnectByte
	ldh [REG_SB], a
	ld [W_ShadowREG_SB], a
	ld a, $80
	ldh [REG_SC], a
	ret
	
SerIO_Wait:
	dec bc
	ld a, b
	or c
	jr nz, SerIO_Wait
	ret
	
SerIO_InitializeRecvArea:
	ld hl, W_SerIO_RecvBuffer
	ld bc, $100
	jp memclr
	
SerIO_SendBufferPush::
	di
	ld a, 1
	ld [W_SerIO_SendBufferReady], a
	ld a, [W_SerIO_SendBufferWrite]
	ld l, a
	ld h, W_SerIO_SendBuffer >> 8
	ld a, [W_SerIO_ProcessOutByte]
	ld [hl], a
	inc l
	or a
	jr z, .skipNullByte
	ld a, l
	ld [W_SerIO_SendBufferWrite], a
	xor a
	ld [W_SerIO_ProcessOutByte], a
	
.skipNullByte
	ei
	ret
	
SerIO_SendBufferPull:
	ld a, [W_SerIO_SendBufferReady]
	and a
	jr z, .nothingToSend
	xor a
	ld [W_SerIO_SendBufferReady], a
	ld a, [W_SerIO_SendBufferRead]
	ld l, a
	ld h, W_SerIO_SendBuffer >> 8
	ld a, [hl]
	inc l
	ld [W_SerIO_DriverOutByte], a
	or a
	ret z
	ld a, l
	ld [W_SerIO_SendBufferRead], a
	ret

.nothingToSend
	xor a
	ld [W_SerIO_DriverOutByte], a
	ret
	
SerIO_RecvBufferPush:
	ld a, 1
	ld [W_SerIO_RecvBufferReady], a
	ld a, [W_SerIO_RecvBufferWrite]
	ld l, a
	ld h, W_SerIO_RecvBuffer >> 8
	ld a, [W_SerIO_DriverInByte]
	ld [hl], a
	inc l
	or a
	ret z
	ld a, l
	ld [W_SerIO_RecvBufferWrite], a
	ret
	
SerIO_RecvBufferPull::
	di
	ld a, [W_SerIO_RecvBufferReady]
	and a
	jr z, .nothingToRecv
	xor a
	ld [W_SerIO_RecvBufferReady], a
	ld a, [W_SerIO_RecvBufferRead]
	ld l, a
	ld h, W_SerIO_RecvBuffer >> 8
	ld a, [hl]
	inc l
	ld [W_SerIO_ProcessInByte], a
	or a
	jr z, .skipNullByte
	ld a, l
	ld [W_SerIO_RecvBufferRead], a
	
.skipNullByte
	ei
	ret

.nothingToRecv
	xor a
	ld [W_SerIO_ProcessInByte], a
	ei
	ret