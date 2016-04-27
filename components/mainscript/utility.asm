SECTION "Main Script Control Code Utilities", ROM0[$2D2B]
MainScript_LoadFromBank::
	ld a, [W_CurrentBank]
	push af
	ld a, [W_MainScript_TextBank]
	rst $10
	ld a, [hli]
	ld c, a
	pop af
	rst $10
	ld a, c
	ret

MainScript_Jump2Operand::
	ld a, [W_CurrentBank]
	push af
	ld a, [W_MainScript_TextBank]
	rst $10
	ld a, [hli]
	ld [W_MainScript_TextPtr], a
	ld a, [hl]
	ld [W_MainScript_TextPtr + 1], a
	pop af
	rst $10
	ret