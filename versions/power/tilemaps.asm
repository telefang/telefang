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
	dw Tilemap_unknown_tilemap_0_6
	dw Tilemap_unknown_tilemap_0_7
	dw Tilemap_unknown_tilemap_0_8
	dw Tilemap_unknown_tilemap_0_9
	dw Tilemap_encounter_backgrounds_base_tmap
	dw Tilemap_title_bg_tmap
	dw Tilemap_unknown_tilemap_0_c
	dw Tilemap_unknown_tilemap_0_d
	dw Tilemap_unknown_tilemap_0_d
	dw Tilemap_menu_phone_left_tmap
	dw Tilemap_unknown_tilemap_0_f
	dw Tilemap_menu_empty_menu_tmap
	dw Tilemap_menu_empty_expanded_option_tmap
	dw Tilemap_unknown_tilemap_0_12
	dw Tilemap_unknown_tilemap_0_13
	dw Tilemap_unknown_tilemap_0_14
	dw Tilemap_unknown_tilemap_0_15
	dw Tilemap_unknown_tilemap_0_16
	dw Tilemap_unknown_tilemap_0_17
	dw Tilemap_phoneconversation_window_tmap
	dw Tilemap_unknown_tilemap_0_19
	dw Tilemap_phoneconversation_monster_name_tmap
	dw Tilemap_unknown_tilemap_0_1b
	dw Tilemap_unknown_tilemap_0_1b
	dw Tilemap_unknown_tilemap_0_1c
	dw Tilemap_pausemenu_resources_controls_hint_tmap
	dw Tilemap_pausemenu_resources_controls_hint_2_tmap
	dw Tilemap_unknown_tilemap_0_1f
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
	dw Tilemap_unknown_tilemap_0_2b
	dw Tilemap_unknown_tilemap_0_2c
	dw Tilemap_unknown_tilemap_0_2d
	dw Tilemap_unknown_tilemap_0_2e
	dw Tilemap_unknown_tilemap_0_2f
	dw Tilemap_unknown_tilemap_0_30
	dw Tilemap_unknown_tilemap_0_31
	dw Tilemap_unknown_tilemap_0_32
	dw Tilemap_titlemenu_buttons_start_tmap
	dw Tilemap_titlemenu_buttons_continue_tmap
	dw Tilemap_titlemenu_buttons_soundtest_tmap
	dw Tilemap_titlemenu_buttons_link_tmap
	dw Tilemap_unknown_tilemap_0_37
	dw Tilemap_unknown_tilemap_0_38
	dw Tilemap_unknown_tilemap_0_39
	dw Tilemap_unknown_tilemap_0_3a
	dw Tilemap_unknown_tilemap_0_3b
	dw Tilemap_unknown_tilemap_0_3c
	dw Tilemap_encounter_backgrounds_field_tmap
	dw Tilemap_encounter_backgrounds_forest_tmap
	dw Tilemap_unknown_tilemap_0_3f
	dw Tilemap_unknown_tilemap_0_40
	dw Tilemap_encounter_backgrounds_cave_tmap
	dw Tilemap_encounter_backgrounds_ocean_tmap
	dw Tilemap_unknown_tilemap_0_43
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
	dw Tilemap_unknown_tilemap_0_4d
	dw Tilemap_unknown_tilemap_0_4e
	dw Tilemap_unknown_tilemap_0_4f
	dw Tilemap_unknown_tilemap_0_50
	dw Tilemap_unknown_tilemap_0_51
	dw Tilemap_menu_multiplayer_tmap
	dw Tilemap_menu_multiplayer_tmap
	dw Tilemap_menu_multiplayer_tmap
	dw Tilemap_menu_multiplayer_tmap
	dw Tilemap_menu_multiplayer_gameboys_tmap
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_54
	dw Tilemap_unknown_tilemap_0_55
	dw Tilemap_unknown_tilemap_0_56
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
	dw Tilemap_unknown_tilemap_0_5b
	dw Tilemap_unknown_tilemap_0_5c
	dw Tilemap_unknown_tilemap_0_5d
	dw Tilemap_unknown_tilemap_0_5e
	dw Tilemap_unknown_tilemap_0_5f
	dw Tilemap_unknown_tilemap_0_60
	dw Tilemap_unknown_tilemap_0_61
	dw Tilemap_unknown_tilemap_0_62
	dw Tilemap_unknown_tilemap_0_63
	dw Tilemap_unknown_tilemap_0_64
	dw Tilemap_unknown_tilemap_0_65
	dw Tilemap_unknown_tilemap_0_66
	dw Tilemap_unknown_tilemap_0_67
	dw Tilemap_unknown_tilemap_0_68
	dw Tilemap_unknown_tilemap_0_69
	dw Tilemap_unknown_tilemap_0_6a
	dw Tilemap_unknown_tilemap_0_6b
	dw Tilemap_unknown_tilemap_0_6c
	dw Tilemap_unknown_tilemap_0_6d
	dw Tilemap_unknown_tilemap_0_6e
	dw Tilemap_unknown_tilemap_0_6f
	dw Tilemap_unknown_tilemap_0_70
	dw Tilemap_unknown_tilemap_0_71
	dw Tilemap_unknown_tilemap_0_72
	dw Tilemap_unknown_tilemap_0_73
	dw Tilemap_unknown_tilemap_0_74
	dw Tilemap_unknown_tilemap_0_75
	dw Tilemap_unknown_tilemap_0_76
	dw Tilemap_victory_levelup_tmap
	dw Tilemap_unknown_tilemap_0_78
	dw Tilemap_unknown_tilemap_0_79
	dw Tilemap_unknown_tilemap_0_7a
	dw Tilemap_unknown_tilemap_0_7b
	dw Tilemap_unknown_tilemap_0_7c
	dw Tilemap_unknown_tilemap_0_7d
	dw Tilemap_unknown_tilemap_0_7e
	dw Tilemap_unknown_tilemap_0_7f
	dw Tilemap_unknown_tilemap_0_80
	dw Tilemap_unknown_tilemap_0_81
	dw Tilemap_unknown_tilemap_0_82
	dw Tilemap_unknown_tilemap_0_83
	dw Tilemap_unknown_tilemap_0_84
	dw Tilemap_unknown_tilemap_0_85
	dw Tilemap_unknown_tilemap_0_86
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
	dw Tilemap_unknown_tilemap_0_90
	dw Tilemap_unknown_tilemap_0_91
	dw Tilemap_unknown_tilemap_0_92
	dw Tilemap_unknown_tilemap_0_93
	dw Tilemap_unknown_tilemap_0_94
	dw Tilemap_unknown_tilemap_0_95
	dw Tilemap_menu_multiplayer_trade_tmap
	dw Tilemap_menu_multiplayer_melody_transfer_tmap
	dw Tilemap_menu_link_error_tmap
	dw Tilemap_unknown_tilemap_0_99
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
	incbin "gfx/menu/stats_tmap.tmap"
Tilemap_menu_stats_tmap_END

Tilemap_menu_stats_tab_progression_tmap::
	incbin "gfx/menu/stats_tab_progression_tmap.tmap"
Tilemap_menu_stats_tab_progression_tmap_END

Tilemap_menu_stats_tab_stats_tmap::
	incbin "gfx/menu/stats_tab_stats_tmap.tmap"
Tilemap_menu_stats_tab_stats_tmap_END

Tilemap_menu_stats_tab_moves_tmap::
	incbin "gfx/menu/stats_tab_moves_tmap.tmap"
Tilemap_menu_stats_tab_moves_tmap_END

Tilemap_screen_save_deleted_tmap::
	incbin "versions/power/gfx/screen/save_deleted_tmap.tmap"
Tilemap_screen_save_deleted_tmap_END

Tilemap_unknown_tilemap_0_5::
	incbin "gfx/unknown/tilemap_0/5.tmap"
Tilemap_unknown_tilemap_0_5_END

Tilemap_unknown_tilemap_0_6::
	incbin "gfx/unknown/tilemap_0/6.tmap"
Tilemap_unknown_tilemap_0_6_END

Tilemap_unknown_tilemap_0_7::
	incbin "gfx/unknown/tilemap_0/7.tmap"
Tilemap_unknown_tilemap_0_7_END

Tilemap_unknown_tilemap_0_8::
	incbin "gfx/unknown/tilemap_0/8.tmap"
Tilemap_unknown_tilemap_0_8_END

Tilemap_unknown_tilemap_0_9::
	incbin "gfx/unknown/tilemap_0/9.tmap"
;TODO: Remove these trash bytes.
   db $00,$FF,$3E,$22,$85,$3F,$76,$00
   db $80,$46,$04,$25,$00,$23,$48,$27
   db $7F,$00,$7F,$00,$7F,$00,$4D,$00
   db $FF
Tilemap_unknown_tilemap_0_9_END

Tilemap_encounter_backgrounds_base_tmap::
	incbin "components/encounter/backgrounds/base_tmap.tmap"
Tilemap_encounter_backgrounds_base_tmap_END

Tilemap_title_bg_tmap::
	incbin "versions/power/gfx/title/bg_tmap.tmap"
Tilemap_title_bg_tmap_END

Tilemap_unknown_tilemap_0_c::
	incbin "gfx/unknown/tilemap_0/c.tmap"
Tilemap_unknown_tilemap_0_c_END

Tilemap_unknown_tilemap_0_d::
	incbin "gfx/unknown/tilemap_0/d.tmap"
Tilemap_unknown_tilemap_0_d_END

Tilemap_menu_phone_left_tmap::
	incbin "gfx/menu/phone_left_tmap.tmap"
Tilemap_menu_phone_left_tmap_END

Tilemap_unknown_tilemap_0_f::
	incbin "gfx/unknown/tilemap_0/f.tmap"
Tilemap_unknown_tilemap_0_f_END

Tilemap_menu_empty_menu_tmap::
	incbin "gfx/menu/empty_menu_tmap.tmap"
Tilemap_menu_empty_menu_tmap_END

Tilemap_menu_empty_expanded_option_tmap::
	incbin "gfx/menu/empty_expanded_option_tmap.tmap"
Tilemap_menu_empty_expanded_option_tmap_END

Tilemap_unknown_tilemap_0_12::
	incbin "gfx/unknown/tilemap_0/12.tmap"
Tilemap_unknown_tilemap_0_12_END

Tilemap_unknown_tilemap_0_13::
	incbin "gfx/unknown/tilemap_0/13.tmap"
Tilemap_unknown_tilemap_0_13_END

Tilemap_unknown_tilemap_0_14::
	incbin "gfx/unknown/tilemap_0/14.tmap"
Tilemap_unknown_tilemap_0_14_END

Tilemap_unknown_tilemap_0_15::
	incbin "gfx/unknown/tilemap_0/15.tmap"
Tilemap_unknown_tilemap_0_15_END

Tilemap_unknown_tilemap_0_16::
	incbin "gfx/unknown/tilemap_0/16.tmap"
Tilemap_unknown_tilemap_0_16_END

Tilemap_unknown_tilemap_0_17::
	incbin "gfx/unknown/tilemap_0/17.tmap"
Tilemap_unknown_tilemap_0_17_END

Tilemap_phoneconversation_window_tmap::
	incbin "gfx/phoneconversation/window_tmap.tmap"
Tilemap_phoneconversation_window_tmap_END

Tilemap_unknown_tilemap_0_19::
	incbin "gfx/unknown/tilemap_0/19.tmap"
Tilemap_unknown_tilemap_0_19_END

Tilemap_phoneconversation_monster_name_tmap::
	incbin "gfx/phoneconversation/monster_name_tmap.tmap"
Tilemap_phoneconversation_monster_name_tmap_END

Tilemap_unknown_tilemap_0_1b::
	incbin "gfx/unknown/tilemap_0/1b.tmap"
Tilemap_unknown_tilemap_0_1b_END

Tilemap_unknown_tilemap_0_1c::
	incbin "gfx/unknown/tilemap_0/1c.tmap"
Tilemap_unknown_tilemap_0_1c_END

Tilemap_pausemenu_resources_controls_hint_tmap::
	incbin "components/pausemenu/resources/controls_hint_tmap.tmap"
Tilemap_pausemenu_resources_controls_hint_tmap_END

Tilemap_pausemenu_resources_controls_hint_2_tmap::
	incbin "components/pausemenu/resources/controls_hint_2_tmap.tmap"
Tilemap_pausemenu_resources_controls_hint_2_tmap_END

Tilemap_unknown_tilemap_0_1f::
	incbin "gfx/unknown/tilemap_0/1f.tmap"
Tilemap_unknown_tilemap_0_1f_END

Tilemap_unknown_tilemap_0_20::
	incbin "gfx/unknown/tilemap_0/20.tmap"
Tilemap_unknown_tilemap_0_20_END

Tilemap_pausemenu_buttons_zukan_tmap::
	incbin "components/pausemenu/buttons/zukan_tmap.tmap"
Tilemap_pausemenu_buttons_zukan_tmap_END

Tilemap_pausemenu_buttons_contacts_tmap::
	incbin "components/pausemenu/buttons/contacts_tmap.tmap"
Tilemap_pausemenu_buttons_contacts_tmap_END

Tilemap_pausemenu_buttons_calls_tmap::
	incbin "components/pausemenu/buttons/calls_tmap.tmap"
Tilemap_pausemenu_buttons_calls_tmap_END

Tilemap_pausemenu_buttons_melody_tmap::
	incbin "components/pausemenu/buttons/melody_tmap.tmap"
Tilemap_pausemenu_buttons_melody_tmap_END

Tilemap_pausemenu_buttons_items_tmap::
	incbin "components/pausemenu/buttons/items_tmap.tmap"
Tilemap_pausemenu_buttons_items_tmap_END

Tilemap_pausemenu_buttons_sms_tmap::
	incbin "components/pausemenu/buttons/sms_tmap.tmap"
Tilemap_pausemenu_buttons_sms_tmap_END

Tilemap_pausemenu_buttons_save_tmap::
	incbin "components/pausemenu/buttons/save_tmap.tmap"
Tilemap_pausemenu_buttons_save_tmap_END

Tilemap_pausemenu_buttons_options_tmap::
	incbin "components/pausemenu/buttons/options_tmap.tmap"
Tilemap_pausemenu_buttons_options_tmap_END

Tilemap_pausemenu_buttons_cancel_tmap::
	incbin "components/pausemenu/buttons/cancel_tmap.tmap"
Tilemap_pausemenu_buttons_cancel_tmap_END

Tilemap_unknown_tilemap_0_2a::
	incbin "gfx/unknown/tilemap_0/2a.tmap"
Tilemap_unknown_tilemap_0_2a_END

Tilemap_unknown_tilemap_0_2b::
	incbin "gfx/unknown/tilemap_0/2b.tmap"
Tilemap_unknown_tilemap_0_2b_END

Tilemap_unknown_tilemap_0_2c::
	incbin "gfx/unknown/tilemap_0/2c.tmap"
Tilemap_unknown_tilemap_0_2c_END

Tilemap_unknown_tilemap_0_2d::
	incbin "gfx/unknown/tilemap_0/2d.tmap"
Tilemap_unknown_tilemap_0_2d_END

Tilemap_unknown_tilemap_0_2e::
	incbin "gfx/unknown/tilemap_0/2e.tmap"
Tilemap_unknown_tilemap_0_2e_END

Tilemap_unknown_tilemap_0_2f::
	incbin "gfx/unknown/tilemap_0/2f.tmap"
Tilemap_unknown_tilemap_0_2f_END

Tilemap_unknown_tilemap_0_30::
	incbin "gfx/unknown/tilemap_0/30.tmap"
Tilemap_unknown_tilemap_0_30_END

Tilemap_unknown_tilemap_0_31::
	incbin "gfx/unknown/tilemap_0/31.tmap"
Tilemap_unknown_tilemap_0_31_END

Tilemap_unknown_tilemap_0_32::
	incbin "gfx/unknown/tilemap_0/32.tmap"
Tilemap_unknown_tilemap_0_32_END

Tilemap_titlemenu_buttons_start_tmap::
	incbin "components/titlemenu/buttons/start_tmap.tmap"
Tilemap_titlemenu_buttons_start_tmap_END

Tilemap_titlemenu_buttons_continue_tmap::
	incbin "components/titlemenu/buttons/continue_tmap.tmap"
Tilemap_titlemenu_buttons_continue_tmap_END

Tilemap_titlemenu_buttons_soundtest_tmap::
	incbin "components/titlemenu/buttons/soundtest_tmap.tmap"
Tilemap_titlemenu_buttons_soundtest_tmap_END

Tilemap_titlemenu_buttons_link_tmap::
	incbin "components/titlemenu/buttons/link_tmap.tmap"
Tilemap_titlemenu_buttons_link_tmap_END

Tilemap_unknown_tilemap_0_37::
	incbin "gfx/unknown/tilemap_0/37.tmap"
Tilemap_unknown_tilemap_0_37_END

Tilemap_unknown_tilemap_0_38::
	incbin "gfx/unknown/tilemap_0/38.tmap"
Tilemap_unknown_tilemap_0_38_END

Tilemap_unknown_tilemap_0_39::
	incbin "gfx/unknown/tilemap_0/39.tmap"
Tilemap_unknown_tilemap_0_39_END

Tilemap_unknown_tilemap_0_3a::
	incbin "gfx/unknown/tilemap_0/3a.tmap"
Tilemap_unknown_tilemap_0_3a_END

Tilemap_unknown_tilemap_0_3b::
	incbin "gfx/unknown/tilemap_0/3b.tmap"
Tilemap_unknown_tilemap_0_3b_END

Tilemap_unknown_tilemap_0_3c::
	incbin "gfx/unknown/tilemap_0/3c.tmap"
Tilemap_unknown_tilemap_0_3c_END

Tilemap_encounter_backgrounds_field_tmap::
	incbin "components/encounter/backgrounds/field_tmap.tmap"
Tilemap_encounter_backgrounds_field_tmap_END

Tilemap_encounter_backgrounds_forest_tmap::
	incbin "components/encounter/backgrounds/forest_tmap.tmap"
Tilemap_encounter_backgrounds_forest_tmap_END

Tilemap_unknown_tilemap_0_3f::
	incbin "gfx/unknown/tilemap_0/3f.tmap"
Tilemap_unknown_tilemap_0_3f_END

Tilemap_unknown_tilemap_0_40::
	incbin "gfx/unknown/tilemap_0/40.tmap"
Tilemap_unknown_tilemap_0_40_END

Tilemap_encounter_backgrounds_cave_tmap::
	incbin "components/encounter/backgrounds/cave_tmap.tmap"
Tilemap_encounter_backgrounds_cave_tmap_END

Tilemap_encounter_backgrounds_ocean_tmap::
	incbin "components/encounter/backgrounds/ocean_tmap.tmap"
Tilemap_encounter_backgrounds_ocean_tmap_END

Tilemap_unknown_tilemap_0_43::
	incbin "gfx/unknown/tilemap_0/43.tmap"
Tilemap_unknown_tilemap_0_43_END

Tilemap_unknown_tilemap_0_44::
	incbin "gfx/unknown/tilemap_0/44.tmap"
Tilemap_unknown_tilemap_0_44_END

Tilemap_phoneconversation_backgrounds_field_tmap::
	incbin "components/phoneconversation/backgrounds/field_tmap.tmap"
Tilemap_phoneconversation_backgrounds_field_tmap_END

Tilemap_phoneconversation_backgrounds_forest_tmap::
	incbin "components/phoneconversation/backgrounds/forest_tmap.tmap"
Tilemap_phoneconversation_backgrounds_forest_tmap_END

Tilemap_unknown_tilemap_0_47::
	incbin "gfx/unknown/tilemap_0/47.tmap"
Tilemap_unknown_tilemap_0_47_END

Tilemap_unknown_tilemap_0_48::
	incbin "gfx/unknown/tilemap_0/48.tmap"
Tilemap_unknown_tilemap_0_48_END

Tilemap_phoneconversation_backgrounds_cave_tmap::
	incbin "components/phoneconversation/backgrounds/cave_tmap.tmap"
Tilemap_phoneconversation_backgrounds_cave_tmap_END

Tilemap_phoneconversation_backgrounds_ocean_tmap::
	incbin "components/phoneconversation/backgrounds/ocean_tmap.tmap"
Tilemap_phoneconversation_backgrounds_ocean_tmap_END

Tilemap_phoneconversation_backgrounds_desert_tmap::
	incbin "components/phoneconversation/backgrounds/desert_tmap.tmap"
Tilemap_phoneconversation_backgrounds_desert_tmap_END

Tilemap_menu_sms_contents_tmap::
	incbin "gfx/menu/sms/contents_tmap.tmap"
Tilemap_menu_sms_contents_tmap_END

Tilemap_unknown_tilemap_0_4d::
	incbin "gfx/unknown/tilemap_0/4d.tmap"
Tilemap_unknown_tilemap_0_4d_END

Tilemap_unknown_tilemap_0_4e::
	incbin "gfx/unknown/tilemap_0/4e.tmap"
Tilemap_unknown_tilemap_0_4e_END

Tilemap_unknown_tilemap_0_4f::
	incbin "gfx/unknown/tilemap_0/4f.tmap"
Tilemap_unknown_tilemap_0_4f_END

Tilemap_unknown_tilemap_0_50::
	incbin "gfx/unknown/tilemap_0/50.tmap"
Tilemap_unknown_tilemap_0_50_END

Tilemap_unknown_tilemap_0_51::
	incbin "gfx/unknown/tilemap_0/51.tmap"
Tilemap_unknown_tilemap_0_51_END

Tilemap_menu_multiplayer_tmap::
	incbin "gfx/menu/multiplayer_tmap.tmap"
Tilemap_menu_multiplayer_tmap_END

Tilemap_menu_multiplayer_gameboys_tmap::
	incbin "gfx/menu/multiplayer/gameboys_tmap.tmap"
Tilemap_menu_multiplayer_gameboys_tmap_END

Tilemap_unknown_tilemap_0_54::
	incbin "gfx/unknown/tilemap_0/54.tmap"
Tilemap_unknown_tilemap_0_54_END

Tilemap_unknown_tilemap_0_55::
	incbin "gfx/unknown/tilemap_0/55.tmap"
Tilemap_unknown_tilemap_0_55_END

Tilemap_unknown_tilemap_0_56::
	incbin "versions/power/gfx/unknown/tilemap_0/56.tmap"
Tilemap_unknown_tilemap_0_56_END

Tilemap_unknown_tilemap_0_57::
	incbin "gfx/unknown/tilemap_0/57.tmap"
Tilemap_unknown_tilemap_0_57_END

Tilemap_unknown_tilemap_0_58::
	incbin "gfx/unknown/tilemap_0/58.tmap"
Tilemap_unknown_tilemap_0_58_END

Tilemap_unknown_tilemap_0_59::
	incbin "gfx/unknown/tilemap_0/59.tmap"
Tilemap_unknown_tilemap_0_59_END

Tilemap_unknown_tilemap_0_5a::
	incbin "gfx/unknown/tilemap_0/5a.tmap"
Tilemap_unknown_tilemap_0_5a_END

Tilemap_unknown_tilemap_0_5b::
	incbin "gfx/unknown/tilemap_0/5b.tmap"
Tilemap_unknown_tilemap_0_5b_END

Tilemap_unknown_tilemap_0_5c::
	incbin "gfx/unknown/tilemap_0/5c.tmap"
Tilemap_unknown_tilemap_0_5c_END

Tilemap_unknown_tilemap_0_5d::
	incbin "gfx/unknown/tilemap_0/5d.tmap"
Tilemap_unknown_tilemap_0_5d_END

Tilemap_unknown_tilemap_0_5e::
	incbin "gfx/unknown/tilemap_0/5e.tmap"
Tilemap_unknown_tilemap_0_5e_END

Tilemap_unknown_tilemap_0_5f::
	incbin "gfx/unknown/tilemap_0/5f.tmap"
Tilemap_unknown_tilemap_0_5f_END

Tilemap_unknown_tilemap_0_60::
	incbin "gfx/unknown/tilemap_0/60.tmap"
Tilemap_unknown_tilemap_0_60_END

Tilemap_unknown_tilemap_0_61::
	incbin "gfx/unknown/tilemap_0/61.tmap"
Tilemap_unknown_tilemap_0_61_END

Tilemap_unknown_tilemap_0_62::
	incbin "gfx/unknown/tilemap_0/62.tmap"
Tilemap_unknown_tilemap_0_62_END

Tilemap_unknown_tilemap_0_63::
	incbin "gfx/unknown/tilemap_0/63.tmap"
Tilemap_unknown_tilemap_0_63_END

Tilemap_unknown_tilemap_0_64::
	incbin "gfx/unknown/tilemap_0/64.tmap"
Tilemap_unknown_tilemap_0_64_END

Tilemap_unknown_tilemap_0_65::
	incbin "gfx/unknown/tilemap_0/65.tmap"
Tilemap_unknown_tilemap_0_65_END

Tilemap_unknown_tilemap_0_66::
	incbin "gfx/unknown/tilemap_0/66.tmap"
Tilemap_unknown_tilemap_0_66_END

Tilemap_unknown_tilemap_0_67::
	incbin "gfx/unknown/tilemap_0/67.tmap"
Tilemap_unknown_tilemap_0_67_END

Tilemap_unknown_tilemap_0_68::
	incbin "gfx/unknown/tilemap_0/68.tmap"
Tilemap_unknown_tilemap_0_68_END

Tilemap_unknown_tilemap_0_69::
	incbin "gfx/unknown/tilemap_0/69.tmap"
Tilemap_unknown_tilemap_0_69_END

Tilemap_unknown_tilemap_0_6a::
	incbin "gfx/unknown/tilemap_0/6a.tmap"
Tilemap_unknown_tilemap_0_6a_END

Tilemap_unknown_tilemap_0_6b::
	incbin "gfx/unknown/tilemap_0/6b.tmap"
Tilemap_unknown_tilemap_0_6b_END

Tilemap_unknown_tilemap_0_6c::
	incbin "gfx/unknown/tilemap_0/6c.tmap"
Tilemap_unknown_tilemap_0_6c_END

Tilemap_unknown_tilemap_0_6d::
	incbin "gfx/unknown/tilemap_0/6d.tmap"
Tilemap_unknown_tilemap_0_6d_END

Tilemap_unknown_tilemap_0_6e::
	incbin "gfx/unknown/tilemap_0/6e.tmap"
Tilemap_unknown_tilemap_0_6e_END

Tilemap_unknown_tilemap_0_6f::
	incbin "gfx/unknown/tilemap_0/6f.tmap"
Tilemap_unknown_tilemap_0_6f_END

Tilemap_unknown_tilemap_0_70::
	incbin "gfx/unknown/tilemap_0/70.tmap"
Tilemap_unknown_tilemap_0_70_END

Tilemap_unknown_tilemap_0_71::
	incbin "gfx/unknown/tilemap_0/71.tmap"
Tilemap_unknown_tilemap_0_71_END

Tilemap_unknown_tilemap_0_72::
	incbin "gfx/unknown/tilemap_0/72.tmap"
Tilemap_unknown_tilemap_0_72_END

Tilemap_unknown_tilemap_0_73::
	incbin "gfx/unknown/tilemap_0/73.tmap"
Tilemap_unknown_tilemap_0_73_END

Tilemap_unknown_tilemap_0_74::
	incbin "gfx/unknown/tilemap_0/74.tmap"
Tilemap_unknown_tilemap_0_74_END

Tilemap_unknown_tilemap_0_75::
	incbin "gfx/unknown/tilemap_0/75.tmap"
Tilemap_unknown_tilemap_0_75_END

Tilemap_unknown_tilemap_0_76::
	incbin "gfx/unknown/tilemap_0/76.tmap"
Tilemap_unknown_tilemap_0_76_END

Tilemap_victory_levelup_tmap::
	incbin "components/victory/levelup_tmap.tmap"
Tilemap_victory_levelup_tmap_END

Tilemap_unknown_tilemap_0_78::
	incbin "gfx/unknown/tilemap_0/78.tmap"
Tilemap_unknown_tilemap_0_78_END

Tilemap_unknown_tilemap_0_79::
	incbin "gfx/unknown/tilemap_0/79.tmap"
Tilemap_unknown_tilemap_0_79_END

Tilemap_unknown_tilemap_0_7a::
	incbin "gfx/unknown/tilemap_0/7a.tmap"
Tilemap_unknown_tilemap_0_7a_END

Tilemap_unknown_tilemap_0_7b::
	incbin "gfx/unknown/tilemap_0/7b.tmap"
Tilemap_unknown_tilemap_0_7b_END

Tilemap_unknown_tilemap_0_7c::
	incbin "gfx/unknown/tilemap_0/7c.tmap"
Tilemap_unknown_tilemap_0_7c_END

Tilemap_unknown_tilemap_0_7d::
	incbin "gfx/unknown/tilemap_0/7d.tmap"
Tilemap_unknown_tilemap_0_7d_END

Tilemap_unknown_tilemap_0_7e::
	incbin "gfx/unknown/tilemap_0/7e.tmap"
Tilemap_unknown_tilemap_0_7e_END

Tilemap_unknown_tilemap_0_7f::
	incbin "gfx/unknown/tilemap_0/7f.tmap"
Tilemap_unknown_tilemap_0_7f_END

Tilemap_unknown_tilemap_0_80::
	incbin "gfx/unknown/tilemap_0/80.tmap"
Tilemap_unknown_tilemap_0_80_END

Tilemap_unknown_tilemap_0_81::
	incbin "gfx/unknown/tilemap_0/81.tmap"
Tilemap_unknown_tilemap_0_81_END

Tilemap_unknown_tilemap_0_82::
	incbin "gfx/unknown/tilemap_0/82.tmap"
Tilemap_unknown_tilemap_0_82_END

Tilemap_unknown_tilemap_0_83::
	incbin "gfx/unknown/tilemap_0/83.tmap"
Tilemap_unknown_tilemap_0_83_END

Tilemap_unknown_tilemap_0_84::
	incbin "gfx/unknown/tilemap_0/84.tmap"
Tilemap_unknown_tilemap_0_84_END

Tilemap_unknown_tilemap_0_85::
	incbin "gfx/unknown/tilemap_0/85.tmap"
Tilemap_unknown_tilemap_0_85_END

Tilemap_unknown_tilemap_0_86::
	incbin "gfx/unknown/tilemap_0/86.tmap"
Tilemap_unknown_tilemap_0_86_END

Tilemap_contactenlist_bg_tmap::
	incbin "components/contactenlist/bg_tmap.tmap"
Tilemap_contactenlist_bg_tmap_END

Tilemap_unknown_tilemap_0_88::
	incbin "gfx/unknown/tilemap_0/88.tmap"
Tilemap_unknown_tilemap_0_88_END

Tilemap_unknown_tilemap_0_89::
	incbin "gfx/unknown/tilemap_0/89.tmap"
Tilemap_unknown_tilemap_0_89_END

Tilemap_unknown_tilemap_0_8a::
	incbin "gfx/unknown/tilemap_0/8a.tmap"
Tilemap_unknown_tilemap_0_8a_END

Tilemap_unknown_tilemap_0_8b::
	incbin "gfx/unknown/tilemap_0/8b.tmap"
Tilemap_unknown_tilemap_0_8b_END

Tilemap_unknown_tilemap_0_8c::
	incbin "gfx/unknown/tilemap_0/8c.tmap"
Tilemap_unknown_tilemap_0_8c_END

Tilemap_unknown_tilemap_0_8d::
	incbin "gfx/unknown/tilemap_0/8d.tmap"
Tilemap_unknown_tilemap_0_8d_END

Tilemap_unknown_tilemap_0_8e::
	incbin "gfx/unknown/tilemap_0/8e.tmap"
Tilemap_unknown_tilemap_0_8e_END

Tilemap_unknown_tilemap_0_8f::
	incbin "gfx/unknown/tilemap_0/8f.tmap"
Tilemap_unknown_tilemap_0_8f_END

Tilemap_unknown_tilemap_0_90::
	incbin "gfx/unknown/tilemap_0/90.tmap"
Tilemap_unknown_tilemap_0_90_END

Tilemap_unknown_tilemap_0_91::
	incbin "gfx/unknown/tilemap_0/91.tmap"
Tilemap_unknown_tilemap_0_91_END

Tilemap_unknown_tilemap_0_92::
	incbin "gfx/unknown/tilemap_0/92.tmap"
Tilemap_unknown_tilemap_0_92_END

Tilemap_unknown_tilemap_0_93::
	incbin "gfx/unknown/tilemap_0/93.tmap"
Tilemap_unknown_tilemap_0_93_END

Tilemap_unknown_tilemap_0_94::
	incbin "gfx/unknown/tilemap_0/94.tmap"
Tilemap_unknown_tilemap_0_94_END

Tilemap_unknown_tilemap_0_95::
	incbin "gfx/unknown/tilemap_0/95.tmap"
Tilemap_unknown_tilemap_0_95_END

Tilemap_menu_multiplayer_trade_tmap::
	incbin "gfx/menu/multiplayer/trade_tmap.tmap"
Tilemap_menu_multiplayer_trade_tmap_END

Tilemap_menu_multiplayer_melody_transfer_tmap::
	incbin "gfx/menu/multiplayer/melody_transfer_tmap.tmap"
Tilemap_menu_multiplayer_melody_transfer_tmap_END

Tilemap_menu_link_error_tmap::
	incbin "gfx/menu/link_error_tmap.tmap"
Tilemap_menu_link_error_tmap_END

Tilemap_unknown_tilemap_0_99::
	incbin "gfx/unknown/tilemap_0/99.tmap"
Tilemap_unknown_tilemap_0_99_END

Tilemap_unknown_tilemap_0_9a::
	incbin "gfx/unknown/tilemap_0/9a.tmap"
Tilemap_unknown_tilemap_0_9a_END

Tilemap_unknown_tilemap_0_9b::
	incbin "gfx/unknown/tilemap_0/9b.tmap"
Tilemap_unknown_tilemap_0_9b_END

SECTION "tilemap Bank 1", ROMX[$4000], BANK[$3f]
Tilemap_BANK_1::
	dw Tilemap_zukan_page_tmap
	dw Tilemap_zukan_page_tmap
	dw Tilemap_unknown_tilemap_1_1
	dw Tilemap_unknown_tilemap_1_1
	dw Tilemap_unknown_tilemap_1_1
	dw Tilemap_unknown_tilemap_1_1
	dw Tilemap_unknown_tilemap_1_1
	dw Tilemap_unknown_tilemap_1_1
	dw Tilemap_unknown_tilemap_1_1
	dw Tilemap_unknown_tilemap_1_2
	dw Tilemap_unknown_tilemap_1_3
	dw Tilemap_unknown_tilemap_1_4
	dw Tilemap_unknown_tilemap_1_5
	dw Tilemap_unknown_tilemap_1_6
	dw Tilemap_unknown_tilemap_1_7
	dw Tilemap_unknown_tilemap_1_7_END

Tilemap_zukan_page_tmap::
	incbin "components/zukan/page_tmap.tmap"
Tilemap_zukan_page_tmap_END

Tilemap_unknown_tilemap_1_1::
	incbin "gfx/unknown/tilemap_1/1.tmap"
Tilemap_unknown_tilemap_1_1_END

Tilemap_unknown_tilemap_1_2::
	incbin "versions/power/gfx/unknown/tilemap_1/2.tmap"
Tilemap_unknown_tilemap_1_2_END

Tilemap_unknown_tilemap_1_3::
	incbin "gfx/unknown/tilemap_1/3.tmap"
Tilemap_unknown_tilemap_1_3_END

Tilemap_unknown_tilemap_1_4::
	incbin "gfx/unknown/tilemap_1/4.tmap"
Tilemap_unknown_tilemap_1_4_END

Tilemap_unknown_tilemap_1_5::
	incbin "versions/power/gfx/unknown/tilemap_1/5.tmap"
Tilemap_unknown_tilemap_1_5_END

Tilemap_unknown_tilemap_1_6::
	incbin "versions/power/gfx/unknown/tilemap_1/6.tmap"
Tilemap_unknown_tilemap_1_6_END

Tilemap_unknown_tilemap_1_7::
	incbin "versions/power/gfx/unknown/tilemap_1/7.tmap"
Tilemap_unknown_tilemap_1_7_END


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
	incbin "gfx/menu/stats_attr.tmap"
Attribmap_menu_stats_attr_END

Attribmap_menu_stats_tab_progression_attr::
	incbin "gfx/menu/stats_tab_progression_attr.tmap"
Attribmap_menu_stats_tab_progression_attr_END

Attribmap_menu_stats_tab_stats_attr::
	incbin "gfx/menu/stats_tab_stats_attr.tmap"
Attribmap_menu_stats_tab_stats_attr_END

Attribmap_menu_stats_tab_moves_attr::
	incbin "gfx/menu/stats_tab_moves_attr.tmap"
Attribmap_menu_stats_tab_moves_attr_END

Attribmap_screen_save_deleted_attr::
	incbin "versions/power/gfx/screen/save_deleted_attr.tmap"
Attribmap_screen_save_deleted_attr_END

Attribmap_unknown_attribs_0_5::
	incbin "gfx/unknown/attribs_0/5.tmap"
Attribmap_unknown_attribs_0_5_END

Attribmap_unknown_attribs_0_6::
	incbin "gfx/unknown/attribs_0/6.tmap"
Attribmap_unknown_attribs_0_6_END

Attribmap_unknown_attribs_0_7::
	incbin "gfx/unknown/attribs_0/7.tmap"
Attribmap_unknown_attribs_0_7_END

Attribmap_title_bg_attr::
	incbin "versions/power/gfx/title/bg_attr.tmap"
Attribmap_title_bg_attr_END

Attribmap_unknown_attribs_0_9::
	incbin "gfx/unknown/attribs_0/9.tmap"
Attribmap_unknown_attribs_0_9_END

Attribmap_unknown_attribs_0_a::
	incbin "gfx/unknown/attribs_0/a.tmap"
Attribmap_unknown_attribs_0_a_END

Attribmap_unknown_attribs_0_b::
	incbin "gfx/unknown/attribs_0/b.tmap"
Attribmap_unknown_attribs_0_b_END

Attribmap_menu_phone_left_attr::
	incbin "gfx/menu/phone_left_attr.tmap"
Attribmap_menu_phone_left_attr_END

Attribmap_unknown_attribs_0_d::
	incbin "gfx/unknown/attribs_0/d.tmap"
Attribmap_unknown_attribs_0_d_END

Attribmap_menu_empty_menu_attr::
	incbin "gfx/menu/empty_menu_attr.tmap"
Attribmap_menu_empty_menu_attr_END

Attribmap_menu_empty_expanded_option_attr::
	incbin "gfx/menu/empty_expanded_option_attr.tmap"
Attribmap_menu_empty_expanded_option_attr_END

Attribmap_unknown_attribs_0_10::
	incbin "gfx/unknown/attribs_0/10.tmap"
Attribmap_unknown_attribs_0_10_END

Attribmap_unknown_attribs_0_11::
	incbin "gfx/unknown/attribs_0/11.tmap"
Attribmap_unknown_attribs_0_11_END

Attribmap_phoneconversation_window_attr::
	incbin "gfx/phoneconversation/window_attr.tmap"
Attribmap_phoneconversation_window_attr_END

Attribmap_phoneconversation_monster_name_attr::
	incbin "gfx/phoneconversation/monster_name_attr.tmap"
Attribmap_phoneconversation_monster_name_attr_END

Attribmap_unknown_attribs_0_14::
	incbin "gfx/unknown/attribs_0/14.tmap"
Attribmap_unknown_attribs_0_14_END

Attribmap_unknown_attribs_0_15::
	incbin "gfx/unknown/attribs_0/15.tmap"
Attribmap_unknown_attribs_0_15_END

Attribmap_unknown_attribs_0_16::
	incbin "gfx/unknown/attribs_0/16.tmap"
Attribmap_unknown_attribs_0_16_END

Attribmap_unknown_attribs_0_17::
	incbin "gfx/unknown/attribs_0/17.tmap"
Attribmap_unknown_attribs_0_17_END

Attribmap_unknown_attribs_0_18::
	incbin "gfx/unknown/attribs_0/18.tmap"
Attribmap_unknown_attribs_0_18_END

Attribmap_unknown_attribs_0_19::
	incbin "gfx/unknown/attribs_0/19.tmap"
Attribmap_unknown_attribs_0_19_END

Attribmap_unknown_attribs_0_1a::
	incbin "gfx/unknown/attribs_0/1a.tmap"
Attribmap_unknown_attribs_0_1a_END

Attribmap_menu_titlebtn_attr::
	incbin "gfx/menu/titlebtn_attr.tmap"
Attribmap_menu_titlebtn_attr_END

Attribmap_unknown_attribs_0_1c::
	incbin "gfx/unknown/attribs_0/1c.tmap"
Attribmap_unknown_attribs_0_1c_END

Attribmap_unknown_attribs_0_1d::
	incbin "gfx/unknown/attribs_0/1d.tmap"
Attribmap_unknown_attribs_0_1d_END

Attribmap_unknown_attribs_0_1e::
	incbin "gfx/unknown/attribs_0/1e.tmap"
Attribmap_unknown_attribs_0_1e_END

Attribmap_unknown_attribs_0_1f::
	incbin "gfx/unknown/attribs_0/1f.tmap"
Attribmap_unknown_attribs_0_1f_END

Attribmap_unknown_attribs_0_20::
	incbin "gfx/unknown/attribs_0/20.tmap"
Attribmap_unknown_attribs_0_20_END

Attribmap_unknown_attribs_0_21::
	incbin "gfx/unknown/attribs_0/21.tmap"
Attribmap_unknown_attribs_0_21_END

Attribmap_unknown_attribs_0_22::
	incbin "gfx/unknown/attribs_0/22.tmap"
Attribmap_unknown_attribs_0_22_END

Attribmap_unknown_attribs_0_23::
	incbin "gfx/unknown/attribs_0/23.tmap"
Attribmap_unknown_attribs_0_23_END

Attribmap_unknown_attribs_0_24::
	incbin "gfx/unknown/attribs_0/24.tmap"
Attribmap_unknown_attribs_0_24_END

Attribmap_unknown_attribs_0_25::
	incbin "gfx/unknown/attribs_0/25.tmap"
Attribmap_unknown_attribs_0_25_END

Attribmap_unknown_attribs_0_26::
	incbin "gfx/unknown/attribs_0/26.tmap"
Attribmap_unknown_attribs_0_26_END

Attribmap_unknown_attribs_0_27::
	incbin "gfx/unknown/attribs_0/27.tmap"
Attribmap_unknown_attribs_0_27_END

Attribmap_unknown_attribs_0_28::
	incbin "gfx/unknown/attribs_0/28.tmap"
Attribmap_unknown_attribs_0_28_END

Attribmap_unknown_attribs_0_29::
	incbin "gfx/unknown/attribs_0/29.tmap"
Attribmap_unknown_attribs_0_29_END

Attribmap_menu_sms_contents_attr::
	incbin "gfx/menu/sms/contents_attr.tmap"
Attribmap_menu_sms_contents_attr_END

Attribmap_unknown_attribs_0_2b::
	incbin "gfx/unknown/attribs_0/2b.tmap"
Attribmap_unknown_attribs_0_2b_END

Attribmap_unknown_attribs_0_2c::
	incbin "gfx/unknown/attribs_0/2c.tmap"
Attribmap_unknown_attribs_0_2c_END

Attribmap_unknown_attribs_0_2d::
	incbin "gfx/unknown/attribs_0/2d.tmap"
Attribmap_unknown_attribs_0_2d_END

Attribmap_unknown_attribs_0_2e::
	incbin "gfx/unknown/attribs_0/2e.tmap"
Attribmap_unknown_attribs_0_2e_END

Attribmap_unknown_attribs_0_2f::
	incbin "gfx/unknown/attribs_0/2f.tmap"
Attribmap_unknown_attribs_0_2f_END

Attribmap_unknown_attribs_0_30::
	incbin "gfx/unknown/attribs_0/30.tmap"
Attribmap_unknown_attribs_0_30_END

Attribmap_menu_multiplayer_gameboys_attr::
	incbin "gfx/menu/multiplayer/gameboys_attr.tmap"
Attribmap_menu_multiplayer_gameboys_attr_END

Attribmap_unknown_attribs_0_32::
	incbin "gfx/unknown/attribs_0/32.tmap"
Attribmap_unknown_attribs_0_32_END

Attribmap_unknown_attribs_0_33::
	incbin "gfx/unknown/attribs_0/33.tmap"
Attribmap_unknown_attribs_0_33_END

Attribmap_unknown_attribs_0_34::
	incbin "versions/power/gfx/unknown/attribs_0/34.tmap"
Attribmap_unknown_attribs_0_34_END

Attribmap_unknown_attribs_0_35::
	incbin "gfx/unknown/attribs_0/35.tmap"
Attribmap_unknown_attribs_0_35_END

Attribmap_unknown_attribs_0_36::
	incbin "gfx/unknown/attribs_0/36.tmap"
Attribmap_unknown_attribs_0_36_END

Attribmap_unknown_attribs_0_37::
	incbin "gfx/unknown/attribs_0/37.tmap"
Attribmap_unknown_attribs_0_37_END

Attribmap_unknown_attribs_0_38::
	incbin "gfx/unknown/attribs_0/38.tmap"
Attribmap_unknown_attribs_0_38_END

Attribmap_unknown_attribs_0_39::
	incbin "gfx/unknown/attribs_0/39.tmap"
Attribmap_unknown_attribs_0_39_END

Attribmap_unknown_attribs_0_3a::
	incbin "gfx/unknown/attribs_0/3a.tmap"
Attribmap_unknown_attribs_0_3a_END

Attribmap_unknown_attribs_0_3b::
	incbin "gfx/unknown/attribs_0/3b.tmap"
Attribmap_unknown_attribs_0_3b_END

Attribmap_unknown_attribs_0_3c::
	incbin "gfx/unknown/attribs_0/3c.tmap"
Attribmap_unknown_attribs_0_3c_END

Attribmap_unknown_attribs_0_3d::
	incbin "gfx/unknown/attribs_0/3d.tmap"
Attribmap_unknown_attribs_0_3d_END

Attribmap_unknown_attribs_0_3e::
	incbin "gfx/unknown/attribs_0/3e.tmap"
Attribmap_unknown_attribs_0_3e_END

Attribmap_unknown_attribs_0_3f::
	incbin "gfx/unknown/attribs_0/3f.tmap"
Attribmap_unknown_attribs_0_3f_END

Attribmap_unknown_attribs_0_40::
	incbin "gfx/unknown/attribs_0/40.tmap"
Attribmap_unknown_attribs_0_40_END

Attribmap_unknown_attribs_0_41::
	incbin "gfx/unknown/attribs_0/41.tmap"
Attribmap_unknown_attribs_0_41_END

Attribmap_unknown_attribs_0_42::
	incbin "gfx/unknown/attribs_0/42.tmap"
Attribmap_unknown_attribs_0_42_END

Attribmap_unknown_attribs_0_43::
	incbin "gfx/unknown/attribs_0/43.tmap"
Attribmap_unknown_attribs_0_43_END

Attribmap_unknown_attribs_0_44::
	incbin "gfx/unknown/attribs_0/44.tmap"
Attribmap_unknown_attribs_0_44_END

Attribmap_unknown_attribs_0_45::
	incbin "gfx/unknown/attribs_0/45.tmap"
Attribmap_unknown_attribs_0_45_END

Attribmap_unknown_attribs_0_46::
	incbin "gfx/unknown/attribs_0/46.tmap"
Attribmap_unknown_attribs_0_46_END

Attribmap_unknown_attribs_0_47::
	incbin "gfx/unknown/attribs_0/47.tmap"
Attribmap_unknown_attribs_0_47_END

Attribmap_unknown_attribs_0_48::
	incbin "gfx/unknown/attribs_0/48.tmap"
Attribmap_unknown_attribs_0_48_END

Attribmap_unknown_attribs_0_49::
	incbin "gfx/unknown/attribs_0/49.tmap"
Attribmap_unknown_attribs_0_49_END

Attribmap_unknown_attribs_0_4a::
	incbin "gfx/unknown/attribs_0/4a.tmap"
Attribmap_unknown_attribs_0_4a_END

Attribmap_unknown_attribs_0_4b::
	incbin "gfx/unknown/attribs_0/4b.tmap"
Attribmap_unknown_attribs_0_4b_END

Attribmap_unknown_attribs_0_4c::
	incbin "gfx/unknown/attribs_0/4c.tmap"
Attribmap_unknown_attribs_0_4c_END

Attribmap_unknown_attribs_0_4d::
	incbin "gfx/unknown/attribs_0/4d.tmap"
Attribmap_unknown_attribs_0_4d_END

Attribmap_unknown_attribs_0_4e::
	incbin "gfx/unknown/attribs_0/4e.tmap"
Attribmap_unknown_attribs_0_4e_END

Attribmap_unknown_attribs_0_4f::
	incbin "gfx/unknown/attribs_0/4f.tmap"
Attribmap_unknown_attribs_0_4f_END

Attribmap_unknown_attribs_0_50::
	incbin "gfx/unknown/attribs_0/50.tmap"
Attribmap_unknown_attribs_0_50_END

Attribmap_unknown_attribs_0_51::
	incbin "gfx/unknown/attribs_0/51.tmap"
Attribmap_unknown_attribs_0_51_END

Attribmap_unknown_attribs_0_52::
	incbin "gfx/unknown/attribs_0/52.tmap"
Attribmap_unknown_attribs_0_52_END

Attribmap_unknown_attribs_0_53::
	incbin "gfx/unknown/attribs_0/53.tmap"
Attribmap_unknown_attribs_0_53_END

Attribmap_unknown_attribs_0_54::
	incbin "gfx/unknown/attribs_0/54.tmap"
Attribmap_unknown_attribs_0_54_END

Attribmap_unknown_attribs_0_55::
	incbin "gfx/unknown/attribs_0/55.tmap"
Attribmap_unknown_attribs_0_55_END

Attribmap_unknown_attribs_0_56::
	incbin "gfx/unknown/attribs_0/56.tmap"
Attribmap_unknown_attribs_0_56_END

Attribmap_unknown_attribs_0_57::
	incbin "gfx/unknown/attribs_0/57.tmap"
Attribmap_unknown_attribs_0_57_END

Attribmap_unknown_attribs_0_58::
	incbin "gfx/unknown/attribs_0/58.tmap"
Attribmap_unknown_attribs_0_58_END

Attribmap_unknown_attribs_0_59::
	incbin "gfx/unknown/attribs_0/59.tmap"
Attribmap_unknown_attribs_0_59_END

Attribmap_menu_multiplayer_trade_attr::
	incbin "gfx/menu/multiplayer/trade_attr.tmap"
Attribmap_menu_multiplayer_trade_attr_END

Attribmap_menu_multiplayer_melody_transfer_attr::
	incbin "gfx/menu/multiplayer/melody_transfer_attr.tmap"
Attribmap_menu_multiplayer_melody_transfer_attr_END

Attribmap_unknown_attribs_0_5c::
	incbin "gfx/unknown/attribs_0/5c.tmap"
Attribmap_unknown_attribs_0_5c_END

Attribmap_unknown_attribs_0_5d::
	incbin "gfx/unknown/attribs_0/5d.tmap"
Attribmap_unknown_attribs_0_5d_END

Attribmap_unknown_attribs_0_5e::
	incbin "gfx/unknown/attribs_0/5e.tmap"
Attribmap_unknown_attribs_0_5e_END

Attribmap_unknown_attribs_0_5f::
	incbin "gfx/unknown/attribs_0/5f.tmap"
Attribmap_unknown_attribs_0_5f_END

Attribmap_unknown_attribs_0_60::
	incbin "gfx/unknown/attribs_0/60.tmap"
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
	incbin "gfx/unknown/attribs_1/0.tmap"
Attribmap_unknown_attribs_1_0_END

Attribmap_unknown_attribs_1_1::
	incbin "gfx/unknown/attribs_1/1.tmap"
Attribmap_unknown_attribs_1_1_END

Attribmap_unknown_attribs_1_2::
	incbin "versions/power/gfx/unknown/attribs_1/2.tmap"
Attribmap_unknown_attribs_1_2_END

Attribmap_unknown_attribs_1_3::
	incbin "gfx/unknown/attribs_1/3.tmap"
Attribmap_unknown_attribs_1_3_END

Attribmap_unknown_attribs_1_4::
	incbin "gfx/unknown/attribs_1/4.tmap"
Attribmap_unknown_attribs_1_4_END

Attribmap_unknown_attribs_1_5::
	incbin "versions/power/gfx/unknown/attribs_1/5.tmap"
Attribmap_unknown_attribs_1_5_END

Attribmap_unknown_attribs_1_6::
	incbin "versions/power/gfx/unknown/attribs_1/6.tmap"
Attribmap_unknown_attribs_1_6_END

Attribmap_unknown_attribs_1_7::
	incbin "versions/power/gfx/unknown/attribs_1/7.tmap"
Attribmap_unknown_attribs_1_7_END


