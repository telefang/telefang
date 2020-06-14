

def format_int(i):
    if i < 0x10: #Small numbers lack the 0x
        return "{0:x}".format(i)
    else: #Large numbers are hex
        return "0x{0:x}".format(i)

def format_hex(i):
    if i < 0x10: #Small numbers lack the 0x
        return "{0:x}".format(i)
    else: #Large numbers are hex
        return "0x{0:x}".format(i)

def format_section(name, flataddr):
    """Format a section macro for the assembler."""
    return "SECTION \"%s\", %s\n" % (name, format_sectionaddr_rom(flataddr))

def format_sectionaddr_rom(flataddr):
    """Format a flat address for the assembler's section macro."""
    if (flataddr < 0x4000):
        return "ROM0[${0:x}]".format(flataddr)
    else:
        return "ROMX[${0:x}], BANK[${1:x}]".format(0x4000 + flataddr % 0x4000, flataddr // 0x4000)
    
def format_symbol(symbol_name, is_export = False):
    """Format a symbol, to be placed right before the data it's referencing."""
    if is_export:
        return symbol_name + "::\n"
    else:
        return symbol_name

def format_bytes(data):
    """Format bytes as a list of `db` instructions."""
    if len(data) > 0:
        return "    db %s\n" % (", ".join(["$%x" % byte for byte in data]))
    else:
        return ""

def format_directives(directives):
    """Format a list of one or more directives.

    Directives can be a list or tuple of the following types of data:
    
     - `bytes`, which will be directly included into the target ROM
     - `str`, which will be treated as already-formatted RGBDS instructions.
    
    Passing anything other than a list or type into here will cause it to be
    treated as a singleton tuple."""

    srcdata = ""
    if not isinstance(directives, tuple) and not isinstance(directives, list):
        directives = (directives,)
    
    for directive in directives:
        if isinstance(directive, bytes):
            srcdata += format_bytes(directive)
        elif isinstance(directive, str):
            srcdata += "    %s\n" % (directive)
    
    return srcdata


def format_control_code(cc, word = None):
    """Format a control code."""
    string = []
    
    string.append("«")
    string.append(cc)
    
    if word != None:
        string.append(format_int(word))
    
    string.append("»")
    
    return "".join(string)

def format_literal(chara, charmap = None):
    """Format a literal character."""
    if charmap is not None and chara in charmap:
        return charmap[chara]
    
    string = []
    
    string.append("«")
    string.append(format_int(chara))
    string.append("»")
    
    return "".join(string)