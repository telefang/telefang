SECTION "SGB Attribute Data (Power Version)", ROMX[$5000], BANK[$77]
SGB_AttrFileData::
    INCBIN "build/versions/power/gfx/sgb/attrfile/00.atf" ; 00
    INCBIN "build/versions/power/gfx/sgb/attrfile/01.atf" ; 01
    INCBIN "build/versions/power/gfx/title/sgb.atf" ; 02
    INCBIN "build/gfx/menu/titlemenu.atf" ; 03
    INCBIN "build/components/status/status_screen.atf" ; 04
    INCBIN "build/components/zukan/zukan_screen.atf" ; 05
    INCBIN "build/gfx/menu/titlemenu_inapp.atf" ; 06
    INCBIN "build/gfx/menu/pausemenu_inapp.atf" ; 07
    INCBIN "build/gfx/menu/pausemenu_inventory.atf" ; 08
    INCBIN "build/components/zukan/zukan_overview.atf" ; 09
    INCBIN "build/gfx/menu/pausemenu_messagecount.atf" ; 0A
    INCBIN "build/gfx/menu/pausemenu_messagelist.atf" ; 0B
    INCBIN "build/gfx/menu/pausemenu_outgoingcall.atf" ; 0C
    INCBIN "build/components/map/no_window.atf" ; 0D
    INCBIN "build/components/map/top_window.atf" ; 0E
    INCBIN "build/components/map/bottom_window.atf" ; 0F
    INCBIN "build/components/encounter/encounter.atf" ; 10
    INCBIN "build/components/summon/summon.atf" ; 11
    INCBIN "build/gfx/menu/titlemenu_nicknames.atf" ; 12
    INCBIN "build/components/battle/main_screen.atf" ; 13
    INCBIN "build/components/battle/attack_menu.atf" ; 14
    INCBIN "build/components/map/dungeon.atf" ; 15
    INCBIN "build/gfx/cutscene/antenna_tree_cutscene.atf" ; 16
    INCBIN "build/gfx/cutscene/shigeki_connected.atf" ; 17
    INCBIN "build/gfx/cutscene/waaaaahh.atf" ; 18
    INCBIN "build/gfx/cutscene/kai.atf" ; 19
    INCBIN "build/versions/power/gfx/screen/gameover.atf" ; 1A
    INCBIN "build/components/fusionlabevo/noevolution.atf" ; 1B
    INCBIN "build/components/fusionlabevo/itemselection.atf" ; 1C
    INCBIN "build/components/fusionlabevo/evolution.atf" ; 1D
    INCBIN "build/components/zukan/completion_certificate.atf" ; 1E
    INCBIN "build/components/overworld/overworld.atf" ; 1F
    INCBIN "build/components/linkmenu/link_menu.atf" ; 20
    INCBIN "build/components/linkmenu/link_connection.atf" ; 21
    ; The highest attrfile number is $2C.
