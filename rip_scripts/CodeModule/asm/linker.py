"""Generic linker implementation

This is a generic linker for both flat-addressing and bank-mapping systems.

"Flat-addressing" systems are ones where all data is stored in a single memory
space, separated into different memory areas (i.e. ROM, RAM, hardware, etc)

"Bank-mapping" systems are systems where some or all areas can be remapped, mid
execution, to another compatible same-size segment. Each possible segment for a
given memory area is assigned a bank number.

The linker takes a description of the target machine, and each assembled section
of the target. The linking process consists of:

 1. Fixation
 
   Sections of the assembled source are assigned memory locations (and, perhaps,
bank numbers) in such a way that no two sections overlap. If two sections do
overlap, this is an error and the linker quits.

   Additionally, fixated segments that export labels are also assigned concrete
values for those exported labels.

 2. Symbol Resolution
 
   Fixed memory locations are propagated into section symbols, and imported
symbols are fixed to the value of the matching exported symbol.

 3. Patching

   Locations within the assembled sections which symbolically referred to
labels in other sections are corrected to reflect the results of the fixation
process.

 4. Writeout
   Each memory area is now considered as a single unit. Bank segments
within a particular memory area are merged; in such a way that each segment is
the same size as the memory area it will be mapped into. Every memory area
corresponding to pre-specified code or data is provided in a separate stream.

   Writeout targets all "permenant" memory areas, which are typically code and
constant data. "Dynamic" memory areas, which are loaded at runtime, are merely
fixated; it is the job of the permenant code sections to load it with data.

   Writeout can be performed by any plugin; the linker provides a Writeout
plugin with a stream for each fully linked permenant memory area as well as a
list of all assembled locations."""

import bisect, heapq
from CodeModule.exc import FixationConflict, OutOfSegmentSpace, PEBKAC
from CodeModule.cmd import logged
from collections import namedtuple

FixBanksFirst  = 0
FixOrgsFirst   = 1

class Fixator(object):
    """A class for managing memory allocations on a fixed-size memory area separated into one or more segments.

    This class is used primarily in the linker's fixation process; it only
    manages memory allocations. You tell it about sections with the addSection
    method, then call fixate to assign sections. Finally, you can get a mapping
    between each section and it's bank and memory address."""
    
    def __init__(self, segmentsize, segids, *args, **kwargs):
        """Create a new Fixator object, with a particular set of segments.
        
        Segments are hot-swappable parts of memory. They can be of arbitrary
        size and are identified with a number called a SegID. SegIDs need not be
        continuously numbered."""
       #Here's how the bankbucket system works
       #None contains all non bank-fixed sections
       #+i contains all bank-fixed sections
       #the unfixed area is a priority queue of elements (size, sectionID).
       #the fixed area contains a list of allocations (begin, end, sectionID)
       #    and is sorted by base address. all allocations must not conflict,
       #    except those in bucket None, since those will be shuttled to
       #    different banks.
       #the freelist contains a list of free areas (begin, end) sorted by begin
       #    address. it is not present in bucket None since it is not a real
       #    segment.
        self.bankbuckets = {None:{"unfixed":[], "fixed":[]}}
        for i in segids:
            self.bankbuckets[i] = {"unfixed":[],
                "fixed":[],
                "freelist":[segmentsize[i]]}
        
       #Note: We allow strangely-sized segments to support exotic mappings, such
       #as the SFC's bank address mapping. Say if you had this mapping:
       # bank 00-3F $8000-$FFFF ROM
       # bank 40-7D $0000-$FFFF ROM
       #then give:
       # segsize: [ 0x8000, ..., 0x8000, 0x10000, ...]
       # segids : [      0, ...,     3F,      40, ...]
       #(I have no idea what kind of ROM mapping this would involve,
    
    def malloc(self, bukkit, size):
        """Finds a free memory location and returns the address.

        Returns an allocation object tuple; the format is:

            [begin, end)

        (i.e. take every byte from begin to end, except end)."""
        
        #Linear search from lowest address
        for memrun in bukkit["freelist"]:
            if (memrun[1] - memrun[0]) >= size:
                return (memrun[0], memrun[0] + size)
        
        raise OutOfSegmentSpace
    
    @logged("fixsects", logcalls=True)
    def fixSection(logger, self, bankfix, alloc):
        """Commit a particular memory allocation to a bucket.

        Alloc is the object you got back from malloc. Optionally, you made alloc
        yourself (say, for an orgfixed memory location.)
        
        Bukkit is the bucket to insert the allocation into.
        
        Throws exceptions if an allocation is impossible."""
        bukkit = self.bankbuckets[bankfix]
        
        #verify the allocation
        allocidx = bisect.bisect(bukkit["fixed"], (alloc[0], -1))
        
        if allocidx > 0:
            #sections were fixed before thyself
            offender = bukkit["fixed"][allocidx - 1]
            if offender[1] > alloc[0]:
                #Allocation is impossible
                raise FixationConflict
        
        if allocidx < len(bukkit["fixed"]) - 1:
            offender2 = bukkit["fixed"][allocidx + 1]
            if alloc[1] > offender2[0]:
                #Allocation is also impossible
                raise FixationConflict

        #Allocation is possible. Insert in the fixedlist, alter freelist to be accurate

        bukkit["fixed"].insert(allocidx, alloc)
        freeidx = bisect.bisect(bukkit["freelist"], (alloc[0], -1))
        if freeidx > 0 and bukkit["freelist"][freeidx - 1][0] < alloc[0]:
            freeidx -= 1
        
        oldrange = bukkit["freelist"][freeidx]
        del bukkit["freelist"][freeidx]
        
        if oldrange[0] < alloc[0]:
            bukkit["freelist"].insert(freeidx, (oldrange[0], alloc[0]))
            freeidx += 1
        
        if alloc[1] < oldrange[1]:
            bukkit["freelist"].insert(freeidx, (alloc[1], oldrange[1]))
        
        logger.debug("Committed to allocation at %(org)d in bank %(bank)d" % {"org":alloc[0], "bank":bankfix})
        
        #Commit allocation to linker segment descriptor
        alloc[2].bank = bankfix
        alloc[2].org = alloc[0]
        return alloc
    
    def addSection(self, section, **kwargs):
        """Add a section to the allocation.
        
        This function returns the ID of the section, which you should use when
        consulting the allocations list from fixate."""
        size = len(section.data)
        orgfix = section.org
        bankfix = section.bank
        
        if bankfix is not None and orgfix is not None:
            #Already-fixated section
            self.fixSection(bankfix, (orgfix, orgfix + size, section))
        elif orgfix is not None:
            #orgfixed only sections
            self.bankbuckets[bankfix]["fixed"].append((orgfix, orgfix + size, section))
        else:
            #bankfixed only or unfixed sections
            heapq.heappush(self.bankbuckets[bankfix]["unfixed"], (size, section))
    
    def fixBank(self, bukkitID):
        """For any section in a particular segment, fixate all it's unfixed sections."""
        while True:
            try:
                bukkit = self.bankbuckets[bukkitID]
                sec = heapq.heappop(bukkit["unfixed"])
                alloc = self.malloc(bukkit, sec[0])
                self.fixSection(bukkitID, (alloc[0], alloc[1], sec[1]))
            except IndexError:
                break
    
    def fixIntoOrg(self, fixRange):
        """Given a particular memory location, try to fixate it in any possible bank."""
        for bukkitID in self.bankbuckets.keys():
            if bukkitID is None:
                continue
            
            try:
                return self.fixSection(bukkitID, fixRange)
            except FixationConflict:
                continue
        
        raise FixationConflict
    
    def fixSomewhere(self, section):
        """Fix a section. Just put it somewhere!"""
        for bukkitID in self.bankbuckets.keys():
            if bukkitID is None:
                continue
            
            bukkit = self.bankbuckets[bukkitID]
            try:
                alloc = self.malloc(bukkit, section[0])
                return self.fixSection(bukkitID, (alloc[0], alloc[1], section[1]))
            except OutOfSegmentSpace:
                pass
            except FixationConflict:
                pass
        
        raise OutOfSegmentSpace
    
    def fixBanks(self):
        for bukkitID in self.bankbuckets.keys():
            if bukkitID is None:
                continue
            
            self.fixBank(bukkitID)
    
    def fixOrgs(self):
        while len(self.bankbuckets[None]["fixed"]) > 0:
            sec = self.bankbuckets[None]["fixed"].pop()
            return self.fixIntoOrg(sec)
    
    def fixUnfixed(self):
        while len(self.bankbuckets[None]["unfixed"]) > 0:
            sec = heapq.heappop(self.bankbuckets[None]["unfixed"])
            return self.fixSomewhere(sec)
    
    def fixate(self, fixorder = FixBanksFirst):
        """For any section not already fixated, fixate it.
        
        Sections are fixated in two orders. First, Orgs-first order:
        
        if fixorder is FixOrgsFirst:
            Orgfixed, non-bankfixed sections
            Bankfixed, non-orgfixed sections
            Completely nonfixed sections
        
        then, Banks-first order:
        
        if fixorder is FixBanksFirst: #occupy wall st
            Bankfixed, non-orgfixed sections
            Orgfixed, non-bankfixed sections
            Completely nonfixed sections
        
        Banks-first order is better if banks are small relative to the amount of
        data that makes sense to fit within them. In this case, banks will first
        fill up with their own data, and then afterwords we will try to fit org
        fixed sections where they may fit.
        
        Orgs-first order is better if banks are relatively big, to the amount of
        data you want to put in them. This case where there's low bank memory
        pressure is rare, but the option is there to use it."""
        
        if fixorder is FixBanksFirst:
            self.fixBanks()
            self.fixOrgs()
        elif fixorder is FixOrgsFirst:
            self.fixOrgs()
            self.fixBanks()
        
        self.fixUnfixed()

Import = 0
Export = 1

class Resolver(object):
    def __init__(self):
        self.unresolvedList = {}
        self.resolvedList = {}
        self.qwikResolve = {} #used to resolve imports, only contains exports.
    
    ResolutionEntry = namedtuple("ResolutionEntry", ["fromFile", "toFiles", "value"])

    def addSection(self, section):
        secSymbols = section.symbols
        resolved = {}
        unresolved = {}

        if section in self.unresolvedList.keys():
            unresolved = self.unresolvedList[section]
        else:
            self.unresolvedList[section] = unresolved

        if section in self.resolvedList.keys():
            resolved = self.resolvedList[section]
        else:
            self.resolvedList[section] = resolved
        
        for symbol in secSymbols:
            if symbol.type is Export:
                buk = []
                if symbol.name in self.qwikResolve.keys():
                    buk = self.qwikResolve[symbol.name]
                else:
                    self.qwikResolve[symbol.name] = buk
                
                bukEntry = Resolver.ResolutionEntry(section.srcname, symbol.limits, symbol.value)
                resolved[symbol.name] = bukEntry
                buk.append(bukEntry)
            else:
                bukEntry = Resolver.ResolutionEntry(section.srcname, symbol.limits, None)
                unresolved[symbol.name] = bukEntry
            
        self.unresolvedList[section].update(unresolved)
        self.resolvedList[section].update(resolved)

    def resolve(self):
        """Resolve all unresolved symbols, if possible."""
        for (secName, secUnresolved) in self.unresolvedList:
            for (symName, symbol) in secUnresolved:
                resolved = False
                for candidateSym in self.qwikResolve[symName]:
                    if candidateSym.toFiles is None or symbol.fromFile in candidateSym.toFiles:
                        if symbol.section is not None and symbol.section.org is not None:
                            #Symbols with an attached section are relative to the
                            #section and must be orgfixed before we can do anything.
                            symbol.value = candidateSym.value + symbol.section.org
                        elif symbol.section is None:
                            #Symbols without an attached section are defined by
                            #the assembler macrolanguage and are absolute.
                            symbol.value = candidateSym.value
                        resolved = True
                        break
                
                if not resolved:
                    #it may be tempting to throw an exception here if a symbol
                    #doesn't resolve, but that would be stupid. Example:
                    #what if the client code wants to resolve each section piecemeal?
                    continue
                else:
                    del secUnresolved[symName]
                    self.resolvedList[secName].update([(symName, symbol)])

    @property
    def unresolved(self):
        if len(self.unresolvedList.keys()) > 0:
            return True
        else:
            return False

    def lookup(self, sectionName, symbolName):
        """Given a section's and a symbol's name, return the resolved symbol.

        If the symbol has not yet been resolved or the section does not exist
        then we will raise KeyError."""
        return self.resolvedList[sectionName][symbolName]

#these aren't really respected just yet
MapIntoMemory = 0 #  GB style bank mapping
#(Views exist in local memory to access external memory spaces)
MapIntoBanks  = 1 #SNES style bank mapping
#(Entire local memory a single view to a larger memory space)

#Memory area types
PermenantArea = 0 # Memory area is part of the program and must be written out.
DynamicArea   = 1 # Memory area is altered by the program and does not persist
                  # across program shutdown and startup.
ShadowArea    = 2 # Memory area is the same as another area.
SaveArea      = 3 # Memory area is altered by the program and persists across
                  # program shutdown and startup.

class SectionDescriptor(object):
    def __init__(self, *args):
        self.srcname = args[0]
        self.name = args[1]
        self.bank = args[2]
        self.org = args[3]
        self.memarea = args[4]
        self.data = args[5]
        self.sourceobj = args[6]
        self.symbols = None

class SymbolDescriptor(object):
    def __init__(self, *args):
        self.name = args[0]
        self.type = args[1]
        self.limits = args[2]
        self.bank = args[3]
        self.value = args[4]
        self.section = args[5]

class Linker(object):
    MemGroup = namedtuple("MemGroup", ["fixator", "sections"])
    
    @logged("linker", logcalls=True)
    def __init__(logger, self, platform):
        self.groups = {None: Linker.MemGroup(None, [])}
        self.resolver = Resolver()
        self.platform = platform
        
        for marea in self.platform.MEMAREAS:
            spec = self.platform.__getattribute__(marea)
            
            if "shadows" in spec.keys():
                continue #we don't care
            
            logdata = {"marea":marea, "spec":spec}
            logger.debug("Setting up memory area %(marea)s." % logdata)
            logger.debug("Spec: %(spec)r" % logdata)
            
            staticSize = spec["segsize"]
            segCount = spec["maxsegs"]
            
            segids = []
            segsize = {}
            for i in range(0, segCount):
                segids.append(i)
                baseAddr = 0
                for view in spec["views"]:
                    if type(view[1]) is int:
                        if view[1] is i:
                            baseAddr = view[0]
                            break
                    elif view[1] is None:
                        baseAddr = view[0]
                        break
                    elif i >= view[1][0] and i <= view[1][1]:
                        baseAddr = view[0]
                        break
                else:
                    logger.error("Memory Area has an unmapped segment!")
                    raise PEBKAC
                
                segsize[i] = (baseAddr, baseAddr+staticSize)

            #Note: For right now, we only support banning whole banks
            if "unusable" in spec.keys():
                for ban in spec["unusable"]:
                    segids.remove(ban[1])
                    del segsize[ban[1]]
            
            self.groups[marea] = Linker.MemGroup(Fixator(segsize, segids), [])
    
    def addsection(self, section):
        if len(section.data) > 0:
            sid = self.groups[section.memarea].fixator.addSection(section)
        
        self.groups[section.memarea].sections.append(section)
    
    def fixate(self):
        """Fix all unfixed known sections into a single core."""
        for marea in self.platform.MEMAREAS:
            info = getattr(self.platform, marea)
            
            if marea in self.groups.keys():
                self.groups[marea].fixator.fixate()
    
    def resolve(self):
        """Resolve all symbols."""
        allsecs = []
        for marea in self.platform.MEMAREAS:
            if marea in self.groups.keys():
                allsecs.extend(self.groups[marea].sections)
        
        symbols = self.extractSymbols(allsecs)
        
        for sym in symbols:
            if sym.section.symbols == None:
                sym.section.symbols = []
            
            if sym.section.symbols.count(sym) < 1:
                sym.section.symbols.append(sym)
        
        for section in allsecs:
            self.resolver.addSection(section)

    def patchup(self):
        """Patch up all patch points."""
        for marea in self.platform.MEMAREAS:
            if marea in self.groups.keys():
                for section in self.groups[marea].sections:
                    self.evalPatches(section)

    def writeout(self, target):
        """Expose data to writeout target."""
        with target:
            for marea in self.platform.MEMAREAS:
                if marea in self.groups.keys():
                    spec = getattr(self.platform, marea)
                    target.enterStream(marea, spec)
                    for section in self.groups[marea].sections:
                        target.writeSection(section)
                    target.exitStream(marea, spec)
