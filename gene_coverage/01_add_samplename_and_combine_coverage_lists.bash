#!/bin/bash

#this script combines the output of the script "xy?" to one list for all genes in a folder
#and sorts it by coverage

PATH_TO_DATA=/drives/d/1_Fachliches/Doktorarbeit/1\.\ Glyphosat/Glyphosat\ omics/gene_richness_selected_genes 
#does not work at the moment, needs to be executed in the folder that contains the different gene coverages per samples as subdirectory
cd $PATH_TO_DATA #gives error, problems are the whitespaces and dots in the path
for gene in $(find . -mindepth 1 -maxdepth 1 -type d) #find only directories
do 
	#echo $PWD 
	cd $gene
	for sample in *.sorted.removeduplicates.bam.cov.tmp
	do 
		#echo $sample 
		#echo $gene
		awk 'BEGIN{OFS="\t"}{print $0, FILENAME}' $sample >> ${gene}_tmp.txt #add all 10 samples to one list and add a column with the sample name
	done
	awk	'{split ($4,a,".");print $1,$2,$3,a[1]|"sort -nk3 "}' ${gene}_tmp.txt > ${gene}_combined.txt #split the long sample name in an array "a" at ".", take only the first part of that array, sort ascendingly by column3 "coverage"
	rm ${gene}_tmp.txt #clean up intermediate files
	cd .. 
	echo ${PWD}_after
done