SECTION "StringTable_battle_nicknames Section", ROMX[$5f00], BANK[$1c]
Encounter_ADVICE_ScriptedDenjuuNicknameTable::
	INCBIN "build/script/battle/nicknames.stringtbl"
Encounter_ADVICE_ScriptedDenjuuNicknameTable_END::

SECTION "StringTable_battle_singular Section", ROMX[$7cf0], BANK[$1]
Battle_SingularCharacterTable::
	INCBIN "build/script/battle/singular.stringtbl"
Battle_SingularCharacterTable_END::

SECTION "StringTable_battle_plural Section", ROMX[$7cf8], BANK[$1]
Battle_PluralCharacterTable::
	INCBIN "build/script/battle/plural.stringtbl"
Battle_PluralCharacterTable_END::

SECTION "StringTable_battle_items Section", ROMX[$6b80], BANK[$78]
StringTable_battle_items::
	INCBIN "build/script/battle/items.stringtbl"
StringTable_battle_items_END::

SECTION "StringTable_battle_items_old Section", ROMX[$6652], BANK[$b]
StringTable_battle_items_old::
	INCBIN "build/script/battle/items_old.stringtbl"
StringTable_battle_items_old_END::

SECTION "StringTable_denjuu_nicknames Section", ROMX[$78fa], BANK[$b]
StringTable_denjuu_nicknames::
	INCBIN "build/script/denjuu/nicknames.stringtbl"
StringTable_denjuu_nicknames_END::

SECTION "StringTable_denjuu_article_mapping Section", ROMX[$5b00], BANK[$1c]
Encounter_ADVICE_ArticleTable::
	INCBIN "build/script/denjuu/article_mapping.stringidx"
Encounter_ADVICE_ArticleTable_END::

SECTION "StringTable_tfanger_article_mapping_1 Section", ROMX[$5c60], BANK[$1c]
Encounter_ADVICE_TFangerArticleTable::
	INCBIN "build/script/battle/tfanger_articles_mapping_1.stringidx"
Encounter_ADVICE_TFangerArticleTable_END::

SECTION "StringTable_tfanger_article_mapping_2 Section", ROMX[$5cc0], BANK[$1c]
Encounter_ADVICE_TFangerArticleTableB::
	INCBIN "build/script/battle/tfanger_articles_mapping_2.stringidx"
Encounter_ADVICE_TFangerArticleTableB_END::

SECTION "StringTable_denjuu_article_strings Section", ROMX[$5d20], BANK[$1c]
StringTable_denjuu_article_strings::
	INCBIN "build/script/denjuu/article_strings.stringblk"
StringTable_denjuu_article_strings_END::

SECTION "StringTable_map_location_mapping Section", ROMX[$6875], BANK[$2a]
StringTable_map_location_mapping::
	INCBIN "build/script/map/location_mapping.stringidx"
StringTable_map_location_mapping_END::

SECTION "StringTable_map_location_strings_old Section", ROMX[$6a75], BANK[$2a]
StringTable_map_location_strings_old::
	INCBIN "build/script/map/location_strings_old.stringblk"
StringTable_map_location_strings_old_END::

SECTION "StringTable_map_dungeon_mapping Section", ROMX[$6800], BANK[$62]
StringTable_map_dungeon_mapping::
	INCBIN "build/script/map/dungeon_mapping.stringidx"
StringTable_map_dungeon_mapping_END::

SECTION "StringTable_map_dungeon_mapping Old Section", ROMX[$6aff], BANK[$2a]
StringTable_map_dungeon_mapping_old::
	REPT $5A
		db 0
	ENDR
StringTable_map_dungeon_mapping_old_END::

SECTION "StringTable_map_dungeon_strings_old Section", ROMX[$6b69], BANK[$2a]
StringTable_map_dungeon_strings_old::
	INCBIN "build/script/map/dungeon_strings_old.stringblk"
StringTable_map_dungeon_strings_old_END::

;If you need to relocate these, ALSO CHANGE stringtable_names.txt to point to
;this section, or bad things will happen.
SECTION "StringTable_map_location_strings Section", ROMX[$7d8b], BANK[$2a]
StringTable_map_location_strings::
	INCBIN "build/script/map/location_strings.stringblk"
StringTable_map_location_strings_END::

SECTION "StringTable_map_dungeon_strings Section", ROMX[$686a], BANK[$62]
StringTable_map_dungeon_strings::
	INCBIN "build/script/map/dungeon_strings.stringblk"
StringTable_map_dungeon_strings_END::

SECTION "StringTable_denjuu_species Section", ROMX[$4000], BANK[$34]
StringTable_denjuu_species::
	INCBIN "build/script/denjuu/species.stringtbl"
StringTable_denjuu_species_END::

SECTION "StringTable_denjuu_species_old Section", ROMX[$4000], BANK[$75]
StringTable_denjuu_species_old::
	INCBIN "build/script/denjuu/species_old.stringtbl"
StringTable_denjuu_species_old_END::

SECTION "StringTable_battle_tfangers_old Section", ROMX[$4578], BANK[$75]
StringTable_battle_tfangers_old::
	INCBIN "build/script/battle/tfangers_old.stringtbl"
StringTable_battle_tfangers_old_END::

SECTION "StringTable_battle_attacks_old Section", ROMX[$46F8], BANK[$75]
StringTable_battle_attacks_old::
	INCBIN "build/script/battle/attacks_old.stringtbl"
StringTable_battle_attacks_old_END::

SECTION "StringTable_denjuu_habitats_old Section", ROMX[$5628], BANK[$75]
StringTable_denjuu_habitats_old::
	INCBIN "build/script/denjuu/habitats_old.stringtbl"
StringTable_denjuu_habitats_old_END::

SECTION "StringTable_battle_attacks Section", ROMX[$5888], BANK[$75]
	REPT $8
		db 0
	ENDR

StringTable_battle_attacks::
	INCBIN "build/script/battle/attacks.stringtbl"
StringTable_battle_attacks_END::

SECTION "StringTable_denjuu_personalities Section", ROMX[$6130], BANK[$75]
StringTable_denjuu_personalities::
	INCBIN "build/script/denjuu/personalities.stringtbl"
StringTable_denjuu_personalities_END::

SECTION "StringTable_denjuu_habitats Section", ROMX[$6200], BANK[$75]
StringTable_denjuu_habitats::
	INCBIN "build/script/denjuu/habitats.stringtbl"
StringTable_denjuu_habitats_END::

SECTION "StringTable_denjuu_statuses Section", ROMX[$6270], BANK[$75]
StringTable_denjuu_statuses::
	INCBIN "build/script/denjuu/statuses.stringtbl"
StringTable_denjuu_statuses_END::

SECTION "StringTable_battle_tfangers Section", ROMX[$6300], BANK[$75]
StringTable_battle_tfangers::
	INCBIN "build/script/battle/tfangers.stringtbl"
StringTable_battle_tfangers_END::

;1D6610
    REPT $1318
        db 0
    ENDR
;1D7928

;Flotsam in the ROM
;TODO: Remove
    INCBIN "build/script/denjuu/personalities_old.stringtbl"
    INCBIN "build/script/denjuu/statuses_old.stringtbl"

;1D79C8
    REPT $0638
        db 0
    ENDR
;1D8000 (end of bank)

SECTION "StringTable_battle_arrive_phrases Section", ROMX[$4000], BANK[$78]
StringTable_battle_arrive_phrases::
	INCBIN "build/script/battle/arrive_phrases.stringtbl"
StringTable_battle_arrive_phrases_END::

SECTION "StringTable_battle_attack_phrases Section", ROMX[$55c0], BANK[$78]
StringTable_battle_attack_phrases::
	INCBIN "build/script/battle/attack_phrases.stringtbl"
StringTable_battle_attack_phrases_END::
