############################# echo
readarray contig_list_phn < phn_contigs_uniq.txt
echo ${contig_list_phn[1]}

############################## cut

############################## head/tail
tail -n +6 #starting from the 6th line


############################### counts

############################## increments

############################### loops

#!bin/bash
for contig in contig_list_phn
do
	grep -F contig -A1 prokka_all_fasta_singleline.txt | sed '/^--$/d' >> loop_test.txt
done

#!/bin/bash
for i in {1..7}; do
mkdir ./kallisto/sampleA${i}
scp rene@milou.uppmax.uu.se:/proj/b2010008/nobackup/projects/rene_roundup/metag_glyph_workflow/quantification/kallisto/quant/meta-sensitive_coassembly_10K/samples/A${i}/abundance.tsv.gz ./kallisto/sampleA${i};
done

#!/bin/bash
for i in {8..10}; do
mkdir ./kallisto/sampleB${i}
scp rene@milou.uppmax.uu.se:/proj/b2010008/nobackup/projects/rene_roundup/metag_glyph_workflow/quantification/kallisto/quant/meta-sensitive_coassembly_10K/samples/B${i}/abundance.tsv.gz ./kallisto/sampleB${i};
done

####################### sed

sed 's/pattern/foobar/' #This tries to replace whatever matches /pattern/ with "foobar". But whether or not the substitution succeeds, the always-true condition "1" prints each line (you could even use 42, or 19, or any other nonzero value if you so prefer; 1 is just what people traditionally use). This results in a program that does the same job as
sed '1,5d' #prints the lines after the first 5 lines

######################## grep
grep ">k141_1000\b" -A1 test.txt #finding the line after a special contig 
grep ">k141_1000\b" -A1 test.txt| awk "NR==2{print}" #if you only wanna get the fasta sequence (print second line)
grep ">k141_10671\b" test_out_one_line.txt #grep by contig_id, substring by CDS
grep ">k141_28027\b" test_out_one_line.txt | awk '{print substr($2,57251,698)}' #cutting at the right positions with substr
grep -e 'foo' -e 'bar') # prints lines that match /foo/ or /bar/


########################### sort

sort -k 1 phnN_nice.txt > phnN_nice_sorted.txt 
sort -n # highest number at bottom
sort -k 1 phnN_contigs_fasta_one_line.txt > phnN_contigs_fasta_one_line_sorted.txt


#########################   awk

$ awk ' {
   a[$1]++             # store to hash a using first field as key. ++ increases
                       # its value by 1 on each iteration for each $1
   print $1 "x" a[$1]  # output $1, "x" and current value of a[$1]
}' file


awk -F '{print $2}' phnN_nice.txt #using input from phnN_nice.txt, trying to extract the right  values (as array?)
awk -F '\t' 'NR==1{print $2}' phnN_nice.txt #getting the first row of column 2
#As a starting example, suppose you want to print all the records (normally lines) in a file that match some pattern (a kind of awk-grep, if you like). A reasonable first shot is usually something like
awk '{if ($0 ~ /pattern/) print $0}'
#That works, but there are some things to note.The first thing to note is that it is not structured according to awk’s definition of a program, which is
condition { actions } #Our program can clearly be rewritten using this form, since both the condition and the action are very clear:
awk '$0 ~ /pattern/ {print $0}' #Our next step in the perfect awk-ification of this program is to note that the /pattern/ syntax is the same as $0 ~ /pattern/. That is, when awk sees a regular expression literal used as an expression, it implicitly applies it to $0, and returns true if there is a match. So now we have:
awk '/pattern/ {print $0}' #Now, let’s turn our attention to the action part (the stuff inside braces). print $0 is redundant, since print alone, by default, prints $0.
awk '/pattern/ {print}' #But let's make another step. When it finds that a condition is true, and there are no associated actions, awk performs a default action, and that action (you guessed it) is print (which we already know is equivalent to print $0). Thus we can finally do this:
awk '/pattern/' #Now we have reduced the initial program to its simplest (and more idiomatic) form. In many cases, if all you want to do is print some records (lines), according to a condition, you can write awk programs composed only of a condition (although complex):
awk '(NR%2 && /pattern/) || (!(NR%2) && /anotherpattern/)' #That prints odd lines that match /pattern/ and even lines that match /anotherpattern/. Naturally, if you don’t want to print $0 but instead do something else, then you’ll have to manually add a specific action to do what you want.
#From the above, it follows that
awk 1
awk '"a"'   # single quotes are important!
#are two awk programs that just print their input unchanged, both "1" and the string "a" obviously being always-true conditions. This is not terribly useful by itself, but it can be used in combination with other code in a number of circumstances.
#For example, sometimes you want to operate only on some records of the input (according to some condition), but also want to print all records, regardless of whether they were affected by your operation or not. A typical example is a program like this:
awk '{sub(/pattern/, "foobar")} 1'
#Here are some examples of typical awk programs, using only conditions:
awk 'NR % 6'            # prints all lines except lines 6,12,18...
awk 'NR > 5'            # prints from line 6 onwards (like tail -n +6, or sed '1,5d')
awk '$2 == "foo"'       # prints lines where the second field is "foo"
awk 'NF >= 6'           # prints lines with 6 or more fields
awk '/foo/ && /bar/'    # prints lines that match /foo/ and /bar/, in any order
awk '/foo/ && !/bar/'   # prints lines that match /foo/ but not /bar/
awk '/foo/ || /bar/'    # prints lines that match /foo/ or /bar/ (like grep -e 'foo' -e 'bar')
awk '/foo/,/bar/'       # prints from line matching /foo/ to line matching /bar/, inclusive
awk 'NF'                # prints only nonempty lines (or: do not print empty lines, where NF==0)
awk 'NF--'              # removes last field and prints the line
awk '$0 = NR" "$0'      # prepends line numbers (assignments are valid in conditions)
awk '!a[$0]++'          # suppresses duplicated lines! (figure out how it works)
#NR - It gives total number of records processed 
#FNR - It gives total number of records for each input file.
#So, the condition NR == FNR is only true while awk is reading the first file.
#FS=":" Field separator

#cut_final.awk
awk -f cut_final.awk pos.txt strings.txt #call it like this
#One important thing to mention. substr() assumes strings to start at index 1 - in opposite to most programming languages 
#where strings start at index 0. If the positions in pos.txt are 0 based, the substr() must become:
mod=substr($2,1,pos[key]) "" substr($2,pos[key]+1+len[key])

# We are reading two files: pos.txt and strings.txt
# NR is equal to FNR as long as we are reading the
# first file.
NR==FNR{
    pos[">"$1]=$2 # Store the startpoint in an array pos (indexed by $1)
    len[">"$1]=$4 # Store the length in an array len (indexed by $1)
    next # skip the block below for pos.txt
}

# This runs on every line of strings.txt
$1 in pos {
    # Extract a substring of $2 based on the position and length
    # stored above
    key=$1
    mod=substr($2,pos[key],len[key])
    $2=mod
    print # Print the modified line
}

