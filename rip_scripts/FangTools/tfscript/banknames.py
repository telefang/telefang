import os

def parse_bank_names(filename):
    """Parse the list of bank names.
    
    `filename` should be the name of a file listing all of the banks available
    to the program. This function will generate and return a list of banks to
    be operated upon."""
    banks = []

    with open(filename, "r", encoding="utf-8") as banknames:
        for line in banknames:
            if line[0] == "#":
                continue

            parameters = line.split(" ")

            bank = {}
            bank["basedir"] = os.path.join(*parameters[0].split("/")[0:-1])
            bank["legacy_filename"] = os.path.join(*(parameters[0] + ".wikitext").split("/"))
            bank["filename"] = os.path.join(*(parameters[0] + ".messages.csv").split("/"))
            bank["objname"] = os.path.join(*(parameters[0] + ".scripttbl").split("/"))
            bank["wikiname"] = parameters[1]
            bank["symbol"] = "MainScript_" + "_".join(parameters[0].split("/")[1:])

            if len(parameters) > 2 and parameters[2] != "null":
                #Parameter 3 is the flat address for the ROM
                #If not present, location of table will be determined from ROM
                flatattr = int(parameters[2], 16)

                if (flatattr < 0x4000):
                    bank["baseaddr"] = flatattr
                    bank["basebank"] = 0
                else:
                    bank["baseaddr"] = flatattr % 0x4000 + 0x4000
                    bank["basebank"] = flatattr // 0x4000
            else:
                #If there's no flat address, add one in
                flatattr = int(parameters[1], 16)

                if (flatattr < 0x4000):
                    bank["baseaddr"] = flatattr
                    bank["basebank"] = 0
                else:
                    bank["baseaddr"] = flatattr % 0x4000 + 0x4000
                    bank["basebank"] = flatattr // 0x4000

            if len(parameters) > 3:
                bank["window_width"] = int(parameters[3], 10)

            banks.append(bank)

    return banks