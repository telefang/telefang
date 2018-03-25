"""Django.db.model-esque API for defining structs."""
import math, collections
from CodeModule.exc import CorruptedData, InvalidSchema, PEBKAC #these are just empty Exception subclasses

class CField(object):
    def __init__(self, name = None, container = None, *args, **kwargs):
        if name is not None:
            self.__fieldname = name
        
        self.__container = container
        super(CField, self).__init__(*args, **kwargs)

    def extSuper(self, exobject):
        """Helper function: Get super of an object we don't know the class of.

        Not to be used to call a function of the same name as yourself."""
        if "__bases__" in exobject.__dict__.keys():
            #this is a class
            return super(exobject, exobject)
        else:
            return super(exobject.__class__, exobject)
    
    def find_argument_field(self, argfieldname):
        """Given a dynamic argument name, return the field instance.

        This function is the basis of the *_dynamic_argument functions. It
        returns a CField object directly."""
        argcontainer = self.__container

        while argcontainer != None:
            try:
                return argcontainer.__getfield(argfieldname)
            except:
                argcontainer = argcontainer.__container

        #Only raised if the argument field requested does not exist
        raise AttributeError

    def alter_dynamic_argument(self, argfieldname, callback):
        arg = self.find_argument_field(argfieldname)
        newarg = callback(arg.core)
        arg.core = newarg

    def get_dynamic_argument(self, argfieldname):
        v = self.find_argument_field(argfieldname).core
        return v

    def set_dynamic_argument(self, argfieldname, newval):
        self.alter_dynamic_argument(argfieldname, lambda x: newval)

    def reparent(self, name = None, container = None):
        #Not sure if this is still needed; since I've eliminated almost all code
        #which moves CFields around between structures/lists.
        if self.__container is not None and container is not None:
            #you must first remove the current container before adding a new one
            #this prevents you from putting the same data in two places
            raise RuntimeError

        if name is None:
            del self.__fieldname
        else:
            self.__fieldname = name

        self.__container = container
    
    def save(self, fileobj):
        """Default implementation of file encoding/saving.
        
        Most CField subclasses can just define the bytes property, and we'll
        just save it automatically."""
        fileobj.write(self.bytes)
    
    def load(self, fileobj):
        """Default implementation of file parsing/loading.
        
        CField subclasses that can define bytelength before having been loaded,
        i.e. everything that is not a null-terminated string, and have a bytes
        property, can just use this implementation.
        
        If you cannot guarantee the length of a field, make bytelength raise an
        exception when called before loading, and override this load method."""
        obytes = fileobj.read(self.bytelength)
        self.bytes = obytes
    
    def parsebytes(self, obytes):
        """Default implementation of byte string parsing.
        
        Like CField.load, fields that don't know their size until after they
        have been parsed should override parsebytes with a proper parser for
        that field type.
        
        CField.parsebytes is equivalent to CField.load, but for byte strings
        instead of files. The byte string equivalent to CField.save is the bytes
        property.
        
        The bytes property may have a setter. In this case, the setter method
        property should only accept properly formatted input with no extra bytes
        while parsebytes may accept said input with extra bytes, so long as it
        returns any bytes it does not need."""
        self.bytes = obytes[0:self.bytelength]
        return obytes[self.bytelength:-1]

    #When this is declared True, Struct and Union will attempt to hide the field
    #entirely from user code by returning the core property in getattribute.
    #If it's False, then the field will not be hidden, so that users may access
    #it's subfields.
    
    #We have PRIMITIVE because in most cases we don't want users moving CFields
    #around directly. CFields exist mainly as wrappers around native Python data
    #objects and users should be working with those. Declaring PRIMITIVE = False
    #indicates that your object has subfields useful to it's users.
    PRIMITIVE = True

def Magic(magicbytes):
    class MagicInstance(CField):
        def load(self, fileobj):
            fbytes = fileobj.read(len(magicbytes))
            self.bytes = fbytes
        
        @property
        def bytes(self):
            return magicbytes
        
        @bytes.setter
        def bytes(self, obytes):
            if obytes == magicbytes:
                return
            else:
                raise CorruptedData
        
        def parsebytes(self, obytes):
            omagic = obytes[0:len(magicbytes)]
            self.bytes = omagic
            return obytes[len(magicbytes):-1]
        
        @property
        def core(self):
            return magicbytes
        
        @core.setter
        def core(self, val):
            if val != magicbytes:
                raise CorruptedData

    return MagicInstance

def String(encoding = "utf-8", terminator = "\u0000"):
    class StringInstance(CField):
        def __init__(self, *args, **kwargs):
            self.__corestr = ""
            super(StringInstance, self).__init__(*args, **kwargs)
        
        def load(self, fileobj):
            corestr = []
            while True:
                ltr = fileobj.read(1)
                corestr.append(ltr)
                if (ltr == b"\x00"):
                    break
            self.bytes = b"".join(corestr)
        
        @property
        def core(self):
            return self.__corestr

        @core.setter
        def core(self, val):
            self.__corestr = val
        
        @property
        def bytes(self):
            return self.__corestr.encode(encoding) + b"\x00"
        
        @bytes.setter
        def bytes(self, inbytes):
            if inbytes[-1] != 0:
                raise CorruptedData
            self.__corestr = inbytes[0:-1].decode(encoding)
        
        @property
        def bytelength(self):
            raise PEBKAC #Strings are always variable length null-terminated,
                         #and thus cannot have a bytelength
        
        def parsebytes(self, obytes):
            corestr = []
            overindex = 0
            
            for i in range(0, len(obytes)):
                ltr = obytes[i]
                corestr += ltr
                if (ltr == b"\x00"):
                    overindex = i + 1
                    break
            
            self.bytes = "".join(corestr)
            return obytes[overindex:-1]
        
        def __str__(self):
            return self.core
    return StringInstance

def UnterminatedString(sizeParam, encoding = "utf-8", allow_decoding_failure = False):
    """Create an instance of a known-length, non-terminated string field.
    
    allow_decoding_failure: If decoding a bytestring fails, type will act as a Blob."""
    #Assumes countType = ByteCount for now, add support for EntriesCount later
    class UnterminatedStringInstance(CField):
        def __init__(self, *args, **kwargs):
            self.__corestr = ""
            super(UnterminatedStringInstance, self).__init__(*args, **kwargs)
        
        def load(self, fileobj):
            count = sizeParam
            if type(sizeParam) is not int:
                count = self.get_dynamic_argument(sizeParam)
            
            self.bytes = fileobj.read(count)
        
        @property
        def core(self):
            return self.__corestr

        @core.setter
        def core(self, val):
            if type(val) is bytes:
                self.bytes = val
            else:
                self.bytes = val.encode(encoding)
        
        @property
        def bytes(self):
            if type(self.__corestr) is not bytes:
                return self.__corestr.encode(encoding)
            else:
                return self.__corestr
        
        @bytes.setter
        def bytes(self, inbytes):
            try:
                if self.bytelength != len(inbytes):
                    self.set_dynamic_argument(sizeParam, len(inbytes))
                    self.__corestr = inbytes.decode(encoding)
                else:
                    self.__corestr = inbytes.decode(encoding)
            except UnicodeDecodeError:
                if allow_decoding_failure:
                    if self.bytelength != len(inbytes):
                        self.set_dynamic_argument(sizeParam, len(inbytes))
                        self.__corestr = inbytes
                    else:
                        self.__corestr = inbytes
                else:
                    raise
        
        @property
        def bytelength(self):
            count = sizeParam
            if type(sizeParam) is not int:
                count = self.get_dynamic_argument(sizeParam)
            
            return count
        
        def parsebytes(self, obytes):
            count = sizeParam
            if type(sizeParam) is not int:
                count = self.get_dynamic_argument(sizeParam)
            
            self.bytes = obytes[:count]
            return obytes[count:-1]
        
        def __str__(self):
            return self.core
    
    return UnterminatedStringInstance

LittleEndian = 0            # 0x12345678 = b'\x78\x56\x34\x12'
BigEndian = 1               # 0x12345678 = b'\x12\x34\x56\x78'
NetworkEndian = BigEndian

Unsigned = 0                # Binary integers interpreted directly
SignedTwos = Signed = 1     # High bit on means absolute value is complement of lower bits, plus one
SignedOnes = 2              # High bit on means absolute value is complement of lower bits
SignedMagnitude = 3         # High bit on means absolute value is all lower bits

def Int(size, endianness = BigEndian, signedness = Unsigned):
    """Integer parsing class factory.

    It's result can also be subclassed. If you are writing a variable-int subclass,
    set size - 1 and override ALL parsing functions."""
    bytecount = math.floor(size / 8)
    if size % 8 is not 0 and size is not -1:
        raise InvalidSchema #we only support byte-aligned ints for now
        
    decomp  = pow(2,size)
    bitmask = pow(2,size) - 1
    highbit = pow(2,size - 1)

    if (size == -1): #support for var-int subclasses
        bitmask = -1

    class IntInstance(CField):
        """Class which parses ints of arbitrary size, endianness, and sign format."""
        def __init__(self, *args, **kwargs):
            self.__coreint = 0
            self.__lengthlock = None
            self.__lengthparam = None
            super(IntInstance, self).__init__(*args, **kwargs)
        
        def load(self, fileobj):
            bytes = fileobj.read(bytecount)
            self.bytes = bytes

        def __int__(self):
            return self.__coreint
        
        def tie_to_length(self, length, param = None):
            """Establish a relationship between this integer and the length of some parameter.
            
            When this relationship is established, the int will be locked to the
            length of this parameter. All attempts to change it will fail.
            
            This is important for the implementation of the Array field, which
            requires that it's size argument equal it's actual size for correct
            structure encoding.
            
            The lock will break if the field is made to parse new data; this
            indicates that a new structure is going to be parsed and thus the
            tied field must be updated with the new data."""
            self.__lengthlock = length
            self.__lengthparam = param
        
        @property
        def core(self):
            if self.__lengthlock is not None:
                if self.__lengthparam is not None:
                    return len(self.__lengthlock.__getattribute__(self.__lengthparam))
                return len(self.__lengthlock)
            return self.__coreint
        
        @core.setter
        def core(self, val):
            #If we have a length-lock, all attempts to write to the field with
            #invalid data will fail.
            if self.__lengthlock is not None and self.__lengthparam is not None \
                and val != len(self.__lengthlock.__getattribute__(self.__lengthparam)):
                raise CorruptedData
            if self.__lengthlock is not None and val != len(self.__lengthlock):
                raise CorruptedData
            self.__coreint = val & bitmask
        
        @property
        def bytes(self):
            data = b''
            
            formattedint = self.__coreint
            if self.__lengthlock is not None:
                if self.__lengthparam is not None:
                    formattedint = len(self.__lengthlock.__getattribute__(self.__lengthparam))
                else:
                    formattedint = len(self.__lengthlock)
            
            if self.__coreint < 0:
                if signedness is Unsigned:
                    #You can't write negative integers to an unsigned field.
                    raise CorruptedData
                elif signedness is SignedTwos:
                    formattedint = ~abs(formattedint) + 1
                elif signedness is SignedOnes:
                    formattedint = ~abs(formattedint)
                elif signedness is SignedMagnitude:
                    formattedint = formattedint + highbit
            
            if endianness == LittleEndian:
                for i in range(0, bytecount):
                    data += bytes(chr(formattedint >> i * 8 & 0xFF), "raw_unicode_escape")
            else:
                for i in range(bytecount, 0, -1):
                    data += bytes(chr(formattedint >> (i - 1) * 8 & 0xFF), "raw_unicode_escape")

            return data
        
        @bytes.setter
        def bytes(self, obytes):
            self.bytesetter(obytes)
        
        def bytesetter(self, obytes):
            """MASSIVE HACK used so that Enum can set IntInstance.bytes from within Enum.bytes.setter."""
            
            self.__lengthlock = None
            self.__lengthparam = None
            
            result = 0
            if endianness is LittleEndian:
                stride = 1
                begin = 0
                end = bytecount
            if endianness is BigEndian:
                stride = -1
                begin = bytecount - 1
                end = -1

            for i in range (begin, end, stride):
                result = result + (obytes[i] << i*8)

            if result & highbit != 0:
                if signedness is Unsigned:
                    pass
                elif signedness is SignedTwos:
                    #since ints are infinitely big 2s compliment, just shifting the bytes in will not
                    #give us a negative number since we started with a positive number, and thus py3k will
                    #sign extend that erronous highbit foreer. so instead we bitwise decode it to unsigned
                    #and arithmetically negate it to change the high bit
                    result = result - decomp
                elif signedness is SignedOnes:
                    result = result - bitmask
                elif signedness is SignedMagnitude:
                    result = -(result - highbit)
            
            self.__coreint = result
            
            return obytes[bytecount:]
        
        def parsebytes(self, obytes):
            self.bytes = obytes[0:bytecount]
            return obytes[bytecount:-1]
        
        @property
        def bytelength(self):
            return bytecount

    return IntInstance

LeU8 = BeU8 = U8 = Int(8)
LeU16 = Int(16, LittleEndian)
BeU16 = Int(16, BigEndian)
LeU24 = Int(24, LittleEndian)
BeU24 = Int(24, BigEndian)
LeU32 = Int(32, LittleEndian)
BeU32 = Int(32, BigEndian)
LeS8 = BeS8 = Int(8, signedness = Signed)
LeS16 = Int(16, LittleEndian, Signed)
BeS16 = Int(16, BigEndian, Signed)
LeS24 = Int(24, LittleEndian, Signed)
BeS24 = Int(24, BigEndian, Signed)
LeS32 = Int(32, LittleEndian, Signed)
BeS32 = Int(32, BigEndian, Signed)

EntriesCount = 0 # Array size is in number of instances of the contained type
BytesCount = 1   # Array size is in number of encoded bytes in the underlying datablob
ParseToEOF = 2   # Array is continuously parsed until some bytes before EOF.

def Array(containedType, sizeParam, countType = EntriesCount, *args, **kwargs):
    """Array class factory.

    CModel arrays can have multiple count types:

    EntriesCount - Parse a specific number of entries from sizeParam
    BytesCount - Parse a specific number of bytes from sizeParam
    ParseToEOF - Parse until sizeParam bytes left in the file

    sizeParam can be an integer (for fixed-size arrays) or the name of another
    previously-parsed integer parameter in the cmodel.Struct."""
    class ArrayInstance(CField, list):
        def __init__(self, *args, **kwargs):
            super(ArrayInstance, self).__init__(*args, **kwargs)
            self.__uniqid = 0
            
            if countType is BytesCount:
                if type(sizeParam) is str:
                    self.find_argument_field(sizeParam).tie_to_length(self, "bytes")
            elif countType is EntriesCount:
                if type(sizeParam) is str:
                    self.find_argument_field(sizeParam).tie_to_length(self)
            
        def load(self, fileobj):
            scount = sizeParam
            if type(sizeParam) is not int:
                scount = self.get_dynamic_argument(sizeParam)
            
            if countType is BytesCount:
                endLoc = scount + fileobj.tell()
                
                while fileobj.tell() < endLoc:
                    item = containedType()
                    self.append(item)
                    
                    oldLoc = fileobj.tell()
                    item.load(fileobj)
                    
                    if oldLoc == fileobj.tell():
                        #Child types are REQUIRED to consume at least one byte
                        #in byte-counted array mode.
                        raise InvalidSchema
                
                if type(sizeParam) is str:
                    self.find_argument_field(sizeParam).tie_to_length(self, "bytes")
            elif countType is EntriesCount:
                for i in range(0, scount):
                    item = containedType()
                    self.append(item)
                    
                    item.load(fileobj)
                if type(sizeParam) is str:
                    self.find_argument_field(sizeParam).tie_to_length(self)
            elif countType is ParseToEOF:
                #determine end position
                curpos = fileobj.tell()
                fileobj.seek(scount, whence=SEEK_END)
                endpos = fileobj.tell()
                fileobj.seek(curpos, whence=SEEK_SET)
                lastpos = fileobj.tell()

                while curpos < endpos:
                    lastpos = curpos
                    item = containedType()
                    self.append(item)
                    
                    item.load(fileobj)
                    curpos = fileobj.tell()
                    if lastpos == curpos:
                        raise InvalidSchema #we MUST consume SOME bytes in this mode
                
                if curpos > endpos:
                    raise CorruptedData #we overwrote some other data

        def save(self, fileobj):
            for thing in self:
                thing.save(fileobj)
        
        #The following three items exist specifically to ensure field objects
        #don't escape their parent structures, just the data.
        def __getitem__(self, key):
            #Uncoerce field into core data. Does not support slicing yet.
            if super(ArrayInstance, self).__getitem__(key).PRIMITIVE != False:
                return super(ArrayInstance, self).__getitem__(key).core
            else:
                #If this is an array of structs, do not core them.
                return super(ArrayInstance, self).__getitem__(key)

        def __setitem__(self, key, value):
            super(ArrayInstance, self).__getitem__(key).core = value
        
        def __delitem__(self, key):
            super(ArrayInstance, self).__delitem__(key)
        
        def append(self, item):
            if type(item) != containedType:
                #Arrays, unlike Python lists, can only contain one type
                #We'll try to coerce the input into a real type by wrapping it
                nitem = containedType()
                nitem.core = item
                item = nitem
            
            itemname = str(self.__uniqid)
            self.__uniqid += 1
            super(ArrayInstance, self).append(item)
            
            item.reparent(itemname, container = self)
        
        def extend(self, otherlist):
            for item in otherList:
                self.append(self, item)
        
        def __add__(self, item):
            self.extend(item)
            return self
        
        def __radd__(self, item):
            self.extend(item)
            return self
        
        def __iadd__(self, item):
            self.extend(item)
            return self
        
        @property
        def bytes(self):
            childbytes = []
            for thing in self:
                childbytes.append(thing.bytes)
            return b"".join(childbytes)
        
        @property
        def bytelength(self):
            return len(self.bytes)
        
        def parsebytes(self, obytes):
            scount = sizeParam
            if type(sizeParam) is not int:
                scount = self.get_dynamic_argument(sizeParam)
            
            if countType is EntriesCount:
                items = scount
                for i in range(0,items):
                    if (len(obytes) == 0):
                        #We ran out of data before parsing was complete.
                        raise CorruptedData
                
                    childItem = containedType()
                    self.append(childItem)
                    obytes = childItem.parsebytes(obytes)
                
                if type(sizeParam) is str:
                    self.find_argument_field(sizeParam).tie_to_length(self)
                return obytes
            elif countType is BytesCount:
                bytecount = scount
                mybytes = obytes[:bytecount]
                while len(mybytes) > 0:
                    #Just keep parsing until we run out of bytes.
                    childItem = containedType()
                    self.append(childItem)
                    
                    oldcount = len(mybytes)
                    mybytes = childItem.parsebytes(mybytes)
                    
                    if oldcount == len(mybytes):
                        #All Array subtypes must consume at least ONE byte.
                        #If the contained type is empty, then parsing it again
                        #won't do anything and we will infinitely-loop until
                        #we run out of memory.
                        raise InvalidSchema
                
                if type(sizeParam) is str:
                    self.find_argument_field(sizeParam).tie_to_length(self, "bytes")
                return obytes[bytecount:]
            elif countType is ParseToEOF:
                mybytes = b""
                if scount is 0:
                    mybytes = obytes
                else:
                    mybytes = obytes[:-(scount)]

                while len(mybytes) > 0:
                    childItem = containedType()
                    self.append(childItem)
                    
                    oldcount = len(mybytes)
                    mybytes = childItem.parsebytes(mybytes)
                    
                    if oldcount == len(mybytes):
                        raise InvalidSchema
                return obytes[-(scount):]
        
        @property
        def core(self):
            """Core property for ArrayInstance.

            Implemented by repacking the whole ArrayInstance into a normal list."""
            normallist = []
            for item in self:
                normallist.append(item.core)
            
            return normallist

        @core.setter
        def core(self, normallist):
            del self[:]
            
            for item in normallist:
                self.append(item)
        
        #Since this CField is a subtype of list, it doubles as a native Python
        #object and thus should be exposed to the user
        PRIMITIVE = False
    
    return ArrayInstance

def Blob(sizeParam):
    class BlobInstance(CField):
        def __init__(self, *args, **kwargs):
            self.__obytes = b""
            if type(sizeParam) is int:
                self.__obytes = bytes(sizeParam)
            
            super(BlobInstance, self).__init__(*args, **kwargs)
        
        def load(self, fileobj):
            count = sizeParam
            if type(sizeParam) is not int:
                count = self.get_dynamic_argument(sizeParam)
            
            self.bytes = fileobj.read(count)
        
        @property
        def bytes(self):
            return self.__obytes
        
        @bytes.setter
        def bytes(self, obytes):
            if len(obytes) != len(self.__obytes):
                #WARNING: Assumes non-fixed-length field.
                #If fixed-length, do not send irregularly sized data
                self.set_dynamic_argument(sizeParam, len(obytes))
                self.__obytes = obytes
            else:
                self.__obytes = obytes
        
        def parsebytes(self, obytes):
            count = sizeParam
            if type(sizeParam) is not int:
                count = self.get_dynamic_argument(sizeParam)
            
            self.bytes = obytes[0:count]
            return obytes[count:-1]
        
        @property
        def core(self):
            return self.bytes
        
        @core.setter
        def core(self, nbytes):
            if type(sizeParam) is not int:
                self.set_dynamic_argument(sizeParam, len(nbytes))
                self.bytes = nbytes
            else:
                if count > len(nbytes):
                    self.bytes = nbytes[:count] + bytes(count - len(nbytes))
                else:
                    self.bytes = nbytes[:count]
        
        @property
        def bytelength(self):
            if type(sizeParam) is not int:
                return self.get_dynamic_argument(sizeParam)
            else:
                return sizeParam
    
    return BlobInstance

def If(variableName, condition, basetype = None, *args, **kwargs):
    """Creates IF-Fields, which only exist if a condition is satisfied in external data.
    
    Can be called in one of two ways:
    
    If("name-of-variable", lambda var: var > 256, OtherType)
    
    where there is a single variablename which is looked up and passed to the
    callable to determine if OtherType should be parsed, or in this way:
    
    If(lambda pStruct: pStruct.group > 0, OtherType)
    
    where the variablename is omitted and """
    
    ctxtprov = lambda s, vn: s.get_dynamic_argument(vn)
    
    if basetype == None:
        basetype = condition
        condition = variableName
        variableName = None
        
        ctxtprov = lambda s, vn: s._CField__container
    
    base = None
    if (len(args) == 0 and len(kwargs) == 0):
        base = basetype
    else:
        base = basetype(*args, **kwargs)
    
    class IfInstance(base):
        """Conditional load class that turns into an empty value if an external condition is unfulfilled."""
        def load(self, fileobj):
            if condition(ctxtprov(self, variableName)):
                super(IfInstance, self).load(fileobj)
        
        def save(self, fileobj):
            if condition(ctxtprov(self, variableName)):
                super(IfInstance, self).save(fileobj)
        
        @property
        def core(self):
            if condition(ctxtprov(self, variableName)):
                return super(IfInstance, self).core
            else:
                return None

        @core.setter
        def core(self, val):
            if condition(ctxtprov(self, variableName)):
                super(IfInstance, self).core = val

        @property
        def bytes(self):
            if condition(ctxtprov(self, variableName)):
                return super(IfInstance, self).bytes
            else:
                return b""

        @bytes.setter
        def bytes(self, val):
            if condition(ctxtprov(self, variableName)):
                super(IfInstance, self).bytesetter(val)
        
        def parsebytes(self, obytes):
            if condition(ctxtprov(self, variableName)):
                return super(IfInstance, self).parsebytes(obytes)
    
    return IfInstance

class EmptyField(CField):
    """Base field class for all fields that do not actually parse bytes from the structure."""
    def load(self, fileobj):
        pass

    @property
    def bytes(self):
        return b""

    @bytes.setter
    def bytes(self, obytes):
        if len(obytes) > 0:
            raise CorruptedData
    
    def parsebytes(self, obytes):
        return obytes
    
    @property
    def core(self):
        return None

def BitRange(targetParam, fromBits, toBits):
    """Define a range of bits shadowed from another field.

    The BitRange itself takes up no space, it just reparses existing, already parsed data."""
    lomask = pow(2, fromBits) - 1
    bitmask = pow(2, toBits) - 1 - lomask
    clearmask = -1 - bitmask
    if toBits is -1:
        bitmask = -1 - lomask
        clearmask = lomask
    
    #TODO: Make bitrange lock it's targetParam integer
    class BitRangeInstance(EmptyField):
        @property
        def core(self):
            basebits = self.get_dynamic_argument(targetParam)
            ourbits = (basebits & bitmask) >> fromBits
            return ourbits
        
        @core.setter
        def core(self, newbits):
            basebits = self.get_dynamic_argument(targetParam)
            ourbits = ((newbits << toBits) & bitmask) | (basebits & clearmask)
            self.set_dynamic_argument(targetParam, ourbits)

    return BitRangeInstance

def Bias(targetParam, biasFactor):
    """Define a field based on another field that returns the first field's value, incremented by a bias value."""
    class BiasInstance(EmptyField):
        @property
        def core(self):
            basebits = self.get_dynamic_argument(targetParam)
            ourbits = basebits + biasFactor
            return ourbits
        
        @core.setter
        def core(self, newbits):
            ourbits = newbits - biasFactor
            self.set_dynamic_argument(targetParam, ourbits)

def Enum(storageType, *valueslist, **kwargs):
    """Class factory for the Enum field type.
    
    Notably, this function is responsible for allocating enum values.
    
    You can control enum allocation by specifying iotaUpdate, which is called
    after each unspecified enum value to select a new one. By default this
    increments the enum value so that enum values are allocated in-order."""
    iota = 0
    valuesDict = {}
    iotaUpdate = None
    
    try:
        iotaUpdate = kwargs["iotaUpdate"]
    except:
        #By default, increment
        iotaUpdate = lambda x: x+1
    
    for value in valueslist:
        if type(value) is str:
            #insert unspecified enum values
            valuesDict[value] = iota
            iota = iotaUpdate(iota)
        else:
            #insert pre-specified enum values
            valuesDict[value[0]] = value[1]
            iota = iotaUpdate(value[1])
    
    class EnumInstance(storageType):
        """Enum class that wraps a storageType.
        
        Requires the wrapped type's values conform to the known set of enum values.
        
        This set of enum values was allocated when the field type was created."""
        @property
        def core(self):
            return super(EnumInstance, self).core
        
        @core.setter
        def core(self, val):
            """Enum core.fset that restricts input values"""
            if val not in valuesDict.values():
                raise CorruptedData
            
            storageType.core.fset(self, val)
        
        @property
        def bytes(self):
            return super(EnumInstance, self).bytes
        
        @bytes.setter
        def bytes(self, val):
            """Enum bytes.fset that validates parsed data"""
            oldCore = self.core
            self.bytesetter(val)
            
            if self.core not in valuesDict.values():
                raise CorruptedData
        
        #This exports values into the parent structure, for convenience
        EXPORTEDVALUES = valuesDict
    
    return EnumInstance

class _CFieldDecl(type):
    """[Super, meta] X class for all declarative types."""
    def __new__(mcls, name, bases, cdict):
        #All declarative types have subfields
        cdict["PRIMITIVE"] = False
        return super(_CFieldDecl, mcls).__new__(mcls, name, bases, cdict)

class _Struct(_CFieldDecl):
    """Metaclass for all Struct types.
    
    It is responsible for taking the static variables in the structure and
    moving them outside of the class namespace, and taking the exported variables
    from certain fields and placing them in the class namespace (i.e. for enums)"""
    DEFAULT_BASE_MADE = False
    def __new__(mcls, name, bases, cdict):
        """Metaclass that copies order and the named fields into two class-mangled variables."""
        if name == "Struct" and not mcls.DEFAULT_BASE_MADE:
            #Do nothing if the Struct class hasn't been constructed yet
            mcls.DEFAULT_BASE_MADE = True
            return super(_Struct, mcls).__new__(mcls, name, bases, cdict)
        order = []
        try:
            order = cdict["__order__"]
            del cdict["__order__"]

            cfields = {}
            for fieldname in order:
                cfields[fieldname] = cdict[fieldname]
                del cdict[fieldname]
                
                try:
                    exVals = cfields[fieldname].EXPORTEDVALUES
                    cdict.update(exVals)
                except:
                    pass
        
            cdict["_Struct__order"] = order
            cdict["_Struct__fields"] = cfields
            cdict["_Struct__coretype"] = collections.namedtuple("_Struct_{}__coretype".format(name), order)
        except:
            #Check if the class is a subclass of a valid Struct, or if something
            #is up and we should bail out so that the user knows to fix his
            #Struct subclass.
            #Also, this technically does not yet support merging orders,
            #so this is really only useful for subclasses of a struct without
            #any fields. Otherwise you will have to merge your __order__ yourself.
            #TODO: Automatically merge __order__ lists in __mro__ order.
            hasvalidbase = False
            for base in bases:
                if "_Struct__order" in base.__dict__.keys():
                    hasvalidbase = True
                    #copy the superclass data into the child class
                    cdict["_Struct__order"] = base._Struct__order
                    cdict["_Struct__fields"] = base._Struct__fields
                    cdict["_Struct__coretype"] = base._Struct__coretype
            
            if not hasvalidbase:
                #Structs must either have __order__ or valid superclasses with __order__
                raise InvalidSchema
        
        return super(_Struct, mcls).__new__(mcls, name, bases, cdict)

class Struct(CField, metaclass=_Struct):
    def __init__(self, *args, **kwargs):
        self.__storage = {}
        for field in self.__order:
            self.__storage[field] = self.__fields[field](name = field, container = self)
        
        super(Struct, self).__init__(*args, **kwargs)
    
    def __getattribute__(self, name):
        if name == "_Struct__order":
            #practically I can't keep users from altering the struct order
            #without making this class twice as verbose
            #I hope the use of the PEP8-mangling will discourage that
            return super(Struct, self).__getattribute__(name)
        elif name in self.__order:
            field = self.__storage[name]
            if field.PRIMITIVE:
                return field.core
            else:
                return field
        else:
            return super(Struct, self).__getattribute__(name)

    def __setattr__(self, name, val):
        if name == "_Struct__order":
            raise CorruptedData #we really shouldn't alter the struct order so brazenly
        elif name in self.__order:
            #Since it is possible for a user program to get access to a field
            #object, we should copy core-to-core for fields and direct-to-core
            #for other Python objects.
            try:
                if "PRIMITIVE" in val.__dict__.keys():
                    self.__storage[name].core = val.core
                else:
                    self.__storage[name].core = val
            except AttributeError:
                #Not a class, just do the direct storage method
                self.__storage[name].core = val
        else:
            super(Struct, self).__setattr__(name, val)
    
    def _CField__getfield(self, name):
        """Internal function that allows CField to access fields irregardless of PRIMITIVE.
        
        While it is possible for anyone to call this, you should be discouraged
        by the use of the __variable mangling indicating that this function is
        intended for CField and CField only."""
        return self.__storage[name]
    
    def __delattr__(self, name):
        #Uh yeah, you aren't deleting stuff from structs. That would change the
        #schema, and binary formats are parsed with a fixed schema.
        raise CorruptedData

    def save(self, fileobj):
        for field in self.__order:
            self.__storage[field].save(fileobj)

    def load(self, fileobj):
        for field in self.__order:
            self.__storage[field].load(fileobj)
    
    @property
    def bytes(self):
        lisbytes = []
        for field in self.__order:
            lisbytes.append(self.__storage[field].bytes)
        
        return b"".join(lisbytes)
    
    @bytes.setter
    def bytes(self, val):
        for field in self.__order:
            val = self.__storage[field].parsebytes(val)
        
        if len(val) > 0:
            #raise an exception if the input was too big
            raise CorruptedData
    
    def parsebytes(self, obytes):
        for field in self.__order:
            obytes = self.__storage[field].parsebytes(obytes)
    
    @property
    def core(self):
        items = []
        for field in self.__order:
            items.append(self.__storage[field].core)
        return self.__coretype(*items)
    
    @core.setter
    def core(self, items):
        """Setter method for structs that accepts dictionaries or tuples."""
        if type(items) is dict:
            for key, value in items.items():
                self.__storage[key].core = value
        else:
            if len(self.__order) != len(items):
                #we need as many items as there are fields
                raise CorruptedData
            
            for item, field in zip(items, self.__order):
                self.__storage[field].core = item

ExternalTag = 0
InternalTag = 1

class _Union(_CFieldDecl):
    DEFAULT_BASE_MADE = False
    
    def __new__(mcls, name, bases, cdict):
        if name == "Union" and not mcls.DEFAULT_BASE_MADE:
            #Do nothing if the Union class hasn't been constructed yet
            mcls.DefaultBaseMade = True
            return super(_Union, mcls).__new__(mcls, name, bases, cdict)
        #The "Default" class is the type of field that gets used for the mapping
        #if the field is unspecified.
        defaultField = EmptyField
        try:
            defaultField = cdict["__defaultfield__"]
            del cdict["__defaultfield__"]
        except:
            pass
        
        #"External tag" mode is activated when __tagname__ is defined
        #When __tagname__ is defined, the value of the tag will be parsed at
        #runtime from parent structures (i.e. the dynamic arugments mechanism)
        #otherwise we run in "Internal tag" mode, where we allocate space for
        #the field ourselves.
        #You still need to declare the field type.
        try:
            tagname = cdict["__tagname__"]
            del cdict["__tagname__"]
            cdict["_Union__tagname"] = tagname
            cdict["_Union__mode"] = ExternalTag
        except:
            cdict["_Union__mode"] = InternalTag
        
        tag = cdict["__tag__"]
        del cdict["__tag__"]
        cdict["_Union__tag"] = tag
        
        #The tag type is required to export values
        #We need it to generate the type mapping. Really.
        values = tag.EXPORTEDVALUES
        reverseValues = {}
        mapping = {}
        for vname, value in values.items():
            if value in mapping.keys() and cdict[vname] is not cdict[reverseValues[value]]:
                #You are not allowed to generate two different field types
                #for the same enum value.
                raise InvalidSchema
            
            try: #Attempt to fill the mapping with the user-specified field
                mapping[value] = cdict[vname]
                del cdict[vname]
            except: #Otherwise use the default
                mapping[value] = defaultField
            
            try: #reverseValues is a dict of lists, because dicts are not
                 #guaranteed to be bijective functions
                reverseValues[value].append(vname)
            except KeyError:
                reverseValues[value] = [vname]
            
            #We also need to import any Enum values into ourself
            try:
                exVals = cfields[vname].EXPORTEDVALUES
                cdict.update(exVals)
            except:
                pass
        
        #Import the exported values from any Enums in our Union.
        cdict.update(values)
        
        cdict["_Union__mapping"] = mapping
        cdict["_Union__reverseValues"] = reverseValues
        cdict["_Union__coretype"] = collections.namedtuple("_Union_{}__coretype".format(name), ["tag", "contents"])

        #"MissingNO mode"
        #when __reparse_on_retag__ is enabled, and user code attempts to change
        #the tag, instead of erasing the child field, we instead grab it's bytes
        #and make the new tag's field attempt to parse them.
        try:
            cdict["_Union__reparse_on_retag"] = cdict["__reparse_on_retag__"]
            del cdict["__reparsable__"]
        except:
            cdict["_Union__reparse_on_retag"] = False

        return super(_Union, mcls).__new__(mcls, name, bases, cdict)

class Union(CField, metaclass = _Union):
    """Implements a tagged union.
    
    A tagged union is a type which delegates to mulitple different types based
    on a tag value, which specifies which type to delegate to.

    It can either specify the tag type and storage directly, or refer to an
    external variable for the tag."""
    def __init__(self, *args, **kwargs):
        if self.__mode is InternalTag:
            self.__tagstorage = self.__tag(name = "__tag__", container = self)
            self.__fieldstorage = None
            self.__currenttag = None
        elif self.__mode is ExternalTag:
            self.__tagstorage = self.find_argument_field(self.__tagname)
            self.__fieldstorage = self.__mapping[self.__tagstorage.core](name = "__contents__", container = self)
            self.__currenttag = self.__tagstorage.core
        
        super(Union, self).__init__(*args, **kwargs)
    
    def load(self, fileobj):
        if self.__mode is InternalTag:
            self.__tagstorage.load(fileobj)
        self.__updatestate()
        self.__fieldstorage.load(fileobj)
    
    @property
    def bytes(self):
        self.__updatestate()
        obytes = b""
        if self.__mode is InternalTag:
            obytes += self.__tagstorage.bytes
        return obytes + self.__fieldstorage.bytes
    
    def parsebytes(self, obytes):
        if self.__mode is InternalTag:
            obytes = self.__tagstorage.parsebytes(obytes)
        self.__updatestate()
        return self.__fieldstorage.parsebytes(obytes)
    
    @property
    def core(self):
        self.__updatestate()
        try:
            return self.__coretype(self.__tag__, self.__fieldstorage.core)
        except AttributeError:
            return self.__coretype(self.__tag__, None)
    
    @core.setter
    def core(self, val):
        if len(val) != 2:
            raise PEBKAC #must give two values, the tag and the contents
        
        self.__tag__ = val[0]
        self.__contents__.core = val[1]
    
    def __updatestate(self):
        """This function is called to ensure that the tag value and current field match.
        
        It is usually called when the tag or contents are accessed, to keep them synced."""
        if self.__tagstorage.core == self.__currenttag:
            return #nothing needs to be done
        
        if self.__currenttag is None:
            #Tag was not parsed at __init__
            #It better have been parsed by now!!
            self.__currenttag = self.__tagstorage.core
            self.__fieldstorage = self.__mapping[self.__tagstorage.core](name = "__contents__", container = self)
        
        newval = self.__tagstorage.core
        if self.__mapping[self.__currenttag] is not self.__mapping[newval]:
            if self.__reparse_on_retag:
                #"MissingNO" mode (bytewise reparse)
                #You have to declare __reparse_on_retag__ = True in your class
                #since this is a behavior 99% of users DON'T want.
                oldfield = self.__fieldstorage
                self.__fieldstorage = self.__mapping[newval](name = "__contents__", container = self)
                
                #new fields may throw out bytes.
                self.__fieldstorage.parsebytes(oldfield.bytes)
            else:
                self.__fieldstorage = self.__mapping[newval](name = "__contents__", container = self)
        
        self.__currenttag = newval

    def __getattribute__(self, name):
        if name.startswith("_Union"):
            #psuedoprivate variables are accessed directly
            return super(Union, self).__getattribute__(name)
        elif name == "__tag__":
            #__tag__ is a special member
            self.__updatestate()
            return self.__tagstorage.core
        elif name == "__contents__":
            #__contents__ will give you the current tag
            self.__updatestate()
            if self.__fieldstorage.PRIMITIVE:
                return self.__fieldstorage.core
            else:
                return self.__fieldstorage
        elif name in self.__mapping.keys():
            #naming a field will let you access that field, regardless of the
            #current tag
            if name not in self.__reverseValues[self.__tag__]:
                #check if accessing this field would cause a field change, and
                #if so, change the tag.
                self.__tag__ = self.__mapping[name]
            return self.__contents__
        else:
            #User variable or class/user function
            return super(Union, self).__getattribute__(name)

    def __setattr__(self, name, val):
        if name.startswith("_Union"):
            #psuedoprivates are specialcased to avoid recursion
            super(Union, self).__setattr__(name, val)
        elif name == "__tag__":
            #setting __tag__ forces the field to change
            self.__tagstorage.core = val
            self.__updatestate()
        elif name == "__contents__":
            self.__updatestate()

            try:
                if "PRIMITIVE" in val.__dict__.keys():
                    self.__fieldstorage.core = val.core
                else:
                    self.__fieldstorage.core = val
            except AttributeError:
                #Not a class, just do the direct storage method
                self.__fieldstorage.core = val
        elif name in self.__tagstorage.EXPORTEDVALUES.keys():
            tagvalue = self.__tagstorage.EXPORTEDVALUES[name]
            if self.__tag__ != tagvalue:
                self.__tag__ = tagvalue
            self.__contents__ = val
        else:
            super(Union, self).__setattr__(name, val)
