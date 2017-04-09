SECTION "MainScript Meta Table", ROMX[$494f], BANK[$b]
MainScript_table::
    dw MainScript_battle_messages
    db BANK(MainScript_battle_messages)
    dw MainScript_denjuu_sms
    db BANK(MainScript_denjuu_sms)
    dw MainScript_npc_1
    db BANK(MainScript_npc_1)
    dw MainScript_story_1
    db BANK(MainScript_story_1)
    dw MainScript_npc_2
    db BANK(MainScript_npc_2)
    dw MainScript_npc_unused
    db BANK(MainScript_npc_unused)
    dw MainScript_npc_postgame
    db BANK(MainScript_npc_postgame)
    dw MainScript_calls_denjuu_1
    db BANK(MainScript_calls_denjuu_1)
    dw MainScript_calls_denjuu_2
    db BANK(MainScript_calls_denjuu_2)
    dw MainScript_story_2
    db BANK(MainScript_story_2)
    dw MainScript_story_3
    db BANK(MainScript_story_3)
    dw MainScript_npc_3
    db BANK(MainScript_npc_3)
    dw MainScript_story_4
    db BANK(MainScript_story_4)
    dw MainScript_calls_denjuu_3
    db BANK(MainScript_calls_denjuu_3)
    dw MainScript_calls_denjuu_4
    db BANK(MainScript_calls_denjuu_4)
    dw MainScript_calls_denjuu_5
    db BANK(MainScript_calls_denjuu_5)
    dw MainScript_calls_denjuu_6
    db BANK(MainScript_calls_denjuu_6)
    dw MainScript_denjuu_descriptions
    db BANK(MainScript_denjuu_descriptions)
    dw MainScript_calls_story
    db BANK(MainScript_calls_story)
    dw MainScript_calls_exp_item
    db BANK(MainScript_calls_exp_item)
    dw MainScript_story_5
    db BANK(MainScript_story_5)

SECTION "MainScript_battle_messages Section", ROMX[$4000], BANK[$45]
MainScript_battle_messages:
	INCBIN "script/battle/messages.scripttbl"
MainScript_battle_messages_END

    REPT $295C
        db 0
    ENDR

SECTION "MainScript_denjuu_sms Section", ROMX[$4000], BANK[$46]
MainScript_denjuu_sms:
	INCBIN "script/denjuu/sms.scripttbl"
MainScript_denjuu_sms_END

    REPT $4000 - $0EF3
        db 0
    ENDR

SECTION "MainScript_npc_1 Section", ROMX[$4000], BANK[$47]
MainScript_npc_1:
	INCBIN "script/npc/1.scripttbl"
MainScript_npc_1_END

SECTION "MainScript_story_1 Section", ROMX[$4000], BANK[$48]
MainScript_story_1:
	INCBIN "script/story/1.scripttbl"
MainScript_story_1_END

SECTION "MainScript_npc_2 Section", ROMX[$4000], BANK[$49]
MainScript_npc_2:
	INCBIN "script/npc/2.scripttbl"
MainScript_npc_2_END

    REPT $4000 - $29AF
        db 0
    ENDR

SECTION "MainScript_npc_unused Section", ROMX[$4000], BANK[$4a]
MainScript_npc_unused:
	INCBIN "script/npc/unused.scripttbl"
MainScript_npc_unused_END

    REPT $4000 - $0070
        db 0
    ENDR

SECTION "MainScript_npc_postgame Section", ROMX[$4000], BANK[$40]
MainScript_npc_postgame:
	INCBIN "script/npc/postgame.scripttbl"
MainScript_npc_postgame_END

    REPT $4000 - $04DE
        db 0
    ENDR

SECTION "MainScript_calls_denjuu_1 Section", ROMX[$4000], BANK[$4c]
MainScript_calls_denjuu_1:
	INCBIN "script/calls/denjuu/1.scripttbl"
MainScript_calls_denjuu_1_END

    REPT $4000 - $1238
        db 0
    ENDR

SECTION "MainScript_calls_denjuu_2 Section", ROMX[$4000], BANK[$4d]
MainScript_calls_denjuu_2:
	INCBIN "script/calls/denjuu/2.scripttbl"
MainScript_calls_denjuu_2_END

    REPT $4000 - $0E00
        db 0
    ENDR

SECTION "MainScript_story_2 Section", ROMX[$4000], BANK[$4b]
MainScript_story_2:
	INCBIN "script/story/2.scripttbl"
MainScript_story_2_END

SECTION "MainScript_story_3 Section", ROMX[$4000], BANK[$4e]
MainScript_story_3:
	INCBIN "script/story/3.scripttbl"
MainScript_story_3_END

    REPT $4000 - $17F0
        db 0
    ENDR

SECTION "MainScript_npc_3 Section", ROMX[$4000], BANK[$4f]
MainScript_npc_3:
	INCBIN "script/npc/3.scripttbl"
MainScript_npc_3_END

    REPT $4000 - $0E00
        db 0
    ENDR

SECTION "MainScript_story_4 Section", ROMX[$4000], BANK[$50]
MainScript_story_4:
	INCBIN "script/story/4.scripttbl"
MainScript_story_4_END

    REPT $4000 - $21D4
        db 0
    ENDR

SECTION "MainScript_calls_denjuu_3 Section", ROMX[$4000], BANK[$44]
MainScript_calls_denjuu_3:
	INCBIN "script/calls/denjuu/3.scripttbl"
MainScript_calls_denjuu_3_END

SECTION "MainScript_calls_denjuu_4 Section", ROMX[$4000], BANK[$51]
MainScript_calls_denjuu_4:
	INCBIN "script/calls/denjuu/4.scripttbl"
MainScript_calls_denjuu_4_END

    REPT $4000 - $173C
        db 0
    ENDR

SECTION "MainScript_calls_denjuu_5 Section", ROMX[$4000], BANK[$58]
MainScript_calls_denjuu_5:
	INCBIN "script/calls/denjuu/5.scripttbl"
MainScript_calls_denjuu_5_END

SECTION "MainScript_calls_denjuu_6 Section", ROMX[$4000], BANK[$25]
MainScript_calls_denjuu_6:
	INCBIN "script/calls/denjuu/6.scripttbl"
MainScript_calls_denjuu_6_END

SECTION "MainScript_calls_denjuu_6 Old Crap", ROMX[$5068], BANK[$26]
;TODO: Remove because we don't need to zero out this old bank
    REPT $2F98
        db 0
    ENDR

SECTION "MainScript_denjuu_descriptions Section", ROMX[$4000], BANK[$10]
MainScript_denjuu_descriptions:
	INCBIN "script/denjuu/descriptions.scripttbl"
MainScript_denjuu_descriptions_END

    REPT $3634
        db 0
    ENDR

SECTION "MainScript_calls_story Section", ROMX[$4000], BANK[$56]
MainScript_calls_story:
	INCBIN "script/calls/story.scripttbl"
MainScript_calls_story_END

    REPT $4000 - $18A4
        db 0
    ENDR

SECTION "MainScript_calls_exp_item Section", ROMX[$4000], BANK[$57]
MainScript_calls_exp_item:
	INCBIN "script/calls/exp_item.scripttbl"
MainScript_calls_exp_item_END

    REPT $4000 - $05CC
        db 0
    ENDR

SECTION "MainScript_story_5 Section", ROMX[$4000], BANK[$43]
MainScript_story_5:
	INCBIN "script/story/5.scripttbl"
MainScript_story_5_END

SECTION "MainScript_overflow_1 Section", ROMX[$4000], BANK[$1E]
MainScript_overflow_1:
	INCBIN "script/overflow/1.scripttbl"
   
   ;TODO: Remove.
   ;This floatsam was added for the sake of binary equivalence between the
   ;old patch and the disassembly patch. When the disassembly process is
   ;complete, please remove this flotsam.
   INCBIN "script/overflow/1_flotsam.bin"
MainScript_overflow_1_END