#!/bin/bash
for file in $(ls *.csv); do
if [ -f $file ] ; then
#print out filename
echo "File is: $file"
#print the total number of times phnM appears in the file
awk ' BEGIN {  print "The number of times phnM appears in the file is:" ; }
/phn/ {  counterx+=1  ;  }
/phnM/ {  countery+=1  ;  }
END {  printf "%s\n",  counterx ; }
END {  printf "%s\n",  countery ; } 
'  $file
else
#print error info incase input is not a file
echo "$file is not a file, please specify a file." >&2 && exit 1
fi
done
#terminate script with exit code 0 in case of successful execution 
exit 0