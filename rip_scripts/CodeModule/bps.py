"""BPS patch format module.

Includes linker writeout module."""

from CodeModule import cmodel
from CodeModule.asm import linker
from math import ceil

class VarInt(cmodel.Int(-1)):
    """Like Py3K, BPS also uses variable size integers."""
    def load(self, fileobj):
        continueParse = 1
        data = 0
        while continueParse is 1:
            newbyte = fileobj.read(1)
            data = data << 7 + (newbyte & 0x7F)
            continueParse = newbyte >> 7

        self.core = data
    
    @property
    def bytes(self):
        data = self.core
        bytesCount = ceil(data.bit_length / 7)
        bytesDat = b""
        for i in range(0, bytesCount):
            highbit = 0x80
            if i is bytesCount - 1:
                highbit = 0x00

            bytesDat += bytes((data & 0x7F) + highbit, "raw_unicode_escape")
            data = data >> 7

        return bytesDat

    def __decode(self, obytes):
        continueParse = 1
        data = 0
        while continueParse is 1:
            newbyte = obytes[0]
            obytes = obytes[1:]
            data = data << 7 + (newbyte & 0x7F)
            continueParse = newbyte >> 7
        
        return (obytes, data)
    
    def bytesetter(self, obytes):
        #TODO: Rethink Int.bytesetter hack, should varints be enumable?
        #For right now, varints replicate the bytesetter hack.
        (obytes, data) = self.__decode(obytes)
        
        if len(obytes) > 0:
            raise CorruptedData
        
        self.core = data

    def parsebytes(self, obytes):
        (obytes, data) = self.__decode(obytes)
        
        self.core = data
        return obytes

    @property
    def core(self):
        return self.__coreint

    @core.setter
    def core(self, varint):
        self.__coreint = varint

class PatchSrcRead(cmodel.Struct):
    __length = cmodel.BitField("cmdLength", 2, -1)
    length = cmodel.Bias("__length", 1)

class PatchTgtRead(cmodel.Struct):
    __length = cmodel.BitField("cmdLength", 2, -1)
    length = cmodel.Bias("__length", 1)
    data = cmodel.Blob("length")

class PatchCopyCmd(cmodel.Struct):
    __length = cmodel.BitField("cmdLength", 2, -1)
    length = cmodel.Bias("__length", 1)
    offset = VarInt

class PatchUnion(cmodel.Union):
    __tag__ = cmodel.Enum(cmodel.BitField("cmdLength", 0, 2), "SRC_READ", "TGT_READ", "SRC_COPY", "TGT_COPY")

    SRC_READ = PatchSrcRead
    TGT_READ = PatchTgtRead
    SRC_COPY = PatchCopyCmd
    TGT_COPY = PatchCopyCmd

class PatchEntry(cmodel.Struct):
    cmdLength = VarInt
    command = PatchUnion

class BPSPatchStruct(cmodel.Struct):
    magic = cmodel.Magic(b"BPS1")
    srcSize = VarInt
    targetSize = VarInt
    metadataSize = VarInt
    metadata = cmodel.String("utf-8") #This is also XML, consider adding cmodel.XML?
    patchData = cmodel.Array(PatchEntry, 12, cmodel.ParseToEOF)
    srcChksum = cmodel.LeU32
    tgtChksum = cmodel.LeU32
    chksum = cmodel.LeU32

def applyPatch(src, patch, tgt):
    bps = BPSPatchStruct()
    bps.load(patch)

    tgtBytesCnt = 0
#UNFINISHED CODE   
#    for command in 

class Writeout(linker.Writeout):
    def __init__(self, srcrom):
        pass
