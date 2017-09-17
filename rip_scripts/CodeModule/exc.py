class InvalidAddress(Exception):
    """Class raised when an address is invalid."""
    pass

class InvalidScript(Exception):
    """Class raised when some script input is invalid."""
    pass

class CorruptedData(Exception):
    """Exception raised when an attempt to parse data from a file fails because some sanity check failed."""
    pass

class InvalidSchema(Exception):
    """Exception raised when the specification for parsing data from a file is inconsistent or otherwise invalid."""
    pass

class PEBKAC(Exception):
    """Exception raised due to programmer error."""
    pass

class FixationConflict(Exception):
    """Exception raised when the attempted fixation of a section would cause it to occupy another section's memory."""
    pass

class OutOfSegmentSpace(Exception):
    """Exception raised when a section cannot be fixated because the enclosing segment is out of room, either due to genuine lack of space, or because of internal fragmentation from user orgfixed sections."""
    pass

class InvalidPatch(Exception):
    """Exception raised when an assembler fixup patch is malformed and does not make sense."""
    pass

class InvalidFileCombination(Exception):
    """Exception raised when multiple files are specified that cannot be used together."""
    pass

class UnknownFileType(Exception):
    """Exception raised to signal that a file could not be identified."""
    pass
