"""Commands dealing with Telefang's script"""

from FangTools.tfscript.banknames import parse_bank_names
from FangTools.tfscript.inject import generate_table_section
from FangTools.tfmessage.charmap import parse_charmap
from FangTools.tfmessage.csv import parse_csv, omnibus_bank_split
from FangTools.tffont.parser import parse_font_metrics
from FangTools.gb import flat
from FangTools.rgbds import format_section, format_symbol, format_directives
import os

def make_tbl(args):
    """Compile the entire script into a single RGBDS file, and then write it to
    disk.
    
    `args` is the arguments passed to the program as processed by `argparse`."""
    charmap = parse_charmap(args.charmap)
    banknames = parse_bank_names(args.banknames)
    
    overflow_bank_ids = []
    
    if args.language == "Japanese":
        metrics = None
    else:
        metrics_file = open(args.metrics, 'r')
        metrics = parse_font_metrics(metrics_file)

    #Some CSV files in the patch branch are merged together.
    #We'll parse these first and add their row data to each individual bank...
    for filename in args.filenames:
        with open(filename, "r", encoding="utf-8") as csvfile:
            rowdata = parse_csv(csvfile, args.language)
        
        split_rowdata = omnibus_bank_split(rowdata, banknames)
        
        for bankid, rowdata in split_rowdata.items():
            banknames[bankid]["textdata"] = rowdata
    
    overflow_strings = {}
    bank_sources = {}
    
    for h, bank in enumerate(banknames):
        if bank["filename"].startswith("script/overflow") or bank["filename"].startswith("script\\overflow"):
            #Don't attempt to compile the overflow bank. That's a separate pass
            overflow_bank_ids.append(h)
            continue
        
        #If filenames are specified, don't bother because we can't do on-demand
        #compilation anyway and the makefile gets the path wrong
        
        print("Compiling " + bank["filename"])
        #Open and parse the data
        if "textdata" not in bank.keys():
            with open(os.path.join(args.input, bank["filename"]), "r", encoding='utf-8') as csvfile:
                bank["textdata"] = parse_csv(csvfile, args.language)

        bank_window_width = args.window_width
        if "window_width" in list(bank.keys()):
            bank_window_width = bank["window_width"]
        
        srcdata, overflow = generate_table_section(bank, bank["textdata"], charmap, metrics, bank_window_width)
        bank_sources[bank["objname"]] = srcdata
        overflow_strings.update(overflow)
    
    number_symbols_exported = 0
    overflow_sources = {}

    for overflow_bank_id in overflow_bank_ids:
        overflow_src = format_section("Overflow Bank %d" % overflow_bank_id, flat(banknames[overflow_bank_id]["basebank"], 0x4000))
        overflow_offset = 0
        
        current_symbol_id = 0
        break_after_adding = False
        for symname, packed_str in overflow_strings.items():
            if current_symbol_id < number_symbols_exported:
                current_symbol_id += 1
                continue

            if overflow_offset + len(packed_str) > 0x4000:
                number_symbols_exported = current_symbol_id
                break

            current_symbol_id += 1

            overflow_src += format_symbol(symname, True)
            overflow_src += format_directives(packed_str)
            overflow_offset += len(packed_str)
        else:
            break_after_adding = True
        
        overflow_sources[overflow_bank_id] = overflow_src
        
        if break_after_adding:
            break
    
    with open(args.output_filename, "wb") as srcfile:
        for bank_id, bank_source in overflow_sources.items():
            srcfile.write(bank_source.encode("utf-8"))
        
        for bank_id, bank_source in bank_sources.items():
            srcfile.write(bank_source.encode("utf-8"))