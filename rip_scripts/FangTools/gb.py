import struct

METATABLE_FARPTR = struct.Struct("<HB")
PTR = struct.Struct("<H")
BE_PTR = struct.Struct(">H")
CHARA = struct.Struct("<B") #Pack or be packed

def flat(bank, addr):
    if (addr < 0x4000):
        return addr

    if (addr > 0x7FFF):
        return None #Maybe raise?

    return (bank * 0x4000) + (addr - 0x4000)

def banked(flataddr):
    if (flataddr < 0x4000):
        return flataddr, 0
    
    return flataddr % 0x4000 + 0x4000, flataddr // 0x4000