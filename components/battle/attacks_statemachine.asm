INCLUDE "telefang.inc"

SECTION "Battle Screen - Attack State Machine", ROMX[$6643], BANK[$5]
Battle_AttackStateMachine::
	ld a, [W_LateDenjuu_SubSubState]
	ld hl, .table
	call System_IndexWordList
	jp [hl]
	
.table
	dw $66A5, $6709, $6724, $68D6, $6C11, $6C6E, $6E82, $6F47
	dw $6F84, $6F97, $7122, $717F, $7347, $73CF, $740C, $741F
	dw $74B9, $7521, $7589, $75CE, $7612, $7AEA, $7DF4, $7E09
	dw $7F13, $6E1D, $6E29, $72DD, $72E9, $7DD6, $7689, $75BD
	dw $76B9, $6801, $747E, $7EF6, $6CBA, $7DE5, $70C5, $6AA7
	dw $70D8, $6C7F, $6CDA, $7190