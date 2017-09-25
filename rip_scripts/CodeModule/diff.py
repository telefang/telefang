"""File differencing (patch) handling"""
from binascii import crc32
import os

class CRC32File(object):
    """File-like file wrapper object that computes CRC32 over all read/written data."""
    def __init__(self, basefile):
        self.base = basefile
        self.crc = 0
    
    def write(self, bytes):
        self.base.write(bytes)
        self.crc = crc32(bytes, self.crc)

    def writelines(self, lines):
        self.base.writelines(lines)

        for line in lines:
            self.crc = crc32(line, self.crc)

    def read(self, count = None):
        bytes = None

        if count is None:
            bytes = self.base.read()
        else:
            bytes = self.base.read(count)
        
        self.crc = crc32(bytes, self.crc)
        return bytes

    def readline(self, count = None):
        bytes = None

        if count is None:
            bytes = self.base.readline()
        else:
            bytes = self.base.readline(count)
        
        self.crc = crc32(bytes, self.crc)
        return bytes

    def readlines(self, counthint = None):
        lines = None

        if count is None:
            lines = self.base.readline()
        else:
            lines = self.base.readline(counthint)
        
        for line in lines:
            self.crc = crc32(lines, self.crc)
        
        return lines

    def seek(self, count, whence):
        self.base.seek(count, whence)

    def tell(self):
        return self.base.tell()

    def truncate(self, count = None):
        if count is None:
            self.base.truncate()
        else:
            self.base.truncate(count)

    def close(self):
        self.base.close()

    def flush(self):
        self.base.close()

    def next(self):
        line = self.base.next()
        self.crc = crc32(line, self.crc)
        return line

    def __iter__(self):
        return self

def produceDirectPatch(copyplan, baserom, patchrom, targetrom):
    """Build a complete ROM directly, from the copyplan, base, and patch.
    
    The base ROM is the target for patching. Patch ROM contains bytes to alter.
    Target ROM is where the patched ROM goes."""

    baserom.seek(0, os.SEEK_END)
    size = baserom.tell()
    baserom.seek(0, os.SEEK_SET)
    bytes = baserom.read(size)
    patchrom.write(bytes)
    
    for copy in copyplan:
        targetrom.seek(copy[0], os.SEEK_SET)
        patchrom.seek(copy[0], os.SEEK_SET)
        
        bytes = targetrom.read(copy[1])
        patchrom.write(bytes)
