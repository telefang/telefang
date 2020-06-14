"""Unpacking tools for Telefang message data"""

#Used here for text extraction from the ROM.
reverse_specials = {}
reverse_specials[0xE5] = "&"
reverse_specials[0xE3] = "S"
reverse_specials[0xE1] = "*"
reverse_specials[0xEC] = "O"
reverse_specials[0xE9] = "D"