from CodeModule import cmodel
from CodeModule.asm import linker
from CodeModule.cmd import logged
from CodeModule.asm.asmotor import _argfunc  #TODO: make patch execution generic

class Rgb6LimitExpr(cmodel.Struct):
    lolimit = cmodel.LeS32
    hilimit = cmodel.LeS32

    __order__ = ["lolimit", "hilimit"]

class Rgb6PatchExpr(cmodel.Union):
    __tag__ = cmodel.Enum(cmodel.U8,
                          "ADD", "SUB", "MUL", "DIV", "MOD", "UNSUB",
                          ("OR", 0x10), "AND", "XOR", "UNNOT",
                          ("LOGAND", 0x21), "LOGOR", "LOGUNNOT",
                          ("LOGEQ", 0x30), "LOGNE", "LOGGT", "LOGLT", "LOGGE", "LOGLE",
                          ("SHL", 0x40), "SHR",
                          ("BANK_SYM", 0x50), "BANK_SECT", "BANK_SELF",
                          ("HRAM", 0x60),
                          ("CONST", 0x80), "SYM")

    RANGECHECK = Rgb6LimitExpr
    CONST = cmodel.LeU32
    SYM = cmodel.LeU32
    BANK_SYM = cmodel.LeU32
    BANK_SECT = cmodel.String("ascii")

class Rgb6Patch(cmodel.Struct):
    srcfile = cmodel.String("ascii")
    srcline = cmodel.LeU32
    patchoffset = cmodel.LeU32
    patchtype = cmodel.Enum(cmodel.U8, "BYTE", "LE16", "LE32", "BE16", "BE32")

    numpatchexprs = cmodel.LeU32
    patchexprs = cmodel.Array(Rgb6PatchExpr, "numpatchexprs", countType = cmodel.BytesCount)

    __order__ = ["srcfile", "srcline", "patchoffset", "patchtype", "numpatchexprs", "patchexprs"]

class Rgb6SectionData(cmodel.Struct):
    data = cmodel.Blob("datasize")
    numpatches = cmodel.LeU32
    patches = cmodel.Array(Rgb6Patch, "numpatches")

    __order__ = ["data", "numpatches", "patches"]

class Rgb6Section(cmodel.Struct):
    name = cmodel.String("ascii") #utf-8 might be safe here...
    datasize = cmodel.LeU32
    sectype = cmodel.Enum(cmodel.U8, "WRAM0", "VRAM", "ROMX", "ROM0", "HRAM", "WRAMX", "SRAM", "OAM")
    org = cmodel.LeS32
    bank = cmodel.LeS32
    align = cmodel.LeS32
    datsec = cmodel.If("sectype", lambda x: x in [2, 3], Rgb6SectionData)

    __order__ = ["name", "datasize", "sectype", "org", "bank", "align", "datsec"]

class Rgb6SymValue(cmodel.Struct):
    filename = cmodel.String("ascii")
    fileline = cmodel.LeU32
    sectionid = cmodel.LeU32
    value = cmodel.LeU32

    __order__ = ["filename", "fileline", "sectionid", "value"]

class Rgb6Symbol(cmodel.Struct):
    name = cmodel.String("ascii")
    symtype = cmodel.Enum(cmodel.U8, "LOCAL", "IMPORT", "EXPORT")
    value = cmodel.If("symtype", lambda x: x not in [1], Rgb6SymValue)

    __order__ = ["name", "symtype", "value"]

class Rgb6(cmodel.Struct):
    magic = cmodel.Magic(b"RGB6")
    numsyms = cmodel.LeU32
    numsects = cmodel.LeU32

    symbols = cmodel.Array(Rgb6Symbol, "numsyms")
    sections = cmodel.Array(Rgb6Section, "numsects")

    __order__ = ["magic", "numsyms", "numsects", "symbols", "sections"]

_gnummap = {0:"BSS", 1:"VRAM", 2:"CODE", 3:("HOME", 0), 4:"HRAM"}

#Used to communicate if you want a symbol's value or it's bank
SymValue = 0
SymBank = 1

class FixInterpreter(object):
    """Fix-up patch interpreter for RGBDS object format."""
    def __init__(self, symLookup):
        """Create a patch interpreter."""
        self.__symLookup = symLookup
        self.__stack = []

    @property
    def value(self):
        return self.__stack[-1]

    @property
    def complete(self):
        return len(self.__stack) == 1
#"ADD", "SUB", "MUL", "DIV", "MOD", "NEGATE", "OR", "AND", "XOR", "NOT", "BOOLNOT", "CMPEQ", "CMPNE", "CMPGT", "CMPLT", "CMPGE", "CMPLE", "SHL", "SHR", "BANK", "FORCE_HRAM", "FORCE_TG16_ZP", "RANGECHECK", ("LONG", 0x80), ("SymID", 0x81))
    SUB = _argfunc(2)(lambda x,y: x-y)
    ADD = _argfunc(2)(lambda x,y: x+y)
    XOR = _argfunc(2)(lambda x,y: x^y)
    OR  = _argfunc(2)(lambda x,y: x|y)
    AND = _argfunc(2)(lambda x,y: x&y)
    SHL = _argfunc(2)(lambda x,y: x<<y)
    SHR = _argfunc(2)(lambda x,y: x>>y)
    MUL = _argfunc(2)(lambda x,y: x*y)
    DIV = _argfunc(2)(lambda x,y: x//y) #the one thing python3 would do worse on :P
    MOD = _argfunc(2)(lambda x,y: x%y)

    @_argfunc(2)
    def BOOLNOT(x, y):
        if x == 0:
            return 1
        else:
            return 0

    CMPGE = _argfunc(2)(lambda x,y: int(x >= y))
    CMPGT = _argfunc(2)(lambda x,y: int(x > y))
    CMPLE = _argfunc(2)(lambda x,y: int(x <= y))
    CMPLT = _argfunc(2)(lambda x,y: int(x < y))
    CMPEQ = _argfunc(2)(lambda x,y: int(x == y))
    CMPNE = _argfunc(2)(lambda x,y: int(x != y))

    def RANGECHECK(self, instr):
        tocheck = self.__stack.pop()
        if tocheck < instr.__contents__.hilimit and tocheck > instr.__contents__.lolimit:
            self.__stack.push(tocheck)
        else:
            raise InvalidPatch

    def LONG(self, instr):
        self.__stack.append(instr.__contents__)

    def SymID(self, instr):
        self.__stack.append(self.__symLookup(SymValue, instr.__contents__))

    def BANK(self, instr):
        self.__stack.append(self.__symLookup(SymBank, instr.__contents__))

    @_argfunc(1)
    def FORCE_HRAM(val):
        if val > 0xFEFF and val < 0x10000:
            return val & 0xFF
        else:
            raise InvalidPatch

    @_argfunc(1)
    def FORCE_TG16_ZP(val):
        if val > 0x1FFF and val < 0x2100:
            return val & 0xFF
        else:
            raise InvalidPatch

class RGBDSLinker(linker.Linker):
    @logged("objparse")
    def loadTranslationUnit(logger, self, filename):
        """Load the translation music and attempt to add the data inside to the linker"""
        with open(filename, "rb") as fileobj:
            objobj = Rgb6()
            objobj.load(fileobj)

            logger.debug("Loading translation unit %(txl)r" % {"txl":objobj.core})

            sectionsbin = {}
            secmap = []

            for section in objobj.sections:
                bankfix = section.bank
                orgfix = section.org

                stype = _gnummap[section.sectype]
                if type(stype) == tuple:
                    bankfix = stype[1]
                    stype = stype[0]

                groupdescript = self.platform.GROUPMAP[stype]

                if bankfix == -1:
                    bankfix = None

                if orgfix == -1:
                    orgfix = None

                marea = None
                if type(groupdescript) == str:
                    marea = groupdescript
                else:
                    bankfix = groupdescript[1]
                    marea = groupdescript[0]

                secDat = None
                if section.datsec is not None:
                    secDat = section.datsec.data

                logger.debug("Adding section fixed at (%(bank)r, %(org)r)" % {"org":orgfix, "bank":bankfix})

                secdescript = linker.SectionDescriptor(filename, None, bankfix, orgfix, marea, secDat, (objobj, section))
                self.addsection(secdescript)

    def extractSymbols(self, sectionsList):
        """Returns a list of Symbol Descriptors."""
        symList = []
        fileslist = set()
        files2sec = {}

        for secdesc in sectionsList:
            fileslist.add(secdesc.sourceobj[0])

            if secdesc.sourceobj[0] not in files2sec.keys():
                files2sec[secdesc.sourceobj[0]] = {}

            secidx = secdesc.sourceobj[0].sections.index(secdesc.sourceobj[1])
            files2sec[secdesc.sourceobj[0]][secidx] = secdesc

        for fileobj in fileslist:
            for symbol in fileobj.symbols:
                if symbol.symtype is Rgb6Symbol.IMPORT:
                    for secidx, secdesc in files2sec[fileobj].items():
                        symList.append(linker.SymbolDescriptor(symbol.name, linker.Import, None, None, None, secdesc))
                else:
                    secdesc = None
                    if symbol.value.sectionid in files2sec[fileobj].keys():
                        secdesc = files2sec[fileobj][symbol.value.sectionid]

                    bfix = None
                    try:
                        bfix = secdesc.bankfix
                    except AttributeError:
                        pass

                    ourLimit = None
                    if symbol.symtype is Rgb6Symbol.LOCAL:
                        ourLimit = secdesc.srcname

                    symList.append(linker.SymbolDescriptor(symbol.name, linker.Export, ourLimit, bfix, symbol.value.value, secdesc))

        return symList

    def evalPatches(self, secDesc):
        """Given a section, evaluate all of it's patches and apply them.

        The method operates primarily by side effects on section, thus it returns
        the same."""
        section = secDesc.sourceobj[1]
        curpatch = None
        def symLookupCbk(mode, arg):
            """Special callback for handling lookups from the symbol interpreter."""
            symbol = section.symbols[arg]
            if mode is SymValue:
                return self.resolver.lookup(section.name, symbol.name).value
            elif mode is SymBank:
                return self.resolver.lookup(section.name, symbol.name).section.bankfix

        for patch in section.datsec.patches:
            curpatch = patch
            interpreter = FixInterpreter(symLookupCbk)
            for opcode in patch.expression:
                getattr(interpret, opcode.__tag__)(opcode)

            if not interpreter.complete:
                raise InvalidPatch

            if patch.patchtype is Rgb6Patch.BYTE:
                secDesc.data[offset] = interpreter.value & 255
            elif patch.patchtype is Rgb6Patch.LE16:
                secDesc.data[offset] = interpreter.value & 255
                secDesc.data[offset + 1] = (interpreter.value >> 8) & 255
            elif patch.patchtype is Rgb6Patch.BE16:
                secDesc.data[offset + 1] = interpreter.value & 255
                secDesc.data[offset] = (interpreter.value >> 8) & 255
            elif patch.patchtype is Rgb6Patch.LE32:
                secDesc.data[offset] = interpreter.value & 255
                secDesc.data[offset + 1] = (interpreter.value >> 8) & 255
                secDesc.data[offset + 2] = (interpreter.value >> 16) & 255
                secDesc.data[offset + 3] = (interpreter.value >> 24) & 255
            elif patch.patchtype is Rgb6Patch.BE32:
                secDesc.data[offset + 3] = interpreter.value & 255
                secDesc.data[offset + 2] = (interpreter.value >> 8) & 255
                secDesc.data[offset + 1] = (interpreter.value >> 16) & 255
                secDesc.data[offset] = (interpreter.value >> 24) & 255

        return secDesc
