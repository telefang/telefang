SECTION "tilemap Section", ROM0[$b18]
RLETilemapBanks::
	db BANK(Tilemap_BANK_0)
	db BANK(Tilemap_BANK_1)

SECTION "attrib Section", ROM0[$c34]
RLEAttribmapBanks::
	db BANK(Attribmap_BANK_0)
	db BANK(Attribmap_BANK_1)


SECTION "tilemap Bank 0", ROMX[$4000], BANK[$3e]
Tilemap_BANK_0::
	dw Tilemap_menu_stats_tmap
	dw Tilemap_menu_stats_tmap
	dw Tilemap_menu_stats_tab_progression_tmap
	dw Tilemap_menu_stats_tab_stats_tmap
	dw Tilemap_menu_stats_tab_moves_tmap
	dw Tilemap_screen_save_deleted_tmap
	dw Tilemap_unknown_tilemap_0_5
	dw Tilemap_titlelogo_smilesoft_tmap
	dw Tilemap_titlelogo_comic_bombom_tmap
	dw Tilemap_titlelogo_natsume_tmap
	dw Tilemap_titlelogo_author_credit_tmap
	dw Tilemap_encounter_backgrounds_base_tmap
	dw Tilemap_title_bg_tmap
	dw Tilemap_unknown_tilemap_0_c
	dw Tilemap_battle_ui_partner_message_layer_tmap
	dw Tilemap_battle_ui_partner_message_layer_tmap
	dw Tilemap_menu_phone_left_tmap
	dw Tilemap_pausemenu_resources_dshot_bottom_tmap
	dw Tilemap_menu_empty_menu_tmap
	dw Tilemap_menu_empty_expanded_option_tmap
	dw Tilemap_titlemenu_time_input_screen
	dw Tilemap_phoneime_hiragana_indicator_tmap
	dw Tilemap_phoneime_katakana_indicator_tmap
	dw Tilemap_pausemenu_resources_options_screen_tmap
	dw Tilemap_unknown_tilemap_0_16
	dw Tilemap_unknown_tilemap_0_17
	dw Tilemap_phoneconversation_window_tmap
	dw Tilemap_phoneime_number_indicator_tmap
	dw Tilemap_phoneconversation_monster_name_tmap
	dw Tilemap_pausemenu_resources_scrolling_menu_1_tmap
	dw Tilemap_pausemenu_resources_scrolling_menu_1_tmap
	dw Tilemap_pausemenu_resources_scrolling_menu_2_tmap
	dw Tilemap_pausemenu_resources_controls_hint_tmap
	dw Tilemap_pausemenu_resources_controls_hint_2_tmap
	dw Tilemap_pausemenu_resources_phone_window_tmap
	dw Tilemap_unknown_tilemap_0_20
	dw Tilemap_pausemenu_buttons_zukan_tmap
	dw Tilemap_pausemenu_buttons_contacts_tmap
	dw Tilemap_pausemenu_buttons_calls_tmap
	dw Tilemap_pausemenu_buttons_melody_tmap
	dw Tilemap_pausemenu_buttons_items_tmap
	dw Tilemap_pausemenu_buttons_sms_tmap
	dw Tilemap_pausemenu_buttons_save_tmap
	dw Tilemap_pausemenu_buttons_options_tmap
	dw Tilemap_pausemenu_buttons_cancel_tmap
	dw Tilemap_unknown_tilemap_0_2a
	dw Tilemap_contactmenu_select_screen_tmap
	dw Tilemap_unknown_tilemap_0_2c
	dw Tilemap_melodyedit_ringtone_select_tmap
	dw Tilemap_pausemenu_resources_inventory_tmap
	dw Tilemap_pausemenu_save_screen_tmap
	dw Tilemap_pausemenu_save_progress_tmap
	dw Tilemap_pausemenu_save_complete_tmap
	dw Tilemap_titlemenu_name_input_tmap
	dw Tilemap_titlemenu_buttons_start_tmap
	dw Tilemap_titlemenu_buttons_continue_tmap
	dw Tilemap_titlemenu_buttons_soundtest_tmap
	dw Tilemap_titlemenu_buttons_link_tmap
	dw Tilemap_titlemenu_screens_denjuu_nickname_tmap
	dw Tilemap_titlemenu_sound_test_tmap
	dw Tilemap_pausemenu_calls_screen_tmap
	dw Tilemap_pausemenu_sms_select_tmap
	dw Tilemap_contactmenu_option_tmap
	dw Tilemap_cutscene_shigeki_connected_tmap
	dw Tilemap_encounter_backgrounds_field_tmap
	dw Tilemap_encounter_backgrounds_forest_tmap
	dw Tilemap_unknown_tilemap_0_3f
	dw Tilemap_unknown_tilemap_0_40
	dw Tilemap_encounter_backgrounds_cave_tmap
	dw Tilemap_encounter_backgrounds_ocean_tmap
	dw Tilemap_encounter_backgrounds_desert_tmap
	dw Tilemap_unknown_tilemap_0_44
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_field_tmap
	dw Tilemap_phoneconversation_backgrounds_forest_tmap
	dw Tilemap_unknown_tilemap_0_47
	dw Tilemap_unknown_tilemap_0_48
	dw Tilemap_phoneconversation_backgrounds_cave_tmap
	dw Tilemap_phoneconversation_backgrounds_ocean_tmap
	dw Tilemap_phoneconversation_backgrounds_desert_tmap
	dw Tilemap_menu_sms_contents_tmap
	dw Tilemap_contactmenu_ringtone_assign_tmap
	dw Tilemap_contactmenu_delete_confirm_tmap
	dw Tilemap_titlemenu_save_overwrite_warning_tmap
	dw Tilemap_unknown_tilemap_0_50
	dw Tilemap_unknown_tilemap_0_51
	dw Tilemap_menu_multiplayer_tmap
	dw Tilemap_menu_multiplayer_tmap
	dw Tilemap_menu_multiplayer_tmap
	dw Tilemap_menu_multiplayer_tmap
	dw Tilemap_menu_multiplayer_gameboys_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_contactenlist_screen_tmap
	dw Tilemap_unknown_tilemap_0_55
	dw Tilemap_screen_game_over_tmap
	dw Tilemap_unknown_tilemap_0_57
	dw Tilemap_unknown_tilemap_0_58
	dw Tilemap_unknown_tilemap_0_58
	dw Tilemap_unknown_tilemap_0_58
	dw Tilemap_unknown_tilemap_0_58
	dw Tilemap_unknown_tilemap_0_58
	dw Tilemap_unknown_tilemap_0_59
	dw Tilemap_unknown_tilemap_0_5a
	dw Tilemap_unknown_tilemap_0_5a
	dw Tilemap_unknown_tilemap_0_5a
	dw Tilemap_unknown_tilemap_0_5a
	dw Tilemap_unknown_tilemap_0_5a
	dw Tilemap_unknown_tilemap_0_5a
	dw Tilemap_unknown_tilemap_0_5a
	dw Tilemap_battle_ui_opponent_bars_tmap
	dw Tilemap_unknown_tilemap_0_5c
	dw Tilemap_unknown_tilemap_0_5d
	dw Tilemap_encounter_ui_name_tmap
	dw Tilemap_unknown_tilemap_0_5f
	dw Tilemap_battle_ui_partner_bars_tmap
	dw Tilemap_unknown_tilemap_0_61
	dw Tilemap_battle_ui_attack_list_tmap
	dw Tilemap_unknown_tilemap_0_63
	dw Tilemap_unknown_tilemap_0_64
	dw Tilemap_unknown_tilemap_0_65
	dw Tilemap_unknown_tilemap_0_66
	dw Tilemap_unknown_tilemap_0_67
	dw Tilemap_unknown_tilemap_0_68
	dw Tilemap_battle_ui_clock_icon_tmap
	dw Tilemap_unknown_tilemap_0_6a
	dw Tilemap_unknown_tilemap_0_6b
	dw Tilemap_unknown_tilemap_0_6c
	dw Tilemap_battle_ui_hp_icon_tmap
	dw Tilemap_unknown_tilemap_0_6e
	dw Tilemap_unknown_tilemap_0_6f
	dw Tilemap_unknown_tilemap_0_70
	dw Tilemap_encounter_ui_level_icon_tmap
	dw Tilemap_unknown_tilemap_0_72
	dw Tilemap_unknown_tilemap_0_73
	dw Tilemap_unknown_tilemap_0_74
	dw Tilemap_unknown_tilemap_0_75
	dw Tilemap_unknown_tilemap_0_76
	dw Tilemap_victory_levelup_tmap
	dw Tilemap_victory_levelup_name_window_tmap
	dw Tilemap_unknown_tilemap_0_79
	dw Tilemap_unknown_tilemap_0_7a
	dw Tilemap_unknown_tilemap_0_7b
	dw Tilemap_unknown_tilemap_0_7c
	dw Tilemap_unknown_tilemap_0_7d
	dw Tilemap_unknown_tilemap_0_7e
	dw Tilemap_summon_ui_level_icon_tmap
	dw Tilemap_summon_ui_clock_icon_tmap
	dw Tilemap_summon_ui_denjuu_name_first_tmap
	dw Tilemap_summon_ui_denjuu_name_second_tmap
	dw Tilemap_summon_ui_denjuu_name_third_tmap
	dw Tilemap_unknown_tilemap_0_84
	dw Tilemap_unknown_tilemap_0_85
	dw Tilemap_contactmenu_questionmark_tmap
	dw Tilemap_contactenlist_bg_tmap
	dw Tilemap_unknown_tilemap_0_88
	dw Tilemap_unknown_tilemap_0_89
	dw Tilemap_unknown_tilemap_0_89
	dw Tilemap_unknown_tilemap_0_8a
	dw Tilemap_unknown_tilemap_0_8b
	dw Tilemap_unknown_tilemap_0_8c
	dw Tilemap_unknown_tilemap_0_8d
	dw Tilemap_unknown_tilemap_0_8e
	dw Tilemap_unknown_tilemap_0_8f
	dw Tilemap_summon_screen_tmap
	dw Tilemap_unknown_tilemap_0_91
	dw Tilemap_unknown_tilemap_0_92
	dw Tilemap_battle_status_effect_partner_tmap
	dw Tilemap_battle_status_effect_opponent_tmap
	dw Tilemap_linkbattle_vs_badge_tmap
	dw Tilemap_menu_multiplayer_trade_tmap
	dw Tilemap_menu_multiplayer_melody_transfer_tmap
	dw Tilemap_menu_link_error_tmap
	dw Tilemap_cutscene_antenna_tree_cutscene_tmap
	dw Tilemap_unknown_tilemap_0_9a
	dw Tilemap_unknown_tilemap_0_9b
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END
	dw Tilemap_unknown_tilemap_0_9b_END

Tilemap_menu_stats_tmap::
	INCBIN "build/gfx/menu/stats_tmap.tmap"
Tilemap_menu_stats_tmap_END

Tilemap_menu_stats_tab_progression_tmap::
	INCBIN "build/gfx/menu/stats_tab_progression_tmap.tmap"
Tilemap_menu_stats_tab_progression_tmap_END

Tilemap_menu_stats_tab_stats_tmap::
	INCBIN "build/gfx/menu/stats_tab_stats_tmap.tmap"
Tilemap_menu_stats_tab_stats_tmap_END

Tilemap_menu_stats_tab_moves_tmap::
	INCBIN "build/gfx/menu/stats_tab_moves_tmap.tmap"
Tilemap_menu_stats_tab_moves_tmap_END

Tilemap_screen_save_deleted_tmap::
	INCBIN "build/gfx/screen/save_deleted_tmap.tmap"
Tilemap_screen_save_deleted_tmap_END

Tilemap_unknown_tilemap_0_5::
	INCBIN "build/gfx/unknown/tilemap_0/5.tmap"
Tilemap_unknown_tilemap_0_5_END

Tilemap_titlelogo_smilesoft_tmap::
	INCBIN "build/components/titlelogo/smilesoft_tmap.tmap"
Tilemap_titlelogo_smilesoft_tmap_END

Tilemap_titlelogo_comic_bombom_tmap::
	INCBIN "build/components/titlelogo/comic_bombom_tmap.tmap"
Tilemap_titlelogo_comic_bombom_tmap_END

Tilemap_titlelogo_natsume_tmap::
	INCBIN "build/components/titlelogo/natsume_tmap.tmap"
Tilemap_titlelogo_natsume_tmap_END

Tilemap_titlelogo_author_credit_tmap::
	INCBIN "build/components/titlelogo/author_credit_tmap.tmap"
Tilemap_titlelogo_author_credit_tmap_END

Tilemap_encounter_backgrounds_base_tmap::
	INCBIN "build/components/encounter/backgrounds/base_tmap.tmap"
Tilemap_encounter_backgrounds_base_tmap_END

Tilemap_title_bg_tmap::
	INCBIN "build/versions/speed/gfx/title/bg_tmap.tmap"
Tilemap_title_bg_tmap_END

Tilemap_unknown_tilemap_0_c::
	INCBIN "build/gfx/unknown/tilemap_0/c.tmap"
Tilemap_unknown_tilemap_0_c_END

Tilemap_battle_ui_partner_message_layer_tmap::
	INCBIN "build/components/battle/ui/partner_message_layer_tmap.tmap"
Tilemap_battle_ui_partner_message_layer_tmap_END

Tilemap_menu_phone_left_tmap::
	INCBIN "build/gfx/menu/phone_left_tmap.tmap"
Tilemap_menu_phone_left_tmap_END

Tilemap_pausemenu_resources_dshot_bottom_tmap::
	INCBIN "build/components/pausemenu/resources/dshot_bottom_tmap.tmap"
Tilemap_pausemenu_resources_dshot_bottom_tmap_END

Tilemap_menu_empty_menu_tmap::
	INCBIN "build/gfx/menu/empty_menu_tmap.tmap"
Tilemap_menu_empty_menu_tmap_END

Tilemap_menu_empty_expanded_option_tmap::
	INCBIN "build/gfx/menu/empty_expanded_option_tmap.tmap"
Tilemap_menu_empty_expanded_option_tmap_END

Tilemap_titlemenu_time_input_screen::
	INCBIN "build/components/titlemenu/time_input_screen.tmap"
Tilemap_titlemenu_time_input_screen_END

Tilemap_phoneime_hiragana_indicator_tmap::
	INCBIN "build/components/phoneime/hiragana_indicator_tmap.tmap"
Tilemap_phoneime_hiragana_indicator_tmap_END

Tilemap_phoneime_katakana_indicator_tmap::
	INCBIN "build/components/phoneime/katakana_indicator_tmap.tmap"
Tilemap_phoneime_katakana_indicator_tmap_END

Tilemap_pausemenu_resources_options_screen_tmap::
	INCBIN "build/components/pausemenu/resources/options_screen_tmap.tmap"
Tilemap_pausemenu_resources_options_screen_tmap_END

Tilemap_unknown_tilemap_0_16::
	INCBIN "build/gfx/unknown/tilemap_0/16.tmap"
Tilemap_unknown_tilemap_0_16_END

Tilemap_unknown_tilemap_0_17::
	INCBIN "build/gfx/unknown/tilemap_0/17.tmap"
Tilemap_unknown_tilemap_0_17_END

Tilemap_phoneconversation_window_tmap::
	INCBIN "build/gfx/phoneconversation/window_tmap.tmap"
Tilemap_phoneconversation_window_tmap_END

Tilemap_phoneime_number_indicator_tmap::
	INCBIN "build/components/phoneime/number_indicator_tmap.tmap"
Tilemap_phoneime_number_indicator_tmap_END

Tilemap_phoneconversation_monster_name_tmap::
	INCBIN "build/gfx/phoneconversation/monster_name_tmap.tmap"
Tilemap_phoneconversation_monster_name_tmap_END

Tilemap_pausemenu_resources_scrolling_menu_1_tmap::
	INCBIN "build/components/pausemenu/resources/scrolling_menu_1_tmap.tmap"
Tilemap_pausemenu_resources_scrolling_menu_1_tmap_END

Tilemap_pausemenu_resources_scrolling_menu_2_tmap::
	INCBIN "build/components/pausemenu/resources/scrolling_menu_2_tmap.tmap"
Tilemap_pausemenu_resources_scrolling_menu_2_tmap_END

Tilemap_pausemenu_resources_controls_hint_tmap::
	INCBIN "build/components/pausemenu/resources/controls_hint_tmap.tmap"
Tilemap_pausemenu_resources_controls_hint_tmap_END

Tilemap_pausemenu_resources_controls_hint_2_tmap::
	INCBIN "build/components/pausemenu/resources/controls_hint_2_tmap.tmap"
Tilemap_pausemenu_resources_controls_hint_2_tmap_END

Tilemap_pausemenu_resources_phone_window_tmap::
	INCBIN "build/components/pausemenu/resources/phone_window_tmap.tmap"
Tilemap_pausemenu_resources_phone_window_tmap_END

Tilemap_unknown_tilemap_0_20::
	INCBIN "build/gfx/unknown/tilemap_0/20.tmap"
Tilemap_unknown_tilemap_0_20_END

Tilemap_pausemenu_buttons_zukan_tmap::
	INCBIN "build/components/pausemenu/buttons/zukan_tmap.tmap"
Tilemap_pausemenu_buttons_zukan_tmap_END

Tilemap_pausemenu_buttons_contacts_tmap::
	INCBIN "build/components/pausemenu/buttons/contacts_tmap.tmap"
Tilemap_pausemenu_buttons_contacts_tmap_END

Tilemap_pausemenu_buttons_calls_tmap::
	INCBIN "build/components/pausemenu/buttons/calls_tmap.tmap"
Tilemap_pausemenu_buttons_calls_tmap_END

Tilemap_pausemenu_buttons_melody_tmap::
	INCBIN "build/components/pausemenu/buttons/melody_tmap.tmap"
Tilemap_pausemenu_buttons_melody_tmap_END

Tilemap_pausemenu_buttons_items_tmap::
	INCBIN "build/components/pausemenu/buttons/items_tmap.tmap"
Tilemap_pausemenu_buttons_items_tmap_END

Tilemap_pausemenu_buttons_sms_tmap::
	INCBIN "build/components/pausemenu/buttons/sms_tmap.tmap"
Tilemap_pausemenu_buttons_sms_tmap_END

Tilemap_pausemenu_buttons_save_tmap::
	INCBIN "build/components/pausemenu/buttons/save_tmap.tmap"
Tilemap_pausemenu_buttons_save_tmap_END

Tilemap_pausemenu_buttons_options_tmap::
	INCBIN "build/components/pausemenu/buttons/options_tmap.tmap"
Tilemap_pausemenu_buttons_options_tmap_END

Tilemap_pausemenu_buttons_cancel_tmap::
	INCBIN "build/components/pausemenu/buttons/cancel_tmap.tmap"
Tilemap_pausemenu_buttons_cancel_tmap_END

Tilemap_unknown_tilemap_0_2a::
	INCBIN "build/gfx/unknown/tilemap_0/2a.tmap"
Tilemap_unknown_tilemap_0_2a_END

Tilemap_contactmenu_select_screen_tmap::
	INCBIN "build/components/contactmenu/select_screen_tmap.tmap"
Tilemap_contactmenu_select_screen_tmap_END

Tilemap_unknown_tilemap_0_2c::
	INCBIN "build/gfx/unknown/tilemap_0/2c.tmap"
Tilemap_unknown_tilemap_0_2c_END

Tilemap_melodyedit_ringtone_select_tmap::
	INCBIN "build/components/melodyedit/ringtone_select_tmap.tmap"
Tilemap_melodyedit_ringtone_select_tmap_END

Tilemap_pausemenu_resources_inventory_tmap::
	INCBIN "build/components/pausemenu/resources/inventory_tmap.tmap"
Tilemap_pausemenu_resources_inventory_tmap_END

Tilemap_pausemenu_save_screen_tmap::
	INCBIN "build/components/pausemenu/save/screen_tmap.tmap"
Tilemap_pausemenu_save_screen_tmap_END

Tilemap_pausemenu_save_progress_tmap::
	INCBIN "build/components/pausemenu/save/progress_tmap.tmap"
Tilemap_pausemenu_save_progress_tmap_END

Tilemap_pausemenu_save_complete_tmap::
	INCBIN "build/components/pausemenu/save/complete_tmap.tmap"
Tilemap_pausemenu_save_complete_tmap_END

Tilemap_titlemenu_name_input_tmap::
	INCBIN "build/components/titlemenu/name_input_tmap.tmap"
Tilemap_titlemenu_name_input_tmap_END

Tilemap_titlemenu_buttons_start_tmap::
	INCBIN "build/components/titlemenu/buttons/start_tmap.tmap"
Tilemap_titlemenu_buttons_start_tmap_END

Tilemap_titlemenu_buttons_continue_tmap::
	INCBIN "build/components/titlemenu/buttons/continue_tmap.tmap"
Tilemap_titlemenu_buttons_continue_tmap_END

Tilemap_titlemenu_buttons_soundtest_tmap::
	INCBIN "build/components/titlemenu/buttons/soundtest_tmap.tmap"
Tilemap_titlemenu_buttons_soundtest_tmap_END

Tilemap_titlemenu_buttons_link_tmap::
	INCBIN "build/components/titlemenu/buttons/link_tmap.tmap"
Tilemap_titlemenu_buttons_link_tmap_END

Tilemap_titlemenu_screens_denjuu_nickname_tmap::
	INCBIN "build/components/titlemenu/screens/denjuu_nickname_tmap.tmap"
Tilemap_titlemenu_screens_denjuu_nickname_tmap_END

Tilemap_titlemenu_sound_test_tmap::
	INCBIN "build/components/titlemenu/sound/test_tmap.tmap"
Tilemap_titlemenu_sound_test_tmap_END

Tilemap_pausemenu_calls_screen_tmap::
	INCBIN "build/components/pausemenu/calls/screen_tmap.tmap"
Tilemap_pausemenu_calls_screen_tmap_END

Tilemap_pausemenu_sms_select_tmap::
	INCBIN "build/components/pausemenu/sms/select_tmap.tmap"
Tilemap_pausemenu_sms_select_tmap_END

Tilemap_contactmenu_option_tmap::
	INCBIN "build/components/contactmenu/option_tmap.tmap"
Tilemap_contactmenu_option_tmap_END

Tilemap_cutscene_shigeki_connected_tmap::
	INCBIN "build/gfx/cutscene/shigeki_connected_tmap.tmap"
Tilemap_cutscene_shigeki_connected_tmap_END

Tilemap_encounter_backgrounds_field_tmap::
	INCBIN "build/components/encounter/backgrounds/field_tmap.tmap"
Tilemap_encounter_backgrounds_field_tmap_END

Tilemap_encounter_backgrounds_forest_tmap::
	INCBIN "build/components/encounter/backgrounds/forest_tmap.tmap"
Tilemap_encounter_backgrounds_forest_tmap_END

Tilemap_unknown_tilemap_0_3f::
	INCBIN "build/gfx/unknown/tilemap_0/3f.tmap"
Tilemap_unknown_tilemap_0_3f_END

Tilemap_unknown_tilemap_0_40::
	INCBIN "build/gfx/unknown/tilemap_0/40.tmap"
Tilemap_unknown_tilemap_0_40_END

Tilemap_encounter_backgrounds_cave_tmap::
	INCBIN "build/components/encounter/backgrounds/cave_tmap.tmap"
Tilemap_encounter_backgrounds_cave_tmap_END

Tilemap_encounter_backgrounds_ocean_tmap::
	INCBIN "build/components/encounter/backgrounds/ocean_tmap.tmap"
Tilemap_encounter_backgrounds_ocean_tmap_END

Tilemap_encounter_backgrounds_desert_tmap::
	INCBIN "build/components/encounter/backgrounds/desert_tmap.tmap"
Tilemap_encounter_backgrounds_desert_tmap_END

Tilemap_unknown_tilemap_0_44::
	INCBIN "build/gfx/unknown/tilemap_0/44.tmap"
Tilemap_unknown_tilemap_0_44_END

Tilemap_phoneconversation_backgrounds_field_tmap::
	INCBIN "build/components/phoneconversation/backgrounds/field_tmap.tmap"
Tilemap_phoneconversation_backgrounds_field_tmap_END

Tilemap_phoneconversation_backgrounds_forest_tmap::
	INCBIN "build/components/phoneconversation/backgrounds/forest_tmap.tmap"
Tilemap_phoneconversation_backgrounds_forest_tmap_END

Tilemap_unknown_tilemap_0_47::
	INCBIN "build/gfx/unknown/tilemap_0/47.tmap"
Tilemap_unknown_tilemap_0_47_END

Tilemap_unknown_tilemap_0_48::
	INCBIN "build/gfx/unknown/tilemap_0/48.tmap"
Tilemap_unknown_tilemap_0_48_END

Tilemap_phoneconversation_backgrounds_cave_tmap::
	INCBIN "build/components/phoneconversation/backgrounds/cave_tmap.tmap"
Tilemap_phoneconversation_backgrounds_cave_tmap_END

Tilemap_phoneconversation_backgrounds_ocean_tmap::
	INCBIN "build/components/phoneconversation/backgrounds/ocean_tmap.tmap"
Tilemap_phoneconversation_backgrounds_ocean_tmap_END

Tilemap_phoneconversation_backgrounds_desert_tmap::
	INCBIN "build/components/phoneconversation/backgrounds/desert_tmap.tmap"
Tilemap_phoneconversation_backgrounds_desert_tmap_END

Tilemap_menu_sms_contents_tmap::
	INCBIN "build/gfx/menu/sms/contents_tmap.tmap"
Tilemap_menu_sms_contents_tmap_END

Tilemap_contactmenu_ringtone_assign_tmap::
	INCBIN "build/components/contactmenu/ringtone_assign_tmap.tmap"
Tilemap_contactmenu_ringtone_assign_tmap_END

Tilemap_contactmenu_delete_confirm_tmap::
	INCBIN "build/components/contactmenu/delete_confirm_tmap.tmap"
Tilemap_contactmenu_delete_confirm_tmap_END

Tilemap_titlemenu_save_overwrite_warning_tmap::
	INCBIN "build/components/titlemenu/save_overwrite_warning_tmap.tmap"
Tilemap_titlemenu_save_overwrite_warning_tmap_END

Tilemap_unknown_tilemap_0_50::
	INCBIN "build/gfx/unknown/tilemap_0/50.tmap"
Tilemap_unknown_tilemap_0_50_END

Tilemap_unknown_tilemap_0_51::
	INCBIN "build/gfx/unknown/tilemap_0/51.tmap"
Tilemap_unknown_tilemap_0_51_END

Tilemap_menu_multiplayer_tmap::
	INCBIN "build/gfx/menu/multiplayer_tmap.tmap"
Tilemap_menu_multiplayer_tmap_END

Tilemap_menu_multiplayer_gameboys_tmap::
	INCBIN "build/gfx/menu/multiplayer/gameboys_tmap.tmap"
Tilemap_menu_multiplayer_gameboys_tmap_END

Tilemap_contactenlist_screen_tmap::
	INCBIN "build/components/contactenlist/screen_tmap.tmap"
Tilemap_contactenlist_screen_tmap_END

Tilemap_unknown_tilemap_0_55::
	INCBIN "build/gfx/unknown/tilemap_0/55.tmap"
Tilemap_unknown_tilemap_0_55_END

Tilemap_screen_game_over_tmap::
	INCBIN "build/versions/speed/gfx/screen/game_over_tmap.tmap"
Tilemap_screen_game_over_tmap_END

Tilemap_unknown_tilemap_0_57::
	INCBIN "build/gfx/unknown/tilemap_0/57.tmap"
Tilemap_unknown_tilemap_0_57_END

Tilemap_unknown_tilemap_0_58::
	INCBIN "build/gfx/unknown/tilemap_0/58.tmap"
Tilemap_unknown_tilemap_0_58_END

Tilemap_unknown_tilemap_0_59::
	INCBIN "build/gfx/unknown/tilemap_0/59.tmap"
Tilemap_unknown_tilemap_0_59_END

Tilemap_unknown_tilemap_0_5a::
	INCBIN "build/gfx/unknown/tilemap_0/5a.tmap"
Tilemap_unknown_tilemap_0_5a_END

Tilemap_battle_ui_opponent_bars_tmap::
	INCBIN "build/components/battle/ui/opponent_bars_tmap.tmap"
Tilemap_battle_ui_opponent_bars_tmap_END

Tilemap_unknown_tilemap_0_5c::
	INCBIN "build/gfx/unknown/tilemap_0/5c.tmap"
Tilemap_unknown_tilemap_0_5c_END

Tilemap_unknown_tilemap_0_5d::
	INCBIN "build/gfx/unknown/tilemap_0/5d.tmap"
Tilemap_unknown_tilemap_0_5d_END

Tilemap_encounter_ui_name_tmap::
	INCBIN "build/components/encounter/ui/name_tmap.tmap"
Tilemap_encounter_ui_name_tmap_END

Tilemap_unknown_tilemap_0_5f::
	INCBIN "build/gfx/unknown/tilemap_0/5f.tmap"
Tilemap_unknown_tilemap_0_5f_END

Tilemap_battle_ui_partner_bars_tmap::
	INCBIN "build/components/battle/ui/partner_bars_tmap.tmap"
Tilemap_battle_ui_partner_bars_tmap_END

Tilemap_unknown_tilemap_0_61::
	INCBIN "build/gfx/unknown/tilemap_0/61.tmap"
Tilemap_unknown_tilemap_0_61_END

Tilemap_battle_ui_attack_list_tmap::
	INCBIN "build/components/battle/ui/attack_list_tmap.tmap"
Tilemap_battle_ui_attack_list_tmap_END

Tilemap_unknown_tilemap_0_63::
	INCBIN "build/gfx/unknown/tilemap_0/63.tmap"
Tilemap_unknown_tilemap_0_63_END

Tilemap_unknown_tilemap_0_64::
	INCBIN "build/gfx/unknown/tilemap_0/64.tmap"
Tilemap_unknown_tilemap_0_64_END

Tilemap_unknown_tilemap_0_65::
	INCBIN "build/gfx/unknown/tilemap_0/65.tmap"
Tilemap_unknown_tilemap_0_65_END

Tilemap_unknown_tilemap_0_66::
	INCBIN "build/gfx/unknown/tilemap_0/66.tmap"
Tilemap_unknown_tilemap_0_66_END

Tilemap_unknown_tilemap_0_67::
	INCBIN "build/gfx/unknown/tilemap_0/67.tmap"
Tilemap_unknown_tilemap_0_67_END

Tilemap_unknown_tilemap_0_68::
	INCBIN "build/gfx/unknown/tilemap_0/68.tmap"
Tilemap_unknown_tilemap_0_68_END

Tilemap_battle_ui_clock_icon_tmap::
	INCBIN "build/components/battle/ui/clock_icon_tmap.tmap"
Tilemap_battle_ui_clock_icon_tmap_END

Tilemap_unknown_tilemap_0_6a::
	INCBIN "build/gfx/unknown/tilemap_0/6a.tmap"
Tilemap_unknown_tilemap_0_6a_END

Tilemap_unknown_tilemap_0_6b::
	INCBIN "build/gfx/unknown/tilemap_0/6b.tmap"
Tilemap_unknown_tilemap_0_6b_END

Tilemap_unknown_tilemap_0_6c::
	INCBIN "build/gfx/unknown/tilemap_0/6c.tmap"
Tilemap_unknown_tilemap_0_6c_END

Tilemap_battle_ui_hp_icon_tmap::
	INCBIN "build/components/battle/ui/hp_icon_tmap.tmap"
Tilemap_battle_ui_hp_icon_tmap_END

Tilemap_unknown_tilemap_0_6e::
	INCBIN "build/gfx/unknown/tilemap_0/6e.tmap"
Tilemap_unknown_tilemap_0_6e_END

Tilemap_unknown_tilemap_0_6f::
	INCBIN "build/gfx/unknown/tilemap_0/6f.tmap"
Tilemap_unknown_tilemap_0_6f_END

Tilemap_unknown_tilemap_0_70::
	INCBIN "build/gfx/unknown/tilemap_0/70.tmap"
Tilemap_unknown_tilemap_0_70_END

Tilemap_encounter_ui_level_icon_tmap::
	INCBIN "build/components/encounter/ui/level_icon_tmap.tmap"
Tilemap_encounter_ui_level_icon_tmap_END

Tilemap_unknown_tilemap_0_72::
	INCBIN "build/gfx/unknown/tilemap_0/72.tmap"
Tilemap_unknown_tilemap_0_72_END

Tilemap_unknown_tilemap_0_73::
	INCBIN "build/gfx/unknown/tilemap_0/73.tmap"
Tilemap_unknown_tilemap_0_73_END

Tilemap_unknown_tilemap_0_74::
	INCBIN "build/gfx/unknown/tilemap_0/74.tmap"
Tilemap_unknown_tilemap_0_74_END

Tilemap_unknown_tilemap_0_75::
	INCBIN "build/gfx/unknown/tilemap_0/75.tmap"
Tilemap_unknown_tilemap_0_75_END

Tilemap_unknown_tilemap_0_76::
	INCBIN "build/gfx/unknown/tilemap_0/76.tmap"
Tilemap_unknown_tilemap_0_76_END

Tilemap_victory_levelup_tmap::
	INCBIN "build/components/victory/levelup_tmap.tmap"
Tilemap_victory_levelup_tmap_END

Tilemap_victory_levelup_name_window_tmap::
	INCBIN "build/components/victory/levelup/name_window_tmap.tmap"
Tilemap_victory_levelup_name_window_tmap_END

Tilemap_unknown_tilemap_0_79::
	INCBIN "build/gfx/unknown/tilemap_0/79.tmap"
Tilemap_unknown_tilemap_0_79_END

Tilemap_unknown_tilemap_0_7a::
	INCBIN "build/gfx/unknown/tilemap_0/7a.tmap"
Tilemap_unknown_tilemap_0_7a_END

Tilemap_unknown_tilemap_0_7b::
	INCBIN "build/gfx/unknown/tilemap_0/7b.tmap"
Tilemap_unknown_tilemap_0_7b_END

Tilemap_unknown_tilemap_0_7c::
	INCBIN "build/gfx/unknown/tilemap_0/7c.tmap"
Tilemap_unknown_tilemap_0_7c_END

Tilemap_unknown_tilemap_0_7d::
	INCBIN "build/gfx/unknown/tilemap_0/7d.tmap"
Tilemap_unknown_tilemap_0_7d_END

Tilemap_unknown_tilemap_0_7e::
	INCBIN "build/gfx/unknown/tilemap_0/7e.tmap"
Tilemap_unknown_tilemap_0_7e_END

Tilemap_summon_ui_level_icon_tmap::
	INCBIN "build/components/summon/ui/level_icon_tmap.tmap"
Tilemap_summon_ui_level_icon_tmap_END

Tilemap_summon_ui_clock_icon_tmap::
	INCBIN "build/components/summon/ui/clock_icon_tmap.tmap"
Tilemap_summon_ui_clock_icon_tmap_END

Tilemap_summon_ui_denjuu_name_first_tmap::
	INCBIN "build/components/summon/ui/denjuu_name_first_tmap.tmap"
Tilemap_summon_ui_denjuu_name_first_tmap_END

Tilemap_summon_ui_denjuu_name_second_tmap::
	INCBIN "build/components/summon/ui/denjuu_name_second_tmap.tmap"
Tilemap_summon_ui_denjuu_name_second_tmap_END

Tilemap_summon_ui_denjuu_name_third_tmap::
	INCBIN "build/components/summon/ui/denjuu_name_third_tmap.tmap"
Tilemap_summon_ui_denjuu_name_third_tmap_END

Tilemap_unknown_tilemap_0_84::
	INCBIN "build/gfx/unknown/tilemap_0/84.tmap"
Tilemap_unknown_tilemap_0_84_END

Tilemap_unknown_tilemap_0_85::
	INCBIN "build/gfx/unknown/tilemap_0/85.tmap"
Tilemap_unknown_tilemap_0_85_END

Tilemap_contactmenu_questionmark_tmap::
	INCBIN "build/components/contactmenu/questionmark_tmap.tmap"
Tilemap_contactmenu_questionmark_tmap_END

Tilemap_contactenlist_bg_tmap::
	INCBIN "build/components/contactenlist/bg_tmap.tmap"
Tilemap_contactenlist_bg_tmap_END

Tilemap_unknown_tilemap_0_88::
	INCBIN "build/gfx/unknown/tilemap_0/88.tmap"
Tilemap_unknown_tilemap_0_88_END

Tilemap_unknown_tilemap_0_89::
	INCBIN "build/gfx/unknown/tilemap_0/89.tmap"
Tilemap_unknown_tilemap_0_89_END

Tilemap_unknown_tilemap_0_8a::
	INCBIN "build/gfx/unknown/tilemap_0/8a.tmap"
Tilemap_unknown_tilemap_0_8a_END

Tilemap_unknown_tilemap_0_8b::
	INCBIN "build/gfx/unknown/tilemap_0/8b.tmap"
Tilemap_unknown_tilemap_0_8b_END

Tilemap_unknown_tilemap_0_8c::
	INCBIN "build/gfx/unknown/tilemap_0/8c.tmap"
Tilemap_unknown_tilemap_0_8c_END

Tilemap_unknown_tilemap_0_8d::
	INCBIN "build/gfx/unknown/tilemap_0/8d.tmap"
Tilemap_unknown_tilemap_0_8d_END

Tilemap_unknown_tilemap_0_8e::
	INCBIN "build/gfx/unknown/tilemap_0/8e.tmap"
Tilemap_unknown_tilemap_0_8e_END

Tilemap_unknown_tilemap_0_8f::
	INCBIN "build/gfx/unknown/tilemap_0/8f.tmap"
Tilemap_unknown_tilemap_0_8f_END

Tilemap_summon_screen_tmap::
	INCBIN "build/components/summon/screen_tmap.tmap"
Tilemap_summon_screen_tmap_END

Tilemap_unknown_tilemap_0_91::
	INCBIN "build/gfx/unknown/tilemap_0/91.tmap"
Tilemap_unknown_tilemap_0_91_END

Tilemap_unknown_tilemap_0_92::
	INCBIN "build/gfx/unknown/tilemap_0/92.tmap"
Tilemap_unknown_tilemap_0_92_END

Tilemap_battle_status_effect_partner_tmap::
	INCBIN "build/components/battle/status_effect_partner.tmap"
Tilemap_battle_status_effect_partner_tmap_END

Tilemap_battle_status_effect_opponent_tmap::
	INCBIN "build/components/battle/status_effect_opponent.tmap"
Tilemap_battle_status_effect_opponent_tmap_END

Tilemap_linkbattle_vs_badge_tmap::
	INCBIN "build/components/linkbattle/vs_badge_tmap.tmap"
Tilemap_linkbattle_vs_badge_tmap_END

Tilemap_menu_multiplayer_trade_tmap::
	INCBIN "build/gfx/menu/multiplayer/trade_tmap.tmap"
Tilemap_menu_multiplayer_trade_tmap_END

Tilemap_menu_multiplayer_melody_transfer_tmap::
	INCBIN "build/gfx/menu/multiplayer/melody_transfer_tmap.tmap"
Tilemap_menu_multiplayer_melody_transfer_tmap_END

Tilemap_menu_link_error_tmap::
	INCBIN "build/gfx/menu/link_error_tmap.tmap"
Tilemap_menu_link_error_tmap_END

Tilemap_cutscene_antenna_tree_cutscene_tmap::
	INCBIN "build/gfx/cutscene/antenna_tree_cutscene_tmap.tmap"
Tilemap_cutscene_antenna_tree_cutscene_tmap_END

Tilemap_unknown_tilemap_0_9a::
	INCBIN "build/gfx/unknown/tilemap_0/9a.tmap"
Tilemap_unknown_tilemap_0_9a_END

Tilemap_unknown_tilemap_0_9b::
	INCBIN "build/gfx/unknown/tilemap_0/9b.tmap"
Tilemap_unknown_tilemap_0_9b_END

SECTION "tilemap Bank 1", ROMX[$4000], BANK[$3f]
Tilemap_BANK_1::
	dw Tilemap_zukan_page_tmap
	dw Tilemap_zukan_page_tmap
	dw Tilemap_attractmode_scene1_cave_bg_tmap
	dw Tilemap_attractmode_scene1_cave_bg_tmap
	dw Tilemap_attractmode_scene1_cave_bg_tmap
	dw Tilemap_attractmode_scene1_cave_bg_tmap
	dw Tilemap_attractmode_scene1_cave_bg_tmap
	dw Tilemap_attractmode_scene1_cave_bg_tmap
	dw Tilemap_attractmode_scene1_cave_bg_tmap
	dw Tilemap_attractmode_scene1_gymnos_tmap
	dw Tilemap_attractmode_scene2_shigeki_phone_tmap
	dw Tilemap_attractmode_scene3_tree_bg_tmap
	dw Tilemap_attractmode_scene4_fungus_shigeki_tmap
	dw Tilemap_attractmode_scene5_gymnos_tmap
	dw Tilemap_attractmode_scene6_fungus_tmap
	dw Tilemap_attractmode_scene6_fungus_tmap_END

Tilemap_zukan_page_tmap::
	INCBIN "build/components/zukan/page_tmap.tmap"
Tilemap_zukan_page_tmap_END

Tilemap_attractmode_scene1_cave_bg_tmap::
	INCBIN "build/components/attractmode/scene1/cave_bg_tmap.tmap"
Tilemap_attractmode_scene1_cave_bg_tmap_END

Tilemap_attractmode_scene1_gymnos_tmap::
	INCBIN "build/versions/speed/components/attractmode/scene1/gymnos_tmap.tmap"
Tilemap_attractmode_scene1_gymnos_tmap_END

Tilemap_attractmode_scene2_shigeki_phone_tmap::
	INCBIN "build/components/attractmode/scene2/shigeki_phone_tmap.tmap"
Tilemap_attractmode_scene2_shigeki_phone_tmap_END

Tilemap_attractmode_scene3_tree_bg_tmap::
	INCBIN "build/components/attractmode/scene3/tree_bg_tmap.tmap"
Tilemap_attractmode_scene3_tree_bg_tmap_END

Tilemap_attractmode_scene4_fungus_shigeki_tmap::
	INCBIN "build/versions/speed/components/attractmode/scene4/fungus_shigeki_tmap.tmap"
Tilemap_attractmode_scene4_fungus_shigeki_tmap_END

Tilemap_attractmode_scene5_gymnos_tmap::
	INCBIN "build/versions/speed/components/attractmode/scene5/gymnos_tmap.tmap"
Tilemap_attractmode_scene5_gymnos_tmap_END

Tilemap_attractmode_scene6_fungus_tmap::
	INCBIN "build/versions/speed/components/attractmode/scene6/fungus_tmap.tmap"
Tilemap_attractmode_scene6_fungus_tmap_END


SECTION "attrib Bank 0", ROMX[$4000], BANK[$8]
Attribmap_BANK_0::
	dw Attribmap_menu_stats_attr
	dw Attribmap_menu_stats_attr
	dw Attribmap_menu_stats_tab_progression_attr
	dw Attribmap_menu_stats_tab_stats_attr
	dw Attribmap_menu_stats_tab_moves_attr
	dw Attribmap_screen_save_deleted_attr
	dw Attribmap_unknown_attribs_0_5
	dw Attribmap_unknown_attribs_0_7
	dw Attribmap_title_bg_attr
	dw Attribmap_title_bg_attr
	dw Attribmap_unknown_attribs_0_6
	dw Attribmap_unknown_attribs_0_9
	dw Attribmap_unknown_attribs_0_6
	dw Attribmap_unknown_attribs_0_a
	dw Attribmap_unknown_attribs_0_b
	dw Attribmap_unknown_attribs_0_b
	dw Attribmap_menu_phone_left_attr
	dw Attribmap_unknown_attribs_0_d
	dw Attribmap_menu_empty_menu_attr
	dw Attribmap_menu_empty_expanded_option_attr
	dw Attribmap_unknown_attribs_0_10
	dw Attribmap_unknown_attribs_0_11
	dw Attribmap_unknown_attribs_0_11
	dw Attribmap_unknown_attribs_0_11
	dw Attribmap_phoneconversation_window_attr
	dw Attribmap_phoneconversation_window_attr
	dw Attribmap_phoneconversation_window_attr
	dw Attribmap_phoneconversation_monster_name_attr
	dw Attribmap_phoneconversation_monster_name_attr
	dw Attribmap_phoneconversation_monster_name_attr
	dw Attribmap_phoneconversation_monster_name_attr
	dw Attribmap_phoneconversation_monster_name_attr
	dw Attribmap_phoneconversation_monster_name_attr
	dw Attribmap_unknown_attribs_0_14
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_15
	dw Attribmap_unknown_attribs_0_16
	dw Attribmap_unknown_attribs_0_17
	dw Attribmap_unknown_attribs_0_18
	dw Attribmap_unknown_attribs_0_19
	dw Attribmap_unknown_attribs_0_1a
	dw Attribmap_unknown_attribs_0_1a
	dw Attribmap_unknown_attribs_0_1a
	dw Attribmap_unknown_attribs_0_1a
	dw Attribmap_menu_titlebtn_attr
	dw Attribmap_menu_titlebtn_attr
	dw Attribmap_menu_titlebtn_attr
	dw Attribmap_menu_titlebtn_attr
	dw Attribmap_menu_titlebtn_attr
	dw Attribmap_unknown_attribs_0_1c
	dw Attribmap_unknown_attribs_0_1d
	dw Attribmap_unknown_attribs_0_1d
	dw Attribmap_unknown_attribs_0_1e
	dw Attribmap_unknown_attribs_0_1f
	dw Attribmap_unknown_attribs_0_20
	dw Attribmap_unknown_attribs_0_21
	dw Attribmap_unknown_attribs_0_22
	dw Attribmap_unknown_attribs_0_23
	dw Attribmap_unknown_attribs_0_24
	dw Attribmap_unknown_attribs_0_25
	dw Attribmap_unknown_attribs_0_26
	dw Attribmap_unknown_attribs_0_27
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_28
	dw Attribmap_unknown_attribs_0_29
	dw Attribmap_menu_sms_contents_attr
	dw Attribmap_unknown_attribs_0_2b
	dw Attribmap_unknown_attribs_0_2c
	dw Attribmap_unknown_attribs_0_2d
	dw Attribmap_unknown_attribs_0_2e
	dw Attribmap_unknown_attribs_0_2f
	dw Attribmap_unknown_attribs_0_30
	dw Attribmap_unknown_attribs_0_30
	dw Attribmap_unknown_attribs_0_30
	dw Attribmap_unknown_attribs_0_30
	dw Attribmap_menu_multiplayer_gameboys_attr
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_32
	dw Attribmap_unknown_attribs_0_33
	dw Attribmap_unknown_attribs_0_34
	dw Attribmap_unknown_attribs_0_35
	dw Attribmap_unknown_attribs_0_36
	dw Attribmap_unknown_attribs_0_37
	dw Attribmap_unknown_attribs_0_38
	dw Attribmap_unknown_attribs_0_39
	dw Attribmap_unknown_attribs_0_3a
	dw Attribmap_unknown_attribs_0_3b
	dw Attribmap_unknown_attribs_0_3c
	dw Attribmap_unknown_attribs_0_3c
	dw Attribmap_unknown_attribs_0_3c
	dw Attribmap_unknown_attribs_0_3c
	dw Attribmap_unknown_attribs_0_3c
	dw Attribmap_unknown_attribs_0_3c
	dw Attribmap_unknown_attribs_0_3c
	dw Attribmap_unknown_attribs_0_3d
	dw Attribmap_unknown_attribs_0_3e
	dw Attribmap_unknown_attribs_0_3f
	dw Attribmap_unknown_attribs_0_40
	dw Attribmap_unknown_attribs_0_41
	dw Attribmap_unknown_attribs_0_42
	dw Attribmap_unknown_attribs_0_43
	dw Attribmap_unknown_attribs_0_44
	dw Attribmap_unknown_attribs_0_45
	dw Attribmap_unknown_attribs_0_46
	dw Attribmap_unknown_attribs_0_47
	dw Attribmap_unknown_attribs_0_48
	dw Attribmap_unknown_attribs_0_49
	dw Attribmap_unknown_attribs_0_4a
	dw Attribmap_unknown_attribs_0_4b
	dw Attribmap_unknown_attribs_0_4c
	dw Attribmap_unknown_attribs_0_4d
	dw Attribmap_unknown_attribs_0_4e
	dw Attribmap_unknown_attribs_0_4f
	dw Attribmap_unknown_attribs_0_50
	dw Attribmap_unknown_attribs_0_51
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_52
	dw Attribmap_unknown_attribs_0_53
	dw Attribmap_unknown_attribs_0_54
	dw Attribmap_unknown_attribs_0_55
	dw Attribmap_unknown_attribs_0_56
	dw Attribmap_unknown_attribs_0_57
	dw Attribmap_unknown_attribs_0_58
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_unknown_attribs_0_59
	dw Attribmap_menu_multiplayer_trade_attr
	dw Attribmap_menu_multiplayer_melody_transfer_attr
	dw Attribmap_unknown_attribs_0_5c
	dw Attribmap_unknown_attribs_0_5d
	dw Attribmap_unknown_attribs_0_5e
	dw Attribmap_unknown_attribs_0_5f
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60
	dw Attribmap_unknown_attribs_0_60

Attribmap_menu_stats_attr::
	INCBIN "build/gfx/menu/stats_attr.tmap"
Attribmap_menu_stats_attr_END

Attribmap_menu_stats_tab_progression_attr::
	INCBIN "build/gfx/menu/stats_tab_progression_attr.tmap"
Attribmap_menu_stats_tab_progression_attr_END

Attribmap_menu_stats_tab_stats_attr::
	INCBIN "build/gfx/menu/stats_tab_stats_attr.tmap"
Attribmap_menu_stats_tab_stats_attr_END

Attribmap_menu_stats_tab_moves_attr::
	INCBIN "build/gfx/menu/stats_tab_moves_attr.tmap"
Attribmap_menu_stats_tab_moves_attr_END

Attribmap_screen_save_deleted_attr::
	INCBIN "build/gfx/screen/save_deleted_attr.tmap"
Attribmap_screen_save_deleted_attr_END

Attribmap_unknown_attribs_0_5::
	INCBIN "build/gfx/unknown/attribs_0/5.tmap"
Attribmap_unknown_attribs_0_5_END

Attribmap_unknown_attribs_0_6::
	INCBIN "build/gfx/unknown/attribs_0/6.tmap"
Attribmap_unknown_attribs_0_6_END

Attribmap_unknown_attribs_0_7::
	INCBIN "build/gfx/unknown/attribs_0/7.tmap"
Attribmap_unknown_attribs_0_7_END

Attribmap_title_bg_attr::
	INCBIN "build/versions/speed/gfx/title/bg_attr.tmap"
Attribmap_title_bg_attr_END

Attribmap_unknown_attribs_0_9::
	INCBIN "build/gfx/unknown/attribs_0/9.tmap"
Attribmap_unknown_attribs_0_9_END

Attribmap_unknown_attribs_0_a::
	INCBIN "build/gfx/unknown/attribs_0/a.tmap"
Attribmap_unknown_attribs_0_a_END

Attribmap_unknown_attribs_0_b::
	INCBIN "build/gfx/unknown/attribs_0/b.tmap"
Attribmap_unknown_attribs_0_b_END

Attribmap_menu_phone_left_attr::
	INCBIN "build/gfx/menu/phone_left_attr.tmap"
Attribmap_menu_phone_left_attr_END

Attribmap_unknown_attribs_0_d::
	INCBIN "build/gfx/unknown/attribs_0/d.tmap"
Attribmap_unknown_attribs_0_d_END

Attribmap_menu_empty_menu_attr::
	INCBIN "build/gfx/menu/empty_menu_attr.tmap"
Attribmap_menu_empty_menu_attr_END

Attribmap_menu_empty_expanded_option_attr::
	INCBIN "build/gfx/menu/empty_expanded_option_attr.tmap"
Attribmap_menu_empty_expanded_option_attr_END

Attribmap_unknown_attribs_0_10::
	INCBIN "build/gfx/unknown/attribs_0/10.tmap"
Attribmap_unknown_attribs_0_10_END

Attribmap_unknown_attribs_0_11::
	INCBIN "build/gfx/unknown/attribs_0/11.tmap"
Attribmap_unknown_attribs_0_11_END

Attribmap_phoneconversation_window_attr::
	INCBIN "build/gfx/phoneconversation/window_attr.tmap"
Attribmap_phoneconversation_window_attr_END

Attribmap_phoneconversation_monster_name_attr::
	INCBIN "build/gfx/phoneconversation/monster_name_attr.tmap"
Attribmap_phoneconversation_monster_name_attr_END

Attribmap_unknown_attribs_0_14::
	INCBIN "build/gfx/unknown/attribs_0/14.tmap"
Attribmap_unknown_attribs_0_14_END

Attribmap_unknown_attribs_0_15::
	INCBIN "build/gfx/unknown/attribs_0/15.tmap"
Attribmap_unknown_attribs_0_15_END

Attribmap_unknown_attribs_0_16::
	INCBIN "build/gfx/unknown/attribs_0/16.tmap"
Attribmap_unknown_attribs_0_16_END

Attribmap_unknown_attribs_0_17::
	INCBIN "build/gfx/unknown/attribs_0/17.tmap"
Attribmap_unknown_attribs_0_17_END

Attribmap_unknown_attribs_0_18::
	INCBIN "build/gfx/unknown/attribs_0/18.tmap"
Attribmap_unknown_attribs_0_18_END

Attribmap_unknown_attribs_0_19::
	INCBIN "build/gfx/unknown/attribs_0/19.tmap"
Attribmap_unknown_attribs_0_19_END

Attribmap_unknown_attribs_0_1a::
	INCBIN "build/gfx/unknown/attribs_0/1a.tmap"
Attribmap_unknown_attribs_0_1a_END

Attribmap_menu_titlebtn_attr::
	INCBIN "build/gfx/menu/titlebtn_attr.tmap"
Attribmap_menu_titlebtn_attr_END

Attribmap_unknown_attribs_0_1c::
	INCBIN "build/gfx/unknown/attribs_0/1c.tmap"
Attribmap_unknown_attribs_0_1c_END

Attribmap_unknown_attribs_0_1d::
	INCBIN "build/gfx/unknown/attribs_0/1d.tmap"
Attribmap_unknown_attribs_0_1d_END

Attribmap_unknown_attribs_0_1e::
	INCBIN "build/gfx/unknown/attribs_0/1e.tmap"
Attribmap_unknown_attribs_0_1e_END

Attribmap_unknown_attribs_0_1f::
	INCBIN "build/gfx/unknown/attribs_0/1f.tmap"
Attribmap_unknown_attribs_0_1f_END

Attribmap_unknown_attribs_0_20::
	INCBIN "build/gfx/unknown/attribs_0/20.tmap"
Attribmap_unknown_attribs_0_20_END

Attribmap_unknown_attribs_0_21::
	INCBIN "build/gfx/unknown/attribs_0/21.tmap"
Attribmap_unknown_attribs_0_21_END

Attribmap_unknown_attribs_0_22::
	INCBIN "build/gfx/unknown/attribs_0/22.tmap"
Attribmap_unknown_attribs_0_22_END

Attribmap_unknown_attribs_0_23::
	INCBIN "build/gfx/unknown/attribs_0/23.tmap"
Attribmap_unknown_attribs_0_23_END

Attribmap_unknown_attribs_0_24::
	INCBIN "build/gfx/unknown/attribs_0/24.tmap"
Attribmap_unknown_attribs_0_24_END

Attribmap_unknown_attribs_0_25::
	INCBIN "build/gfx/unknown/attribs_0/25.tmap"
Attribmap_unknown_attribs_0_25_END

Attribmap_unknown_attribs_0_26::
	INCBIN "build/gfx/unknown/attribs_0/26.tmap"
Attribmap_unknown_attribs_0_26_END

Attribmap_unknown_attribs_0_27::
	INCBIN "build/gfx/unknown/attribs_0/27.tmap"
Attribmap_unknown_attribs_0_27_END

Attribmap_unknown_attribs_0_28::
	INCBIN "build/gfx/unknown/attribs_0/28.tmap"
Attribmap_unknown_attribs_0_28_END

Attribmap_unknown_attribs_0_29::
	INCBIN "build/gfx/unknown/attribs_0/29.tmap"
Attribmap_unknown_attribs_0_29_END

Attribmap_menu_sms_contents_attr::
	INCBIN "build/gfx/menu/sms/contents_attr.tmap"
Attribmap_menu_sms_contents_attr_END

Attribmap_unknown_attribs_0_2b::
	INCBIN "build/gfx/unknown/attribs_0/2b.tmap"
Attribmap_unknown_attribs_0_2b_END

Attribmap_unknown_attribs_0_2c::
	INCBIN "build/gfx/unknown/attribs_0/2c.tmap"
Attribmap_unknown_attribs_0_2c_END

Attribmap_unknown_attribs_0_2d::
	INCBIN "build/gfx/unknown/attribs_0/2d.tmap"
Attribmap_unknown_attribs_0_2d_END

Attribmap_unknown_attribs_0_2e::
	INCBIN "build/gfx/unknown/attribs_0/2e.tmap"
Attribmap_unknown_attribs_0_2e_END

Attribmap_unknown_attribs_0_2f::
	INCBIN "build/gfx/unknown/attribs_0/2f.tmap"
Attribmap_unknown_attribs_0_2f_END

Attribmap_unknown_attribs_0_30::
	INCBIN "build/gfx/unknown/attribs_0/30.tmap"
Attribmap_unknown_attribs_0_30_END

Attribmap_menu_multiplayer_gameboys_attr::
	INCBIN "build/gfx/menu/multiplayer/gameboys_attr.tmap"
Attribmap_menu_multiplayer_gameboys_attr_END

Attribmap_unknown_attribs_0_32::
	INCBIN "build/gfx/unknown/attribs_0/32.tmap"
Attribmap_unknown_attribs_0_32_END

Attribmap_unknown_attribs_0_33::
	INCBIN "build/gfx/unknown/attribs_0/33.tmap"
Attribmap_unknown_attribs_0_33_END

Attribmap_unknown_attribs_0_34::
	INCBIN "build/versions/speed/gfx/unknown/attribs_0/34.tmap"
Attribmap_unknown_attribs_0_34_END

Attribmap_unknown_attribs_0_35::
	INCBIN "build/gfx/unknown/attribs_0/35.tmap"
Attribmap_unknown_attribs_0_35_END

Attribmap_unknown_attribs_0_36::
	INCBIN "build/gfx/unknown/attribs_0/36.tmap"
Attribmap_unknown_attribs_0_36_END

Attribmap_unknown_attribs_0_37::
	INCBIN "build/gfx/unknown/attribs_0/37.tmap"
Attribmap_unknown_attribs_0_37_END

Attribmap_unknown_attribs_0_38::
	INCBIN "build/gfx/unknown/attribs_0/38.tmap"
Attribmap_unknown_attribs_0_38_END

Attribmap_unknown_attribs_0_39::
	INCBIN "build/gfx/unknown/attribs_0/39.tmap"
Attribmap_unknown_attribs_0_39_END

Attribmap_unknown_attribs_0_3a::
	INCBIN "build/gfx/unknown/attribs_0/3a.tmap"
Attribmap_unknown_attribs_0_3a_END

Attribmap_unknown_attribs_0_3b::
	INCBIN "build/gfx/unknown/attribs_0/3b.tmap"
Attribmap_unknown_attribs_0_3b_END

Attribmap_unknown_attribs_0_3c::
	INCBIN "build/gfx/unknown/attribs_0/3c.tmap"
Attribmap_unknown_attribs_0_3c_END

Attribmap_unknown_attribs_0_3d::
	INCBIN "build/gfx/unknown/attribs_0/3d.tmap"
Attribmap_unknown_attribs_0_3d_END

Attribmap_unknown_attribs_0_3e::
	INCBIN "build/gfx/unknown/attribs_0/3e.tmap"
Attribmap_unknown_attribs_0_3e_END

Attribmap_unknown_attribs_0_3f::
	INCBIN "build/gfx/unknown/attribs_0/3f.tmap"
Attribmap_unknown_attribs_0_3f_END

Attribmap_unknown_attribs_0_40::
	INCBIN "build/gfx/unknown/attribs_0/40.tmap"
Attribmap_unknown_attribs_0_40_END

Attribmap_unknown_attribs_0_41::
	INCBIN "build/gfx/unknown/attribs_0/41.tmap"
Attribmap_unknown_attribs_0_41_END

Attribmap_unknown_attribs_0_42::
	INCBIN "build/gfx/unknown/attribs_0/42.tmap"
Attribmap_unknown_attribs_0_42_END

Attribmap_unknown_attribs_0_43::
	INCBIN "build/gfx/unknown/attribs_0/43.tmap"
Attribmap_unknown_attribs_0_43_END

Attribmap_unknown_attribs_0_44::
	INCBIN "build/gfx/unknown/attribs_0/44.tmap"
Attribmap_unknown_attribs_0_44_END

Attribmap_unknown_attribs_0_45::
	INCBIN "build/gfx/unknown/attribs_0/45.tmap"
Attribmap_unknown_attribs_0_45_END

Attribmap_unknown_attribs_0_46::
	INCBIN "build/gfx/unknown/attribs_0/46.tmap"
Attribmap_unknown_attribs_0_46_END

Attribmap_unknown_attribs_0_47::
	INCBIN "build/gfx/unknown/attribs_0/47.tmap"
Attribmap_unknown_attribs_0_47_END

Attribmap_unknown_attribs_0_48::
	INCBIN "build/gfx/unknown/attribs_0/48.tmap"
Attribmap_unknown_attribs_0_48_END

Attribmap_unknown_attribs_0_49::
	INCBIN "build/gfx/unknown/attribs_0/49.tmap"
Attribmap_unknown_attribs_0_49_END

Attribmap_unknown_attribs_0_4a::
	INCBIN "build/gfx/unknown/attribs_0/4a.tmap"
Attribmap_unknown_attribs_0_4a_END

Attribmap_unknown_attribs_0_4b::
	INCBIN "build/gfx/unknown/attribs_0/4b.tmap"
Attribmap_unknown_attribs_0_4b_END

Attribmap_unknown_attribs_0_4c::
	INCBIN "build/gfx/unknown/attribs_0/4c.tmap"
Attribmap_unknown_attribs_0_4c_END

Attribmap_unknown_attribs_0_4d::
	INCBIN "build/gfx/unknown/attribs_0/4d.tmap"
Attribmap_unknown_attribs_0_4d_END

Attribmap_unknown_attribs_0_4e::
	INCBIN "build/gfx/unknown/attribs_0/4e.tmap"
Attribmap_unknown_attribs_0_4e_END

Attribmap_unknown_attribs_0_4f::
	INCBIN "build/gfx/unknown/attribs_0/4f.tmap"
Attribmap_unknown_attribs_0_4f_END

Attribmap_unknown_attribs_0_50::
	INCBIN "build/gfx/unknown/attribs_0/50.tmap"
Attribmap_unknown_attribs_0_50_END

Attribmap_unknown_attribs_0_51::
	INCBIN "build/gfx/unknown/attribs_0/51.tmap"
Attribmap_unknown_attribs_0_51_END

Attribmap_unknown_attribs_0_52::
	INCBIN "build/gfx/unknown/attribs_0/52.tmap"
Attribmap_unknown_attribs_0_52_END

Attribmap_unknown_attribs_0_53::
	INCBIN "build/gfx/unknown/attribs_0/53.tmap"
Attribmap_unknown_attribs_0_53_END

Attribmap_unknown_attribs_0_54::
	INCBIN "build/gfx/unknown/attribs_0/54.tmap"
Attribmap_unknown_attribs_0_54_END

Attribmap_unknown_attribs_0_55::
	INCBIN "build/gfx/unknown/attribs_0/55.tmap"
Attribmap_unknown_attribs_0_55_END

Attribmap_unknown_attribs_0_56::
	INCBIN "build/gfx/unknown/attribs_0/56.tmap"
Attribmap_unknown_attribs_0_56_END

Attribmap_unknown_attribs_0_57::
	INCBIN "build/gfx/unknown/attribs_0/57.tmap"
Attribmap_unknown_attribs_0_57_END

Attribmap_unknown_attribs_0_58::
	INCBIN "build/gfx/unknown/attribs_0/58.tmap"
Attribmap_unknown_attribs_0_58_END

Attribmap_unknown_attribs_0_59::
	INCBIN "build/gfx/unknown/attribs_0/59.tmap"
Attribmap_unknown_attribs_0_59_END

Attribmap_menu_multiplayer_trade_attr::
	INCBIN "build/gfx/menu/multiplayer/trade_attr.tmap"
Attribmap_menu_multiplayer_trade_attr_END

Attribmap_menu_multiplayer_melody_transfer_attr::
	INCBIN "build/gfx/menu/multiplayer/melody_transfer_attr.tmap"
Attribmap_menu_multiplayer_melody_transfer_attr_END

Attribmap_unknown_attribs_0_5c::
	INCBIN "build/gfx/unknown/attribs_0/5c.tmap"
Attribmap_unknown_attribs_0_5c_END

Attribmap_unknown_attribs_0_5d::
	INCBIN "build/gfx/unknown/attribs_0/5d.tmap"
Attribmap_unknown_attribs_0_5d_END

Attribmap_unknown_attribs_0_5e::
	INCBIN "build/gfx/unknown/attribs_0/5e.tmap"
Attribmap_unknown_attribs_0_5e_END

Attribmap_unknown_attribs_0_5f::
	INCBIN "build/gfx/unknown/attribs_0/5f.tmap"
Attribmap_unknown_attribs_0_5f_END

Attribmap_unknown_attribs_0_60::
	INCBIN "build/gfx/unknown/attribs_0/60.tmap"
Attribmap_unknown_attribs_0_60_END

SECTION "attrib Bank 1", ROMX[$4000], BANK[$9]
Attribmap_BANK_1::
	dw Attribmap_unknown_attribs_1_0
	dw Attribmap_unknown_attribs_1_0
	dw Attribmap_unknown_attribs_1_1
	dw Attribmap_unknown_attribs_1_1
	dw Attribmap_unknown_attribs_1_1
	dw Attribmap_unknown_attribs_1_1
	dw Attribmap_unknown_attribs_1_1
	dw Attribmap_unknown_attribs_1_1
	dw Attribmap_unknown_attribs_1_1
	dw Attribmap_unknown_attribs_1_2
	dw Attribmap_unknown_attribs_1_3
	dw Attribmap_unknown_attribs_1_4
	dw Attribmap_unknown_attribs_1_5
	dw Attribmap_unknown_attribs_1_6
	dw Attribmap_unknown_attribs_1_7
	dw Attribmap_unknown_attribs_1_7_END

Attribmap_unknown_attribs_1_0::
	INCBIN "build/gfx/unknown/attribs_1/0.tmap"
Attribmap_unknown_attribs_1_0_END

Attribmap_unknown_attribs_1_1::
	INCBIN "build/gfx/unknown/attribs_1/1.tmap"
Attribmap_unknown_attribs_1_1_END

Attribmap_unknown_attribs_1_2::
	INCBIN "build/versions/speed/gfx/unknown/attribs_1/2.tmap"
Attribmap_unknown_attribs_1_2_END

Attribmap_unknown_attribs_1_3::
	INCBIN "build/gfx/unknown/attribs_1/3.tmap"
Attribmap_unknown_attribs_1_3_END

Attribmap_unknown_attribs_1_4::
	INCBIN "build/gfx/unknown/attribs_1/4.tmap"
Attribmap_unknown_attribs_1_4_END

Attribmap_unknown_attribs_1_5::
	INCBIN "build/versions/speed/gfx/unknown/attribs_1/5.tmap"
Attribmap_unknown_attribs_1_5_END

Attribmap_unknown_attribs_1_6::
	INCBIN "build/versions/speed/gfx/unknown/attribs_1/6.tmap"
Attribmap_unknown_attribs_1_6_END

Attribmap_unknown_attribs_1_7::
	INCBIN "build/versions/speed/gfx/unknown/attribs_1/7.tmap"
Attribmap_unknown_attribs_1_7_END


