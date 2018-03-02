#!/bin/bash


awk 'NR==FNR{start[NR]=$2; end[NR]=$3; key[$1,$2]=$4 sprintf("_%03d",NR); print start[NR], end[NR], key[$1,$2]; next}
           {for(i in start)
              {s=start[i];
               if(s<=$2 && $2<=end[i] && ($1,s) in key) print $0, key[$1,s] | "sort -nk1 "}}' intersect.bed coverage_file.txt