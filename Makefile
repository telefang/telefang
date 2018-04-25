.PHONY: all compare_power compare_speed clean power speed

.SUFFIXES:
.SUFFIXES: .asm .o .gbc .png .wav .wikitext

# Build Telefang.
# We have two targets:
# Power (English on top of Japanese Power)
# Speed (English on top of Japanese Speed)
ROMS_POWER := telefang_pw_english.gbc
ROMS_POWER_NORTC := telefang_pw_english_nortc.gbc
BASEROM_POWER := baserom_pw.gbc
ROMS_SPEED := telefang_sp_english.gbc
ROMS_SPEED_NORTC := telefang_sp_english_nortc.gbc
BASEROM_SPEED := baserom_sp.gbc
OBJS := components/compression/malias.o \
     components/compression/rle_tilemap.o components/compression/rle_attribmap.o \
	  components/lcdc/vblank_irq.o components/lcdc/hblank_irq.o \
	  components/lcdc/oam_dma.o components/lcdc/shadow_regs.o \
	  components/lcdc/sprite_compose.o components/lcdc/memory.o \
     components/lcdc/cgb_palette.o components/lcdc/tilemap_math.o \
	  components/lcdc/load_tiles.o components/lcdc/fades.o \
     components/lcdc/fades_cgb.o components/lcdc/tile_index.o \
     components/lcdc/wraparound.o components/lcdc/init_attributes.o \
     components/lcdc/disable_lcd.o components/lcdc/dmg_palette.o \
	  components/system/main.o components/system/state_machine.o \
	  components/system/rst.o components/mainscript/state_machine.o \
	  components/system/memory.o components/system/empty.o \
	  components/system/entrypoints.o components/system/bankcalls.o \
	  components/system/math.o components/system/bitmanip.o \
     components/system/overclock.o \
	  components/system/patch_utils.o components/system/patch_unknown.o \
	  components/system/aux_code.o \
     components/sgb/palettes.o components/sgb/detect.o \
     components/sgb/packets.o components/sgb/precomposed.o \
     components/pausemenu/contacts.o components/pausemenu/nameutil.o \
     components/pausemenu/menu.o components/pausemenu/window_flavor.o \
     components/pausemenu/cursor.o components/pausemenu/phoneime.o \
     components/pausemenu/tilemaps.o components/pausemenu/utility.o \
     components/pausemenu/palette.o components/pausemenu/drawfuncs.o \
     components/pausemenu/phoneime_mapping.o components/pausemenu/phoneime_sync.o \
     components/pausemenu/phoneime_diacritics.o components/pausemenu/phoneime_glyph.o \
     components/pausemenu/contact_statemachine.o components/pausemenu/sms_statemachine.o \
     components/pausemenu/sms_utils.o components/pausemenu/inventory_statemachine.o \
     components/pausemenu/inventory_utils.o components/pausemenu/indicators.o \
     components/pausemenu/save/statemachine.o components/pausemenu/save/input.o \
     components/pausemenu/screen_resources.o \
     components/melodyedit/memory.o components/melodyedit/indicators.o \
     components/melodyedit/ringtone_menu.o \
     components/titlemenu/state_machine.o components/titlemenu/name_input.o \
     components/titlemenu/nickname_editor.o components/titlemenu/sram.o \
     components/titlemenu/rtc.o components/titlemenu/menu_scroll.o \
     components/titlemenu/time_entry.o \
     components/titlemenu/advice.o components/titlemenu/trash.o \
     components/titlelogo/state_machine.o \
     components/titlescreen/state_machine.o components/titlescreen/position_sprite.o \
     components/titlescreen/advice.o \
	  components/mainscript/ccinterpreter.o components/mainscript/utility.o \
	  components/mainscript/font.o components/mainscript/draw_text.o \
     components/mainscript/statustext.o components/mainscript/window.o \
     components/mainscript/canned_initializer.o components/mainscript/message_args.o \
     components/mainscript/shop_item_window.o \
     components/mainscript/arrows.o \
     components/mainscript/advice.o \
	  components/map/locations.o components/map/states.o \
     components/overworld/memory.o components/overworld/rtc.o \
     components/overworld/power_antenna.o components/overworld/new_save_init.o \
     components/overworld/flags.o \
     components/phoneconversation/inbound.o components/phoneconversation/scenery.o \
     components/phoneconversation/ui.o components/phoneconversation/outbound.o \
     components/phoneconversation/data.o \
	  components/sound/samples.o components/sound/indexing.o \
     components/sound/control.o \
	  components/serio/driver.o components/serio/vssummon_statemachine.o \
     components/serio/game_statemachine.o components/serio/vssummon_utils.o \
     components/serio/battle_utils.o \
     components/linkmelody/cursor_utils.o \
	  components/jpinput/jpinput.o \
	  components/battle/statistics.o components/battle/species.o \
     components/battle/denjuu_portrait.o components/battle/message.o \
     components/battle/attacks_statemachine.o \
     components/battle/attacks.o components/battle/screen_statemachine.o \
     components/battle/participant.o components/battle/meters_ui.o \
     components/battle/link_management.o \
     components/battle/status.o \
     components/battle/plural.o \
	  components/status/nickname.o components/status/stats.o \
     components/status/statetbl.o components/status/icons.o \
     components/status/tabs.o components/status/interface.o \
     components/status/draw_funcs.o components/status/evolution.o \
     components/status/shift_bg.o components/status/phone_number.o \
     components/status/ui_graphics.o components/status/digits.o \
	  components/stringtable/load.o components/stringtable/table_banks.o \
	  components/stringtable/padding.o \
     components/saveclock/sram_lock.o components/saveclock/save_format.o \
	  components/saveclock/denjuu_nicknames.o components/saveclock/initialize_new.o \
     components/saveclock/friendliness_pellets.o components/saveclock/rtc.o \
     components/saveclock/initialize_save.o components/saveclock/integrity.o \
     components/saveclock/persistence.o \
     components/encounter/articles.o \
     components/encounter/late_denjuu_statemachine.o \
     components/encounter/string_utils.o components/encounter/select_indicator.o \
     components/encounter/opponent_display_machine.o components/encounter/tile_digits.o \
     components/encounter/tfanger_portraits.o components/encounter/signal_indicator.o \
     components/encounter/scenery.o components/encounter/state_machine.o \
     components/encounter/scripted_denjuu.o \
     components/summon/state_machine.o components/summon/index_utils.o \
     components/summon/draw_utils.o \
     components/victory/external_statemachine.o components/victory/participant_utils.o \
     components/victory/battle_statemachine.o components/victory/levelup.o \
     components/victory/stat_icon.o components/victory/natural_evo.o \
     components/victory/ui_utils.o components/victory/game_statemachine.o \
     components/victory/defection_statemachine.o components/victory/contact_utils.o \
     components/victory/advice.o \
     components/linktrade/loss_statemachine.o \
     components/zukan/completion_certificate_tmap.o \
     components/zukan/completion_flags.o components/zukan/draw_utils.o \
     components/zukan/state_machine.o \
     components/fusionlabevo/item_name_utils.o \
     components/eventscript/general_opcodes.o \
     components/eventscript/flag_opcodes.o \
     components/eventscript/jump_opcodes.o \
     components/eventscript/animation_opcodes.o \
     components/eventscript/denjuu_opcodes.o \
     components/eventscript/interpreter.o \
	  gfx/denjuu_stages.o gfx/phones/keypad_gfx.o gfx/samples.o gfx/items.o \
	  gfx/statusbar.o gfx/denjuu.o \
     script/mainscript.o script/stringtable.o
     
OBJS_POWER := versions/power/compressed_gfx.o versions/power/extra_gfx.o \
	  versions/power/tilemaps.o versions/power/metasprite.o \
     versions/power/palettes.o versions/power/gfx/sgb/border.o \
     versions/power/gfx/sgb/attrfile.o \
     versions/power/gfx/sgb/palettes.o \
     versions/power/components/titlemenu/state_machine.o \
     versions/power/components/saveclock/integrity.o \
     versions/power/components/titlescreen/state_machine.o \
     versions/power/components/overworld/new_save_init.o
OBJS_SPEED := versions/speed/compressed_gfx.o versions/speed/extra_gfx.o \
	  versions/speed/tilemaps.o versions/speed/metasprite.o \
     versions/speed/palettes.o versions/speed/gfx/sgb/border.o \
     versions/speed/gfx/sgb/attrfile.o \
     versions/speed/gfx/sgb/palettes.o \
     versions/speed/components/titlemenu/state_machine.o \
     versions/speed/components/saveclock/integrity.o \
     versions/speed/components/titlescreen/state_machine.o \
     versions/speed/components/overworld/new_save_init.o

SRC_MESSAGE := script/battle/messages.messages.csv script/denjuu/sms.messages.csv \
					script/npc/all.messages.csv script/npc/unused.messages.csv \
					script/npc/postgame.messages.csv script/calls/denjuu/all.messages.csv \
					script/story/all.messages.csv script/denjuu/descriptions.messages.csv \
					script/calls/story.messages.csv script/calls/exp_item.messages.csv

OBJS_MESSAGE := script/mainscript_data.o
OBJS_MESSAGE_BLOCKS := script/battle/messages.scripttbl script/denjuu/sms.scripttbl \
               script/npc/1.scripttbl script/story/1.scripttbl \
               script/npc/2.scripttbl script/npc/unused.scripttbl \
               script/npc/postgame.scripttbl script/calls/denjuu/1.scripttbl \
               script/calls/denjuu/2.scripttbl script/story/2.scripttbl script/story/3.scripttbl \
               script/npc/3.scripttbl script/story/4.scripttbl script/calls/denjuu/3.scripttbl \
               script/calls/denjuu/4.scripttbl script/calls/denjuu/5.scripttbl \
               script/calls/denjuu/6.scripttbl script/denjuu/descriptions.scripttbl \
               script/calls/story.scripttbl script/calls/exp_item.scripttbl \
               script/story/5.scripttbl

OBJS_ASM := ${OBJS} ${OBJS_POWER} ${OBJS_SPEED}

PYTHON := $(shell rip_scripts/find_python.sh)
ifndef PYTHON
$(error Couldn't find Python 3)
endif

# Link objects together to build a rom.
all: power speed

ips: $(ROMS_POWER:.gbc=.ips) $(ROMS_SPEED:.gbc=.ips)

power: $(ROMS_POWER) $(ROMS_POWER_NORTC)

speed: $(ROMS_SPEED) $(ROMS_SPEED_NORTC)

# Assemble source files into objects.
# Use rgbasm -h to use halts without nops.
$(OBJS_ASM): %.o: %.asm
	rgbasm -h -o $@ $<

$(ROMS_POWER): $(OBJS) $(OBJS_POWER) $(OBJS_MESSAGE) $(OBJS_MESSAGE_BLOCKS)
	rgblink -n $(ROMS_POWER:.gbc=.sym) -m $(ROMS_POWER:.gbc=.map) -O $(BASEROM_POWER) -o $@ $^
	rgbfix -v -c -i BTXJ -k 2N -l 0x33 -m 0x10 -p 0 -r 3 -s -t "TELEFANG PW" $@

$(ROMS_SPEED): $(OBJS) $(OBJS_SPEED) $(OBJS_MESSAGE) $(OBJS_MESSAGE_BLOCKS)
	rgblink -n $(ROMS_SPEED:.gbc=.sym) -m $(ROMS_SPEED:.gbc=.map) -O $(BASEROM_SPEED) -o $@ $^
	rgbfix -v -c -i BTZJ -k 2N -l 0x33 -m 0x10 -p 0 -r 3 -s -t "TELEFANG SP" $@

$(ROMS_POWER_NORTC): $(OBJS) $(OBJS_POWER) $(OBJS_MESSAGE) $(OBJS_MESSAGE_BLOCKS)
	rgblink -n $(ROMS_POWER_NORTC:.gbc=.sym) -m $(ROMS_POWER_NORTC:.gbc=.map) -O $(BASEROM_POWER) -o $@ $^
	rgbfix -v -c -i BTXJ -k 2N -l 0x33 -m 0x13 -p 0 -r 3 -s -t "TELEFANG PW" $@

$(ROMS_SPEED_NORTC): $(OBJS) $(OBJS_SPEED) $(OBJS_MESSAGE) $(OBJS_MESSAGE_BLOCKS)
	rgblink -n $(ROMS_SPEED_NORTC:.gbc=.sym) -m $(ROMS_SPEED_NORTC:.gbc=.map) -O $(BASEROM_SPEED) -o $@ $^
	rgbfix -v -c -i BTZJ -k 2N -l 0x33 -m 0x13 -p 0 -r 3 -s -t "TELEFANG SP" $@

# Remove files generated by the build process.
clean:
	rm -f $(ROMS_POWER) $(ROMS_POWER_NORTC) $(OBJS) $(OBJS_POWER) $(ROMS_POWER:.gbc=.sym) $(ROMS_POWER:.gbc=.map) $(ROMS_POWER_NORTC:.gbc=.sym) $(ROMS_POWER_NORTC:.gbc=.map) $(ROMS_SPEED) $(ROMS_SPEED_NORTC) $(OBJS_SPEED) $(ROMS_SPEED:.gbc=.sym) $(ROMS_SPEED:.gbc=.map) $(ROMS_SPEED_NORTC:.gbc=.sym) $(ROMS_SPEED_NORTC:.gbc=.map) $(OBJS_MESSAGE) $(ROMS_POWER:.gbc=.ips) $(ROMS_SPEED:.gbc=.ips)
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' -o -iname '*.pcm' -o -iname '*.scripttbl' -o -iname '*.tmap' -o -iname '*.stringtbl' -o -iname '*.sprite.bin' -o -iname '*.atf' \) -exec rm {} +

%.color.2bpp %.gbcpal: %.color.png
	@echo "Building $*.color.2bpp and $*.gbcpal..."
	@rm -f $@
	rgbgfx -d 2 -p $*.gbcpal -o $*.color.2bpp $<

$(filter-out %.color.2bpp,%.2bpp): %.png
	@echo "Building" $<
	@./rip_scripts/is_nonindexed_png.sh $<
	@rm -f $@
	@rgbgfx -d 2 -o $@ $<

%.1bpp: %.png
	@echo "Building" $<
	@./rip_scripts/is_nonindexed_png.sh $<
	@rm -f $@
	@rgbgfx -d 1 -o $@ $<

%.pcm: %.wav
	@rm -f $@
	@$(PYTHON) rip_scripts/pcm.py pcm $<

$(OBJS_MESSAGE) $(OBJS_MESSAGE_BLOCKS): $(SRC_MESSAGE)
	@rm -f $@
	@$(PYTHON) rip_scripts/mainscript_text.py make_tbl /dev/null $(SRC_MESSAGE) $(OBJS_MESSAGE) --language="English" --metrics="components/mainscript/font.tffont.csv"

%.stringtbl: %.csv
	@rm -f $@
	@$(PYTHON) rip_scripts/stringtable_text.py make_tbl /dev/null --language="English"

%.tmap: %.csv
	@rm -f $@
	@$(PYTHON) rip_scripts/rip_tilemaps.py make_maps $(BASEROM_POWER) $<

%.sprite.bin: %.sprite.csv
	@rm -f $@
	@$(PYTHON) rip_scripts/metasprite.py make_spritebin $<
   
%.atf: %.sgbattr.csv
	@rm -f $@
	@$(PYTHON) rip_scripts/rip_sgb_attrfile.py make_atf $< $@
   
%.metrics.bin: %.tffont.csv
	@rm -f $@
	@$(PYTHON) rip_scripts/tffontasm.py $< $@

# Shoutout to SimpleFlips
$(ROMS_POWER:.gbc=.ips): $(BASEROM_POWER) $(ROMS_POWER)
	flips --create --ips $^ $@

$(ROMS_SPEED:.gbc=.ips): $(BASEROM_SPEED) $(ROMS_SPEED)
	flips --create --ips $^ $@

DEPENDENCY_SCAN_EXIT_STATUS := $(shell $(PYTHON) rip_scripts/scan_includes.py $(OBJS_ASM:.o=.asm) > dependencies.d; echo $$?)
ifneq ($(DEPENDENCY_SCAN_EXIT_STATUS), 0)
$(error Dependency scan failed)
endif
include dependencies.d
