#!/bin/bash
GENE1="NA"
GENE2="fadD"
for file in *.csv; do
if [ -f $file ] ; then
#print out filename
echo "File is: $file"
#print the total numbers of genes in the files
awk -v a="$GENE1" -v b="$GENE2" ' BEGIN {  print "The number of times", a, "and", b " appear in the file are:" ; }
$0 ~ a {  a_counter+=1  ;  }
END {  printf "%s\t %s\n", a, a_counter ; }
$0 ~ b {  b_counter+=1  ;  }
END {  printf "%s\t %s\n", b, b_counter ; }
'  $file
else
#print error info incase input is not a file
echo "$file is not a file, please specify a file." >&2 && exit 1
fi
done
#terminate script with exit code 0 in case of successful execution 
exit 0