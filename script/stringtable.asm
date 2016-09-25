SECTION "MainScript_battle_items Section", ROMX[$6b80], BANK[$78]
MainScript_battle_items::
	INCBIN "script/battle/items.stringtbl"
MainScript_battle_items_END

SECTION "MainScript_denjuu_species Section", ROMX[$4000], BANK[$34]
MainScript_denjuu_species::
	INCBIN "script/denjuu/species.stringtbl"
MainScript_denjuu_species_END

;D0B00
    REPT $3200
        db $E0
    ENDR
;D3D00

SECTION "MainScript_battle_tfangers Section", ROMX[$6300], BANK[$75]
MainScript_battle_tfangers::
	INCBIN "script/battle/tfangers.stringtbl"
MainScript_battle_tfangers_END

;1D6610
    REPT $1318
        db 0
    ENDR
;1D7927

;Flotsam in the ROM
;TODO: Remove
    INCBIN "script/denjuu/personalities_old.stringtbl"
    INCBIN "script/denjuu/statuses_old.stringtbl"

;1D79C8
    REPT $0638
        db 0
    ENDR
;1D8000 (end of bank)

SECTION "MainScript_battle_attacks Section", ROMX[$5890], BANK[$75]
MainScript_battle_attacks::
	INCBIN "script/battle/attacks.stringtbl"
MainScript_battle_attacks_END

SECTION "MainScript_denjuu_habitats Section", ROMX[$6200], BANK[$75]
MainScript_denjuu_habitats::
	INCBIN "script/denjuu/habitats.stringtbl"
MainScript_denjuu_habitats_END

SECTION "MainScript_battle_arrive_phrases Section", ROMX[$4000], BANK[$78]
MainScript_battle_arrive_phrases::
	INCBIN "script/battle/arrive_phrases.stringtbl"
MainScript_battle_arrive_phrases_END

SECTION "MainScript_battle_attack_phrases Section", ROMX[$55c0], BANK[$78]
MainScript_battle_attack_phrases::
	INCBIN "script/battle/attack_phrases.stringtbl"
MainScript_battle_attack_phrases_END

SECTION "MainScript_denjuu_personalities Section", ROMX[$6130], BANK[$75]
MainScript_denjuu_personalities::
	INCBIN "script/denjuu/personalities.stringtbl"
MainScript_denjuu_personalities_END

SECTION "MainScript_denjuu_statuses Section", ROMX[$6270], BANK[$75]
MainScript_denjuu_statuses::
	INCBIN "script/denjuu/statuses.stringtbl"
MainScript_denjuu_statuses_END

