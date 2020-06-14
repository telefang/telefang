import csv
from FangTools.gb import flat

def parse_csv(csvfile, language):
    """Parse a message CSV from a file into a list of rows, filtering by language."""
    csvreader = csv.reader(csvfile)
    headers = None
    rows = []

    for row in csvreader:
        if len(row) == 0:
            continue

        if headers is None:
            headers = row
        else:
            rows.append(row)
    
    #Determine what column we want
    ptr_col = headers.index("Pointer")
    try:
        str_col = headers.index(language)
    except ValueError:
        str_col = ptr_col

    try:
        formatted_col = headers.index("Formatted?")
    except ValueError:
        formatted_col = None

    should_wrap = lambda row: True if formatted_col is None or '#' in row[ptr_col] else not int(row[formatted_col])
    return [(row[ptr_col], row[str_col], should_wrap(row)) for row in rows]

def omnibus_bank_split(rowdata, banknames):
    """Given row data from a non-bank-affiliated file, split it into banks.
    
    Returns a dict whose keys are bank IDs and values are that bank's specific
    row data."""
    
    out = {}
    
    for bankid, bank in enumerate(banknames):
        in_current_bank = False
        
        for row in rowdata:
            try:
                rowptr = int(row[0][2:], 16)
                bankflat = flat(bank["basebank"], bank["baseaddr"])
                
                #This line assumes text blocks do not share an MBC3 bank, which
                #is NOT true for the original game. Patched versions do relocate
                #the text blocks to occupy one bank each.
                in_current_bank = rowptr >= bankflat and rowptr < bankflat + 0x4000
            except ValueError:
                pass
            
            if in_current_bank:
                if bankid not in out.keys():
                    out[bankid] = []
                
                out[bankid].append(row)
    
    return out