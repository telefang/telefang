INCLUDE "telefang.inc"

SECTION "Patch Utilities - Queue Message and Articles", ROM0[$3E5C]
Battle_ADVICE_QueueMessage_WithoutArticle::
	M_PrepAuxJmp Banked_Battle_ADVICE_BattleNoArticle
	jr Battle_ADVICE_QueueMessage_WithArticle.remJumpP

Battle_ADVICE_QueueMessage_WithArticle::
	M_PrepAuxJmp Banked_Battle_ADVICE_BattleArticle

.remJumpP
	call PatchUtils_AuxCodeJmp
	jp Battle_QueueMessage

SECTION "Patch Utilities - Status Infliction Articles", ROMX[$5200], BANK[$1]
Battle_ADVICE_StatusInflictionArticle::
	M_AdviceSetup

	call SaveClock_EnterSRAM2
	ld a, [W_Battle_CurrentParticipantTeam]
	ld h, a
	and a
	jp z, Battle_ADVICE_BattleArticle.postSetup
	jp Battle_ADVICE_BattleNoArticle.postSetup

SECTION "Patch Utilities - Battle Articles", ROMX[$4BE0], BANK[$1]
Battle_ADVICE_BattleNoArticle::
	M_AdviceSetup
	
.postSetup
	ld a, $E0
	ld [W_Map_LocationStaging + $11], a
	ld [W_Map_LocationStaging + $19], a
	jp Battle_ADVICE_BattleArticle_teardown

Battle_ADVICE_BattleArticle::
	M_AdviceSetup
	
.postSetup
	ld a, [W_Battle_OpponentUsingLinkCable]
	cp 1
	jr z, .articlesNeeded
	ld a, [W_Encounter_BattleType]
	cp M_Encounter_BattleTypeStory
	jr nz, .articlesNeeded
	ld a, [$D402]
	or a
	jr z, .noArticlesNeeded
	cp $C
	jr z, .noArticlesNeeded
	cp $D
	jr z, .noArticlesNeeded
	cp $E
	jr z, .noArticlesNeeded
	cp $F
	jr z, .noArticlesNeeded
	cp $86
	jr z, .noArticlesNeeded
	jr .articlesNeeded

.noArticlesNeeded
	jp Battle_ADVICE_BattleNoArticle.postSetup
	
.articlesNeeded
	push hl
	push de
	ld de, W_Map_LocationStaging + $11
	ld hl, Battle_ADVICE_BattleArticle_articles.the
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
	ld de, W_Map_LocationStaging + $19
	ld hl, Battle_ADVICE_BattleArticle_articles.thelower
	ld b, $F
	
.copyLoopB
	ld a, [hli]
	cp $E0
	jr z, .abandonLoopB
	ld [de], a
	inc de
	dec b
	jr nz, .copyLoopB

.abandonLoopB
	ld a, $E0
	ld [de], a
	pop de
	pop hl

;used in fusionlabevo/number_utils.asm
Battle_ADVICE_BattleArticle_teardown::
	M_AdviceTeardown
	ret

; I am not going to bother making a speadsheet for just one word.

Battle_ADVICE_BattleArticle_articles::
.the
	db "The "
	db $E0

.thelower
	db "the "
	db $E0
