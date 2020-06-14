CHARMAP_DELIM = 'charmap "'

def parse_charmap(filename):
    """Parse charmap.asm to determine the ROM's encoding.

    File must be UTF-8, sorry.

    This actually could support a hypothetical multibyte encoding, even though
    no build of Telefang (hacked or no) would support it."""
    mapping = {}
    reverse_mapping = {}

    with open(filename, "r", encoding="utf-8") as charmap:
        for line in charmap:
            if CHARMAP_DELIM not in line:
                continue

            if line[0] == "#":
                continue

            delim_split = line.split('"')
            chara = delim_split[1]
            if chara == "":
                #Special case: Quoted quotes.
                #   e.g. charmap """, $22

                #This parsing logic sucks arse.
                if len(delim_split) > 3:
                    chara = "\""

            if chara == "\\n":
                chara = "\n"

            unparsed_hex = delim_split[-1].split("$")[1].strip()
            bytedata = 0

            for i in range(0, len(unparsed_hex), 2):
                bytedata += int(unparsed_hex[i:i+2], 16) << i // 2

            mapping[chara] = bytedata
            reverse_mapping[bytedata] = chara

    return mapping, reverse_mapping