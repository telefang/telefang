from CodeModule import gb
from CodeModule.exc import *

import os

TERMINATOR   = (0xE1, 1, "tx", ("state", [(0x00, "terminate")]))
NEWLINE      = (0xE2, 0, "newline")
UNK01        = (0xE7, 0, "unknown-seven")
UNK02        = (0xE9, 0, "unknown-nine")
TXTSPD       = (0xE3, 1, "speed", "val")
RET          = (0xE0, 0, "ret")
CALL         = (0xE5, 2, "call", "script")

#New opcodes in Telefang Eng-v84+
VWFON        = (0xEB, 0, "vwfon")
VWFOFF       = (0xEA, 0, "vwfoff")

OPCODES = {0xE0:RET, 0xE1:TERMINATOR, 0xE2:NEWLINE, 0xE3:TXTSPD, 0xE5:CALL, 0xE7:UNK01, 0xE9:UNK02, 0xEA:VWFOFF, 0xEB:VWFON}

class CtrlCode(object):
    def __init__(self, doc, op = RET, operand = None):
        self.__doc = doc
        self.__op = op
        self.__operand = operand
    
    def assemble(self):
        retstr = ""
        retstr += chr(self.__op[0])

        if self.__operand != None:
            if self.__op[1] == 2:
                retstr += chr(self.__operand & 0xFF)
                retstr += chr(floor(self.__operand / 0x100) & 0xFF)
            else:
                retstr += chr(self.__operand & 0xFF)

        return retstr

class Script(object):
    def __init__(self):
        self.__ops = []

    def write(self, text):
        if type(self.__ops[-1]) != type(""):
            self.__ops.append("")
        
        for byte in text:
            if byte > 0xE0:
                raise InvalidScript()

            self.__ops[-1] += byte

    def write_ctrlcode(self, op, oper = None):
        self.__ops.append(CtrlCode(self, op, oper))

    def __iter__(self):
        return self.__ops.__iter__()

    def disassemble(self, fileobj, start):
        """Given a fileobject and an offset, disassemble script at that location."""
        fileobj.seek(start, os.SEEK_BEGIN)
        self.__ops = []
        txt = []
    
        while True:
            ltr = fileobj.read(1)
            byte = ord(ltr)
            if byte > 0xE0:
                self.write("".join(txt))
                
                try:
                    op = OPCODES[byte]
                except KeyError:
                    raise InvalidScript()
    
                operand = None
    
                if op[1] == 1:
                    operand = ord(fileobj.read(1))
                elif op[1] == 2:
                    oplo = ord(fileobj.read(1))
                    ophi = ord(fileobj.read(1))

                    operand = ophi * 0x100 + oplo
    
                self.write_ctrlcode(op, operand)
    
                if op == TERMINATOR and operand == 00:
                    break#! c'mon! ooh! *beat* scratch-o! hey!
            else:
                txt.append(ltr)
    
        #This should never happen, since the only opcode that can stop disassembly is E1 00,
        # but just in case we'll make sure the text got added
        if len(txt) > 0:
            self.write("".join(txt))

    def assemble(self):
        """Assemble the current script into a string suitable for writing into ROM."""
        retstr = ""
        
        for tag in self:
            if type(tag) == type(""):
                retstr += tag
            else:
                retstr += tag.assemble()

        return retstr

class ScriptTable(object):
    def __init__(self, rom, baseaddr, basebank):
        self.__bank = self.__rom.bank(basebank)
        self.__basebank = basebank
        self.__baseaddr = baseaddr
        self.__rom = rom
        
        self.__scripts = []
        self.__scriptstartptr = 0x8000
        
    def __getitem__(self, key):
        return self.__scripts[key]
    
    def __setitem__(self, key, value):
        self.__scripts[key] = value
    
    def __iter__(self):
        return self.__scripts.__iter__()
        
    def disassemble(self):
        """Read a script table into memory."""
        

class ROMScript(object):
    MASTER_TABLE_PTR = 0x494F
    MASTER_TABLE_BANK = 0xB
    MASTER_TABLE_SIZE = 21
    
    def read_far_ptr(self, fobj):
        """Read a far-pointer structure, and return a z80 Pointer and MBC Bank ID."""
        ptr = gb.Z80INT.unpack(fobj.read(2))
        bank = gb.Z80CHAR.unpack(fobj.read(1))

        return (bank, ptr)

    def write_far_ptr(self, fobj, bank, ptr):
        """Write a far-pointer structure from a z80 Pointer and MBC Bank ID."""
        fobj.write(gb.Z80INT.pack(ptr))
        fobj.write(gb.Z80CHAR.pack(bank))
    
    def __init__(self, rom):
        self.__rom = rom
        self.__mastertbl = []
        self.__tables = {}
        self.__masterbank = self.__rom.bank(self.MASTER_TABLE_BANK)
    
    def __getitem__(self, key):
        return self.__tables[key]

    def __setitem__(self, key, value):
        self.__tables[key] = value

    def __iter__(self):
        return self.__tables.__iter__()

    def disassemble(self):
        #Read out the master table of string tables
        self.__masterbank.seek(self.MASTER_TABLE_PTR, os.SEEK_BEGIN)
        
        (bank, ptr) = read_far_ptr(self.__masterbank)
        
        for i in range(1, MASTER_TABLE_SIZE):
            self.__tables.append((bank, ptr))
            (bank, ptr) = read_far_ptr(self.__masterbank)

    def assemble(self):
        """Save all changes to the ROM script into the ROM."""
        self.__masterbank.seek(self.MASTER_TABLE_PTR, os.SEEK_BEGIN)
        for tblptr in self.__mastertbl:
            write_far_ptr(self.__masterbank, *tblptr)
