.PHONY: all compare_power compare_speed clean power speed

.SUFFIXES:
.SUFFIXES: .asm .o .gbc .png .wav .wikitext
.SECONDEXPANSION:

# Build Telefang.
ROMS_POWER := telefang_pw.gbc
BASEROM_POWER := baserom_pw.gbc
ROMS_SPEED := telefang_sp.gbc
BASEROM_SPEED := baserom_sp.gbc
OBJS := components/compression/malias.o \
     components/compression/rle_tilemap.o components/compression/rle_attribmap.o \
	  components/lcdc/vblank_irq.o components/lcdc/hblank_irq.o \
	  components/lcdc/oam_dma.o components/lcdc/shadow_regs.o \
	  components/lcdc/sprite_compose.o components/lcdc/memory.o \
     components/lcdc/cgb_palette.o components/lcdc/tilemap_math.o \
	  components/lcdc/load_tiles.o components/lcdc/fades.o \
     components/lcdc/fades_cgb.o components/lcdc/tile_index.o \
	  components/system/main.o components/system/state_machine.o \
	  components/system/rst.o components/mainscript/state_machine.o \
	  components/system/memory.o components/system/empty.o \
	  components/system/entrypoints.o components/system/bankcalls.o \
	  components/system/math.o components/system/bitmanip.o \
     components/sgb/palettes.o \
     components/pausemenu/contacts.o components/pausemenu/nameutil.o \
     components/pausemenu/menu.o components/pausemenu/window_flavor.o \
     components/pausemenu/cursor.o components/pausemenu/phoneime.o \
     components/pausemenu/tilemaps.o components/pausemenu/utility.o \
     components/pausemenu/palette.o components/pausemenu/drawfuncs.o \
     components/pausemenu/phoneime_mapping.o components/pausemenu/phoneime_sync.o \
     components/pausemenu/phoneime_diacritics.o components/pausemenu/phoneime_glyph.o \
     components/melodyedit/memory.o components/melodyedit/indicators.o \
     components/titlemenu/state_machine.o components/titlemenu/name_input.o \
	  components/mainscript/ccinterpreter.o components/mainscript/utility.o \
	  components/mainscript/font.o components/mainscript/draw_text.o \
     components/mainscript/statustext.o components/mainscript/window.o \
     components/mainscript/canned_initializer.o \
	  components/map/locations.o \
	  components/sound/samples.o \
	  components/serio/driver.o \
	  components/jpinput/jpinput.o \
	  components/battle/statistics.o components/battle/species.o \
     components/battle/denjuu_portrait.o \
	  components/status/nickname.o components/status/stats.o \
     components/status/statetbl.o components/status/icons.o \
     components/status/tabs.o components/status/interface.o \
     components/status/draw_funcs.o components/status/evolution.o \
     components/status/shift_bg.o components/status/phone_number.o \
     components/status/ui_graphics.o components/status/digits.o \
	  components/stringtable/load.o components/stringtable/table_banks.o \
	  components/stringtable/padding.o \
     components/saveclock/sram_lock.o components/saveclock/save_format.o \
	  components/saveclock/denjuu_nicknames.o \
	  gfx/denjuu_stages.o gfx/phones/keypad_gfx.o gfx/samples.o \
     script/mainscript.o script/stringtable.o
     
OBJS_POWER := versions/power/compressed_gfx.o versions/power/extra_gfx.o \
	  versions/power/tilemaps.o
OBJS_SPEED := versions/speed/compressed_gfx.o versions/speed/extra_gfx.o \
	  versions/speed/tilemaps.o
OBJS_ALL := ${OBJS} ${OBJS_POWER} ${OBJS_SPEED}

# If your default python is 3, you may want to change this to python27.
PYTHON := python
PRET := pokemon-reverse-engineering-tools/pokemontools

$(foreach obj, $(OBJS), \
	$(eval $(obj:.o=)_dep := $(shell $(PYTHON) rip_scripts/scan_includes.py $(obj:.o=.asm))) \
)

$(foreach obj, $(OBJS_POWER), \
	$(eval $(obj:.o=)_dep := $(shell $(PYTHON) rip_scripts/scan_includes.py $(obj:.o=.asm))) \
)

$(foreach obj, $(OBJS_SPEED), \
	$(eval $(obj:.o=)_dep := $(shell $(PYTHON) rip_scripts/scan_includes.py $(obj:.o=.asm))) \
)

# Link objects together to build a rom.
all: power speed

power: $(ROMS_POWER) compare_power

speed: $(ROMS_SPEED) compare_speed

# Assemble source files into objects.
# Use rgbasm -h to use halts without nops.
$(OBJS_ALL): $$*.asm $$($$*_dep)
	@$(PYTHON) rip_scripts/mainscript_text.py make_tbl $(BASEROM_POWER)
	@$(PYTHON) rip_scripts/stringtable_text.py make_tbl $(BASEROM_POWER)
	rgbasm -h -o $@ $<

$(ROMS_POWER): $(OBJS) $(OBJS_POWER)
	rgblink -n $(ROMS_POWER:.gbc=.sym) -m $(ROMS_POWER:.gbc=.map) -O $(BASEROM_POWER) -o $@ $^
	rgbfix -v -c -i BXTJ -k 2N -l 0x33 -m 0x10 -p 0 -r 3 -t "TELEFANG PW" $@

$(ROMS_SPEED): $(OBJS) $(OBJS_SPEED)
	rgblink -n $(ROMS_SPEED:.gbc=.sym) -m $(ROMS_SPEED:.gbc=.map) -O $(BASEROM_SPEED) -o $@ $^
	rgbfix -v -c -i BTZJ -k 2N -l 0x33 -m 0x10 -p 0 -r 3 -t "TELEFANG SP" $@

# The compare target is a shortcut to check that the build matches the original roms exactly.
# This is for contributors to make sure a change didn't affect the contents of the rom.
# More thorough comparison can be made by diffing the output of hexdump -C against both roms.
compare_power: $(ROMS_POWER) $(BASEROM_POWER)
	cmp $^

compare_speed: $(ROMS_SPEED) $(BASEROM_SPEED)
	cmp $^

# Remove files generated by the build process.
clean:
	rm -f $(ROMS_POWER) $(OBJS) $(OBJS_POWER) $(ROMS_POWER:.gbc=.sym) $(ROMS_POWER:.gbc=.map) $(ROMS_SPEED) $(OBJS_SPEED) $(ROMS_SPEED:.gbc=.sym) $(ROMS_SPEED:.gbc=.map)
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' -o -iname '*.pcm' -o -iname '*.scripttbl' \) -exec rm {} +

%.2bpp: %.png
	@rm -f $@
	@$(PYTHON) $(PRET)/gfx.py 2bpp $<

%.1bpp: %.png
	@rm -f $@
	@$(PYTHON) $(PRET)/gfx.py 1bpp $<

%.pcm: %.wav
	@rm -f $@
	@$(PYTHON) rip_scripts/pcm.py pcm $<

%.scripttbl: %.wikitext
	@rm -f $@

%.stringtbl: %.wikitext
	@rm -f $@

%.tmap: %.csv
	@rm -f $@
	@$(PYTHON) rip_scripts/rip_tilemaps.py make_maps $(BASEROM_POWER) $<
