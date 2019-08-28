##bash command tests 
#in mobaxterm
cd /drives/e/
head omics_collection.csv > temp.csv
tail -n +6 omics_collection.csv
tail -n 20 omics_collection.csv > temp2.csv

grep "k141_1000" omics_collection.csv   #all starting with 1000
grep "k141_1000\b" omics_collection.csv  #exactly 1000
grep "k141_1000\b" omics_collection.csv | cat #"echo" doesn't read stdin
echo $(grep "k141_1000\b" omics_collection.csv) #this would work with echo
ls | xargs echo
ls | xargs -I {} echo {} # not in mobxterm? if you want it to be called for each line individually 
grep "k141_1000" omics_collection.csv | wc		# prints number of newlines, words and characters
grep "k141_1000" omics_collection.csv | wc -L #prints the length of the longest line
grep "k141_1000" omics_collection.csv | wc -l #prints number of newlines


###anstelle ls * zu nutzen lieber "find", ist sicherer
find -name "*.py" -exec wc -l {} \; #backslash maskiert notwendiges semikolon
for i in $(ls) ; do echo $i ; done #which is the "safe" version of:
for i in `ls` ; do echo $i ; done 
for i in $(ls temp*); do echo $i ; grep "Bacteria" $i; done #search specific string in multiple files called "temp...", name files and print line by for loop
for i in $(ls temp*); do echo $i ; grep -c "Bacteria" $i; done #count hits per file

for i in $(ls temp*); do echo $i ; grep "yes" $i | wc -c; done #counts characters per file

head -n 20 omics_collection.csv | cut -f 1,2 -d ";"  #print the first two ;-delimited columns of the first 20 lines of file 
head -n 20 omics_collection.csv | cut -f 1,2 -d ";" | awk '{print length($0)}' |sort -n | uniq -c #get the occurrences of the lengths of each line

awk ' {FS=";"} { print $5 }' temp2.csv | sort | uniq -c #print all genes, sorts and counts them
awk '/phnM/ { print $0 }' omics_collection.csv | wc -l #print lines matching phnM and counts
awk 'BEGIN{FS=";"} /phnM/ { print $2 }' omics_collection.csv  #match lines with phnM and print the second field (contig id) of the line sep by ;
awk '/phnM/ {FS=";"} { print $2 }' omics_collection.csv  #match lines with phnM and print the second field (contig id) of the line sep by ;

awk '/phnM/ { counter+=1 ; printf "%s\n", counter ; }' omics_collection.csv