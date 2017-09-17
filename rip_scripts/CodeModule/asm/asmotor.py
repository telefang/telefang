"""ASMotor support package

This parses and links ASMotor object files."""
from CodeModule.asm import linker
from CodeModule.exc import InvalidPatch
from CodeModule.cmd import logged
from CodeModule import cmodel

from math import atan2, pi, sin, cos, tan, asin, acos, atan

class SectionGroup(cmodel.Struct):
    name = cmodel.String("ascii")
    typeid = cmodel.Enum(cmodel.LeU32, "GROUP_TEXT", "GROUP_BSS")
    
    __order__ = ["name", "typeid"]

class FixupOpcode(cmodel.Union):
    __tag__ = cmodel.Enum(cmodel.LeU8, "OBJ_OP_SUB", "OBJ_OP_ADD", "OBJ_OP_XOR",
    "OBJ_OP_OR", "OBJ_OP_AND", "OBJ_OP_SHL", "OBJ_OP_SHR", "OBJ_OP_MUL",
    "OBJ_OP_DIV", "OBJ_OP_MOD", "OBJ_OP_LOGICOR", "OBJ_OP_LOGICAND",
    "OBJ_OP_LOGICNOT", "OBJ_OP_LOGICGE", "OBJ_OP_LOGICGT", "OBJ_OP_LOGICLE",
    "OBJ_OP_LOGICLT", "OBJ_OP_LOGICEQU", "OBJ_OP_LOGICNE", "OBJ_FUNC_LOWLIMIT",
    "OBJ_FUNC_HIGHLIMIT", "OBJ_FUNC_FDIV", "OBJ_FUNC_FMUL", "OBJ_FUNC_ATAN2",
    "OBJ_FUNC_SIN", "OBJ_FUNC_COS", "OBJ_FUNC_TAN", "OBJ_FUNC_ASIN",
    "OBJ_FUNC_ACOS", "OBJ_FUNC_ATAN", "OBJ_CONSTANT", "OBJ_SYMBOL", "OBJ_PCREL",
    "OBJ_FUNC_BANK")
    
    OBJ_CONSTANT = cmodel.LeU32
    OBJ_SYMBOL = cmodel.LeU32
    OBJ_FUNC_BANK = cmodel.LeU32

class FixupEntry(cmodel.Struct):
    offset = cmodel.LeU32
    #Size of the patch result, not the actual fixup operands (which are always Le32)
    patchtype = cmodel.Enum(cmodel.LeU32, "BYTE", "LE16", "BE16", "LE32", "BE32")
    exprsize = cmodel.LeU32
    expression = cmodel.Array(FixupOpcode, "exprsize", countType = cmodel.BytesCount)
    
    __order__ = ["offset", "patchtype", "exprsize", "expression"]

class SectionData(cmodel.Struct):
    data = cmodel.Blob("datasize")
    numpatches = cmodel.LeU32
    fixup = cmodel.Array(FixupEntry, "numpatches")

    __order__ = ["data", "numpatches", "fixup"]

class Symbol(cmodel.Struct):
    name = cmodel.String("ascii")
    symtype = cmodel.Enum(cmodel.LeS32, "EXPORT", "IMPORT", "LOCAL", "LOCALEXPORT", "LOCALIMPORT", ("FLAT_WHAT", -1))
    value = cmodel.If("symtype", lambda x: x in [-1, 0, 2, 3], cmodel.LeS32)
    
    __order__ = ["name", "symtype", "value"]

class Section(cmodel.Struct):
    groupid = cmodel.LeS32 #if -1, contains exported symbols only
    name = cmodel.String("ascii")
    bank = cmodel.LeS32
    org = cmodel.LeS32
    numsymbols = cmodel.LeU32
    symbols = cmodel.Array(Symbol, "numsymbols")
    datasize = cmodel.LeU32
    data = cmodel.If(lambda self: self.groupid > 0 and self._CField__container._CField__container.groups[self.groupid].typeid == SectionGroup.GROUP_TEXT, SectionData)
    
    __order__ = ["groupid", "name", "bank", "org", "numsymbols", "symbols", "datasize", "data"]

class XObj(cmodel.Struct):
    magic = cmodel.Magic(b"XOB\x00")
    numgroups = cmodel.LeU32
    groups = cmodel.Array(SectionGroup, "numgroups")
    numsections = cmodel.LeU32
    sections = cmodel.Array(Section, "numsections")
    
    __order__ = ["magic", "numgroups", "groups", "numsections", "sections"]

def asm2rad(asmDegs):
    return (asmDegs / (384 * 256)) % 1 * pi

def _argfunc(numargs):
    """Helper function that returns a decorator that wraps evaluation functions which take a certain number of arguments"""
    def decorator(op):
        """Decorator which wraps function op to look like a normal eval func.
        
        A normal eval func has the following signature:
        
            def evalOp(self, instr) --> None
            
        All operations cause side effects on the stack. On the contrary, the
        following signature is much more natural:
        
            def add(x, y) --> sum
            
        This decorator takes a number of arguments off of the stack, calls
        the wrapped function with them, and then places the result on the
        stack. If the result is not an integer than we will assume it is an
        iterable and copy all of it's elements onto the stack."""
        def decorated (self, instr):
            for i in range(0, numargs):
                args.push(self.__stack.pop())
            ret = op(*args)
            self.__stack.push(ret)
        
        return decorated
    return decorator

class ASMotorLinker(linker.Linker):
    """Linker mixin for ASMotor object file support."""
    @logged("objparse")
    def loadTranslationUnit(logger, self, filename):
        """Load the translation music and attempt to add the data inside to the linker"""
        with open(filename, "rb") as fileobj:
            objobj = XObj()
            objobj.load(fileobj)
            
            logger.debug("Loading translation unit %(txl)r" % {"txl":objobj.core})
            
            sectionsbin = {}
            secmap = []
            
            for group in objobj.groups:
                logger.debug("Adding section group %(groupname)s" % {"groupname":group.name})
                
                gid = len(secmap)
                secmap.append(group.name)
                areatoken = self.platform.GROUPMAP[group.name]
                groupname = None
                bankfix = None
                
                if type(areatoken) is not str:
                    groupname = areatoken[0]
                    bankfix = areatoken[1]
                    #basically this means if you declared the group as ("ROM", 0)
                    #then all sections in that group start at 0.
                else:
                    groupname = areatoken
                
                groupdescript = {"memarea": groupname}
                if bankfix is not None:
                    groupdescript["bankfix"] = bankfix
                
                sectionsbin[gid] = groupdescript
            
            for section in objobj.sections:
                groupdescript = None
                if section.groupid == -1 and section.datasize == 0:
                    logger.debug("Adding symbols section...")
                else:
                    #NOTE: If this crashes, and groupid is -1, please investigate
                    #the debug output from this function. It will tell you exactly
                    #how the translation unit was parsed.
                    groupdescript = sectionsbin[section.groupid]
                
                bankfix = section.bank
                orgfix = section.org
                
                if bankfix == -1:
                    bankfix = None
                
                if orgfix == -1:
                    orgfix = None
                
                if groupdescript != None and "bankfix" in groupdescript.keys():
                    bankfix = groupdescript["bankfix"]
                
                secDat = None
                if section.data is not None:
                    secDat = section.data.data
                
                marea = None
                if groupdescript != None:
                    marea = groupdescript["memarea"]
                    logger.debug("Adding section %(section)s fixed at (%(bank)r, %(org)r)" % {"section":section.name, "org":orgfix, "bank":bankfix})
                
                secdescript = linker.SectionDescriptor(filename, section.name, bankfix, orgfix, marea, section.data.data, section)
                self.addsection(secdescript)
    
    def extractSymbols(self, secdesc):
        """Takes a fixed section and returns all symbols within.
        
        Returns a list of Symbol Descriptors.
        
        Do not run this method until all symbols have been fixed."""
        objSection = secdesc.sourceobj
        symList = []
        for symbol in objSection.symbols:
            if symbol.symtype is Symbol.IMPORT:
                symList.append(linker.SymbolDescriptor(symbol.name, linker.Import, None, None, None, secdesc))
            elif symbol.symtype is Symbol.LOCALIMPORT:
                symList.append(linker.SymbolDescriptor(symbol.name, linker.Import, secdesc.srcname, None, None, secdesc))
            else:
                ourLimit = None
                if symbol.symtype is Symbol.LOCALEXPORT or symbol.symtype is Symbol.LOCAL:
                    ourLimit = secdesc.srcname
                
                symList.append(linker.SymbolDescriptor(symbol.name, linker.Export, ourLimit, secdesc.bankfix, secdesc.orgfix + symbol.value, secdesc))
        
        return symList
    
    class FixInterpreter(object):
        def __init__(self, symLookup):
            self.__symLookup = symLookup
            self.__stack = []
        
        @property
        def value(self):
            return self.__stack[-1]

        @property
        def complete(self):
            return len(self.__stack) == 1

        OBJ_OP_SUB = _argfunc(2)(lambda x,y: x-y)
        OBJ_OP_ADD = _argfunc(2)(lambda x,y: x+y)
        OBJ_OP_XOR = _argfunc(2)(lambda x,y: x^y)
        OBJ_OP_OR  = _argfunc(2)(lambda x,y: x|y)
        OBJ_OP_AND = _argfunc(2)(lambda x,y: x&y)
        OBJ_OP_SHL = _argfunc(2)(lambda x,y: x<<y)
        OBJ_OP_SHR = _argfunc(2)(lambda x,y: x>>y)
        OBJ_OP_MUL = _argfunc(2)(lambda x,y: x*y)
        OBJ_OP_DIV = _argfunc(2)(lambda x,y: x//y) #the one thing python3 would do worse on
        OBJ_OP_MOD = _argfunc(2)(lambda x,y: x%y)
        OBJ_OP_LOGICOR  = _argfunc(2)(lambda x,y: min(x|y, 1))
        OBJ_OP_LOGICAND = _argfunc(2)(lambda x,y: min(x&y, 1))
        
        @_argfunc(2)
        def OBJ_OP_LOGICNOT(x, y):
            if x == 0:
                return 1
            else:
                return 0
        
        OBJ_OP_LOGICGE  = _argfunc(2)(lambda x,y: int(x >= y))
        OBJ_OP_LOGICGT  = _argfunc(2)(lambda x,y: int(x > y))
        OBJ_OP_LOGICLE  = _argfunc(2)(lambda x,y: int(x <= y))
        OBJ_OP_LOGICLT  = _argfunc(2)(lambda x,y: int(x < y))
        OBJ_OP_LOGICEQU = _argfunc(2)(lambda x,y: int(x == y))
        OBJ_OP_LOGICNE  = _argfunc(2)(lambda x,y: int(x != y))
        
        @_argfunc(2)
        def OBJ_FUNC_LOWLIMIT(x, y):
            if (x >= y):
                raise InvalidPatch
            else:
                return x
        
        @_argfunc(2)
        def OBJ_FUNC_HIGHLIMIT(x, y):
            if (x >= y):
                raise InvalidPatch
            else:
                return x
        #TODO: Verify bitwise compatibility with XLink
        OBJ_FUNC_FDIV   = _argfunc(2)(lambda x,y: (x<<16) // y)
        OBJ_FUNC_FMUL   = _argfunc(2)(lambda x,y: (x//y) >> 16)
        OBJ_FUNC_FATAN2 = _argfunc(2)(lambda x,y: int(atan2(asm2rad(x), asm2rad(y)) * 65536))
        OBJ_FUNC_SIN    = _argfunc(1)(lambda x:   int(  sin(asm2rad(x)) * 65536))
        OBJ_FUNC_COS    = _argfunc(1)(lambda x:   int(  cos(asm2rad(x)) * 65536))
        OBJ_FUNC_TAN    = _argfunc(1)(lambda x:   int(  tan(asm2rad(x)) * 65536))
        OBJ_FUNC_ASIN   = _argfunc(1)(lambda x:   int( asin(asm2rad(x)) * 65536))
        OBJ_FUNC_ACOS   = _argfunc(1)(lambda x:   int( acos(asm2rad(x)) * 65536))
        OBJ_FUNC_ATAN   = _argfunc(1)(lambda x:   int( atan(asm2rad(x)) * 65536))

        def OBJ_CONSTANT(self, instr):
            self.__stack.append(instr.__contents__)

        def OBJ_SYMBOL(self, instr):
            self.__stack.append(self.symLookup(ASMotorLinker.SymValue, instr.__contents__))
            
        def OBJ_FUNC_BANK(self, instr):
            self.__stack.append(self.symLookup(ASMotorLinker.SymBank, instr.__contents__))

        def OBJ_FUNC_PCREL(self, instr):
            self.__stack.append(self.symLookup(ASMotorLinker.SymPCRel, instr.__contents__))
    
    #Special values used for the interpreter
    SymValue = 0
    SymBank = 1
    SymPCRel = 2
    
    def evalPatches(self, secDesc):
        """Given a section, evaluate all of it's patches and apply them.
        
        The method operates primarily by side effects on section, thus it returns
        the same."""
        section = secDesc.sourceobj
        curpatch = None
        def symLookupCbk(mode, arg):
            """Special callback for handling lookups from the symbol interpreter."""
            symbol = section.symbols[arg]
            if mode is ASMotorLinker.SymValue:
                return self.resolver.lookup(section.name, symbol.name).value
            elif mode is ASMotorLinker.SymBank:
                return self.resolver.lookup(section.name, symbol.name).section.bankfix
            elif mode is ASMotorLinker.SymPCRel:
                return curpatch.offset + section.org
        
        for patch in section.data.fixup:
            curpatch = patch
            interpreter = ASMotorLinker.FixInterpreter(symLookupCbk)
            for opcode in patch.expression:
                getattr(interpret, opcode.__tag__)(opcode)
            
            if not interpreter.complete:
                raise InvalidPatch

            if patch.patchtype is FixupEntry.BYTE:
                secDesc.data[offset] = interpreter.value & 255
            elif patch.patchtype is FixupEntry.LE16:
                secDesc.data[offset] = interpreter.value & 255
                secDesc.data[offset + 1] = (interpreter.value >> 8) & 255
            elif patch.patchtype is FixupEntry.BE16:
                secDesc.data[offset + 1] = interpreter.value & 255
                secDesc.data[offset] = (interpreter.value >> 8) & 255
            elif patch.patchtype is FixupEntry.LE32:
                secDesc.data[offset] = interpreter.value & 255
                secDesc.data[offset + 1] = (interpreter.value >> 8) & 255
                secDesc.data[offset + 2] = (interpreter.value >> 16) & 255
                secDesc.data[offset + 3] = (interpreter.value >> 24) & 255
            elif patch.patchtype is FixupEntry.BE16:
                secDesc.data[offset + 3] = interpreter.value & 255
                secDesc.data[offset + 2] = (interpreter.value >> 8) & 255
                secDesc.data[offset + 1] = (interpreter.value >> 16) & 255
                secDesc.data[offset] = (interpreter.value >> 24) & 255
            
        return secDesc
