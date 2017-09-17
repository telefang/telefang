from CodeModule.asm import linker
from CodeModule.cmd import logged
import os

class ROMWriteout(object):
    """A Writeout object that saves any interested streams to disk.
    
    This class relies on the platform providing a mapping from bank/addr pairs
    to file pointer / stream-name pairs."""
    def __init__(self, streams, platform, *args, **kwargs):
        """Create a basic writeout object.

        streams - A dictionary mapping between memory areas and file objects.
        If a stream does not exist then it will not be written to."""
        self.streams = streams
        self.platform = platform
        self.curFile = None
        self.streamName = None
        self.streamSpec = None
        self.interested = False
        
        super(ROMWriteout, self).__init__(*args, **kwargs)
    
    def __enter__(self):
        pass
    
    def enterStream(self, streamName, streamSpec):
        if streamName in self.streams.keys():
            if type(self.streams[streamName]) is str:
                self.curFile = open(self.streams[streamName], 'wb')
            else:
                self.curFile = self.streams[streamName]
            
            self.interested = True
        else:
            self.interested = False
        
        self.streamName = streamName
        self.streamSpec = streamSpec
    
    @logged("output")
    def writeSection(logger, self, sectionSpec):
        if not self.interested:
            return
        
        logger.debug("Writing section %(name)s out to disk with fix (%(bank)d, %(org)d)..." % sectionSpec.__dict__)
        pos = self.platform.banked2flat(sectionSpec.bank, sectionSpec.org)
        
        assert pos[1] == self.streamName
        
        self.curFile.seek(pos[0])
        self.curFile.write(sectionSpec.data)
    
    def exitStream(self, streamName, streamSpec):
        if self.curFile != None:
            self.curFile.close()
            self.curFile = None
        
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.curFile != None:
            self.curFile.close()
            self.curFile = None
        
        return False

class OverlayWriteout(ROMWriteout):
    """A Writeout object that overlays new streams over an existing base ROM."""
    def __init__(self, bases, *args, **kwargs):
        self.bases = bases
        super(OverlayWriteout, self).__init__(*args, **kwargs)
    
    def enterStream(self, streamName, streamSpec):
        #just-in-time copy from base ROM to output
        super(OverlayWriteout, self).enterStream(streamName, streamSpec)
        
        if streamName in self.bases.keys() and self.interested:
            frmname = self.bases[streamName]
            
            with open(frmname, 'rb') as frm:
                topos = self.curFile.tell()
                
                frm.seek(0, os.SEEK_END)
                frmlen = frm.tell() - topos
                
                frm.seek(topos)
                self.curFile.seek(topos)
                
                while frmlen > 0x1000:
                    frmlen -= 0x1000
                    self.curFile.write(frm.read(0x1000))
                
                self.curFile.write(frm.read(frmlen))
                
                frm.seek(topos)
                self.curFile.seek(topos)

class MapWriteout(object):
    """Writeout object that creates a report of every symbol used.
    
    This writeout object is intended to be used alongside another one and is
    primarily for programmer debug purposes."""
    def __init__(self, mapstream, platform, *args, **kwargs):
        self.mapstream = mapstream
        self.platform = platform
        self.linkerobj = None
        
        if type(self.mapstream) is str:
            self.openFile = true
        else:
            self.openFile = false
            self.mapfile = mapstream
        
        super(MapWriteout, self).__init__(*args, **kwargs)
    
    def __enter__(self, linkerobj):
        if self.openFile:
            self.mapfile = open(self.mapstream, 'w')
        
        return self
    
    def enterStream(self, streamName, streamSpec):
        self.mapstream.write("%(strn)s AREA:\n" % {"strn":streamName})

        self.streamName = streamName
        self.streamSpec = streamSpec
    
    def writeSection(self, sectionSpec):
        self.mapstream.write("\t(%(srcname)s) SECTION: %(name)s\n" % sectionSpec)
        
        for symbol in sectionSpec.symbols:
            if symbol.type is linker.Export:
                self.mapstream.write("\t\t%(bank)x:%(org)x: %(name)s\n" % sectionSpec)
        
        self.mapstream.write("\t%(size)s bytes\n" % {"size":len(sectionSpec.data)})
    
    def exitStream(self, streamName, streamSpec):
        pass
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        self.mapfile.close()
        return False
