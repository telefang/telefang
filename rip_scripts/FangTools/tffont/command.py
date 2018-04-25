from FangTools.tffont.parser import parse_font_metrics
from FangTools.tffont.passes import generate_metrics_data

import argparse, sys

def tffontasm():
    parser = argparse.ArgumentParser(description="Compiler for the font metrics used by VWF'd versions of Telefang")
    
    parser.add_argument("infile", metavar="file.tffont.csv", type=str, help='The font metrics data to compile.')
    parser.add_argument('output', metavar='file.metrics.bin', type=str, help='Where to save the assembled metrics.')
    
    args = parser.parse_args()
    
    with open(args.infile) as srcfile:
        metrics = parse_font_metrics(srcfile)
        data = generate_metrics_data(metrics)
        
        with open(args.output, 'wb') as outfile:
            outfile.write(data)