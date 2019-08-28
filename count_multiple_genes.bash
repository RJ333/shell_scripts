#!/bin/bash
for file in *.csv; do
	if [ -f $file ] ;
		then
			#print out filename
			echo "File is: $file"
			#print out gene name
			for gene in phn{A..Z}; do
				#print the total numbers of genes in the files
				awk -v a="$gene" ' BEGIN {a_counter=0}
				($0 ~ a) {  a_counter+=1  ;  }
				END {  printf "%s\t %s\n", a, a_counter ; }
				'  $file
				done
			else
		#print error info incase input is not a file
		echo "$file is not a file, please specify a file." >&2 && exit 1
	fi
done
#terminate script with exit code 0 in case of successful execution 
exit 0