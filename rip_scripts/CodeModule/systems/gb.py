from CodeModule.exc import *
from CodeModule.asm import linker
from CodeModule.systems.helper import BasePlatform
from CodeModule.games.identify import identifier
from CodeModule import cmodel

import math, os, struct, json

class BaseSystem(BasePlatform):
    """Base class implementation of a Gameboy.
    
    You must combine this class with a system (DMG or GBC) and cartridge mapper before it can be used."""
    
    MEMAREAS = ["ROM", "VRAM", "SRAM", "WRAM", "HRAM", "OAM", "IOSPACE", "INTMASK"]
    IOSPACE = {"views":[(0xFF00, 0)],
               "segsize":128,
               "maxsegs":1,
               "type":linker.DynamicArea}
    INTMASK = {"views":[(0xFFFF, 0)],
               "segsize":1,
               "maxsegs":1,
               "type":linker.DynamicArea}
    HRAM = {"views":[(0xFF80, 0)],
            "segsize":127,
            "maxsegs":1,
            "type":linker.DynamicArea}
    OAM = {"views":[(0xFE00, 0)],
           "segsize":0xA0,
           "maxsegs":1,
           "type":linker.DynamicArea}
    ECHO = {"views":[(0xE000, 0)],
            "segsize":0x1E00,
            "type":linker.ShadowArea,
            "shadows":"WRAM"}
    GROUPMAP = {"CODE": "ROM", "DATA": "ROM", "BSS":"WRAM", "HOME":("ROM", 0), "VRAM":"VRAM", "HRAM":"HRAM"}
    
    @classmethod
    def banked2flat(self, bank, addr):
        if addr > 0xFDFF and addr < 0xFEA0:
            return (addr - 0xFE00, "OAM")
        elif addr > 0xFEFF and addr < 0xFF80:
            return (addr - 0xFF00, "IOSPACE")
        elif addr > 0xFF7F and addr < 0xFFFF:
            return (addr - 0xFF80, "HRAM")
        elif addr > 0xDFFF and addr < 0xFE00:
            return self.banked2flat(addr - 0x2000)
        elif addr == 0xFFFF:
            return (0, "INTMASK")
        else:
            return super(BaseSystem, self).banked2flat(bank, addr)
    
    @classmethod
    def flat2banked(self, addr, src):
        """Convert a flat address and memory area name to Gameboy bank number and Z80 address."""
        if src == "OAM":
            return (0, addr + 0xFE00)
        elif src == "IOSPACE":
            return (0, addr + 0xFF00)
        elif src == "HRAM":
            return (0, addr + 0xFF80)
        elif src == "INTMASK":
            return (0, addr)
        else:
            return super(BaseSystem, self).flat2banked(bank, addr)
    
    def __init__(self):
        self.streams = {}
    
    def install_stream(self, fileobj, area = "ROM", bus = "main"):
        """Install a file stream into a particular area, such as ROM."""
        self.streams[area] = fileobj
    
    def bus_read(self, bank, addr, bytecount = 1, bus = "main"):
        """Execute a read from Z80 space, returning the byte(s) at that address.
        
        Internally, this uses installed streams. Use install_stream to add one."""
        
        out_bytes = b""
        
        for i in range(0, bytecount):
            linear_addr, area = self.banked2flat(bank, addr)
            self.streams[area].seek(linear_addr)
            out_bytes += self.streams[area].read(1)
        
        return out_bytes
    
    def bus_write(self, bank, addr, datum, bus = "main"):
        """Execute a write from Z80 space, returning the byte(s) at that address.
        
        Internally, this uses installed streams. Use install_stream to add one."""
        
        for databyte in datum:
            linear_addr, area = self.banked2flat(bank, addr)
            self.streams[area].seek(linear_addr)
            out_bytes += self.streams[area].write(databyte)
        
        return out_bytes
    
    @property
    def resources_list(self):
        """Obtain a list of resources that this game has that can be modified."""
        return ["rom_header"]
    
    def resource_information(self, resource_type):
        if resource_type == "rom_header":
            return {"storage_pattern":"singleton",
                    "singleton_name":"header",
                    "extracted_as":dict,
                    "inject_accepts":["text/json", dict, RomHeader]}
    
    def extract_resource(self, resource_type, resource_id = None):
        if resource_type == "rom_header":
            self.streams["ROM"].seek(0x104)
            rh = RomHeader()
            rh.load(self.streams["ROM"])
            result = rh.core._asdict()
            result["logo"] = list(result["logo"])
            
            return result
    
    def inject_resource(self, resource_type, resource_id = None, resource = None):
        if resource_type == "rom_header":
            ires = resource
            if type(ires) is bytes:
                ires = str(ires, "utf-8")
            
            if type(ires) is str:
                ires = json.loads(ires)
                ires["logo"] = bytes(ires["logo"])
            
            if type(ires) is not RomHeader:
                ires = RomHeader()
                ires.core = jres
            
            self.streams["ROM"].seek(0x104)
            ires.save(self.streams["ROM"])

class RomHeader(cmodel.Struct):
    logo = cmodel.Blob(48)
    title = cmodel.UnterminatedString(11, "ascii", allow_decoding_failure = True)
    mfxr_code = cmodel.UnterminatedString(4, "ascii", allow_decoding_failure = True)
    cgb_flag = cmodel.LeU8
    new_licensee = cmodel.UnterminatedString(2, "ascii", allow_decoding_failure = True)
    sgb_flag = cmodel.LeU8
    cartridge_type = cmodel.LeU8
    rom_size = cmodel.LeU8
    ram_size = cmodel.LeU8
    destination_code = cmodel.LeU8
    old_licensee = cmodel.LeU8
    rom_version = cmodel.LeU8
    header_checksum = cmodel.LeU8
    rom_checksum = cmodel.BeU16 #why big endian? why not?
    
    __order__ = ["logo", "title", "mfxr_code", "cgb_flag", "new_licensee", "sgb_flag", "cartridge_type", "rom_size", "ram_size", "destination_code", "old_licensee", "rom_version", "header_checksum", "rom_checksum"]

@identifier
def identify_file(fileobj, filename = None):
    """Attempt to identify Game Boy cartridge ROMs."""

    results = []
    base_score = -5     #Score for being a Gameboy ROM
    dmg_score  = 0      #Score for being intended for Gameboy Color
    cgb_score  = 0      #Score for being intended for Gameboy Color
    mapper_scores = []  #Score for having various mappers attached
    
    try:
        if filename != None and os.path.splitext(filename)[1] in ["gb", "gbc"]:
            base_score += 1         #1 point for having the right file extension
        
        #ROM Header test check
        rh = RomHeader()
        fileobj.seek(0x104)
        rh.load(fileobj)
        
        base_score += 1 #1 point for RomHeader loading properly
    except:
        return []
    else:
        #Check validity of Nintendo logo
        nintendo_logo = b"\xCE\xED\x66\x66\xCC\x0D\x00\x0B\x03\x73\x00\x83\x00\x0C\x00\x0D\x00\x08\x11\x1F\x88\x89\x00\x0E\xDC\xCC\x6E\xE6\xDD\xDD\xD9\x99\xBB\xBB\x67\x63\x6E\x0E\xEC\xCC\xDD\xDC\x99\x9F\xBB\xB9\x33\x3E"
        if rh.logo == nintendo_logo:
            base_score += 10        #Very unlikely non-Gameboy data will have this data at the right position
        
        #1 point each for title, manufacturer code, and new licensee having valid ASCII data
        if type(rh.title) == str:
            base_score += 1
        
        if type(rh.mfxr_code) == str:
            base_score += 1
        
        if type(rh.new_licensee) == str:
            base_score += 1
        
        #Extra points for CGB support
        if rh.cgb_flag == 0x80:
            cgb_score += 5          #5 points towards CGB over DMG if supported
        elif rh.cgb_flag == 0xC0:
            dmg_score -= 1000000    #Heavily weigh against DMG analysis if ROM indicates CGB required
            cgb_score += 10         #10 points if required
        
        #Mapper detection
        if rh.cartridge_type in [0x00, 0x08, 0x09]:
            mapper_scores.append((1, "flat"))
        
        if rh.cartridge_type in [0x01, 0x02, 0x03]:
            mapper_scores.append((1, "mbc1"))
        
        if rh.cartridge_type in [0x05, 0x06]:
            mapper_scores.append((1, "mbc2"))
        
        if rh.cartridge_type in [0x0F, 0x10, 0x11, 0x12, 0x13]:
            mapper_scores.append((1, "mbc3"))
#       TODO: Reenable when I find MBC4 documentation        
#        if rh.cartridge_type in [0x15, 0x16, 0x17]:
#            mapper_scores.append((1, "mbc4"))
        
        if rh.cartridge_type in [0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E]:
            mapper_scores.append((1, "mbc5"))
        
        if len(mapper_scores) > 0:
            gb_base = DMG
            if (base_score + cgb_score) > (base_score + dmg_score):
                gb_base = CGB
                base_score += cgb_score
            else:
                base_score += dmg_score
            
            mapper_scores.sort()
            best_mapper = {"flat":FlatMapper,
                           "mbc1":MBC1Mapper,
                           "mbc2":MBC2Mapper,
                           "mbc3":MBC3Mapper,
                           "mbc5":MBC5Mapper}[mapper_scores[-1][-1]]
            base_score += mapper_scores[-1][0]
            
            results.append({"class_bases":(gb_base, best_mapper), "score":base_score, "name":"Gameboy ROM Image", "stream":"ROM"})
    
    return results

class FlatMapper(BasePlatform):
    ROM = {"segsize":0x8000,
           "views":[(0, 0)],
           "maxsegs":1,
           "type":linker.PermenantArea}
    SRAM = {"segsize":0x2000,
           "views":[(0xA000, 0)],
           "maxsegs":1,
           "type":linker.SaveArea}

    @classmethod
    def banked2flat(self, bank, addr):
        """Convert a Gameboy bank number and Z80 address to a flat ROM address and stream name."""
        
        if addr < 0x8000:
            return (addr, "ROM")
        elif addr > 0x9FFF and addr < 0xC000:
            return ((addr - 0x9FFF), "SRAM")
        else:
            return super(FlatMapper, self).banked2flat(bank, addr)

    @classmethod
    def flat2banked(self, addr, src):
        """Convert a flat address and memory area name to Gameboy bank number and Z80 address."""
        if src == "ROM":
            return (0, addr)
        elif src == "SRAM":
            return (0, addr + 0xA000)
        else:
            return super(FlatMapper, self).flat2banked(bank, addr)
            

class MBC1Mapper(BasePlatform):
    ROM = {"segsize":0x4000,
           "views":[(0, 0), (0x4000, (1, 0x80))],
           "maxsegs":0x80,
           "unusable":[(None, 0x20), (None, 0x40), (None, 0x60)],
           "type":linker.PermenantArea}
    SRAM = {"segsize":0x2000,
           "views":[(0xA000, None)],
           "maxsegs":4,
           "type":linker.SaveArea}

    @classmethod
    def banked2flat(self, bank, addr):
        """Convert a Gameboy bank number and Z80 address to a flat ROM address."""
        
        if addr < 0x8000 and bank < 0x80:
            if bank == 0x20 or bank == 0x40 or bank == 0x60 or bank == 0:
                bank += 1

            if addr < 0x4000:
                bank = 0
            else:
                addr -= 0x4000

            return (bank * 0x4000 + addr, "ROM")
        elif addr > 0x9FFF and addr < 0xC000 and bank < 0x04:
            addr -= 0xA000
            
            return (bank * 0x1000 + addr, "SRAM")
        else:
            return super(MBC1Mapper, self).banked2flat(bank, addr)

    @classmethod
    def flat2banked(self, addr, src):
        """Convert a flat address and memory area name to Gameboy bank number and Z80 address."""
        if src == "ROM":
            bank = addr // 0x4000
            
            base = 0
            if bank > 0:
                base = 0x4000
            
            return (bank, addr % 0x4000 + base)
        elif src == "SRAM":
            return (addr // 0x2000, (addr % 0x2000) + 0xA000)
        else:
            return super(MBC1Mapper, self).flat2banked(bank, addr)

class MBC2Mapper(BasePlatform):
    ROM = {"segsize":0x4000,
           "views":[(0, 0), (0x4000, (1, 0x10))],
           "maxsegs":0x10,
           "unusable":[(None, 0x20), (None, 0x40), (None, 0x60)],
           "type":linker.PermenantArea}
    SRAM = {"segsize":0x200,
           "views":[(0xA000, 0)],
           "maxsegs":1,
           "type":linker.SaveArea}

    @classmethod
    def banked2flat(self, bank, addr):
        """Convert a Gameboy bank number and Z80 address to a flat ROM address."""
        
        if addr < 0x8000 and bank < 0x10:
            if addr < 0x4000:
                bank = 0
            else:
                addr -= 0x4000

            return (bank * 0x4000 + addr, "ROM")
        elif addr > 0x9FFF and addr < 0xA200 and bank == 0:
            addr -= 0xA000
            
            return (addr, "SRAM")
        else:
            return super(MBC2Mapper, self).banked2flat(bank, addr)

    @classmethod
    def flat2banked(self, addr, src):
        """Convert a flat address and memory area name to Gameboy bank number and Z80 address."""
        if src == "ROM":
            bank = addr // 0x4000
            
            base = 0
            if bank > 0:
                base = 0x4000
            
            return (bank, addr % 0x4000 + base)
        elif src == "SRAM":
            return (addr // 0x2000, (addr % 0x2000) + 0xA000)
        else:
            return super(MBC2Mapper, self).flat2banked(bank, addr)

class MBC3Mapper(BasePlatform):
    ROM = {"segsize":0x4000,
           "views":[(0, 0), (0x4000, (1, 0x80))],
           "maxsegs":0x80,
           "type":linker.PermenantArea}
    SRAM = {"segsize":0x2000,
           "views":[(0xA000, None)],
           "maxsegs":4,
           "type":linker.SaveArea}

    @classmethod
    def banked2flat(self, bank, addr):
        """Convert a Gameboy bank number and Z80 address to a flat ROM address."""
        
        if addr < 0x8000 and bank < 0x80:
            if addr < 0x4000:
                bank = 0
            else:
                addr -= 0x4000

            return (bank * 0x4000 + addr, "ROM")
        elif addr > 0x9FFF and addr < 0xC000 and bank < 0x04:
            addr -= 0xA000
            
            return (bank * 0x1000 + addr, "SRAM")
        else:
            return super(MBC3Mapper, self).banked2flat(bank, addr)

    @classmethod
    def flat2banked(self, addr, src):
        """Convert a flat address and memory area name to Gameboy bank number and Z80 address."""
        if src == "ROM":
            bank = addr // 0x4000
            
            base = 0
            if bank > 0:
                base = 0x4000
            
            return (bank, addr % 0x4000 + base)
        elif src == "SRAM":
            return (addr // 0x2000, (addr % 0x2000) + 0xA000)
        else:
            return super(MBC3Mapper, self).flat2banked(bank, addr)

class MBC5Mapper(BasePlatform):
    ROM = {"segsize":0x4000,
           "views":[(0, 0), (0x4000, (1, 0x200))],
           "maxsegs":0x200,
           "type":linker.PermenantArea}
    SRAM = {"segsize":0x2000,
           "views":[(0xA000, None)],
           "maxsegs":0x10,
           "type":linker.SaveArea}
    
    @classmethod
    def banked2flat(self, bank, addr):
        """Convert a Gameboy bank number and Z80 address to a flat ROM address.
        
        This MBC5 implementation supports 64mbit cartridges, which were never
        released by Nintendo but are mentioned in the GBPM. Some EMS flashcarts
        are 64mbit, but allow you to boot to the first or second half of that
        memory space through reset-counting hardware."""
        
        if addr < 0x8000 and bank < 0x200:
            if addr < 0x4000:
                bank = 0
            else:
                addr -= 0x4000

            return (bank * 0x4000 + addr, "ROM")
        elif addr > 0x9FFF and addr < 0xC000 and bank < 0x10:
            addr -= 0xA000
            
            return (bank * 0x1000 + addr, "SRAM")
        else:
            return super(MBC5Mapper, self).banked2flat(bank, addr)

    @classmethod
    def flat2banked(self, addr, src):
        """Convert a flat address and memory area name to Gameboy bank number and Z80 address."""
        if src == "ROM":
            bank = addr // 0x4000
            
            base = 0
            if bank > 0:
                base = 0x4000
            
            return (bank, addr % 0x4000 + base)
        elif src == "SRAM":
            return (addr // 0x2000, (addr % 0x2000) + 0xA000)
        else:
            return super(MBC3Mapper, self).flat2banked(bank, addr)

class CGB(BaseSystem):
    WRAM = {"segsize":0x1000,
            "views":[(0xC000, 0), (0xD000, (1, 0x8))],
            "maxsegs":8,
            "type":linker.DynamicArea}
    VRAM = {"segsize":0x2000,
            "views":[(0x8000, None)],
            "maxsegs":2,
            "type":linker.DynamicArea}
    
    def banked2flat(self, bank, addr):
        """Convert a Gameboy bank number and Z80 address to a flat ROM address."""
        if addr > 0x7FFF and addr < 0xA000 and bank < 2:
            return (bank * 0x2000 + addr - 0x8000, "VRAM")
        elif addr > 0xBFFF and addr < 0xE000 and bank < 8:
            if addr < 0xC000:
                bank = 0
            else:
                addr -= 0x1000
            
            addr -= 0xC000
            return (bank * 0x1000 + addr, "WRAM")
        else:
            return super(BaseSystem, self).banked2flat(bank, addr)

class DMG(BaseSystem):
    WRAM = {"segsize":0x2000,
            "views":[(0xC000, 0)],
            "maxsegs":1,
            "type":linker.DynamicArea}
    VRAM = {"segsize":0x2000,
            "views":[(0x8000, 0)],
            "maxsegs":1,
            "type":linker.DynamicArea}
    
    def banked2flat(self, bank, addr):
        """Convert a Gameboy bank number and Z80 address to a flat ROM address."""
        if addr > 0x7FFF and addr < 0xA000:
            return (addr - 0x8000, "VRAM")
        elif addr > 0xBFFF and addr < 0xE000:
            return (addr - 0xC000, "WRAM")
        else:
            return super(BaseSystem, self).banked2flat(bank, addr)

MAPPERLIST = {"flat":(FlatMapper, None),
    "mbc1":(MBC1Mapper, None),
    "mbc2":(MBC2Mapper, None),
    "mbc3":(MBC3Mapper, None),
    "mbc5":(MBC5Mapper, None)}

VARIANTLIST = {"dmg":(DMG, MAPPERLIST),
    "gb":(DMG, MAPPERLIST),
    "cgb":(CGB, MAPPERLIST),
    "gbc":(CGB, MAPPERLIST)}

def GameboyLinker(variant1, variant2):
    class GameboyLinkerInstance(linker.Linker, variant1, variant2):
        pass
    
    return GameboyLinkerInstance

def flat2banked(flataddr):
    """Convert a flat address to a Gameboy Bank number and Z80 address."""

    bank = math.floor(flataddr / 0x4000)
    addr = flataddr - bank * 0x4000

    if bank > 0:
        addr += 0x4000

    return (bank, addr)

#this is all dead code :/

Z80INT = struct.Struct("<H")
Z80CHAR = struct.Struct("<B")

class ROMImage(object):
    class ROMBank (object):
        """File-like object wrapper for banked ROM accesses."""
        def __init__(self, parent, fileobj, bank = 0, mbcver = 3):
            self.__parent = parent
            self.__fobj = fileobj
            self.__open = True
            self.__bank = bank
            self.__fptr = 0
            self.__mbcver = mbcver

        def __makerange(self, nbytes):
            hbegin = 0
            hsize = 0
            bbegin = 0
            bsize = 0

            if self.__fptr < 0x4000:
                hbegin = self.__fptr
                if self.__fptr + bytes > 0x3FFF:
                    hsize = 0x4000 - hbegin
                    bbegin = banked2flat(self.__bank, 0x4000, self.__mbcver)
                    bsize = min(bytes - hsize, 0x4000)
                else:
                    hsize = bytes
            elif self.__fptr < 0x8000:
                bbegin = banked2flat(self.__bank, self.__fptr, self.__mbcver)
                bsize = min(bytes, 0x8000 - self.__fptr)

            return (hbegin, hsize, bbegin, bsize)

        def close(self):
            #I don't need this, but...
            self.__open = False
            self.__fobj.flush()

        def flush(self):
            if not self.__open:
                raise ValueError()
            
            self.__fobj.flush()

        def next(self):
            #Not implemented just yet...
            raise NotImplemented()

        def read(self, bytes):
            if not self.__open:
                raise ValueError()
            
            (hbegin, hsize, bbegin, bsize) = self.__makerange(bytes)

            returned = b""
            if hsize > 0:
                self.__fobj.seek(hbegin, os.SEEK_BEGIN)
                returned += self.__fobj.read(hsize)

            if bsize > 0:
                self.__fobj.seek(bbegin, os.SEEK_BEGIN)
                returned += self.__fobj.read(bsize)

            self.__fptr += hsize + bsize
            return returned

        def seek(self, offset, whence):
            if not self.__open:
                raise ValueError()
            
            if whence == os.SEEK_BEGIN:
                self.__fptr = offset
            elif whence == os.SEEK_END:
                self.__fptr = 0x8000 + offset
            elif whence == os.SEEK_CUR:
                self.__fptr += offset
            else:
                raise ValueError()

        def tell(self):
            if not self.__open:
                raise ValueError()
            
            return self.__fptr

        def write(self, target):
            if not self.__open:
                raise ValueError()
            
            (hbegin, hsize, bbegin, bsize) = self.__makerange(target.size())
            
            if hsize > 0:
                self.__fobj.seek(hbegin, os.SEEK_BEGIN)
                returned += self.__fobj.write(target[0:hsize])

            if bsize > 0:
                self.__fobj.seek(bbegin, os.SEEK_BEGIN)
                returned += self.__fobj.write(target[hsize:hsize+bsize])
    
    def __init__(self, fileobj, mbcver = 3):
        self.__fileobj = fileobj
        self.__mbcver  = mbcver

    def bank(self, banknum = 0):
        """Get a file-like object that reads and writes to a particular ROM bank.

        The returned file object will show the HOME bank at 0x4000 and the selected bank at 0x8000."""
        return ROMImage.ROMBank(self, self.__fileobj, banknum, self.__mbcver)
        
