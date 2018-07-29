import struct

#Used by the original text injector script to represent special codes.
class Special():
    def __init__(self, byte, default=0, bts=1, end=False, names=None, redirect=False, base=16):
        self.byte = byte
        self.default = default
        self.bts = bts
        self.end = end
        self.redirect = redirect
        self.base = base
        self.names = names if names else {}

specials = {}
specials["&"] = Special(0xe5, bts=2, names={0xc92c: "name", 0xd448: "num"})
specials['S'] = Special(0xe3, default=2)
specials['*'] = Special(0xe1, end=True)
specials['O'] = Special(0xec, bts=2, redirect=True)
specials['D'] = Special(0xe9, base=10)
specials['P'] = Special(0xed, base=10) #not present in base ROM

def measure_string(encoded_string, metrics):
    """Given an encoded string, return a measure of it's width."""
    measure = 0

    for encbyte in encoded_string:
        measure += metrics[encbyte]

    return measure

def encode_string(string, charmap):
    """Given a string of text, convert it to encoded text."""
    encoded_string = []

    for char in string:
        try:
            encoded_string.append(charmap[char])
        except KeyError:
            print("Warning: Character 0x{0:x} does not exist in current ROM.\n".format(ord(char)))
            encoded_string.append(charmap["?"])

    return bytes(encoded_string)

def parse_string(string, known_tokens):
    """Given text with formatting opcodes, tokenize it.

    The tokenized text consists of a list of strings and control codes. Each
    string represents a run of raw text from the translation file. Each control
    code is a token representation of a particular formatting instruction,
    which may be encoded or interpreted as necessary.

    The expected format of each control code must be provided in known_tokens.
    known_tokens must consist of a dictionary whose keys are control code
    tokens and whose values are Special objects. See the definition of Special
    for more information on how control codes are configured

    The exact Python representation of a control code consists of a tuple whose
    first item is the control code token, and whose remaining tokens are
    arguments. Control code arguments may consist of integers, strings, or
    nested tokenstreams."""

    tokenstream = []

    special = ""
    unspecial = []
    skip_sentinel = False

    for char in string:
        if skip_sentinel:
            skip_sentinel = False
            continue

        if special:
            if char in ">»": #End of a control code.
                special = special[1:]
                is_literal = True

                try:
                    special_num = int(special, 16)
                except ValueError:
                    is_literal = False

                #TODO: This exists specifically for the "D" literal.
                #Can we generalize this to any defined special whose token is
                #also a valid hexdigit?
                if is_literal and not special.startswith("D"):
                    if special_num > 255:
                        print("Warning: Invalid literal special {} (0x{:3x})".format(special_num, special_num))
                        continue

                    tokenstream.append(bytes([special_num]))
                else:
                    token = special[0]
                    if token not in list(known_tokens.keys()):
                        print("Warning: Invalid control code: ")
                        for char in token:
                            print("{0:x}".format(ord(char)))
                        print("\n")
                        print("Found in line " + string + "\n")
                        special = ""
                        continue

                    s = known_tokens[token]
                    val = special[1:]

                    for value, name in list(s.names.items()):
                        if name == val:
                            val = value
                            break
                    else:
                        if val[:2] == "0x":
                            val = int(val[2:], 16)
                        else:
                            val = int(val, s.base)

                    if val == "":
                        val = s.default

                    if s.end:
                        end_sentinel = True

                    if val is not None and val != "":
                        tokenstream.append((token, s, val))
                    else:
                        tokenstream.append((token, s))

                special = ""
            else:
                special += char
        else:
            if char == "\\":
                skip_sentinel = True

            if char in "<«":
                special = char

                if len(unspecial) > 0:
                    tokenstream.append("".join(unspecial))
                    unspecial = []
            else:
                if char in "\r":
                    #Fix CRLF-based files parsed on LF operating systems.
                    #NOTE: Breaks on Mac OS 9 and lower. Who cares?
                    continue

                unspecial.append(char)

    if len(unspecial) > 0:
        tokenstream.append("".join(unspecial))
        unspecial = []

    return tokenstream

memory_widths = {}
memory_widths[0xd448] = 3*8
memory_widths[0xccc1] = 2*8
memory_widths[0xccc3] = 1*8
memory_widths[0xccc5] = 1*8
memory_widths[0xccc7] = 1*8
memory_widths[0xccc9] = 1*8
memory_widths[0xcccb] = 1*8
memory_widths[0xcccd] = 1*8
memory_widths[0xcccf] = 1*8
memory_widths[0xccd1] = 1*8

def format_tokenstream(tokenstream, charmap, metrics, window_width, window_height, memory_widths):
    """Given a tokenstream, modify it such that no line exceeds a maximum width.

    The metrics given must be in the form of a dict whose keys are encoded
    bytes and whose values are pixel widths. memory_widths is a mapping of
    memory locations to pixel widths (intended to be the longest possible
    string fit in there).

    Returned value is another tokenstream matching the input tokenstream but
    with all strings encoded and lines broken into acceptable widths. Control
    code tokens will have widths calculated for them based on their values and
    lines will be divided taking those widths into account. (e.g. a control
    code reading text from a memory buffer known for being 8 characters wide
    will be formatted as a 64 pixel word)"""

    new_tokenstream = []

    encoded_space = encode_string(" ", charmap)
    encoded_newline = encode_string("\n", charmap)
    encoded_space_px = measure_string(encoded_space, metrics)

    line_px = 0
    newline_count = 0
    is_final_line = newline_count % window_height == (window_height - 1)
    max_px = window_width - 8 if is_final_line else window_width

    #TODO: Should these be class methods instead of closures?
    def increment_line():
        line_px = 0
        newline_count += 1
        is_final_line = newline_count % window_height == (window_height - 1)
        max_px = window_width - 8 if is_final_line else window_width

    def process_word(encoded_word):
        encoded_word_px = measure_string(encoded_word, metrics)

        new_tokenstream.append(encoded_word)

        if (line_px + encoded_word_px + encoded_space_px) > max_px:
            #Insert a newline.
            new_tokenstream.append(encoded_newline)
            increment_line()
        else:
            new_tokenstream.append(encoded_space)
            line_px += encoded_word_px + encoded_space_px

    for token in tokenstream:
        if type(token) == string:
            #Divide the string into lines and words; encode them; add them to
            #the wordbuffer. We have to split by lines so that manual newlines
            #reset the automatic formatting logic.
            for index, line in token.split("\n").enumerate():
                if index > 0:
                    new_tokenstream.append(encoded_newline)
                    increment_line()

                for word in line.split(" "):
                    encoded_word = encode_string(word, charmap)
                    process_word(encoded_word)
        elif type(token) == bytes:
            #We've been given an already encoded bytestream. Perhaps we've been
            #fed our own output, or this is just an encoded control code.
            #Either way, we should treat it normally.
            for index, line in token.split(encoded_newline).enumerate():
                if index > 0:
                    new_tokenstream.append(encoded_newline)
                    increment_line()

                for encoded_word in line.split(encoded_space):
                    process_word(encoded_word)
        elif type(token) == tuple:
            #Okay, this is an actual control code.
            cctoken = token[0]
            if cctoken == "&": #Memory buffer reference
                if token[2] in memory_widths:
                    word_px += memory_widths[token[2]]
                else:
                    word_px += 8*8

            new_tokenstream.append(token)

    return new_tokenstream

def pack_text(string, known_tokens, charmap, metrics, window_width, window_height, memory_widths, do_not_terminate = False):
    #Sanity check: Empty strings indicate aliases.
    #TODO: Should we more explicitly notate these, instead of just specialcasing
    #them? There's precisely one table in Telefang that has about 10 messages
    #with no content that just point to the end of the block.
    if string == "":
        return b""
    
    tokenstream = parse_string(string, known_tokens)
    
    if metrics:
        tokenstream = format_tokenstream(tokenstream, charmap, metrics, window_width, window_height, memory_widths)
    
    encstream = []
    stream_is_terminated = do_not_terminate

    for token in tokenstream:
        if type(token) == str:
            encstream.append(encode_string(token, charmap))
        elif type(token) == bytes:
            encstream.append(token)
        else:
            encstream.append(bytes([token[1].byte]))

            if token[1].bts and len(token) > 2:
                fmt = "<" + ("", "B", "H")[token[1].bts]
                encstream.append(struct.pack(fmt, token[2]))

            if token[1].end:
                stream_is_terminated = True

    if not stream_is_terminated:
        encstream.append(b"\xe1\x00")

    return b"".join(encstream)
