#!/bin/bash

#remove coverage below 5 from coverage files

PATH_TO_DATA=/drives/d/1_Fachliches/Doktorarbeit/1\.\ Glyphosat/Glyphosat\ omics/gene_richness_selected_genes
threshold=5 #coverage must be equal or higher to be kept

cd $PATH_TO_DATA #gives error and still works? problems are the whitespaces and dots in the path
echo "threshold is set to $threshold";
for coverage_file in */*_combined.txt
do
	echo $coverage_file;
	awk -v a="$threshold" '$3 >= a {print $0}' $coverage_file > ${coverage_file}_filtered_${threshold}.txt
done
