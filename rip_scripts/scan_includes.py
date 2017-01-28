#!/bin/python
# coding: utf-8

"""
Recursively scan an asm file for dependencies.
Highly modified version of the PRET (Pokemon Reverse Engineering Tools) ver
"""

import sys
import argparse
import os.path

includes = set()

def scan_file(filename):
	for line in open(filename):
		if 'INC' not in line.upper():
			continue
		line = line.split(';')[0]
		if 'INCLUDE' in line.upper():
			include = line.split('"')[1]
			includes.add(include)
			scan_file(include)
		elif 'INCBIN' in line.upper():
			include = line.split('"')[1]
			includes.add(include)

def main():
	ap = argparse.ArgumentParser()
	ap.add_argument('filenames', nargs='*')
	args = ap.parse_args()
	for filename in set(args.filenames):
		scan_file(filename)
	sys.stdout.write(' '.join(includes))

if __name__ == '__main__':
	main()
