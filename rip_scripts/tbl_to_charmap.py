import sys

for line in open(sys.argv[1]):
    hex, char = line.strip("\r\n").split('=', 1)
    print(('charmap "{}", ${}'.format(char, hex)))
