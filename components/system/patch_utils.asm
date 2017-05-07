IMPORT SaveClock_ADVICE_LoadDenjuuNickname.indexNicknameArray

SECTION "Patch Utilities", ROM0[$0063]
PatchUtils_ResetVector: jp PatchUtils_ResetGame
	db "Denjuu" ;not sure what this is
	ld [$FF00], a
PatchUtils_LimitBreak:: sla e
	rl d
	sla e
	rl d
	ret
	
SECTION "Patch Utilities 2", ROM0[$0096]
PatchUtils_MainScript_ADVICE_LoadItemNameAsArg3::
	ld a, BANK(MainScript_ADVICE_LoadItemNameAsArg3)
	rst $10
	call MainScript_ADVICE_LoadItemNameAsArg3
	rst $18
	ret
	
PatchUtils_LoadDenjuuName_Bankswitch::
	ld a, h
	cp $40
	jr nz, .aboveHL
	ld a, l
	or a
	jr nz, .aboveHL
	ld a, $34
	rst $10
	ret
	
.aboveHL
	ld a, $75 ;Original Denjuu bank
	rst $10
	ret
	
;YAY NOP SLIDE
	db 0,0,0,0
	db 0,0,0,0
	db 0,0,0,0
	db 0,0,0,0
	
;BF
Banked_SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr_indexNicknameArray::
	rst $10
	call SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr_indexNicknameArray
	rst $10
	ret
	
;C5
Banked_TitleMenu_ADVICE_SplitNickAndSpeciesNames::
	rst $10
	call TitleMenu_ADVICE_SplitNickAndSpeciesNames
	rst $18
	ret
	
;CB
Banked_TitleMenu_ADVICE_LoadDenjuuNicknameIntoBuffer::
	rst $10
	call TitleMenu_ADVICE_LoadDenjuuNicknameIntoBuffer
	rst $18
	ret
	
;D1
Banked_SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr::
	rst $10
	call SaveClock_ADVICE_LoadDenjuuNicknameByStatPtr
	rst $10
	ret

;D7
Banked_StringTable_ADVICE_PadCopyBuffer::
	ld a, [W_CurrentBank]
	push af
	ld a, BANK(StringTable_ADVICE_PadCopyBuffer)
	rst $10
	call StringTable_ADVICE_PadCopyBuffer
	pop af
	rst $10
	ret
	
;E4
MainScript_ADVICE_DrawDenjuuName::
	push af
	push hl
	cp h
	jr z, .mystery2
	call $548
	jr .mystery3
	
.mystery2 ;EE
	call Banked_PauseMenu_ADVICE_LoadName75

.mystery3 ;F1
	pop af
	pop hl
	ret

Banked_PauseMenu_ADVICE_LoadName75:: ;F4
	ld a, $34
	rst $10
	call PauseMenu_ADVICE_LoadName75
	rst $18
	ret
	
PatchUtils_ResetGame: nop
	nop
	nop
	nop ;Further execution hits the main vector of the rom header

SECTION "PatchUtils Auxiliary Code", ROM0[$3FF1]
PatchUtils_AuxCodeJmp::
	push af
	ld a, 1
	rst $10
	pop af
	ld hl, .returnVec
	push hl
	ld l, a
	ld h, $40
	jp [hl]

.returnVec
	rst $18
	ret