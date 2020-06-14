# coding=utf-8
import argparse, csv

def extract(args):
    csv_data = []
    csv_row = []
    
    with open(args.filename, 'rb') as binfile:
        binfile.seek(args.offset)
        
        while True:
            if (len(csv_row) >= 20):
                csv_data.append(csv_row)
                csv_row = []
            
            if (len(csv_data) >= 18):
                break
            
            byte = binfile.read(1)
            
            if (len(byte) < 1):
                break
            
            for i in range(3, -1, -1):
                csv_row.append(str((ord(byte) >> (i * 2)) & 0x03))
        
        if (len(csv_row) > 0):
            csv_data.append(csv_row)
    
    with open(args.output, 'w') as csvfile:
        csvwriter = csv.writer(csvfile)
        
        for row in csv_data:
            csvwriter.writerow(row)

def encode_atf(data):
    bytenum = 0
    bitcnt = 0
    bytestream = []
    
    for row in data:
        for val in row:
            if val > 3:
                raise ValueError("SGB attribute data only supports 4 palettes")
            
            if bitcnt >= 8:
                bytestream.append(bytenum)
                bytenum = 0
                bitcnt = 0
            
            bytenum = (bytenum << 2) | val
            bitcnt += 2
    
    if bitcnt != 0:
        bytestream.append(bytenum)
    
    return bytes(bytestream)

def make_atf(args):
    with open(args.filename, "r") as csvfile:
        csvreader = csv.reader(csvfile)
        csv_data = []

        for row in csvreader:
            nrow = []
            for cell in row:
                try:
                    nrow.append(int(cell, 10))
                except ValueError:
                    pass

            csv_data.append(nrow)

        print("Compiling " + args.filename)

        with open(args.output, "wb") as objfile:
            objfile.write(encode_atf(csv_data))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('filename', type=str, metavar="*.sgbattr.csv")
    ap.add_argument('output', type=str, metavar="*.atf")
    ap.add_argument('--offset', type=int)
    args = ap.parse_args()

    method = {
        "extract": extract,
        "make_atf": make_atf
    }.get(args.mode, None)

    if method == None:
        raise Exception("Unknown conversion method!")

    method(args)

if __name__ == "__main__":
    main()
