;A Participant struct refers to information about a particular Denjuu in battle.
;It's copied around fairly frequently as various parts of the battle engine need
;to be able to handle moves performed on both partners and opponents.

DEF M_Battle_ParticipantSpecies EQU $00
DEF M_Battle_ParticipantLevel EQU $01
DEF M_Battle_ParticipantHP EQU $02
DEF M_Battle_ParticipantMaxHP EQU $03
DEF M_Battle_ParticipantDP EQU $05
DEF M_Battle_ParticipantArrivalTimeElapsed EQU $06
DEF M_Battle_ParticipantLocation EQU $07
DEF M_Battle_ParticipantMaxArrivalTime EQU $08
DEF M_Battle_ParticipantMaxDP EQU $09
DEF M_Battle_ParticipantPersonality EQU $0C
DEF M_Battle_ParticipantContactID EQU $0D
DEF M_Battle_ParticipantStatusCondition EQU $12

DEF M_Battle_ParticipantSize EQU $16

DEF M_Battle_TeamSize EQU $03

DEF M_Battle_LocationNotPresent EQU $00
DEF M_Battle_LocationCalled EQU $01
DEF M_Battle_LocationArriving EQU $02
DEF M_Battle_LocationPresent EQU $03
DEF M_Battle_LocationDelayed EQU $04
DEF M_Battle_LocationChargingDenma EQU $05
DEF M_Battle_LocationDeserted EQU $08
DEF M_Battle_LocationQueuedForEXP EQU $09
DEF M_Battle_LocationLeveling EQU $0A
DEF M_Battle_LocationEvolving EQU $0B