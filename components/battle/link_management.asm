SECTION "Battle Link Vars", WRAMX[$D458], BANK[$1]
W_Battle_OpponentUsingLinkCable:: ds 1

SECTION "Battle Link Vars2", WRAMX[$DC45], BANK[$1]
W_Battle_NextSerIOByteIn:: ds 1

SECTION "Battle Link Management", ROM0[$3EEE]
Battle_ReadByteFromRecvBuffer::
    ld hl, W_SerIO_RecvBuffer
    ld d, 0
    ld a, [W_Battle_NextSerIOByteIn]
    ld e, a
    add hl, de
    ld a, [hl]
    ret