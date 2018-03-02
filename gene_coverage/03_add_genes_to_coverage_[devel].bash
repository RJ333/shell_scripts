#!/bin/bash

#this script adds the annotated gene region the coverage was calculated for. 
#It became complicated as it was supposed to distuingish between two genes placed on the same contig, only differing by their annotated region.
#it now continously counts all unique occurrences of the gene based on the data of the bed file
#####but I still don't exactly understand how it does it!!!
#
#with a lot of help from
#https://stackoverflow.com/questions/49050245/how-to-use-awk-to-add-specific-values-to-a-column-based-on-numeric-ranges/49054710?noredirect=1#comment85120455_49054710

awk 'NR==FNR{start[NR]=$2; end[NR]=$3; key[$1,$2]=$4 sprintf("_%03d",NR); next}
           {for(i in start)
              {s=start[i];
               if(s<=$2 && $2<=end[i] && ($1,s) in key) print $0,key[$1,s] | "sort -nk1 "}}' intersect.bed phnm_combined.txt_filtered_5.txt > test.cov