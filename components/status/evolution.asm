INCLUDE "telefang.inc"

SECTION "Status Evolution Indicator Loader", ROM0[$3D95]
Status_LoadEvolutionIndicatorBySpecies::
    cp $14
    jr c, .naturalDenjuu
    cp $23
    jr c, .cultivatedDenjuu
    cp $37
    jr c, .technoDenjuu
    cp $4B
    jr c, .bigDenjuu
    cp $5A
    jr c, .burstDenjuu
    cp $6E
    jr c, .explosionDenjuu
    cp $78
    jr c, .superMachineDenjuu
    cp $87
    jr c, .superDenjuu
    cp $96
    jr c, .demonDenjuu
    cp $9B
    jr c, .darkSpaceDenjuu
    cp $A0
    jr c, .trueDenjuu
    cp $A9
    jr c, .godDenjuu
    cp $AC
    jr c, .devilDenjuu
    jr .demonDenjuu

.naturalDenjuu
    ld a, M_Status_NaturalDenjuuIcon
    jr .loadEvoIcon
    
.cultivatedDenjuu
    ld a, M_Status_CultivatedDenjuuIcon
    jr .loadEvoIcon
    
.technoDenjuu
    ld a, M_Status_TechnoDenjuuIcon
    jr .loadEvoIcon
    
.bigDenjuu
    ld a, M_Status_BigDenjuuIcon
    jr .loadEvoIcon
    
.burstDenjuu
    ld a, M_Status_BurstDenjuuIcon
    jr .loadEvoIcon
    
.explosionDenjuu
    ld a, M_Status_ExplosionDenjuuIcon
    jr .loadEvoIcon
    
.superMachineDenjuu
    ld a, M_Status_SuperMachineDenjuuIcon
    jr .loadEvoIcon
    
.superDenjuu
    ld a, M_Status_SuperDenjuuIcon
    jr .loadEvoIcon
    
.demonDenjuu
    ld a, M_Status_DemonDenjuuIcon
    jr .loadEvoIcon
    
.darkSpaceDenjuu
    ld a, M_Status_DarkSpaceDenjuuIcon
    jr .loadEvoIcon
    
.trueDenjuu
    ld a, M_Status_TrueDenjuuIcon
    jr .loadEvoIcon
    
.godDenjuu
    ld a, M_Status_GodDenjuuIcon
    jr .loadEvoIcon
    
.devilDenjuu
    ld a, M_Status_DevilDenjuuIcon
    
.loadEvoIcon
    jp Banked_Status_LoadDenjuuEvolutionIndicator