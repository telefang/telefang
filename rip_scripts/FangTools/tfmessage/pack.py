import struct, math

QUESTION_FORMATTING_WRAPPER = "QUESTION_FORMATTING_WRAPPER"
WRAPPED_STREAM_SEPARATOR = "WRAPPED_STREAM_SEPARATOR"

#Used by the original text injector script to represent special codes.
class Special():
    def __init__(self, byte, default=0, bts=1, end=False, names=None, redirect=False, base=16, wrapper=False, purpose=None):
        self.byte = byte
        self.default = default
        self.bts = bts
        self.end = end
        self.redirect = redirect
        self.base = base
        self.names = names if names else {}
        self.wrapper = wrapper
        self.purpose = purpose

specials = {}
specials["&"] = Special(0xe5, bts=2, names={0xc92c: "name", 0xd448: "num"})
specials['S'] = Special(0xe3, default=2)
specials['*'] = Special(0xe1, end=True)
specials['O'] = Special(0xec, bts=2, redirect=True)
specials['D'] = Special(0xe9, base=10)
specials['P'] = Special(0xed, base=10) #not present in base ROM
specials['Q'] = Special(None, default=None, wrapper=True, purpose=QUESTION_FORMATTING_WRAPPER)
specials['|'] = Special(None, default=None, purpose=WRAPPED_STREAM_SEPARATOR)

def measure_string(encoded_string, metrics, memory_widths):
    """Given an encoded string or tokenstream, return a measure of it's width."""
    measure = 0
    
    for encbyte in encoded_string:
        if type(encbyte) == bytes:
            measure += measure_string(encbyte, metrics, memory_widths)
            continue
        
        if type(encbyte) == tuple:
            cctoken = encbyte[0]
            if cctoken == "&": #Memory buffer reference
                if encbyte[2] in memory_widths:
                    measure += memory_widths[encbyte[2]]
                else:
                    measure += 8*8
            continue
        
        if encbyte >= 0xe0:
            #TODO: handle measuring already encoded control codes?
            continue
        
        #HACK/BUG: Special case \x00 as 7, even though we should count it as 8.
        #This is to maintain parity with a previous version of the encoder,
        #which measured literal tokens without adding the 1px of spacing between
        #characters.
        if encbyte == 0:
            measure += 7
            continue
        
        measure += metrics[encbyte] + 1

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
    
    #Current list of parsed tokens.
    tokenstream = []
    
    #Stack of parent tokenstreams. These are used when a wrapper has finished
    #consuming symbols.
    wrapper_stack = []

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
                end_wrapper = False
                
                if special.startswith("/"):
                    end_wrapper = True
                    special = special[1:]
                
                #Aliases for Bold and Normal font
                if special == "bold":
                    special = "0xF2"
                elif special == "normal":
                    special = "0xF3"
                
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

                    tokenstream.append((special_num))
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
                    
                    if val == "":
                        val = s.default
                    else:
                        for value, name in list(s.names.items()):
                            if name == val:
                                val = value
                                break
                        else:
                            if val[:2] == "0x":
                                val = int(val[2:], 16)
                            else:
                                val = int(val, s.base)
                    
                    if s.end:
                        end_sentinel = True
                    
                    if s.wrapper and not end_wrapper:
                        wrapper_stack.append(tokenstream)
                        tokenstream = []
                    
                    if s.wrapper and end_wrapper:
                        #Subtle note: The starting token gets added into the
                        #child tokenstream, so we have to dig it out and then
                        #append the rest of the stream as a variable to it.
                        starttoken = tokenstream[0]
                        argstream = tokenstream[1:]
                        tokenargs = []
                        cur_tokenarg = []
                        
                        for token in argstream:
                            if type(token) == tuple and token[1].purpose == WRAPPED_STREAM_SEPARATOR:
                                tokenargs.append(cur_tokenarg)
                                cur_tokenarg = []
                            else:
                                cur_tokenarg.append(token)
                        
                        tokenargs.append(cur_tokenarg)
                        
                        starttoken += tuple(tokenargs)
                        
                        tokenstream = wrapper_stack.pop()
                        tokenstream.append(starttoken)
                    elif val is not None and val != "":
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
memory_widths[0xccd9] = 1*8

def format_tokenstream(tokenstream, charmap, metrics, window_width, window_height, memory_widths, wrap):
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
    encoded_space_px = measure_string(encoded_space, metrics, memory_widths)

    line_px = 0
    newline_count = 0
    is_final_line = (newline_count % window_height) == (window_height - 1)
    max_px = (window_width - 8) if is_final_line else window_width

    #TODO: Should these be class methods instead of closures?
    def increment_line():
        nonlocal line_px, newline_count, is_final_line, max_px
        line_px = 0
        newline_count += 1
        is_final_line = (newline_count % window_height) == (window_height - 1)
        max_px = (window_width - 8) if is_final_line else window_width
    
    def replace_emitted_space():
        nonlocal new_tokenstream
        
        last_space = None
        
        #Reparse our old tokenstream to determine if we just emitted a space.
        for index, token in reversed(list(enumerate(new_tokenstream))):
            if type(token) is not bytes:
                break
            
            if len(token) == 0:
                continue
            
            if token[-1] == ord(encoded_space):
                last_space = index
                break
        
        if last_space is not None:
            new_tokenstream[last_space] = new_tokenstream[last_space][:-1]
    
    current_word_ts = []
    
    for index, token in enumerate(tokenstream):
        if type(token) == str:
            token = encode_string(token, charmap)
        
        if type(token) == bytes:
            if not wrap:
                new_tokenstream.append(token)
                continue

            current_word = b""
            for char in token:
                char = bytes([char])
                
                if char in (encoded_space, encoded_newline):
                    current_word_px = measure_string(current_word_ts + [current_word, char], metrics, memory_widths)
                    
                    if len(current_word) > 0 and (line_px + current_word_px) > max_px:
                        replace_emitted_space()
                        new_tokenstream.append(encoded_newline)
                        increment_line()
                    
                    if len(current_word_ts) > 0:
                        new_tokenstream += current_word_ts
                        current_word_ts = []
                    
                    new_tokenstream.append(current_word)
                    new_tokenstream.append(char)
                    line_px += current_word_px
                    current_word = b""

                    if char == encoded_newline:
                        increment_line()
                else:
                    current_word += char
            
            #Save the current word for processing alongside the next token.
            if len(current_word) > 0:
                current_word_ts.append(current_word)
        elif type(token) == int:
            #Literal control code
            #TODO: Detect nonstandard newline
            if wrap:
                current_word_ts.append(token)
            else:
                new_tokenstream.append(token)
        elif type(token) == tuple:
            #Okay, this is an actual control code.
            cctoken = token[0]
            special = token[1]
            
            if special.purpose is None:
                if wrap:
                    token_px = 0
                    if cctoken == "&": #Memory buffer reference
                        if token[2] in memory_widths:
                            token_px += memory_widths[token[2]]
                        else:
                            token_px += 8*8

                        #This only triggers on a memory reference so that control codes
                        #aren't inadvertently treated as spaces.
                        #TODO: This functionality should only be triggered on space or
                        #newline and the measure function should handle memory widths.
                        if (line_px + token_px) > max_px:
                            replace_emitted_space()
                            new_tokenstream.append(encoded_newline)
                            increment_line()

                    current_word_ts.append(token)
                else:
                    new_tokenstream.append(token)
            elif special.purpose == QUESTION_FORMATTING_WRAPPER:
                #Questions can be formatted as a single-line or multi-line
                #question. If the sum of both lines' widths exceeds the width of
                #a line, we instead emit a multi-line question.
                arg1 = []
                for subtoken in token[-2]:
                    if type(subtoken) == str:
                        # For pleasant formatting in the sheet, questions may
                        # sometimes contain newlines, but these shouldn't be
                        # reproduced in the actual game. Hence, they're removed.
                        arg1.append(encode_string(subtoken.replace('\n', ''), charmap))
                    else:
                        arg1.append(subtoken)
                
                arg2 = []
                for subtoken in token[-1]:
                    if type(subtoken) == str:
                        arg2.append(encode_string(subtoken.replace('\n', ''), charmap))
                    else:
                        arg2.append(subtoken)
                
                arg1px = measure_string(arg1, metrics, memory_widths)
                arg2px = measure_string(arg2, metrics, memory_widths)
                
                #TODO: Can we make these hardcoded sequences more configurable?
                if (math.floor(arg1px / 8) * 8 + arg2px + 24) > max_px:
                    new_tokenstream.append(b"\xf1\x00")
                    new_tokenstream += arg1
                    new_tokenstream.append(encoded_newline)
                    new_tokenstream.append(b"\x00")
                    new_tokenstream += arg2
                else:
                    new_tokenstream.append(b"\x00")
                    new_tokenstream += arg1
                    new_tokenstream.append(b"\xf0")
                    new_tokenstream += arg2
    
    if len(current_word_ts) > 0:
        current_word_px = measure_string(current_word_ts, metrics, memory_widths)
        
        if (line_px + current_word_px) > max_px:
            replace_emitted_space()
            new_tokenstream.append(encoded_newline)
            increment_line()
        
        new_tokenstream += current_word_ts
        current_word_ts = []

    return new_tokenstream

def pack_text(string, known_tokens, charmap, metrics, window_width, window_height, memory_widths, wrap=True, do_not_terminate=False):
    #Sanity check: Empty strings indicate aliases.
    #TODO: Should we more explicitly notate these, instead of just specialcasing
    #them? There's precisely one table in Telefang that has about 10 messages
    #with no content that just point to the end of the block.
    if string == "":
        return b""
    
    tokenstream = parse_string(string, known_tokens)
    
    if metrics:
        tokenstream = format_tokenstream(tokenstream, charmap, metrics, window_width, window_height, memory_widths, wrap=wrap)
    
    encstream = []
    stream_is_terminated = do_not_terminate

    for token in tokenstream:
        if type(token) == str:
            encstream.append(encode_string(token, charmap))
        elif type(token) == bytes:
            encstream.append(token)
        elif type(token) == int:
            encstream.append(bytes([token]))
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
