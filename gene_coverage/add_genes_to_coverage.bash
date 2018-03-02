#!/bin/bash

#this script combines the output of the script "xy?" to one list for all genes in a folder
#and sorts it by coverage
 
#PATH_TO_DATA='/drives/d/1_Fachliches/Doktorarbeit/1. Glyphosat/Glyphosat omics/gene_richness_selected_genes'

#eval cd $PATH_TO_DATA #gives error and still works? problems are the whitespaces and dots in the path
#echo $PATH_TO_DATA
for gene_folder in $(find . -mindepth 1 -maxdepth 1 -type d)
	do
		cd $gene_folder;
		coverage_file=${gene_folder}_combined.txt_filtered*
		echo $gene_folder;
		echo $coverage_file
		echo ${PWD}
		cd ..
	done
	
	# We are reading two files: coverage_file.txt and intersect.bed
# NR is equal to FNR as long as we are reading the
# first file.
# Store the positions in an array current_position from the coverage file (indexed by $1)
# go to bed file
# store the start and end positions and the gene names in similar arrays
# if current_position is between start_pos and end_pos, print additionally gene name 

awk 'NR==FNR{current_position[$1]=$2} 
	NR==FNR{next}
	{start_pos[$1]=$2;end_pos[$1]=$3;gen_name[$1]=$4}
	{if(current_position[$1] >= start_pos[$1]) AND (current_position[$1] <= end_pos[$1]); print $1,$2,$3,$4,gen_name[$1]}' coverage_file.txt intersect.bed > test.txt