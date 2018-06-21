INCLUDE "telefang.inc"

SECTION "Patch Utilities - Queue Message and Articles", ROM0[$3E5C]
Battle_ADVICE_QueueMessage_WithoutArticle::
	ld a, Banked_Battle_ADVICE_BattleNoArticle & $FF
	jr Battle_ADVICE_QueueMessage_WithArticle.remJumpP

Battle_ADVICE_QueueMessage_WithArticle::
	ld a, Banked_Battle_ADVICE_BattleArticle & $FF

.remJumpP
	call PatchUtils_AuxCodeJmp
	jp Battle_QueueMessage

SECTION "Patch Utilities - Battle Articles", ROMX[$4900], BANK[$1]
Battle_ADVICE_BattleNoArticle::
	M_AdviceSetup
	ld a, $E0
	ld [W_Map_LocationStaging + $11], a
	jp Battle_ADVICE_BattleArticle.teardown

Battle_ADVICE_BattleArticle::
	M_AdviceSetup
	push hl
	push de
	ld de, W_Map_LocationStaging + $11
	ld hl, .the
	ld b, $F
	
.copyLoopA
	ld a, [hli]
	cp $E0
	jr z, .abandonLoopA
	ld [de], a
	inc de
	dec b
	jr nz, .copyLoopA

.abandonLoopA
	ld a, $E0
	ld [de], a
	pop de
	pop hl

.teardown
	M_AdviceTeardown
	ret

; I am not going to bother making a speadsheet for just one word.

.the
	db "The "
	db $E0
