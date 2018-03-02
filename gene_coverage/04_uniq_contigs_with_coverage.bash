#!/bin/bash

#this script counts how many contigs and genes of a certain type (e.g. "phnM") have bases that met the coverage threshold

#define variables
PATH_TO_DATA=/drives/d/1_Fachliches/Doktorarbeit/1.\ Glyphosat/Glyphosat\ omics/gene_richness_selected_genes #still not working, will  be changed anyway
gene="phnM"
threshold="5"

#define functions
cmd_gene() { awk '{print $5}' $1 |sort | uniq -c | wc -l ; } #semicolon is important here!
cmd_contig() { awk '{print $1}' $1 |sort | uniq -c | wc -l ; } #semicolon is important here!

# loop over coverage files and print output
cd $PATH_TO_DATA #gives error, problems are the whitespaces and dots in the path ...probably only works, when in correct directory "gene_richness_selected_genes"
for coverage_file in */*.cov
do
	echo $gene" was found" $(cmd_gene "$coverage_file") "times on" $(cmd_contig "$coverage_file")" contigs with minimum coverage of" $threshold in $coverage_file
done