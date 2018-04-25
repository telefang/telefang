import csv

def parse_font_metrics(f_file):
    """Parse a font metrics file.
    
    Returns a mapping of encoded characters to lengths.
    
    Format of metrics file is a CSV with 256 cells containing either decimal or
    hexadecimal values. One row and one column serve as headers that will not be
    parsed."""
    csvreader = csv.reader(f_file)
    values = []
    header = None
    
    for row in csvreader:
        if header is None and len(row) != 0:
            header = row
            continue
        
        rowhdr = None
        
        for cell in row:
            if rowhdr == None:
                rowhdr = cell
                continue
            
            if cell[0] == "$":
                values.append(int(cell[1:], 16))
            else:
                values.append(int(cell, 10))
    
    return values