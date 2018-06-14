;A voice is a structure which follows song stream data and writes song data
;to a single specific hardware channel.

M_Sound_VoiceCount EQU 6
M_Sound_VoiceSize EQU $28

;There are six voices, two of which are redundantly mapped to the same hardware
;channel as two others. It is currently unknown why there are more voices than
;hardware channels to service them.

