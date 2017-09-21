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

;Individual script banks are generated from the mainscript compiler.