"""SNES linker class primarily to demonstrate the flexibility of the linker's fixation system.

If you seriously expect me to support SNES fan translations, go back to RH.net
and continue your one-system circlejerk."""
from CodeModule.assembly import linker

class LoROM(object):
    """SHVC LoROM cartridge mapper.
    
    Maps ROM into the high half of every memory bank.
    
    (Seriously, why is it called Low if it's in the high half of memory?"""
    ROM = {"segsize": 0x8000,
           "views": [(0x8000, None)],
           "maxsegs": 0x100}

class HiROM(object):
    pass

class SHVC(object):
    MEMMODE = linker.MapIntoBanks
    WRAM = {"segsize": 0x10000,
            "views": [(0, 0, 1, 0x1FFF), (0, 0x7E, 0x80)]}
