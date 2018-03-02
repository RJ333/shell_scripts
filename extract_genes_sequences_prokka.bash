###grep phn from prokka files

#create first file
grep "phn" PROKKA0.gff > phn.txt
#move phn-file to above folder and attach the other prokka extracts
cd ../prokka1
grep "phn" PROKKA*.gff >> ../phn.txt
cd ../prokka2
...

#open phn.txt in excel, homogenize gene names (remove _1,_2 etc), remove but contig id, CDS positions, gene name (check if EC-number are correct)

#idea: take contig_id with fasta sequence from file and extract fasta sequence from CDS start position to CDS end position into new file
#this file needs to the sequence, the contig id and the gene name and maybe the length 

#create one file, that contains only the contig_ids with the fasta sequences in one line from the original gff files
#copying the 7 gff fasta parts into one file (manually, searching for ##fasta, set line ends to "unix" format)
#transform to one line
awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n } ' input.file > outputfile
#finding the line after a special contig 
grep ">k141_1000\b" -A1 test.txt
#grep ">k141_1000\b" -A1 test.txt| awk "NR==2{print}" if you only wanna get the fasta sequence (print second line)
#using a list as input for grep

cut -f1 < phn_nice.txt >phn_contigs.txt
sort phn_contigs.txt |uniq > phn_contigs_uniq.txt ##maybe problems with unique, e.g. k141_20066 gone (flag -u was problem)
grep -F -f phn_contigs_uniq.txt -A1 prokka_all_fasta_singleline.txt | sed '/^--$/d' > output_test.txt

#grep/awk contig_id, use sequence, 
grep -F -f phn_contigs_uniq.txt -A 1 prokka_all_fasta_singleline.txt | sed '/^--$/d'> test_out.txt

#putting contig_id and fasta sequence into the same line
cat test_out.txt | paste - - > test_out_one_line.txt

#grep by contig_id, substring by CDS
grep ">k141_10671\b" test_out_one_line.txt

#cutting at the right positions with substr
grep ">k141_28027\b" test_out_one_line.txt | awk '{print substr($2,57251,698)}'

#using input from phn_nice.txt, trying to extract the right  values (as array?)
print -f 2 phn_nice.txt
https://stackoverflow.com/questions/27451807/awk-print-fields-from-every-line-in-file-and-the-following-line