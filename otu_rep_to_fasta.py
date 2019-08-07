#!/bin/python

"""
script takes the output from mothurs get.oturep() command and turns it into a
standard fasta file which can be used in R as DNAstrings object and
therefore included in phyloseqs refseq() slot
"""

import argparse
import re

parser = argparse.ArgumentParser()

parser.add_argument("-i", "--input_file", dest = "input_file", type = str, 
					default = None, required = True, action = "store",
                    help = "input file (get.oturep() fasta file from mothur)")
parser.add_argument("-o", "--output_file", dest = "output_file", type = str, 
					default = None, required = True, action = "store",
                    help="output file")
					
args = parser.parse_args()

input_filename = open(args.input_file, "r")
output_filename = open(args.output_file, "w")
to_replace = [".", "-"]

def clean_fasta_alignment(line, symbols):
    for symbol in symbols:
        line = line.rstrip().replace(symbol, "")
    return line
 
with input_filename as f:
    for line in f:
        if line.startswith(">"):
            fasta_header = re.match(r"(.+?)\|", line.split()[1]).group(1)
            output_filename.write(">" + fasta_header + "\n")
        else:
            seq = clean_fasta_alignment(line, to_replace)
            output_filename.write(seq + "\n")

			
			

