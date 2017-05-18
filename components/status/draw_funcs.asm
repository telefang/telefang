INCLUDE "telefang.inc"

SECTION "Status Screen Draw Funcs", ROMX[$50C2], BANK[2]
Status_DrawDenjuuMoves::
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove1
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld de, StringTable_battle_attacks
    ld bc, $8B80
    call Banked_MainScript_DrawName75
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove2
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld de, StringTable_battle_attacks
    ld bc, $8C00
    call Banked_MainScript_DrawName75
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove3Level
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    ld a, [W_Status_SelectedDenjuuLevel]
    cp b
    jr c, .drawUnknownMove3
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove3
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld de, StringTable_battle_attacks
    ld bc, $8C80
    call Banked_MainScript_DrawName75
    jr .drawMove4
    
.drawUnknownMove3
    ld de, $4BAF ;???
    ld hl, $8C80
    ld b, 8
    call Banked_MainScript_DrawStatusText
    
.drawMove4
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove4Level
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    cp $64
    jr z, .drawEmptyMove4
    ld a, [W_Status_SelectedDenjuuLevel]
    cp b
    jr c, .drawUnknownMove4
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove4
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld de, StringTable_battle_attacks
    ld bc, $8D00
    call Banked_MainScript_DrawName75
    jr .drawCompleted
    
.drawUnknownMove4
    ld de, $4BAF ;???
    ld hl, $8D00
    ld b, 8
    call Banked_MainScript_DrawStatusText

.drawCompleted
    ret

.drawEmptyMove4
    ld hl, $8D00
    ld a, 8
    call MainScript_DrawEmptySpaces
    ret

;Big WTF here: this is called to 'validate' the moves, but it just loads stuff
;without doing anything to them...
Status_ValidateMoves::
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove1
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove2
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove3Level
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    ld a, [W_Status_SelectedDenjuuLevel]
    cp b
    jr c, .done
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove3
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove4Level
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld b, a
    ld a, [W_Status_SelectedDenjuuLevel]
    cp b
    jr c, .done
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesMove4
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    
.done
    ret

Status_DrawDenjuuBattleStats::
    ld a, [W_Status_SelectedDenjuuLevel]
    ld b, a
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, M_Battle_SpeciesBaseSpeed
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $9986
    ld c, 0
    call Status_DrawStatValue
    
    ld a, [W_Status_SelectedDenjuuLevel]
    ld b, a
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, M_Battle_SpeciesBaseAttack
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $99C6
    ld c, 0
    call Status_DrawStatValue
    
    ld a, [W_Status_SelectedDenjuuLevel]
    ld b, a
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, M_Battle_SpeciesBaseDefense
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $9A06
    ld c, 0
    call Status_DrawStatValue
    
    ld a, [W_Status_SelectedDenjuuLevel]
    ld b, a
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, M_Battle_SpeciesBaseDenmaAttack
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $998F
    ld c, 0
    call Status_DrawStatValue
    
    ld a, [W_Status_SelectedDenjuuLevel]
    ld b, a
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, M_Battle_SpeciesBaseDenmaDefense
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $99CF
    ld c, 0
    call Status_DrawStatValue
    
    ret

Status_DrawDenjuuProgressionStats::
    ld a, $A
    ld [REG_MBC3_SRAMENABLE], a
    ld a, 2
    ld [REG_MBC3_SRAMBANK], a ;manually enter SRAM2
    
    ld a, [W_Status_SelectedDenjuuLevel]
    ld hl, $99E5
    ld c, 1
    call Status_DrawStatValue
    
    ld a, [W_Status_SelectedDenjuuLevel]
    ld b, a
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld c, M_Battle_SpeciesBaseHP
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Battle_RetrSpeciesByte]
    ld hl, $9A05
    ld c, 0
    call Status_DrawStatValue
    
    ld a, [W_Status_CalledFromContactScreen]
    cp 1
    jr z, .readFDValue
    ld a, [W_Status_UseDenjuuNickname]
    cp 1
    jr z, .readFDValue
    ld a, [W_SystemSubState]
    cp 2
    jp nz, .nullFDValue
    
.readFDValue
    ld a, [W_Status_SelectedDenjuuIndex]
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuFriendship
    call Battle_IndexStatisticsArray
    ld a, [hl]
    jr .drawFDValue

.nullFDValue
    ld a, 0
    
.drawFDValue
    ld hl, $99EE
    ld c, 0
    call Status_DrawStatValue
    
    ld a, [W_Status_SelectedDenjuuLevel]
    cp M_SaveClock_DenjuuLevelCap
    jp z, .atLevelCap
    
    ld a, [W_Status_CalledFromContactScreen]
    cp 1
    jr z, .drawExpCount
    ld a, [W_Status_UseDenjuuNickname]
    cp 1
    jr z, .drawExpCount
    ld a, [W_SystemSubState]
    cp 2
    jp nz, .atLevelCap

.drawExpCount
    ld a, [W_Status_SelectedDenjuuIndex]
    ld hl, S_SaveClock_StatisticsArray + M_SaveClock_DenjuuExperience
    call Battle_IndexStatisticsArray
    
    ld a, [hli]
    ld c, a
    ld b, [hl]
    sra b
    rr c
    push bc
    pop hl
    ld bc, $9A0B
    call Status_DrawStatValuePad3
    
    ld a, [W_Status_SelectedDenjuuSpecies]
    ld b, 0
    ld c, M_Battle_SpeciesType
    call Banked_Battle_LoadSpeciesData
    ld a, [W_Status_SelectedDenjuuLevel]
    ld b, a
    ld a, [W_Battle_RetrSpeciesByte]
    call Banked_Battle_LoadNextLevelExp
    sra b
    rr c
    push bc
    pop hl
    ld bc, $9A0F
    call Status_DrawStatValuePad3
    
    jr .done
    
.atLevelCap
    ld bc, $C10
    ld e, $AC
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
    ld bc, $1010
    ld e, $AC
    ld a, 0
    call Banked_RLEDecompressTMAP0
    
.done
    ret